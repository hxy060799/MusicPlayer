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

@synthesize songsTableView;
@synthesize groupArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)setTableViewWithMusicArray:(NSMutableArray*)array{
    groupArray=[array copy];
    if(!songsTableView)songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    songsTableView.delegate=self;
    songsTableView.dataSource=self;
    
    [self.view insertSubview:self.songsTableView atIndex:0];
    
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groupArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
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

-(void)dealloc{
    if(songsTableView)[songsTableView release];
    if(groupArray)[groupArray release];
    [super dealloc];
}

@end
