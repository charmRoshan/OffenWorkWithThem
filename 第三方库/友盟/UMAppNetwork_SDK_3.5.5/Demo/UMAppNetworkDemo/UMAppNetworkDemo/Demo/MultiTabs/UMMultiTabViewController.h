//
//  UMMultiTabViewController.h
//  UFP
//
//  Created by liuyu on 3/20/13.
//  Copyright (c) 2013 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMUFPTableView.h"
#import "UMTabBar.h"

@interface UMMultiTabViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UMUFPTableViewDataLoadDelegate, UMTabBarDelegate> {
    
    UMTabBar       *_mTabBar;
    
    UMUFPTableView *_mNecessaryTableView;
    UMUFPTableView *_mRecommendTableView;
    UMUFPTableView *_mMarketTableView;
    
    UMUFPTableView *_mCurrentUMTableView;
}

@end