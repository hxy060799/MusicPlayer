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
@synthesize listInformation;

#pragma UIViewView Methods

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil listInformation:(struct MusicListInformation)information{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
        UINavigationItem *item=[[[UINavigationItem alloc] initWithTitle:@"MusicList"]autorelease];
        UINavigationItem *back=[[[UINavigationItem alloc]initWithTitle:@"音乐库"]autorelease];
        NSArray *items=[[[NSArray alloc]initWithObjects:back,item,nil]autorelease];
        [navigationBar setItems:items];
        navigationBar.delegate=self;
        
        self.listInformation=MusicListInformationMake(information.listType, information.listSuperIdnex);
        
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
    [navigationBar release];
    [super dealloc];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    switch(listInformation.listType) {
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
    switch(listInformation.listType){
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
            return ((MPMediaItemCollection*)[musicByAlbum objectAtIndex:listInformation.listSuperIdnex]).items.count;
        case DFMusicListTypeArtistSongs:
            return ((MPMediaItemCollection*)[musicByArtist objectAtIndex:listInformation.listSuperIdnex]).items.count;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    
    NSString *cellText=nil;
    NSString *smallText=nil;
    UIImage *artworkImage=nil;
    if(listInformation.listType==DFMusicListTypeArtistGroup){
        NSArray *collection=[[musicByArtist objectAtIndex:indexPath.row]items];
        
        cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
        smallText=[NSString stringWithFormat:@"%i首歌曲",[collection count]];
        
        artworkImage=[[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(44, 44)];
        artworkImage=(!artworkImage)?[UIImage imageNamed:@"no_album.png"]:artworkImage;
    }else if(listInformation.listType==DFMusicListTypeAlbumGroup){
        NSArray *collection=[[musicByAlbum objectAtIndex:indexPath.row]items];
        
        cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyAlbumTitle];
        smallText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
        
        artworkImage=[[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(44, 44)];
        artworkImage=(!artworkImage)?[UIImage imageNamed:@"no_album.png"]:artworkImage;
    }else{
        MPMediaItem *nowItem=nil;
        if(listInformation.listType==DFMusicListTypeAllSongs){
            nowItem=[musicByTitle objectAtIndex:indexPath.row];
        }else if(listInformation.listType==DFMusicListTypeArtistSongs){
            nowItem=[((MPMediaItemCollection*)[musicByArtist objectAtIndex:listInformation.listSuperIdnex]).items objectAtIndex:indexPath.row];
        }else if(listInformation.listType==DFMusicListTypeAlbumSongs){
            nowItem=[((MPMediaItemCollection*)[musicByAlbum objectAtIndex:listInformation.listSuperIdnex]).items objectAtIndex:indexPath.row];
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
    
    switch(listInformation.listType){
        case DFMusicListTypeArtistGroup:
            [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToArtistSongsViewWithIndex:indexPath.row];
            break;
        case DFMusicListTypeAlbumGroup:
            [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToAlbumSongsViewWithIndex:indexPath.row];
            break;
        case DFMusicListTypeAlbumSongs:{
            MPMediaItem *selectedItem=[((MPMediaItemCollection*)[musicByAlbum objectAtIndex:listInformation.listSuperIdnex]).items objectAtIndex:indexPath.row];
            NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
            NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
            [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
            break;
        }
        case DFMusicListTypeAllSongs:{
            MPMediaItem *selectedItem=[musicByTitle objectAtIndex:indexPath.row];
            NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
            NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
            NSLog(@"%@",theArtist);
            [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
            [songsTableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        }case DFMusicListTypeArtistSongs:{
            MPMediaItem *selectedItem=[((MPMediaItemCollection*)[musicByArtist objectAtIndex:listInformation.listSuperIdnex]).items objectAtIndex:indexPath.row];
            NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
            NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
            [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
            break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma Functions

struct MusicListInformation MusicListInformationMake(DFMusicListType listType,int listSuperIdnex){
    struct MusicListInformation information={listType,listSuperIdnex};
    return information;
}

@end
