//
//  UMTabBar.h
//  UFP
//
//  Created by liuyu on 3/20/13.
//  Copyright (c) 2013 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMTabBarDelegate;

@interface UMTabBar : UIView
{
	UIImageView *_backgroundView;
	id<UMTabBarDelegate> _delegate;
	NSMutableArray *_buttons;
    UIButton *_selectedButton;
}

@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, assign) id<UMTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray selectedImage:(UIImage *)image;
- (void)setBackgroundImage:(UIImage *)img;

@end

@protocol UMTabBarDelegate<NSObject>

@optional
- (void)tabBar:(UMTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end
