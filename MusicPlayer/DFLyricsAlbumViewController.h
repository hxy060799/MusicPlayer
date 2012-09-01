//
//  DFLyricsAlbumViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPaginator.h"


@interface DFLyricsAlbumViewController : SYPaginatorViewController{
    IBOutlet SYPageView *albumPageView;
    IBOutlet SYPageView *lyricsPageView;
    
    IBOutlet UIImageView *albumImageView;
    IBOutlet UIImageView *lyricsAlbumImageView;
    
    NSMutableArray *labelArray;
}

-(void)setAlbumArtwork:(UIImage*)albumArtwork;

@end
