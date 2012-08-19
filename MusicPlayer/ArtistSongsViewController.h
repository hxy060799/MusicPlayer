//
//  ArtistSongsViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SongsTableViewController.h"

@interface ArtistSongsViewController : SongsTableViewController{
    IBOutlet UINavigationBar *navigationBar;
}
-(void)setItemsWithIndex:(int)index;
@end
