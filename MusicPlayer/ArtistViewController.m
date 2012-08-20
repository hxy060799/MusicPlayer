//
//  ArtistViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArtistViewController.h"
#import "AppDelegate.h"

@implementation ArtistViewController

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
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:@"ArtistView"];
    return NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *collection=[[groupArray objectAtIndex:indexPath.row]items];
    
    NSString *cellText=[[collection objectAtIndex:0]valueForProperty:MPMediaItemPropertyArtist];
    NSString *smallText=[NSString stringWithFormat:@"%i首歌曲",[collection count]];
    
    MPMediaItemArtwork *mia=[[collection objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *artworkImage=[mia imageWithSize:CGSizeMake(44, 44)];
    
    artworkImage=(artworkImage)?artworkImage:[UIImage imageNamed:@"no_album.png"];
    
    [cell.textLabel setText:cellText];
    [cell.detailTextLabel setText:smallText];
    [[cell imageView] setImage:artworkImage];
    return cell;
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
    
    [[[AppDelegate switchViewController]iPodLibrarySwitchViewController]changeToArtistSongsViewWithIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
