//
//  YCSearchBar.h
//  TestSearchBar
//
//  Created by li shiyong on 10-12-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YCSearchBar : UISearchBar 
{
	BOOL canResignFirstResponder;
}

@property(nonatomic,assign) BOOL canResignFirstResponder;

@end
