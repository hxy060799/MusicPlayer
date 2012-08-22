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
@property(retain,nonatomic)IBOutlet UIImageView *imageView;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *information;
@property(copy,nonatomic)UIImage *picture;

-(void)setTitle:(NSString *)tit;
-(void)setInformation:(NSString *)inf;
-(void)setPicture:(UIImage *)pic;

@end
