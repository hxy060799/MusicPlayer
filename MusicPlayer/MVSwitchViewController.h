//
//  MVSwitchViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSearchController.h"

@interface MVSwitchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YCSearchControllerDelegete>{
    UITableView *mvTableView;
    NSMutableArray *tableViewArray;
    IBOutlet UINavigationBar *navigationBar;
    
    UISearchDisplayController *searchDisplayController;
}
@property (nonatomic, retain) YCSearchController *searchController;

@end
