//
//  AllSongsViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllSongsViewController.h"
#import "AppDelegate.h"

#import "SongInformationViewController.h"

#import "DFMusicQuery.h"
#import "DFSongInformation.h"

#import "TKEmptyView.h"


@implementation AllSongsViewController



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
}

-(void)tableViewLongPress:(UILongPressGestureRecognizer*)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        CGPoint touchPoint=[gestureRecognizer locationInView:songsTableView];
        NSIndexPath *indexPath=[songsTableView indexPathForRowAtPoint:touchPoint];
        if(indexPath==nil){
            //NSLog(@"Not tableView");
        }else{
            //NSLog(@"%i",indexPath.row);
            [self showInformationViewWithCell:[songsTableView cellForRowAtIndexPath:indexPath]];
        }
    }
}

-(void)loadSongs{
    
    static BOOL songLoaded=NO;
    
    if(![musicByTitle count]==0&&!songLoaded){
        
        tableViewItems=tableViewItems?tableViewItems:[[NSMutableArray alloc]init];
        tableViewSmallText=tableViewSmallText?tableViewSmallText:[[NSMutableArray alloc]init];

        [tableViewItems removeAllObjects];
        [tableViewSmallText removeAllObjects];
        
        for(int i=0;i<[musicByTitle count];i++){
            MPMediaItem *theItem=[musicByTitle objectAtIndex:i];
            
            NSString *smallText=[NSString stringWithFormat:@"%@-%@",[theItem valueForProperty:MPMediaItemPropertyArtist],[theItem valueForProperty: MPMediaItemPropertyAlbumTitle]];
            
            [tableViewItems addObject:[theItem valueForProperty:MPMediaItemPropertyTitle]];
            [tableViewSmallText addObject:smallText];
        }
        [songsTableView reloadData];
        
        songLoaded=YES;
    }
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)dealloc{
    [tableViewItems release];
    [tableViewSmallText release];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[tableViewItems objectAtIndex:[indexPath row]]]];
    if([tableViewSmallText count]>0){
        [cell.detailTextLabel setText:[tableViewSmallText objectAtIndex:[indexPath row]]];
    }
    return cell;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(void)showInformationViewWithCell:(UITableViewCell*)theCell{
    SongInformationViewController *controller=[[[SongInformationViewController alloc]initWithNibName:@"SongInformationViewController" bundle:nil]autorelease];
    
    
    FPPopoverController *popover=[[[FPPopoverController alloc]initWithViewController:controller]autorelease];
    
    NSLog(@"%i",[[songsTableView indexPathForCell:theCell]row]);
    
    MPMediaItem *selectedItem=[musicByTitle objectAtIndex:[[songsTableView indexPathForCell:theCell]row]];
    
    [controller setInformationWithItem:selectedItem];
    
    controller.title=@"Information";
    
    popover.tint=FPPopoverDefaultTint;
    popover.arrowDirection=FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:theCell];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[tableViewItems objectAtIndex:[indexPath row]]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]==0){
        return nil;
    }
    return indexPath;
}

@end


