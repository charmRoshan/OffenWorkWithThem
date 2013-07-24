//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageView.h"
#import "EGOImageLoader.h"

@implementation EGOImageView
@synthesize imageURL, placeholderImage, delegate;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL
{
	if(imageURL)
    {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL)
    {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	}
    else
    {
		imageURL = [aURL retain];
	}
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
    
    UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
    
	if(anImage)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            self.image = anImage;
            float scale = self.frame.size.width/CGImageGetWidth(anImage.CGImage);
            [self redrawImage:anImage to:self withScale:scale];
            // trigger the delegate callback if the image was found in the cache
            if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)])
            {
                [self.delegate imageViewLoadedImage:self];
            }
        });
	}
    else
    {
		self.image = self.placeholderImage;
	}
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}


- (void)imageLoaderDidLoad:(NSNotification*)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
        UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
            //            self.image = anImage;
            float scale = self.frame.size.width/CGImageGetWidth(anImage.CGImage);
            [self redrawImage:anImage to:self withScale:scale];
            self.alpha = 1;
        }];
        
        [self setNeedsDisplay];
        
        if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)])
        {
            [self.delegate imageViewLoadedImage:self];
        }
        
    });
    
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark - Add Function

-(void)redrawImage:(UIImage *)image to:(UIImageView *)imageView withScale:(float)scale
{
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, scale*CGImageGetHeight(image.CGImage));
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, scale*(CGImageGetWidth(image.CGImage)), scale*(CGImageGetHeight(image.CGImage))), image.CGImage);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
//    [imageView.layer setMasksToBounds:YES];
//    [imageView.layer setCornerRadius:3];
    
    // 阴影无效,而且阴影超卡
//    [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
//    [imageView.layer setShadowOffset:CGSizeMake(5, 5)];
//    [imageView.layer setShadowOpacity:0.5];
//    [imageView.layer setShadowRadius:5];
    
    UIGraphicsEndImageContext();
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	self.delegate = nil;
	self.imageURL = nil;
	self.placeholderImage = nil;
    [super dealloc];
}

@end
