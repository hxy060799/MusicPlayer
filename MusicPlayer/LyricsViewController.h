//
//  LyricsViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DFLyricsReader.h"
#import "DFLyricsMusicPlayer.h"
#import "DFQianQianLyricsDownloader.h"

@interface LyricsViewController : UIViewController<MPMediaPickerControllerDelegate,DFLyricsMusicPlayerDelegate>{
    IBOutlet UILabel *label;
    IBOutlet UIImageView *albumImageView;
    IBOutlet UISlider *slider;
    
    IBOutlet UILabel *goesTimeL;
    IBOutlet UILabel *readyTimeL;
    IBOutlet UINavigationBar *navigationBar;
}

-(IBAction)stopButtonClicked;
@end
