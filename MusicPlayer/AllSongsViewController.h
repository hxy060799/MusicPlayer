//
//  AllSongsViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "SongsTableViewController.h"

extern NSMutableArray *musicByTitle;

@interface AllSongsViewController : SongsTableViewController{
    IBOutlet UINavigationBar *navigationBar;
    //UITableView *songsTableView;
    NSMutableArray *tableViewItems;
    NSMutableArray *tableViewSmallText;
}

-(void)loadSongs;

@end
