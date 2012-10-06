//
//  DFLyricsMusicPlayer.m
//  MusicPlayer
//
//  Created by Bill on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsMusicPlayer.h"
#import "Constents.h"
#import "DFOnlinePlayer.h"

@implementation DFLyricsMusicPlayer

@synthesize player;
@synthesize delegate;
@synthesize lyricsManager;
NSTimer *endTimer;

-(id)init{
    if(self=[super init]){
        self.player=[MPMusicPlayerController applicationMusicPlayer];
        self.lyricsManager=[[DFLyricsManager alloc]init];
        if (self.player) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iPodPlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.player];
            [self.player beginGeneratingPlaybackNotifications];
        }
        
    }
    return self;
}

-(void)removePlayBackDelegate{
    if (self.player) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.player];
        [self.player endGeneratingPlaybackNotifications];
    }
}

-(void)dealloc{
    [self.player release];
    [self.lyricsManager release];
    [super dealloc];
}

-(void)iPodPlaybackStateChanged:(id)sender{
    
    //这里加入了一个static变量，一个是用来判断当前状态是从那个状态转变过来的以方便操作，同时也为了解决iOS5在开始播放的时候会调用两次的漏洞
    
    static MPMusicPlaybackState lastState=0;
    
    if(self.player.playbackState==MPMusicPlaybackStateStopped){
        if(lastState==0){
            NSLog(@"Player inited");
        }else if(lastState==MPMusicPlaybackStateStopped){
            NSLog(@"Problem is here");
        }else{
            NSLog(@"音乐结束");
            [endTimer invalidate];
            endTimer=nil;
            
            [delegate updateSliderWithValue:0.0f TimeGoes:@"00:00" readyTime:@"-00:00"];
            [delegate musicEnded];
            
        }
        
        lastState=MPMusicPlaybackStateStopped;
    }else if(self.player.playbackState==MPMusicPlaybackStatePlaying){
        if(!lastState==MPMusicPlaybackStatePlaying){
            NSLog(@"Change to Playing");
        }else{
            NSLog(@"StillPlaying");
        }
        
        lastState=MPMusicPlaybackStatePlaying;
    }
}

-(void)timerGoes:(NSTimer*)sender{
    
    //发现如果播放器状态改变的回调和这个函数同时触发的的时候会导致定时器不被停止，这里再做一次判断
    
    if(self.player.playbackState==MPMusicPlaybackStateStopped){
        NSLog(@"音乐已经结束");
        [endTimer invalidate];
        endTimer=nil;
        
    }else{
        float timeGoes=self.player.currentPlaybackTime;
        float readyTime=[[self.player.nowPlayingItem valueForKey:MPMediaItemPropertyPlaybackDuration]floatValue];
        
        float result=timeGoes/readyTime;
        [delegate updateSliderWithValue:result TimeGoes:[self timeStringWithNumber:(int)timeGoes] readyTime:[NSString stringWithFormat:@"-%@",[self timeStringWithNumber:(int)readyTime-(int)timeGoes]]];
        //NSLog(@"播放中");
    }
    
}

-(void)startPlayWithMusicCollection:(MPMediaItemCollection*)collection Artist:(NSString*)theArtist Title:(NSString*)theTitle{
    [onlinePlayer stop];
    
    [self.player stop];
    [self.player setQueueWithItemCollection:collection];
    [self.player play];
    
    NSLog(@"%@",theArtist);
    
    [lyricsManager setLyricsWithArtist:theArtist SongName:theTitle];
    
    endTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerGoes:) userInfo:nil repeats:YES];
    
    [delegate musicChanged];
}

//-(void)saveLyricsWithArtist:(NSString*)artist Title:(NSString*)title{
//    NSLog(@"startSaving");
//    [self.lyricsDictionary setObject:lyrics forKey:[NSString stringWithFormat:@"%@-%@",artist,title]];
//    //NSLog(@"%@",self.lyricsDictionary);
//}

-(NSString*)timeStringWithNumber:(float)theTime{
    NSString *minuteS=[NSString string];
    
    int minute=(theTime)/60;
    if(theTime<60){
        minuteS=[NSString stringWithString:@"00"];
    }else if(minute<10){
        minuteS=[NSString stringWithFormat:@"0%i",(minute)];
    }else{
        minuteS=[NSString stringWithFormat:@"%i",(minute)];
    }
    
    NSString *playTimeS=[NSString string];
    if(theTime-60*minute<10){
        playTimeS=[NSString stringWithFormat:@"%@:0%0.0f",minuteS,theTime-60*minute];
    }else{
        playTimeS=[NSString stringWithFormat:@"%@:%0.0f",minuteS,theTime-60*minute];
    }
    
    return playTimeS;
    
}

-(void)stopMusic{
    [player stop];
}

@end