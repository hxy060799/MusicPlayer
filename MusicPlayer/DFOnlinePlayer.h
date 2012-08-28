//
//  DFOnlinePlayer.h
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioStreamer.h"

@interface DFOnlinePlayer : NSObject{
    AudioStreamer *streamer;
}
-(void)destroyStreamer;
-(void)createStreamer;
@end
