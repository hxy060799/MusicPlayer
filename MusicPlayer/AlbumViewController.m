//
//  AlbumViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlbumViewController.h"
#import "AppDelegate.h"

@implementation AlbumViewController

@synthesize navigationBar;

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
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"音乐库"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,item,nil];
    [navigationBar setItems:items];
    [back release];
    [items release];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:@"AlbumView"];
    return NO;
}

-(void)dealloc{
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToAlbumSongsViewWithIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
     NSArray *collection=[[groupArray objectAtIndex:indexPath.row]items];
     
     
     NSString *cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyAlbumTitle];
     NSString *smallText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
     
     MPMediaItemArtwork *mia=[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork];
     UIImage *artworkImage=[mia imageWithSize:CGSizeMake(44, 44)];
     
     artworkImage=(artworkImage)?artworkImage:[UIImage imageNamed:@"no_album.png"];
     
     [cell.textLabel setText:cellText];
     [cell.detailTextLabel setText:smallText];
     [[cell imageView] setImage:artworkImage];
     return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
