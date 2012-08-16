//
//  AlbumSongsViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlbumSongsViewController.h"

#import "AppDelegate.h"

@implementation AlbumSongsViewController

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
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"Album"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
    [navigationBar setItems:items];
    [back release];
    [items release];
    
}

-(void)setItemsWithIndex:(int)index{
    MPMediaItemCollection *collection=[musicByAlbum objectAtIndex:index];
    NSMutableArray *array=[[NSMutableArray alloc]initWithArray:collection.items];
    [super setTableViewWithMusicArray:array];
    [array release];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeBackToAlbumController];
    return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
