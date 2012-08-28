//
//  HotMVGetter.h
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDownloader.h"

struct mvInformation{
    NSMutableArray *information;
    int pagesCount;
};

@protocol HotMVGetterDelegate <NSObject>
-(void)downloadFinishedWithResult:(struct mvInformation)result AndKey:(NSString*)key;
@end

@interface HotMVGetter : NSObject<DFDownloaderDelegate>
-(void)getHotMVWithPage:(int)page;
-(void)searchByString:(NSString *)theString AndPage:(int)page;
@property(retain,nonatomic)id<HotMVGetterDelegate>delegate;
@end
