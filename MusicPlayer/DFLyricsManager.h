//
//  DFLyricsManager.h
//  MusicPlayer
//
//  Created by Bill on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQLyricsGetter.h"
#import "Constents.h"

@protocol DFLyricsManagerDelegate <NSObject>
-(void)updateLyrics:(NSMutableArray*)lyric;
@end

@interface DFLyricsManager : NSObject<QQLyricsGetterDelegate>{
    NSMutableArray *lyrics; 
    BOOL isDownloading;
    NSTimer *lyricsTimer;
    
    id<DFLyricsManagerDelegate>delegate;
}

@property(retain,nonatomic)NSMutableArray *lyrics;
@property(assign,nonatomic)BOOL isDowloading;
@property(retain,nonatomic)id<DFLyricsManagerDelegate>delegate;
@property(retain,nonatomic)NSTimer *lyricsTimer;

-(id)init;

-(void)setLyricsWithArtist:(NSString*)theArtist SongName:(NSString*)songName;

-(void)startLyricsTimer;
-(void)pauseLyricsTimer;
-(void)stopLyricsTimer;

@end
