//
//  AlbumSongsViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SongsTableViewController.h"

@interface AlbumSongsViewController : SongsTableViewController{
    IBOutlet UINavigationBar *navigationBar;
}
-(void)setItemsWithIndex:(int)index;
@end
