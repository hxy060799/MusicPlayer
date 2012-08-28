//
//  DFOnlinePlayer.m
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFOnlinePlayer.h"

@implementation DFOnlinePlayer

-(void)destroyStreamer{
    if(streamer){
        [[NSNotificationCenter defaultCenter]removeObserver:self name:ASStatusChangedNotification object:streamer];
        
        [streamer stop];
        [streamer release];
        streamer=nil;
    }
}

-(void)createStreamer{
    
}

@end
