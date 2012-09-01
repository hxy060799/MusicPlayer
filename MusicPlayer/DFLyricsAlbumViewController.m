//
//  DFLyricsAlbumViewControlle.m
//  MusicPlayer
//
//  Created by Bill on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsAlbumViewController.h"

@implementation DFLyricsAlbumViewController

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
    self.paginatorView.pageGapWidth=0.0f;
    self.paginatorView.currentPageIndex=0;
    [self.paginatorView.pageControl.pageControl setHidden:YES];
    
    labelArray=[[NSMutableArray alloc] initWithCapacity:9];
    
    for(int i=0;i<7;i++){
        UILabel *lyricLabel=[[UILabel alloc]initWithFrame:CGRectMake(139, 20+21*2*i, 42, 21)];
        [lyricLabel setTextColor:[UIColor whiteColor]];
        [lyricLabel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        [lyricLabel setText:@"Hello"];
        [lyricLabel setTextAlignment:UITextAlignmentCenter];
        
        [lyricsPageView addSubview:lyricLabel];
        //[lyricLabel autorelease];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [labelArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark SVPaginatorViewDataSource

-(NSInteger)numberOfPagesForPaginatorView:(SYPaginatorView *)paginatorView{
    return 2;
}

-(SYPageView*)paginatorView:(SYPaginatorView *)paginatorView viewForPageAtIndex:(NSInteger)pageIndex{
    if(pageIndex==0){
        return albumPageView;
    }else{
        return lyricsPageView;
    }
}

-(void)setAlbumArtwork:(UIImage *)albumArtwork{
    [albumImageView setImage:albumArtwork];
    [lyricsAlbumImageView setImage:albumArtwork];
}

@end
