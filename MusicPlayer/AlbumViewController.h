//
//  AlbumViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicGroupViewController.h"

@interface AlbumViewController : MusicGroupViewController{
    IBOutlet UINavigationBar *navigationBar;
}
@property(retain,nonatomic)IBOutlet UINavigationBar *navigationBar;

@end
