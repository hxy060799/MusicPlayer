//
//  IPodLibraryMainViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IPodLibraryMainViewController.h"
#import "AppDelegate.h"


@implementation IPodLibraryMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([musicByTitle count]==0){
        //如果没有歌，就就加载提示界面
        emptyView=[[TKEmptyView alloc]initWithFrame:self.view.frame emptyViewImage:TKEmptyViewImageMusicNote title:@"No Songs" subtitle:@"No songs in your music library"];
        [self.view insertSubview:emptyView atIndex:0];
    }else{
        
        iPodLibraryTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-44) style:UITableViewStyleGrouped];
        
        iPodLibraryTableView.delegate=self;
        iPodLibraryTableView.dataSource=self;
        
        tableViewItems=[[NSMutableArray alloc]initWithObjects:@"所有歌曲",@"歌手",@"专辑",@"CoverFlow",nil];
        
        [self.view addSubview:iPodLibraryTableView];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
    }
    
    
    [cell.textLabel setText:[tableViewItems objectAtIndex:[indexPath row]]];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==0){
        [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToAllSongsView];
    }else if([indexPath row]==2){
        [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToAlbumController];
    }else if ([indexPath row]==3) {
        [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToCoverFlowView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
