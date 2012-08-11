//
//  LyricsRow.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricsRow : NSObject{
    NSString *content;
    NSString *time;
}
@property(retain,nonatomic)NSString *content;
@property(retain,nonatomic)NSString *time;

@end
