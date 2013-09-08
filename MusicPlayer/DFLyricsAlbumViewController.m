//
//  DFLyricsAlbumViewControlle.m
//  MusicPlayer
//
//  Created by Bill on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsAlbumViewController.h"
#import "GlowLabel.h"

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
        GlowLabel *lyricLabel=[[GlowLabel alloc]initWithFrame:CGRectMake(0, (20+40*i)-(100/2)+(20/2), 320, 100)];
        [lyricLabel setTextColor:[UIColor whiteColor]];
        [lyricLabel setFont:[UIFont systemFontOfSize:20]];
        [lyricLabel setBackgroundColor:[UIColor clearColor]];
        [lyricLabel setText:@"*****"];
        [lyricLabel setTextAlignment:UITextAlignmentCenter];
        if(i==3){
            lyricLabel.redValue=1;
            lyricLabel.greenValue=0;
            lyricLabel.blueValue=0;
            //lyricLabel.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            [lyricLabel setNeedsDisplay];
        }
        
        [lyricsPageView addSubview:lyricLabel];
        [labelArray addObject:lyricLabel];
        //[lyricLabel autorelease];
    }
}

-(void)updateTheLyricsWithLyrics:(NSMutableArray*)lyrics{
    for(int i=0;i<[lyrics count];i++){
        [[labelArray objectAtIndex:i]setText:[lyrics objectAtIndex:i]];
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
