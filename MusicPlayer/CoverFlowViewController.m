//
//  CoverFlowViewController.m
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverFlowViewController.h"
#import "CoverflowSelectViewController.h"
#import "AppDelegate.h"
#import "DFMusicQuery.h"

@implementation CoverFlowViewController

@synthesize coverFlowView;
@synthesize covers;

CoverflowSelectViewController *controller;

UILabel *label;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    CGRect frame=CGRectMake(0, 0, 320, 480-44-20);
    
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    [navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    UINavigationItem *titleItem=[[UINavigationItem alloc]initWithTitle:@"Coverflow"];
    
    [navigationBar setDelegate:self];
    UINavigationItem *back=[[UINavigationItem alloc]initWithTitle:@"音乐库"];
    NSArray *items=[[NSArray alloc]initWithObjects:back,titleItem,nil];
    [navigationBar setItems:items];
    [items release];
    
    [self.view insertSubview:navigationBar atIndex:1];
    
    coverFlowView=[[TKCoverflowView alloc]initWithFrame:frame];
    coverFlowView.coverflowDelegate=self;
    coverFlowView.dataSource=self;
    [self.view insertSubview:coverFlowView atIndex:0];
    
    if(!musicByAlbum){
        DFMusicQuery *query=[[DFMusicQuery alloc]init];
        [query albumQuery];
        [query release];
    }
    covers=[[NSMutableArray alloc]init];
    coversAlbumTitle=[[NSMutableArray alloc]init];
    if([musicByAlbum count]>0){
        for(MPMediaItemCollection *songs in musicByAlbum){
            NSArray *songsArray=[songs items];
            
            MPMediaItem *theItem=[songsArray objectAtIndex:0];
            
            MPMediaItemArtwork *artWork=[theItem valueForProperty:MPMediaItemPropertyArtwork];
            UIImage *artworkImage=[artWork imageWithSize:CGSizeMake(224, 224)];
            if(artworkImage){
                [covers addObject:artworkImage];
            }else{
                [covers addObject:[UIImage imageNamed:@"no_album.png"]];
            }
            
            [coversAlbumTitle addObject:[theItem valueForProperty:MPMediaItemPropertyAlbumTitle]];
        }
        [coverFlowView setNumberOfCovers:[musicByAlbum count]];
    }else{
        [covers addObject:[UIImage imageNamed:@"no_album.png"]];
        [coverFlowView setNumberOfCovers:1];
    }
    
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(100, 370, 120, 21)];
    [label setText:@"0"];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view insertSubview:label atIndex:1];
    [label release];
    
    controller=[[CoverflowSelectViewController alloc]initWithNibName:@"CoverflowSelectViewController" bundle:nil];
    [self.view insertSubview:controller.view atIndex:1];
    [controller.view setFrame:CGRectMake(-224, -224, 224, 224)];
}

-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    [[[AppDelegate switchViewController] iPodLibrarySwitchViewController]changeToIPodLibraryMainViewWithNowController:@"CoverflowView"];
    [controller.view setFrame:CGRectMake(-224, -224, 224, 224)];
    return NO;
}

-(void)coverflowView:(TKCoverflowView *)coverflowView coverAtIndexWasBroughtToFront:(int)index{
    [label setText:[coversAlbumTitle objectAtIndex:index]];
}

-(TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	TKCoverflowCoverView *cover =[coverFlowView dequeueReusableCoverView];
	if(cover == nil){
		CGRect rect=CGRectMake(0, 0, 224, 300);
        cover = [[TKCoverflowCoverView alloc] initWithFrame:rect];
        cover.baseline = 224;
	}
    
	cover.image = [covers objectAtIndex:index%[covers count]];
	
    return cover;
}

-(void)coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index{
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil){
        return;
    }
    //coverFlowView.userInteractionEnabled=NO;
    [controller fallToPoint:CGPointMake(48,82)];

	NSLog(@"Index: %d",index);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadView{
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
}

-(void)dealloc{
    [coverFlowView release];
    [covers release];
    [coversAlbumTitle release];
    [super dealloc];
}

@end
