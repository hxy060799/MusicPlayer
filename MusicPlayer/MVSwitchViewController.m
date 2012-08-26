//
//  MVSwitchViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MVSwitchViewController.h"
#import "MVCell.h"
#import "HotMVGetter.h"
#import "MVInformation.h"
#import "MediaPlayer/MediaPlayer.h"
#import "SearchBarCell.h"

@implementation MVSwitchViewController

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
    
    displaySearch=NO;
    
    if(!hotMVResult.tableViewArray)hotMVResult.tableViewArray=[[NSMutableArray alloc]init];
    hotMVResult.nowPageAt=1;
    HotMVGetter *getter=[[HotMVGetter alloc]init];
    NSMutableArray *tempArray=[getter getHotMVWithPage:1];
    [hotMVResult.tableViewArray removeAllObjects];
    for(MVInformation *inf in tempArray){
        [hotMVResult.tableViewArray addObject:inf];
    }
    [getter release];
    
    if(!mvTableView)mvTableView=[[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    mvTableView.delegate=self;
    mvTableView.dataSource=self;
    
    [mvTableView reloadData];
    
    [mvTableView addHeaderRefreshViewWithFrame:CGRectMake(0.0f, 0.0f-65, self.view.frame.size.width, 65) IsFooterView:NO Delegate:self];
    [mvTableView addHeaderRefreshViewWithFrame:CGRectMake(0, mvTableView.contentSize.height, 320, 65) IsFooterView:YES Delegate:self];
    
    [self.view insertSubview:mvTableView atIndex:0];
    
    
}

-(void)dealloc{
    if(mvTableView)[mvTableView release];
    if(searchDisplayController)[searchDisplayController release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>0){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        MVInformation *information=nil;
        if(displaySearch==NO){
            information=[hotMVResult.tableViewArray objectAtIndex:indexPath.row-1];
        }else{
            information=[searchResult.tableViewArray objectAtIndex:indexPath.row-1];
        }
        
        
        NSString *url = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
        
        
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];  
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)  name:MPMoviePlayerPlaybackDidFinishNotification  object:[playerViewController moviePlayer]];  
        
        [playerViewController.view setFrame:CGRectMake(0,-20,320, 480)];
        [self presentModalViewController:playerViewController animated:YES];
        
        
        MPMoviePlayerController *player = [playerViewController moviePlayer];
        //playerViewController.moviePlayer.movieSourceType=MPMovieSourceTypeStreaming;
        [player play];
        [player stop];
        NSURL *tempUrl=[NSURL URLWithString:information.playURL];
        [player setContentURL:tempUrl];
        [player play];
        [playerViewController release];
        
    }
    
    
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(displaySearch==NO){
        return [hotMVResult.tableViewArray count]+1;
    }else{
        return [searchResult.tableViewArray count]+1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 88.0f;
    }else {
        return 110.0f;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=nil;
    static BOOL nibRegistered=NO;
    
    if(!nibRegistered){
        UINib *nib=[UINib nibWithNibName:@"MVCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"MVCellIdentifier"];
        nib=[UINib nibWithNibName:@"SearchBarCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SearchBarCellIdentifier"];
        nibRegistered=YES;
    }
    
    if(indexPath.row==0){
        cellIdentifier=@"SearchBarCellIdentifier";
        SearchBarCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        searchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:cell.searchBar contentsController:self];
        
        [cell.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        
        searchController = [[YCSearchController alloc] initWithDelegate:self
                                                searchDisplayController:searchDisplayController];
        
        return cell;
    }else {
        cellIdentifier=@"MVCellIdentifier";
        
        MVCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(displaySearch==NO){
            MVInformation *information=[hotMVResult.tableViewArray objectAtIndex:indexPath.row-1];
            
            [cell setTitle:[information title]];
            [cell setInformation:[information information]];
            [cell setPicture:[information picture]];
        }else{
            MVInformation *information=[searchResult.tableViewArray objectAtIndex:indexPath.row-1];
            
            [cell setTitle:[information title]];
            [cell setInformation:[information information]];
            [cell setPicture:[information picture]];
        }
        return cell;
    }
}

#pragma mark -
#pragma mark MPMoviePlayerViewController CallBack

-(void)movieFinishedCallback:(MPMoviePlayerViewController*)controller{
    
}

#pragma mark -
#pragma mark UISegmentedControl CallBack

-(void)segmentedControlChanged:(UISegmentedControl*)segmentedControl{
    int index = segmentedControl.selectedSegmentIndex;
    NSLog(@"Seg.selectedSegmentIndex:%i",index);
    if(index==1){
        if([searchResult.tableViewArray count]==0){
            [searchController setActive:YES animated:YES];
        }else{
            displaySearch=YES;
            [mvTableView setFooterRefreshViewHidden:YES];
            [mvTableView reloadData];
        }
    }else{
        [searchController setActive:NO animated:YES];
        displaySearch=NO;
        [mvTableView setFooterRefreshViewHidden:NO];
        [mvTableView reloadData];
    }
}


#pragma mark -
#pragma mark YCSearchBarDelegate

-(NSArray*)searchController:(YCSearchController *)controller searchString:(NSString *)searchString{
    NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    
    SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];;
    cell.segmentedControl.selectedSegmentIndex=1;
    
    
    HotMVGetter *getter=[[HotMVGetter alloc]init];
    searchResult.tableViewArray=[[getter searchByString:searchString]copy];
    [getter release];
    displaySearch=YES;
    [mvTableView setFooterRefreshViewHidden:YES];
    
    [mvTableView reloadData];
    
    return nil;
}

