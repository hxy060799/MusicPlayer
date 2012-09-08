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

@protocol QQMusicSearcherDelegate <NSObject>
-(void)searchFinishedWithResult:(NSMutableArray*)result;
-(void)getLyricsFinishedWithResult:(NSString*)result;
@end

@interface QQMusicSearcher : NSObject<ASIHTTPRequestDelegate>

-(void)searchMusicWithTitle:(NSString*)title Artist:(NSString*)artist;
-(void)getLyricsWithMusicID:(NSInteger)songID;
-(void)getAlbumArtworkWithMusicId:(NSInteger)songID;

-(void)parseWithSearchResultRequest:(ASIHTTPRequest*)request;
-(void)parseWithLyricsGetRequest:(ASIHTTPRequest*)request;

-(NSString*)formatJsonWithJsonString:(NSString*)jsonString;

+(NSInteger)chooseLyricsWithLyricsResult:(NSMutableArray*)result Artist:(NSString*)artist;

@property(retain,nonatomic)id<QQMusicSearcherDelegate>delegate;

@end
