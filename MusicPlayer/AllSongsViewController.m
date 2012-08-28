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
#import "SongInformationViewController.h"

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
    
    /*
    UILongPressGestureRecognizer *longPressReger=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    longPressReger.minimumPressDuration = 1.0;
    [self.songsTableView addGestureRecognizer:longPressReger];
    [longPressReger release];
    */
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:@"MusicSelectView"];
    return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
/*
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:songsTableView];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        NSIndexPath *indexPath = [songsTableView indexPathForRowAtPoint:point];
        if (indexPath == nil){
            //NSLog(@"not tableView");
        }else{
            NSLog(@"%i",indexPath.row);
            
            SongInformationViewController *controller = [[SongInformationViewController alloc]initWithNibName:@"SongInformationViewController" bundle:nil];
            [controller setInformationWithItem:[musicByTitle objectAtIndex:indexPath.row]];
            
            FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
            [controller release];
            popover.tint = FPPopoverDefaultTint;
            popover.arrowDirection = FPPopoverArrowDirectionAny;
            [popover presentPopoverFromView:[songsTableView cellForRowAtIndexPath:indexPath]];

        }
    }
}
*/
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
    [songsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc{
    [super dealloc];
}

@end


