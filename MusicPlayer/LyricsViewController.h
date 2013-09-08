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
#import "DFLyricsAlbumViewController.h"
#import "QQLyricsGetter.h"

@interface LyricsViewController : UIViewController<DFLyricsMusicPlayerDelegate,DFLyricsManagerDelegate>{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *artistLabel;
    IBOutlet UILabel *albumLabel;
    IBOutlet UISlider *slider;
    
    IBOutlet UILabel *goesTimeL;
    IBOutlet UILabel *readyTimeL;
    IBOutlet UINavigationBar *navigationBar;
    
    UIButton *playButton;
    DFLyricsAlbumViewController *lyricsAlbumViewController;
}

-(IBAction)stopButtonClicked;
@end
