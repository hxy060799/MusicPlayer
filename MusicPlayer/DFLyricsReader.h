//
//  DFLyricsReader.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFLycirsReaderDelegete <NSObject>
-(void)readingFinishedWithLyrics:(NSMutableArray*)lyricsFinished;
@end

@interface DFLyricsReader : NSObject{
    id<DFLycirsReaderDelegete>delegate;
}
@property(retain,nonatomic)id<DFLycirsReaderDelegete>delegate;
-(void)readLyricsWithLyricsString:(NSString*)lyricsString;
-(float)getLyricsTime:(NSString*)time;
@end
