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
    
    HotMVGetter *getter=[[HotMVGetter alloc]init];
    tableViewArray=[[NSMutableArray alloc] initWithArray:[getter getHotMV]];
    [getter release];
    
    if(!mvTableView)mvTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 367) style:UITableViewStylePlain];
    
    mvTableView.delegate=self;
    mvTableView.dataSource=self;
    
    if(refreshHeaderView==nil){
		EGORefreshTableHeaderView *headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - mvTableView.bounds.size.height, self.view.frame.size.width, mvTableView.bounds.size.height)];
        headerView.delegate=self;
        [mvTableView addSubview:headerView];
        refreshHeaderView=headerView;
        [headerView release];
    }
    
    [refreshHeaderView refreshLastUpdatedDate];
    
    [self.view insertSubview:mvTableView atIndex:0];
    

}

-(void)dealloc{
    if(tableViewArray)[tableViewArray release];
    if(mvTableView)[tableViewArray release];
    if(searchDisplayController)[searchDisplayController release];
    if(searchArray)[searchArray release];
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
            information=[tableViewArray objectAtIndex:indexPath.row-1];
        }else{
            information=[searchArray objectAtIndex:indexPath.row-1];
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
        return [tableViewArray count]+1;
    }else{
        return [searchArray count]+1;
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
    NSString *cellIdentifier=[NSString string];
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
        
        self.searchController = [[YCSearchController alloc] initWithDelegate:self
                                                                              searchDisplayController:searchDisplayController];
        
        return cell;
    }else {
        cellIdentifier=@"MVCellIdentifier";
        
        MVCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(displaySearch==NO){
            MVInformation *information=[tableViewArray objectAtIndex:indexPath.row-1];
            
            [cell setTitle:[information title]];
            [cell setInformation:[information information]];
            [cell setPicture:[information picture]];
        }else{
            MVInformation *information=[searchArray objectAtIndex:indexPath.row-1];
            
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

#pragma mark-
#pragma mark UISegmentedControl CallBack

-(void)segmentedControlChanged:(UISegmentedControl*)segmentedControl{
    int index = segmentedControl.selectedSegmentIndex;
    NSLog(@"Seg.selectedSegmentIndex:%i",index);
    if(index==1){
        [self.searchController setActive:YES animated:YES];
    }else{
        [self.searchController setActive:NO animated:YES];
    }
}


#pragma mark-
#pragma mark YCSearchBarDelegate

-(NSArray*)searchController:(YCSearchController *)controller searchString:(NSString *)searchString{
    NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    
    SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];;
    cell.segmentedControl.selectedSegmentIndex=1;
    
    
    HotMVGetter *getter=[[HotMVGetter alloc]init];
    searchArray=[[NSMutableArray alloc] initWithArray:[getter searchByString:searchString]];
    [getter release];
    displaySearch=YES;
    
    [mvTableView reloadData];
    
    return nil;
}

-(void)searchEndedWithNothing{
    NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    
    SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];;
    cell.segmentedControl.selectedSegmentIndex=0;
}

#pragma mark-
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark-
#pragma mark EGORefreshTableHeaderViewDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)reloadTableViewDataSource{
	
    if(displaySearch==YES){
        NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
        SearchBarCell *cell =(SearchBarCell*)[mvTableView cellForRowAtIndexPath:myIndexPath];
        
        
        HotMVGetter *getter=[[HotMVGetter alloc]init];
        searchArray=[[NSMutableArray alloc] initWithArray:[getter searchByString:cell.searchBar.text]];
        [getter release];
        
        [mvTableView reloadData];
    }else{
        HotMVGetter *getter=[[HotMVGetter alloc]init];
        tableViewArray=[[NSMutableArray alloc] initWithArray:[getter getHotMV]];
        [getter release];
        [mvTableView reloadData];
        NSLog(@"Refresh Finished");
    }
	reloading = YES;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mvTableView];
	
}



@end
