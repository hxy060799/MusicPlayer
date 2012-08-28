//
//  DFLyricsMusicPlayer.h
//  MusicPlayer
//
//  Created by Bill on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "LyricsRow.h"
#import "DFLyricsReader.h"
#import "DFQianQianLyricsDownloader.h"

@protocol DFLyricsMusicPlayerDelegate <NSObject>
-(void)loadingFinished;
-(void)musicEnded;
-(void)updateSliderWithValue:(float)value TimeGoes:(NSString*)goesTime readyTime:(NSString*)readyTime;

//测试中
-(void)updateLyrics:(NSString*)lyric;
-(void)musicChanged;
@end

@interface DFLyricsMusicPlayer : NSObject<DFLycirsReaderDelegete,DFQianQianLyricsDownloaderDelegate>{
    MPMusicPlayerController *player;
    NSMutableArray *lyrics;
    id<DFLyricsMusicPlayerDelegate>delegate;
    BOOL isDownloading;
    
    //测试中
    NSMutableDictionary *lyricsDictionary;
}

@property(retain,nonatomic)MPMusicPlayerController *player;
@property(retain,nonatomic)NSMutableArray *lyrics;
@property(retain,nonatomic)id<DFLyricsMusicPlayerDelegate>delegate;
@property(assign,nonatomic)BOOL isDownloading;
//测试中
@property(retain,nonatomic)NSMutableDictionary *lyricsDictionary;

-(id)init;
-(void)readLyricsWithString:(NSString*)string;


//测试中
-(int)getLyricsRowIndexByTime:(NSString*)time;
-(void)saveLyricsWithArtist:(NSString*)artist Title:(NSString*)title;
-(void)findLyricsWithArtist:(NSString*)artist Title:(NSString*)title;
-(void)startPlayWithMusicCollection:(MPMediaItemCollection*)collection Artist:(NSString*)theArtist Title:(NSString*)theTitle;
-(void)stopMusic;

@end
