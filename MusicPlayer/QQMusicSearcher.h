//
//  QQMusicSearcher.h
//  MusicPlayer
//
//  Created by Bill on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#define NSGB2312StringEncoding CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

@interface QQMusicSearcher : NSObject<ASIHTTPRequestDelegate>

-(void)searchMusicWithTitle:(NSString*)title Artist:(NSString*)artist;
-(void)getLyricsWithMusicID:(NSInteger)songID;
-(void)getAlbumArtworkWithMusicId:(NSInteger)songID;
-(NSString*)formatJsonWithJsonString:(NSString*)jsonString;

@end
