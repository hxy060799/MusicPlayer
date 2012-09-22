//
//  DFLyricsManager.m
//  MusicPlayer
//
//  Created by Bill on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFLyricsManager.h"
#import "DFLyricsMusicPlayer.h"


@implementation DFLyricsManager

@synthesize lyrics;
@synthesize isDowloading;
@synthesize delegate;
@synthesize lyricsTimer;

-(id)init{
    if(self){
        self.lyrics=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)startLyricsTimer{
    if(!lyricsTimer.isValid){
        if(lyrics.count==0){
            NSLog(@"No Lyrics");
        }else{
            [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(changeLyricsWithTime:) userInfo:nil repeats:YES];
        }
    }else{
        [self stopLyricsTimer];
    }
    NSLog(@"TimerStarted");
}

-(void)pauseLyricsTimer{
    [lyricsTimer invalidate];
    NSLog(@"TimerPaused");
}

-(void)stopLyricsTimer{
    [lyrics removeAllObjects];
}

-(void)setLyricsWithArtist:(NSString*)theArtist SongName:(NSString*)songName{
    isDownloading=YES;
    QQLyricsGetter *lyricsGetter=[[QQLyricsGetter alloc]init];
    lyricsGetter.delegate=self;
    [lyricsGetter startGetLyricsWithTitle:songName Artist:theArtist];
}

-(void)getLyrcsFinishedWithLyrics:(NSMutableArray*)lyricsReturn Getter:(QQLyricsGetter *)getter{
    isDownloading=NO;

    //赋值部分
    if([lyrics count]>0)[self.lyrics removeAllObjects];
    
    for(int i=0;i<[lyricsReturn count];i++){
        [self.lyrics addObject:[lyricsReturn objectAtIndex:i]];
    }
    
    //输出部分
    for(int i=0;i<[self.lyrics count];i++){
        NSMutableDictionary *row=[self.lyrics objectAtIndex:i];
        NSLog(@"!%@--%@",[row valueForKey:@"time"],[row valueForKey:@"content"]);
    }
    
    //lyricsTimer=[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(lyricsTimerGoes:) userInfo:nil repeats:YES];
    NSLog(@"TimerStarted-");
    [getter autorelease];
    
    [self startLyricsTimer];
}

-(int)getLyricsRowIndexByTime:(float)fTime{
    for(int i=0;i<[lyrics count];i++){
        NSMutableDictionary *row=[self.lyrics objectAtIndex:i];
        float rTime=[[row valueForKey:@"time"]floatValue];
        //NSLog(@"索引%i对应的时间为%f",i,rTime);
        if(fTime<rTime){
            return i-1;
        }
    }
    return -2;
}

-(void)changeLyricsWithTime:(NSTimer*)timer{
    
    static int currentAt=-1;
    
    //NSLog(@"%f",fTime);
    
    int indexShouldBe=[self getLyricsRowIndexByTime:manager.player.currentPlaybackTime];
    
    if(indexShouldBe==-2){
        [timer invalidate];
        timer=nil;
        NSLog(@"TimerStopped");
        [self stopLyricsTimer];
    }
    
    if(indexShouldBe!=currentAt){
        currentAt=indexShouldBe;
        
        NSMutableArray *lyricsRowsArray=[NSMutableArray array];
        for(int i=indexShouldBe-3;i<=indexShouldBe+3;i++){
            if(i>=0&&i<[lyrics count]){
                NSMutableDictionary *row=[self.lyrics objectAtIndex:i];
                [lyricsRowsArray addObject:[row valueForKey:@"content"]];
                if(i==indexShouldBe){
                    NSLog(@"%@",[row valueForKey:@"content"]);
                }
            }else{
                [lyricsRowsArray addObject:@"***"];
            }
        }
        if(delegate){
            [delegate updateLyrics:lyricsRowsArray];
        }
    }

}

-(void)dealloc{
    [self.lyrics release];
    [super dealloc];
}

@end
