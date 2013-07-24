//
//  ViewController.h
//  UFP
//
//  Created by liu yu on 1/9/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    NSArray *demoTitles;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)showWebView;
- (void)showGridView;
- (void)showTableView;
- (void)showBannerView;
- (void)showHandleView;

@end
