//
//  DFLyricsMusicPlayer.m
//  MusicPlayer
//
//  Created by Bill on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsMusicPlayer.h"

@implementation DFLyricsMusicPlayer

@synthesize player;
@synthesize lyrics;
@synthesize delegate;
@synthesize lyricsDictionary;
@synthesize isDownloading;

NSTimer *endTimer;

NSTimer *lyricsTimer;

-(id)init{
    if(self=[super init]){
        self.player=[MPMusicPlayerController applicationMusicPlayer];
        self.lyrics=[[NSMutableArray alloc] init];
        
        if (self.player) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iPodPlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.player];
            [self.player beginGeneratingPlaybackNotifications];
            
            self.lyricsDictionary=[[NSMutableDictionary alloc]init];
        }

    }
    return self;
}

-(void)removePlayBackDelecate{
    if (self.player) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.player];
        [self.player endGeneratingPlaybackNotifications];
    }
}

-(void)dealloc{
    [lyricsDictionary release];
    [lyrics release];
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
        
            [lyricsTimer invalidate];
            lyricsTimer=nil;
            
            [lyrics removeAllObjects];
            
            //音乐结束事件的响应会比歌词开始寻找略迟一点，从而导致状态显示出现问题
            if(isDownloading==NO){
                [delegate updateLyrics:@"歌词"];
            }
            
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

-(void)searchFinished{
    [delegate updateLyrics:@"下载歌词..."];
}

-(void)findLyricsWithArtist:(NSString*)artist Title:(NSString*)title{
    NSLog(@"%@",artist);
    isDownloading=YES;
    if(delegate){
        [delegate updateLyrics:@"寻找歌词..."];
    }else{
        NSLog(@"Nil~");
    }
    DFQianQianLyricsDownloader *d=[[DFQianQianLyricsDownloader alloc]init];
    d.delegate=self;
    [d downLoadLyricsByArtist:artist AndTitle:title];
    [d release];
}

-(void)downloadFinishedWithString:(NSString *)lyricsString{
    isDownloading=NO;
    if(![lyricsString isEqualToString:@"NoLyrics"]){
        [delegate updateLyrics:@"处理歌词..."];
        [self readLyricsWithString:lyricsString];
    }else {
        [delegate updateLyrics:@"没有找到歌词！"];
        NSLog(@"没有找到歌词");
    }
}


-(void)timerGoes:(NSTimer*)sender{
    
    //发现如果播放器状态改变的回调和这个函数同时触发的的时候会导致定时器不被停止，这里再做一次判断
    
    if(self.player.playbackState==MPMusicPlaybackStateStopped){
        NSLog(@"音乐已经结束");
        [endTimer invalidate];
        endTimer=nil;

        [lyricsTimer invalidate];
        lyricsTimer=nil;
        
    }else{
        float timeGoes=self.player.currentPlaybackTime;
        float readyTime=[[self.player.nowPlayingItem valueForKey:MPMediaItemPropertyPlaybackDuration]floatValue];
        
        float result=timeGoes/readyTime;
        [delegate updateSliderWithValue:result TimeGoes:[self timeStringWithNumber:(int)timeGoes] readyTime:[NSString stringWithFormat:@"-%@",[self timeStringWithNumber:(int)readyTime-(int)timeGoes]]];
        //NSLog(@"播放中");
    }
    


}

-(void)startPlayWithMusicCollection:(MPMediaItemCollection*)collection Artist:(NSString*)theArtist Title:(NSString*)theTitle{
    [self.player stop];
    [self.player setQueueWithItemCollection:collection];
    [self.player play];
    
    NSLog(@"%@",theArtist);
    [self findLyricsWithArtist:theArtist Title:theTitle];
    endTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerGoes:) userInfo:nil repeats:YES];
}

-(void)saveLyricsWithArtist:(NSString*)artist Title:(NSString*)title{
    NSLog(@"startSaving");
    [self.lyricsDictionary setObject:lyrics forKey:[NSString stringWithFormat:@"%@-%@",artist,title]];
    //NSLog(@"%@",self.lyricsDictionary);
}

-(int)getLyricsRowIndexByTime:(NSString*)time{
    
    float fTime=[self getLyricsTime:time];
    
    for(int i=0;i<[lyrics count];i++){
        LyricsRow *row=(LyricsRow*)[self.lyrics objectAtIndex:i];
        float rTime=[self getLyricsTime:row.time];
        //NSLog(@"索引%i对应的时间为%f",i,rTime);
        if(fTime<rTime){
            return i-1;
        }
    }
    return -1;
}

-(float)getLyricsTime:(NSString*)time{
    NSString *minute=[[time componentsSeparatedByString:@":"] objectAtIndex:0];
    NSString *second=[[time componentsSeparatedByString:@":"] objectAtIndex:1];
    return 60*[minute intValue]+[second floatValue];
}

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

-(void)lyricsTimerGoes:(NSTimer*)sender{
    
    //原本这个nowAt是一个全局变量，但是后来觉得为了这只有两个方法使用到的变量定义一个全局变量有点没必要就改成static变量了
    
    static int nowAt=-2;
    
        
    float playTime=[self.player currentPlaybackTime];
    
    
    NSString *playTimeS=[self timeStringWithNumber:playTime];

    
    //NSLog(@"%@",playTimeS);
    
    
    int t=[self getLyricsRowIndexByTime:playTimeS];
    
    
    if(nowAt!=t){
        nowAt=t;
        if(t!=-1){
            LyricsRow *row=(LyricsRow*)[self.lyrics objectAtIndex:t];
            [delegate updateLyrics:row.content];
            NSLog(@"%@",row.content);
        }
    }
}



-(void)readLyricsWithString:(NSString *)string{
    DFLyricsReader *reader=[[DFLyricsReader alloc] init];
    reader.delegate=self;
    [reader readLyricsWithLyricsString:string];

    if(delegate){
        [delegate loadingFinished];
    }else{
        NSLog(@"Nil");
    }
    lyricsTimer=[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(lyricsTimerGoes:) userInfo:nil repeats:YES];
    NSLog(@"TimerStarted-");
}

-(void)readingFinishedWithLyrics:(NSMutableArray *)lyricsFinished{
    NSMutableArray *theLyrics=[[NSMutableArray alloc]initWithArray:lyricsFinished];;
    
    //赋值部分
    if([lyrics count]>0){
        [self.lyrics removeAllObjects];
    }
    for(int i=0;i<[theLyrics count];i++){
        [self.lyrics addObject:[theLyrics objectAtIndex:i]];
    }
    [theLyrics release];
    
    //输出部分
    for(int i=0;i<[self.lyrics count];i++){
        LyricsRow *row=(LyricsRow*)[self.lyrics objectAtIndex:i];
        NSLog(@"!%@--%@",row.time,row.content);
    }
    
    [self saveLyricsWithArtist:[[self.player nowPlayingItem] valueForKey:MPMediaItemPropertyArtist] Title:[[self.player nowPlayingItem] valueForKey:MPMediaItemPropertyTitle]];

}

-(void)stopMusic{
    [player stop];
}

@end
