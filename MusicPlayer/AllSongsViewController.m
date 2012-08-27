//
//  AllSongsViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllSongsViewController.h"
#import "AppDelegate.h"
#import "Constents.h"

@implementation AllSongsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navigationBar.delegate=self;
    
    UINavigationItem *item=[navigationBar.items objectAtIndex:0];
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"音乐库"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
    [navigationBar setItems:items];
    [back release];
    [items release];
    
    [super setTableViewWithMusicArray:musicByTitle];
    
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:@"MusicSelectView"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MPMediaItem *selectedItem=[musicByTitle objectAtIndex:indexPath.row];
    NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
    NSLog(@"%@",theArtist);
    [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
}

-(void)dealloc{
    [super dealloc];
}

@end


