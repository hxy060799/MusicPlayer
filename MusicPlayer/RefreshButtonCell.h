//
//  RefreshButtonCell.h
//  MusicPlayer
//
//  Created by Bill on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIGlossyButton.h"

@interface RefreshButtonCell : UITableViewCell{
    IBOutlet UIGlossyButton *refreshButton;
}
-(void)setButton;
@end
