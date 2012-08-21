//
//  MVSwitchViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVSwitchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *mvTableView;
    NSMutableArray *tableViewArray;
}

@end
