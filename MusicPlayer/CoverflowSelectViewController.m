//
//  CoverflowSelectViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverflowSelectViewController.h"

@implementation CoverflowSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)fallToPoint:(CGPoint)point{
    self.view.frame = CGRectMake(point.x,-224,224,224);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    self.view.frame = CGRectMake(point.x,point.y,224,224);
    [UIView commitAnimations];
}

-(void)upToPoint:(CGPoint)point{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    self.view.frame = CGRectMake(point.x,point.y,224,224);
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame=CGRectMake(0, 0, 224, 224);
    
    UINavigationItem *titleItem=[[UINavigationItem alloc]initWithTitle:@"信息"];
    [navigationBar setDelegate:self];
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"返回"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,titleItem,nil];
    [navigationBar setItems:items];
    [items release];
    
    songsTableView.delegate=self;
    songsTableView.dataSource=self;
    
    tableViewItems=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",nil];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [self upToPoint:CGPointMake(self.view.frame.origin.x, -224)];
    return NO;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"第%@项",[tableViewItems objectAtIndex:[indexPath row]]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"列表中的第%@项",[tableViewItems objectAtIndex:[indexPath row]]]];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
