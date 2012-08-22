//
//  UISearchUtility.h
//  TestSearchBar
//
//  Created by li shiyong on 10-11-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCSearchController;
@protocol YCSearchControllerDelegete

@required
 
- (NSArray*)searchController:(YCSearchController *)controller searchString:(NSString *)searchString;

@end

@interface YCSearchController : UIViewController 
<UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
	id<YCSearchControllerDelegete> delegate;
	UISearchDisplayController *searchDisplayController;  //重新设置父类的这个属性
	
	//static NSMutableArray	*listContent;			// The master content.
	NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.

	UIView *searchMaskView;
	UITableView *searchTableView;
	NSString *lastSearchString;
	NSString *originalPlaceholderString;
	BOOL originalSearchBarHidden;
}

@property(nonatomic,retain) id<YCSearchControllerDelegete> delegate;
@property(nonatomic,retain) UISearchDisplayController *searchDisplayController;

@property(nonatomic,retain,readonly) NSMutableArray *listContent;
@property(nonatomic,retain,readonly) NSMutableArray *filteredListContent;

@property(nonatomic,retain) UIView *searchMaskView;
@property(nonatomic,retain) UITableView *searchTableView;
@property(nonatomic,retain) NSString *lastSearchString;
@property(nonatomic,retain) NSString *originalPlaceholderString;

- (id) initWithDelegate:(id<YCSearchControllerDelegete>)theDelegate 
searchDisplayController:(UISearchDisplayController*) theSearchDisplayController;

//激活或退出搜索
- (void)setActive:(BOOL)visible animated:(BOOL)animated;


@end
