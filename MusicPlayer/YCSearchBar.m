//
//  YCSearchBar.m
//  TestSearchBar
//
//  Created by li shiyong on 10-12-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YCSearchBar.h"


@implementation YCSearchBar

@synthesize canResignFirstResponder;

- (BOOL)resignFirstResponder
{
	if (self.canResignFirstResponder) 
	{
		return [super resignFirstResponder];
	}
	
	return NO;
}



@end
