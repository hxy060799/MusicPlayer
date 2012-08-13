//
//  RefreshButtonCell.m
//  MusicPlayer
//
//  Created by Bill on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RefreshButtonCell.h"

@implementation RefreshButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}

-(void)setButton{
    [refreshButton setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
