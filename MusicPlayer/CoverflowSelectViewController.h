//
//  CoverflowSelectViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverflowSelectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *songsTableView;
    NSMutableArray *tableViewItems;
    
    IBOutlet UINavigationBar *navigationBar;
}
-(void)fallToPoint:(CGPoint)point;
@end
