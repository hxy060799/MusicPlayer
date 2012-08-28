//
//  MusicSearchViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicSearchViewController.h"

@implementation MusicSearchViewController

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
    searchTableView.delegate=self;
    searchTableView.dataSource=self;
    searchController = [[YCSearchController alloc] initWithDelegate:self
												 searchDisplayController:self.searchDisplayController];
    searchController.delegate=self;
    tableViewItems=[[NSMutableArray alloc]init];
    
    lastSearchString=[NSString string];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc{
    [searchController release];
    [tableViewItems release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableViewItems.count>0){
        return tableViewItems.count;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"musicCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID]autorelease];
    }
    if(tableViewItems.count>0){
        [[cell textLabel] setText:lastSearchString];
    }else{
        [cell.textLabel setText:@"请点按上方的搜索框框来搜索"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableViewItems.count>0){
        NSLog(@"%@",[tableViewItems objectAtIndex:indexPath.row]);
    }
}

-(NSArray*)searchController:(YCSearchController *)controller searchString:(NSString *)searchString{
    lastSearchString=searchString;
    BaiduMP3Searcher *searcher=[[[BaiduMP3Searcher alloc]init]autorelease];
    searcher.delegate=self;
    [searcher searchByString:searchString];
    return nil;
}

-(void)searchEndedWithNothing{
    
}

-(void)searchFinishedWithResult:(NSMutableArray *)result{
    for(NSString *url in result){
        [tableViewItems addObject:url];
    }
    [searchTableView reloadData];
}

@end
