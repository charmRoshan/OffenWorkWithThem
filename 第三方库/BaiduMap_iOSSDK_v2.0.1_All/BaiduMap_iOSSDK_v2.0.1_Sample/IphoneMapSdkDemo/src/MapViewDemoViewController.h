//
//  MapViewDemoController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-3-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMapKit.h"
//@class BMKMapView;
@interface MapViewDemoViewController :  UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
    
    IBOutlet UITextField* xPos;
    IBOutlet UITextField* yPos;
    IBOutlet UISegmentedControl* segment;
    
}


@property (nonatomic, retain) IBOutlet UITextField* xPos;
@property (nonatomic, retain) IBOutlet UITextField* yPos;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;
-(IBAction)changeMapType:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
@end
