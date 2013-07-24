//
//  OverlayDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-4-19.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface OverlayDemoViewController : UIViewController<BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
}
@end
