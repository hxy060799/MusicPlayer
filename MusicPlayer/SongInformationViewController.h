//
//  SongInformationViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMediaItem;

@interface SongInformationViewController : UIViewController{
    IBOutlet UIImageView *artworkView;
    IBOutlet UILabel *songTitle;
    IBOutlet UILabel *songArtist;
    IBOutlet UILabel *songAlbum;
}

@property(retain,nonatomic)IBOutlet UIImageView *artworkView;
@property(retain,nonatomic)IBOutlet UILabel *songTitle;
@property(retain,nonatomic)IBOutlet UILabel *songArtist;
@property(retain,nonatomic)IBOutlet UILabel *songAlbum;

-(void)setInformationWithItem:(MPMediaItem*)theItem;

@end
