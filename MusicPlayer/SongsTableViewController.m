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

@implementation SongsTableViewController

@synthesize songsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)setTableViewWithMusicArray:(NSMutableArray*)array{
    if(!songsTableView)self.songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    self.songsTableView.delegate=self;
    self.songsTableView.dataSource=self;
    
    [self.view insertSubview:self.songsTableView atIndex:0];
    
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    
    musicArray=[array copy];
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)dealloc{
    if(songsTableView)[songsTableView release];
    [super dealloc];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    
    MPMediaItem *nowItem=[musicArray objectAtIndex:indexPath.row];
    
    NSString *cellText=[nowItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *smallText=[NSString stringWithFormat:@"%@-%@",[nowItem valueForProperty:MPMediaItemPropertyArtist],[nowItem valueForProperty: MPMediaItemPropertyAlbumTitle]];
    
    [cell.textLabel setText:cellText];
    [cell.detailTextLabel setText:smallText];
    return cell;
    
}


@end
