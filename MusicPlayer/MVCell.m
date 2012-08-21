//
//  MVCell.m
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MVCell.h"

@implementation MVCell
@synthesize titleLabel;
@synthesize informationLabel;
@synthesize title;
@synthesize information;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setTitle:(NSString *)tit{
    if (![tit isEqualToString:title]) {
        title=[tit copy];
        self.titleLabel.text=title;
    }
}


-(void)setInformation:(NSString *)inf{
    if (![inf isEqualToString:information]) {
        information=[inf copy];
        self.informationLabel.text=information;
    }
}

@end
