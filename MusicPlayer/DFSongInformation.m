//
//  DFSongInformation.m
//  MusicPlayer
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFSongInformation.h"

@implementation DFSongInformation

@synthesize pinYin;
@synthesize index;

-(void)dealloc{
    [super dealloc];
    if(pinYin)[pinYin retain];
}

@end
