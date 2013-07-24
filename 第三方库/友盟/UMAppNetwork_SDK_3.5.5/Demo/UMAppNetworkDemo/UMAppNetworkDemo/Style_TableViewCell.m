//
//  Style_TableViewCell.h
//  UFP
//
//  Created by liuyu on 10/11/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "Style_TableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation Style_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {                
        self.textLabel.font = [UIFont systemFontOfSize:17.0f];
        self.textLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.opaque = YES;
        self.textLabel.shadowColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
        self.textLabel.shadowOffset = CGSizeMake(0, 1);
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
        rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 25, 24, 8.0f, 13.0f)];
        rightArrow.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        rightArrow.image = [UIImage imageNamed:@"cell_right_arrow.png"];
        [self.contentView addSubview:rightArrow];
        [rightArrow release];
        
        UIImageView *bgimage = [[UIImageView alloc] initWithFrame:self.bounds];
        bgimage.image = [UIImage imageNamed:@"cell_bg.png"];
        self.backgroundView = bgimage;
        [bgimage release];
        
        UIImageView *bgimageSel = [[UIImageView alloc] initWithFrame:self.bounds];
        bgimageSel.image = [UIImage imageNamed:@"cell_bg_lighted.png"];
        self.selectedBackgroundView = bgimageSel;
        [bgimageSel release];
                
        if ([self.layer respondsToSelector:@selector(setShouldRasterize:)])
        {
            self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
            [self.layer setShouldRasterize:YES];
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.textLabel.frame;
    frame.origin.x = 15.0f;
    self.textLabel.frame = frame;
}

@end
