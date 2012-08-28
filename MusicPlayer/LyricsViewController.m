//
//  LyricsViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LyricsViewController.h"
#import "LyricsRow.h"
#import <AVFoundation/AVFoundation.h>
#import "DFDownloader.h"
#import "Constents.h"

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
    NSString *sel_title=[item valueForProperty:MPMediaItemPropertyTitle];
    NSString *sel_artist=[item valueForProperty:MPMediaItemPropertyArtist];
    NSString *sel_album=[item valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    [[navigationBar.items objectAtIndex:0]setTitle:[NSString stringWithFormat:@"%@-%@-%@",sel_title,sel_artist,sel_album]];
    
    MPMediaItemArtwork *artwork=[item valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *artworkImage=[artwork imageWithSize:CGSizeMake(135, 135)];
    if(artworkImage){
        [albumImageView setImage:artworkImage];
    }else{
        [albumImageView setImage:[UIImage imageNamed:@"no_album.png"]];
    }
}

-(void)dealloc{
    [label release];
    [albumImageView release];
    [super dealloc];
}

-(void)updateLyrics:(NSString *)lyric{
    [label setText:lyric];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
	[self dismissModalViewControllerAnimated: YES];
}

-(void)musicEnded{
    NSLog(@"音乐结束回调");
}

-(void)loadingFinished{
    NSLog(@"歌词处理结束回调");
    [label setText:@"歌词处理完成，即将显示"];
}

-(IBAction)stopButtonClicked{
    [manager.player stop];
    
    [[navigationBar.items objectAtIndex:0]setTitle:@"正在播放"];
    [albumImageView setImage:[UIImage imageNamed:@"no_album.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager=[[DFLyricsMusicPlayer alloc]init];
    manager.delegate=self;
    slider.enabled=NO;
    
    //DFDownloader *d=[[DFDownloader alloc]init];
    //[d startDownloadWithURLString:@"http://ttlrccnc.qianqian.com/dll/lyricsvr.dll?sh?Artist=0F5C4E861F96&Title=3172&Flags=0"];
    //[d release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
