//
//  QQLyricsGetter.h
//  MusicPlayer
//
//  Created by Bill on 12-9-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQMusicSearcher.h"

@class QQLyricsGetter;

@protocol QQLyricsGetterDelegate <NSObject>
-(void)getLyrcsFinishedWithLyrics:(NSString*)lyrics Getter:(QQLyricsGetter*)getter;
@end

@interface QQLyricsGetter : NSObject<QQMusicSearcherDelegate>{
    NSString *songTitle;
    NSString *songArtist;
    id<QQLyricsGetterDelegate>delegate;
    QQMusicSearcher *musicSearcher;
}

-(id)init;

-(void)startGetLyricsWithTitle:(NSString*)title Artist:(NSString*)artist;

@property(retain,nonatomic)id<QQLyricsGetterDelegate>delegate;

@end
