//
//  MVCell.h
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVCell : UITableViewCell

@property(retain,nonatomic)IBOutlet UILabel *titleLabel;
@property(retain,nonatomic)IBOutlet UILabel *informationLabel;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *information;

-(void)setTitle:(NSString *)tit;
-(void)setInformation:(NSString *)inf;

@end
