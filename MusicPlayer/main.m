//
//  main.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "DFMusicQuery.h"

int main(int argc, char *argv[])
{
    
    DFMusicQuery *query=[[DFMusicQuery alloc]init];
    //[query albumQuery];
    [query release];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
