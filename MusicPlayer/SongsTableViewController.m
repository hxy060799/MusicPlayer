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
@synthesize contentArray;
@synthesize currentType;

#pragma UIViewView Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
        UINavigationItem *item=[[UINavigationItem alloc] initWithTitle:@"MusicList"];
        UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"音乐库"];
        NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
        [navigationBar setItems:items];
        navigationBar.delegate=self;
        [back release];
        [item release];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)dealloc{
    [songsTableView release];
    [contentArray release];
    [super dealloc];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    switch(currentType) {
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
    return [contentArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];

    [cell.textLabel setText:[[contentArray objectAtIndex:indexPath.row] valueForKey:@"cellText"]];
    [cell.detailTextLabel setText:[[contentArray objectAtIndex:indexPath.row] valueForKey:@"smallText"]];
    [cell.imageView setImage:[[contentArray objectAtIndex:indexPath.row]valueForKey:@"artworkImage"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(currentType==DFMusicListTypeArtistGroup){
        [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToArtistSongsViewWithIndex:indexPath.row];
    }else if(currentType==DFMusicListTypeAlbumGroup){
        [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToAlbumSongsViewWithIndex:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma Other Methods

-(void)setCellsWithContentArray:(NSMutableArray*)array ListType:(DFMusicListType)listType{
    self.currentType=listType;
    if(!songsTableView)songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    songsTableView.delegate=self;
    songsTableView.dataSource=self;
    
    [self.view insertSubview:self.songsTableView atIndex:0];
    
    contentArray=[[self makeMusicArrayToDictionary:array ListType:listType]copy];
    
    [songsTableView reloadData];
}

-(void)setCellsWithIndex:(int)index ListType:(DFMusicListType)listType{
    MPMediaItemCollection *collection;
    if(listType==DFMusicListTypeAlbumSongs){
        collection=[musicByAlbum objectAtIndex:index];
    }else if(listType==DFMusicListTypeArtistSongs){
        collection=[musicByArtist objectAtIndex:index];
    }
    NSMutableArray *array=[[NSMutableArray alloc]initWithArray:collection.items];
    //[navigationBar.topItem setTitle:[[array objectAtIndex:0]valueForProperty:MPMediaItemPropertyAlbumTitle]];
    [self setCellsWithContentArray:array ListType:listType];
    [array release];
    
}

-(NSMutableArray*)makeMusicArrayToDictionary:(NSMutableArray*)musicArray ListType:(DFMusicListType)listType{
    NSMutableArray *returnArray=[NSMutableArray array];
    for(int i=0;i<musicArray.count;i++){
        NSMutableDictionary *musicDictionary=[NSMutableDictionary dictionary];
        if(listType==DFMusicListTypeAllSongs||listType==DFMusicListTypeArtistSongs||listType==DFMusicListTypeAlbumSongs ){
            MPMediaItem *nowItem=[musicArray objectAtIndex:i];
            NSString *cellText=[nowItem valueForProperty:MPMediaItemPropertyTitle];
            NSString *smallText=[NSString stringWithFormat:@"%@-%@",[nowItem valueForProperty:MPMediaItemPropertyArtist],[nowItem valueForProperty: MPMediaItemPropertyAlbumTitle]];
            [musicDictionary setObject:cellText forKey:@"cellText"];
            [musicDictionary setObject:smallText forKey:@"smallText"];
        }else if(listType==DFMusicListTypeArtistGroup){
            NSArray *collection=[[musicArray objectAtIndex:i]items];
    
            NSString *cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
            NSString *smallText=[NSString stringWithFormat:@"%i首歌曲",[collection count]];
            
            MPMediaItemArtwork *mia=[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork];
            UIImage *artworkImage=[mia imageWithSize:CGSizeMake(44, 44)];
            
            artworkImage=(!artworkImage)?[UIImage imageNamed:@"no_album.png"]:artworkImage;
            
            [musicDictionary setObject:cellText forKey:@"cellText"];
            [musicDictionary setObject:smallText forKey:@"smallText"];
            [musicDictionary setObject:artworkImage forKey:@"artworkImage"];
        }else if(listType==DFMusicListTypeAlbumGroup){
            NSArray *collection=[[musicArray objectAtIndex:i]items];
            
            NSString *cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyAlbumTitle];
            NSString *smallText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
            
            MPMediaItemArtwork *mia=[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork];
            UIImage *artworkImage=[mia imageWithSize:CGSizeMake(44, 44)];
            
            artworkImage=(artworkImage)?artworkImage:[UIImage imageNamed:@"no_album.png"];
            
            [musicDictionary setObject:cellText forKey:@"cellText"];
            [musicDictionary setObject:smallText forKey:@"smallText"];
            [musicDictionary setObject:artworkImage forKey:@"artworkImage"];
        }
        [returnArray addObject:musicDictionary];
    }
    return returnArray;
}

@end
