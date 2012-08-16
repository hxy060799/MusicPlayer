//
//  MusicGroupViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicGroupViewController.h"
#import "Constents.h"
#import "MediaPlayer/MediaPlayer.h"

@implementation MusicGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    if(!songsTableView)self.songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    self.songsTableView.delegate=self;
    self.songsTableView.dataSource=self;
    
    [self.view insertSubview:self.songsTableView atIndex:0];
    
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicByAlbum count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    
    NSArray *collection=[[musicByAlbum objectAtIndex:indexPath.row]items];

    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
