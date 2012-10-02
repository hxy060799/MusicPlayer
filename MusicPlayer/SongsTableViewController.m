//
//  SongsTableViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SongsTableViewController.h"

#import "Constents.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AppDelegate.h"

@implementation SongsTableViewController

@synthesize songsTableView;
@synthesize currentType;

#pragma UIViewView Methods

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil listInformation:(struct MusicListInformation)information{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
        UINavigationItem *item=[[UINavigationItem alloc] initWithTitle:@"MusicList"];
        UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"音乐库"];
        NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
        [navigationBar setItems:items];
        navigationBar.delegate=self;
        [back release];
        [item release];
        [items release];
        
        currentType.listType=information.listType;
        currentType.listSuperIdnex=information.listSuperIdnex;
        
        if(!songsTableView){
            songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
            
            songsTableView.delegate=self;
            songsTableView.dataSource=self;
            
            [self.view insertSubview:self.songsTableView atIndex:0];
        }
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)dealloc{
    [songsTableView release];
    [super dealloc];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    switch(currentType.listType) {
        case DFMusicListTypeArtistSongs:
            [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeBackToArtistController];
            break;
        case DFMusicListTypeAlbumSongs:
            [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeBackToAlbumController];
            break;
        default:
            [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:self];
            break;
    }
    return NO;
}

#pragma UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch(currentType.listType){
        case DFMusicListTypeAllSongs:
            return [musicByTitle count];
            break;
        case DFMusicListTypeAlbumGroup:
            return [musicByAlbum count];
            break;
        case DFMusicListTypeArtistGroup:
            return [musicByArtist count];
            break;
        case DFMusicListTypeAlbumSongs:
            return ((MPMediaItemCollection*)[musicByAlbum objectAtIndex:currentType.listSuperIdnex]).items.count;
        case DFMusicListTypeArtistSongs:
            return ((MPMediaItemCollection*)[musicByArtist objectAtIndex:currentType.listSuperIdnex]).items.count;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    
    NSString *cellText=[NSString string];
    NSString *smallText=[NSString string];
    UIImage *artworkImage=nil;
    if(currentType.listType==DFMusicListTypeArtistGroup){
        NSArray *collection=[[musicByArtist objectAtIndex:indexPath.row]items];
        
        cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
        smallText=[NSString stringWithFormat:@"%i首歌曲",[collection count]];
        
        artworkImage=[[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(44, 44)];
        artworkImage=(!artworkImage)?[UIImage imageNamed:@"no_album.png"]:artworkImage;
    }else if(currentType.listType==DFMusicListTypeAlbumGroup){
        NSArray *collection=[[musicByAlbum objectAtIndex:indexPath.row]items];
        
        cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyAlbumTitle];
        smallText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
        
        artworkImage=[[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(44, 44)];
        artworkImage=(!artworkImage)?[UIImage imageNamed:@"no_album.png"]:artworkImage;
    }else{
        MPMediaItem *nowItem=nil;
        if(currentType.listType==DFMusicListTypeAllSongs){
            nowItem=[musicByTitle objectAtIndex:indexPath.row];
        }else if(currentType.listType==DFMusicListTypeArtistSongs){
            nowItem=[((MPMediaItemCollection*)[musicByArtist objectAtIndex:currentType.listSuperIdnex]).items objectAtIndex:indexPath.row];
        }else if(currentType.listType==DFMusicListTypeAlbumSongs){
            nowItem=[((MPMediaItemCollection*)[musicByAlbum objectAtIndex:currentType.listSuperIdnex]).items objectAtIndex:indexPath.row];
        }
        cellText=[nowItem valueForProperty:MPMediaItemPropertyTitle];
        smallText=[NSString stringWithFormat:@"%@-%@",[nowItem valueForProperty:MPMediaItemPropertyArtist],[nowItem valueForProperty: MPMediaItemPropertyAlbumTitle]];
    }
    
    [cell.textLabel setText:cellText];
    [cell.detailTextLabel setText:smallText];
    [cell.imageView setImage:artworkImage];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(currentType.listType==DFMusicListTypeArtistGroup){
        [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToArtistSongsViewWithIndex:indexPath.row];
    }else if(currentType.listType==DFMusicListTypeAlbumGroup){
        [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToAlbumSongsViewWithIndex:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma Functions

struct MusicListInformation MusicListInformationMake(DFMusicListType listType,int listSuperIdnex){
    struct MusicListInformation information={listType,listSuperIdnex};
    return information;
}

@end
