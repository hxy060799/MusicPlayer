//
//  DFLyricsMusicPlayer.h
//  MusicPlayer
//
//  Created by Bill on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "DFLyricsReader.h"
#import "QQLyricsGetter.h"
#import "DFLyricsManager.h"

@protocol DFLyricsMusicPlayerDelegate <NSObject>
-(void)musicEnded;
-(void)updateSliderWithValue:(float)value TimeGoes:(NSString*)goesTime readyTime:(NSString*)readyTime;
-(void)musicChanged;

//测试中

@end

@interface DFLyricsMusicPlayer : NSObject{
    MPMusicPlayerController *player;
    DFLyricsManager *lyricsManager;
    
    id<DFLyricsMusicPlayerDelegate>delegate;
    BOOL isDownloading;
}

@property(retain,nonatomic)MPMusicPlayerController *player;
@property(retain,nonatomic)id<DFLyricsMusicPlayerDelegate>delegate;
@property(retain,nonatomic)DFLyricsManager *lyricsManager;

-(id)init;

//测试中
-(void)startPlayWithMusicCollection:(MPMediaItemCollection*)collection Artist:(NSString*)theArtist Title:(NSString*)theTitle;
-(void)stopMusic;

@end
