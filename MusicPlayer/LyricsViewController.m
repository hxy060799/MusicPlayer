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

@implementation LyricsViewController

DFLyricsMusicPlayer *manager;

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

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissModalViewControllerAnimated: YES];
    
    for(MPMediaItem *mi in mediaItemCollection.items){
        NSString *sel_title=[mi valueForProperty:MPMediaItemPropertyTitle];
        NSString *sel_artist=[mi valueForProperty:MPMediaItemPropertyArtist];
        NSString *sel_album=[mi valueForProperty:MPMediaItemPropertyAlbumTitle];
        
        
        [manager startPlayWithMusicCollection:mediaItemCollection Artist:sel_artist Title:sel_title];
        
        [songTitle setText:sel_title];
        [songArtist setText:sel_artist];
        [songAlbum setText:sel_album];
        
        MPMediaItemArtwork *mia=[mi valueForProperty:MPMediaItemPropertyArtwork];
        UIImage *artworkImage=[mia imageWithSize:CGSizeMake(135, 135)];
        if(artworkImage){
            [albumImageView setImage:artworkImage];
        }else{
            [albumImageView setImage:[UIImage imageNamed:@"no_album.png"]];
        }

    }
}

-(void)dealloc{
    [label release];
    [albumImageView release];
    [songTitle release];
    [songArtist release];
    [songAlbum release];
    [super dealloc];
}

-(void)updateLyrics:(NSString *)lyric{
    NSLog(@"~~!%@",lyric);
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
    //这里只用把音乐停下来，其他所有的事情都交给管理器完成
    [manager.player stop];
}

-(IBAction)addButtonClicked:(id)sender{
    MPMediaPickerController *picker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate=self;
    picker.allowsPickingMultipleItems=NO;
    picker.prompt=@"添加歌曲";
    [self presentModalViewController:picker animated:YES];
    [picker release];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
