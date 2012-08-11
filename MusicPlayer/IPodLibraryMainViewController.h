//
//  IPodLibraryMainViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPodLibraryMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UINavigationBar *navigationBar;
    
    UITableView *iPodLibraryTableView;
    
    NSArray *tableViewItems;
}

@end
