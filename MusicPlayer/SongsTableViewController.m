//
//  SongsTableViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SongsTableViewController.h"

#import "Constents.h"
#import "TKEmptyView.h"

@implementation SongsTableViewController

@synthesize songsTableView;
@synthesize emptyView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        
        if(MUSIC_COUNT>0){
            if(!emptyView)self.emptyView=[[TKEmptyView alloc]initWithFrame:self.view.frame emptyViewImage:TKEmptyViewImageMusicNote title:@"No Songs" subtitle:@"No songs in your music library"];
            [self.view insertSubview:self.emptyView atIndex:0];
        }else{
            
            if(!songsTableView)self.songsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-44) style:UITableViewStyleGrouped];
            
            self.songsTableView.delegate=self;
            self.songsTableView.dataSource=self;
            
            [self.view insertSubview:self.songsTableView atIndex:0];
        }

    }
    return self;
}

-(void)dealloc{
    if(songsTableView)[songsTableView release];
    if(emptyView)[emptyView release];
    [super dealloc];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MUSIC_COUNT;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%i",[indexPath row]]];
    
    return cell;
}


@end
