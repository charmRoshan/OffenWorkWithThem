//
//  UMTabBar.m
//  UFP
//
//  Created by liuyu on 3/20/13.
//  Copyright (c) 2013 Realcent. All rights reserved.
//

#import "UMTabBar.h"

@implementation UMTabBar

@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (void)initTabButton:(UIButton *)btn {
    
    btn.showsTouchWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
}

- (void)setTabButtonTitle:(UIButton *)btn title:(NSString *)title {
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateSelected];
}

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray selectedImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self insertSubview:_backgroundView atIndex:0];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = self.frame.size.width / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
            btn.titleLabel.textColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
            [self initTabButton:btn];
            [self setTabButtonTitle:btn title:[[imageArray objectAtIndex:i] objectForKey:@"Title"]];
            
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
        
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.frame = CGRectMake(1, 1, width-2, frame.size.height-2);
        [_selectedButton setBackgroundImage:image forState:UIControlStateNormal];
        [_selectedButton setTitleColor:[UIColor colorWithRed:0.561 green:0.725 blue:0.031 alpha:1.0] forState:UIControlStateNormal];
        [self initTabButton:_selectedButton];
        
        NSString *title = [[imageArray objectAtIndex:0] objectForKey:@"Title"];
        [self setTabButtonTitle:_selectedButton title:title];
        
        [self addSubview:_selectedButton];
    }
    
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
    
    [UIView beginAnimations:@"SelectedItemChangedAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _selectedButton.center = btn.center;
    [UIView commitAnimations];
    
    NSString *title = btn.titleLabel.text;
    [self setTabButtonTitle:_selectedButton title:title];
    
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    
    [super dealloc];
}

@end
