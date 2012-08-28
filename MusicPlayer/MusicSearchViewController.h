//
//  MusicSearchViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSearchController.h"
#import "BaiduMP3Searcher.h"

@interface MusicSearchViewController : UIViewController<YCSearchControllerDelegete,UITableViewDelegate,UITableViewDataSource,BaiduMP3SearcherDelegate>{
    YCSearchController *searchController;
    IBOutlet UITableView *searchTableView;
    NSMutableArray *tableViewItems;
    NSString *lastSearchString;
}
@end
