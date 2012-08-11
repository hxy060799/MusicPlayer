//
//  AllSongsViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

extern NSMutableArray *musicByTitle;

@interface AllSongsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UINavigationBar *navigationBar;
    UITableView *songsTableView;
    NSMutableArray *tableViewItems;
    NSMutableArray *tableViewSmallText;
}

-(IBAction)buttonClicked:(id)sender;

@end