-(void)searchEndedWithNothing{
    NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    
    SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];;
    cell.segmentedControl.selectedSegmentIndex=0;
    displaySearch=NO;
    [mvTableView setFooterRefreshViewHidden:NO];
    
    [mvTableView reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-1){
        if(mvTableView.headerRefreshView)[mvTableView.headerRefreshView egoRefreshScrollViewDidScroll:scrollView];
    }else{
        if(!displaySearch){
            if(mvTableView.footerRefreshView)[mvTableView.footerRefreshView egoRefreshScrollViewDidScroll:scrollView];
        }
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y<-1) {
        if(mvTableView.headerRefreshView)[mvTableView.headerRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    }else{
        if(!displaySearch){
            if(mvTableView.footerRefreshView)[mvTableView.footerRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
	
}

#pragma mark -
#pragma mark Refresh Methods

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	reloading = NO;
	[mvTableView.headerRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:mvTableView];
    [mvTableView.footerRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:mvTableView];
	
}


-(void)refreshTableView{
    if(!displaySearch){
        hotMVResult.nowPageAt=1;
        HotMVGetter *getter=[[HotMVGetter alloc]init];
        NSMutableArray *tempArray=[getter getHotMVWithPage:1];
        [hotMVResult.tableViewArray removeAllObjects];
        for(MVInformation *inf in tempArray){
            [hotMVResult.tableViewArray addObject:inf];
        }
        [getter release];
        [mvTableView reloadData];
    }else{
        NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
        
        SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];;
        
        HotMVGetter *getter=[[HotMVGetter alloc]init];
        searchResult.tableViewArray=[[getter searchByString:cell.searchBar.text]copy];
        [getter release];
        [mvTableView reloadData];
    }
    reloading = YES;
}

-(void)getMoreData{
    if(!displaySearch){
        if(hotMVResult.nowPageAt<10){
            hotMVResult.nowPageAt+=1;
            HotMVGetter *getter=[[HotMVGetter alloc]init];
            NSMutableArray *tempArray=[getter getHotMVWithPage:hotMVResult.nowPageAt];
            for(MVInformation *inf in tempArray){
                [hotMVResult.tableViewArray addObject:inf];
            }
            [getter release];
            [mvTableView reloadData];
        }
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderViewDelegade

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    if(view==mvTableView.headerRefreshView){
        [self refreshTableView];
    }else{
        [self getMoreData];
    }
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
    
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
