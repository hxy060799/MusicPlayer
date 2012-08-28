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
    NSLog(@"destroyed");
}

-(void)createStreamerWithURL:(NSString*)url{
    if(streamer){
        return;
    }
    [self destroyStreamer];
    NSString *escapedValue=[(NSString*)CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)url, NULL, NULL, kCFStringEncodingUTF8)autorelease];
    
    NSURL *theURL=[NSURL URLWithString:escapedValue];
    streamer=[[AudioStreamer alloc]initWithURL:theURL];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playbackStateChanged:) name:ASStatusChangedNotification object:streamer];
    [streamer start];
}

-(void)stop{
    if(streamer){
        [streamer stop];
        [self destroyStreamer];
    }
}

- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting]){
		NSLog(@"IS WAITING");
	}else if ([streamer isPlaying]){
		NSLog(@"IS PLAYING");
	}else if ([streamer isIdle]){
		[self destroyStreamer];
		NSLog(@"IS IDLE");	
    }
}

@end
