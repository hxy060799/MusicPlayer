//
//  SearchBarCell.h
//  MusicPlayer
//
//  Created by Bill on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSearchBar.h"

@interface SearchBarCell : UITableViewCell

@property(retain,nonatomic)IBOutlet YCSearchBar *searchBar;
@property(retain,nonatomic)IBOutlet UISegmentedControl *segmentedControl;
@end

