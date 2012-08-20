//
//  CoverflowSelectViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoverFlowSelectViewDelegate <NSObject>
-(void)backButtonClicked;
@end

@interface CoverflowSelectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *songsTableView;
    NSMutableArray *tableViewItems;
    
    IBOutlet UINavigationBar *navigationBar;
    id<CoverFlowSelectViewDelegate>deleagte;
}
-(void)fallToPoint:(CGPoint)point;
@property(retain,nonatomic)id<CoverFlowSelectViewDelegate>deleagte;
@end

