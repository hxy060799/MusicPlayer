//
//  BaiduMP3Searcher.h
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDownloader.h"

@protocol BaiduMP3SearcherDelegate <NSObject>
-(void)searchFinishedWithResult:(NSMutableArray*)result;
@end

@interface BaiduMP3Searcher : NSObject<DFDownloaderDelegate>
-(void)searchByString:(NSString *)theString;
@property(retain,nonatomic)id<BaiduMP3SearcherDelegate>delegate;
@end
