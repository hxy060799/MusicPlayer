//
//  DFQianQianLyricsDownloader.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFDownloader.h"

@protocol DFQianQianLyricsDownloaderDelegate <NSObject>
-(void)downloadFinishedWithString:(NSString*)lyricsString;
-(void)searchFinished;
@end

@interface DFQianQianLyricsDownloader : NSObject<DFDownloaderDelegate>{
    NSString *artistToUse;
    NSString *titleToUse;
    id<DFQianQianLyricsDownloaderDelegate>delegate;
}

@property(retain,nonatomic)id<DFQianQianLyricsDownloaderDelegate>delegate;

-(void)downLoadLyricsByArtist:(NSString*)theArtist AndTitle:(NSString*)theTitle;
-(void)searchFinishedWithResult:(NSString*)result;
@end
