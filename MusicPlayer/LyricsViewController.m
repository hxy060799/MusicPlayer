//
//  LyricsViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LyricsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DFDownloader.h"
#import "Constents.h"
#import "DFOnlinePlayer.h"
#import "UIImage+Reflection.h"

@implementation LyricsViewController


-(void)updateSliderWithValue:(float)value TimeGoes:(NSString *)goesTime readyTime:(NSString *)readyTime{
    slider.value=value;
    [goesTimeL setText:goesTime];
    [readyTimeL setText:readyTime];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)musicChanged{
    MPMediaItem *item=manager.player.nowPlayingItem;
    
    [titleLabel setText:[item valueForKey:MPMediaItemPropertyTitle]];
    [artistLabel setText:[item valueForKey:MPMediaItemPropertyArtist]];
    [albumLabel setText:[item valueForKey:MPMediaItemPropertyAlbumTitle]];
    
    MPMediaItemArtwork *artwork=[item valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *artworkImage=[artwork imageWithSize:CGSizeMake(135, 135)];
    if(artworkImage){
        [lyricsAlbumViewController setAlbumArtwork:artworkImage];
    }else{
        [lyricsAlbumViewController setAlbumArtwork:[UIImage imageNamed:@"no_album.png"]];
    }
}

-(void)dealloc{
    [titleLabel release];
    [albumLabel release];
    [artistLabel release];
    [lyricsAlbumViewController release];
    [super dealloc];
}

-(void)updateLyrics:(NSMutableArray*)lyric{
    [lyricsAlbumViewController updateTheLyricsWithLyrics:lyric];
}

-(void)musicEnded{
    NSLog(@"音乐结束回调");
}

-(void)loadingFinished{
    NSLog(@"歌词处理结束回调");
}

-(IBAction)stopButtonClicked{
    [manager.player stop];
    
    [[navigationBar.items objectAtIndex:0]setTitle:@"正在播放"];
    [lyricsAlbumViewController setAlbumArtwork:[UIImage imageNamed:@"no_album.png"]];
    
    [onlinePlayer stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager=[[DFLyricsMusicPlayer alloc]init];
    manager.delegate=self;
    manager.lyricsManager.delegate=self;
    slider.enabled=NO;
    isPlay = YES;//初始化为播放状态
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    lyricsAlbumViewController=[[DFLyricsAlbumViewController alloc]initWithNibName:@"DFLyricsAlbumViewController" bundle:nil];
    [lyricsAlbumViewController.view setFrame:CGRectMake(0, 44, 320, 320)];
    [self.view addSubview:lyricsAlbumViewController.view];
    
    //playBtn
    playButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 368, 40, 40)];
    [playButton setImage:[UIImage imageNamed:@"media-play.png"] forState:UIControlStateNormal];
    playButton.showsTouchWhenHighlighted=YES;
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    //previous
    UIButton *previousButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 368, 40, 40)];
    [previousButton setImage:[UIImage imageNamed:@"media-previous.png"] forState:UIControlStateNormal];
    previousButton.showsTouchWhenHighlighted=YES;
    [previousButton addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    
    //next
    UIButton *nextButton=[[UIButton alloc]initWithFrame:CGRectMake(230, 368, 40, 40)];
    [nextButton setImage:[UIImage imageNamed:@"media-next.png"] forState:UIControlStateNormal];
    nextButton.showsTouchWhenHighlighted=YES;
    [nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)play
{
    if(isPlay)
    {
        //play
        MPMediaItem *selectedItem=[musicByTitle objectAtIndex:currentSongOfIndex];
        NSString *theTitle=[selectedItem valueForProperty:MPMediaItemPropertyTitle];
        NSString *theArtist=[selectedItem valueForProperty:MPMediaItemPropertyArtist];
        //NSLog(@"%@",theArtist);
        [manager startPlayWithMusicCollection:[MPMediaItemCollection collectionWithItems:[NSArray arrayWithObject:selectedItem]] Artist:theArtist Title:theTitle];
        
        [playButton setImage:[UIImage imageNamed:@"media-pause.png"] forState:UIControlStateNormal];
        isPlay = NO;
    }
    else
    {
        //pause
        [manager stopMusic];
        [playButton setImage:[UIImage imageNamed:@"media-play.png"] forState:UIControlStateNormal];
        isPlay = YES;
    }
}

- (IBAction)previous:(id)sender
{
    if (currentSongOfIndex == 0)
    {
        currentSongOfIndex = musicByTitle.count - 1;
    }
    else
    {
        currentSongOfIndex--;
    }
    isPlay = YES;
    [self play];
}

- (IBAction)next:(id)sender
{
    if (currentSongOfIndex == (musicByTitle.count - 1))
    {
        currentSongOfIndex = 0;
    }
    else
    {
        currentSongOfIndex++;
    }
    isPlay = YES;
    [self play];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

@end
