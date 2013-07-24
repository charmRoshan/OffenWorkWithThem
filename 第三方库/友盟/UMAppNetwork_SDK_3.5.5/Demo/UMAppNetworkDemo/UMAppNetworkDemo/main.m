//
//  main.m
//  UMUFPDemo
//
//  Created by liu yu on 2/28/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int value = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    [pool release];
    
    return value;
}
