//
//  ArtistSongsViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArtistSongsViewController.h"
#import "AppDelegate.h"

@implementation ArtistSongsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    navigationBar.delegate=self;
    
    UINavigationItem *item=[navigationBar.items objectAtIndex:0];
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"歌手"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
    [navigationBar setItems:items];
    [back release];
    [items release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)setItemsWithIndex:(int)index{
    MPMediaItemCollection *collection=[musicByArtist objectAtIndex:index];
    NSMutableArray *array=[[NSMutableArray alloc]initWithArray:collection.items];
    [navigationBar.topItem setTitle:[[array objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist]];
    [super setTableViewWithMusicArray:array];
    [array release];
    
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeBackToArtistController];
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MPMediaItem *selectedItem=[musicArray objectAtIndex:indexPath.row];
    NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
    NSLog(@"%@",theArtist);
    [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
    [songsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
