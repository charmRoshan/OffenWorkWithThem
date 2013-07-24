//
//  OfflineDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-16.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface OfflineDemoViewController :UIViewController<BMKMapViewDelegate,BMKOfflineMapDelegate>
{
    IBOutlet BMKMapView* _mapView;
    BMKOfflineMap* _offlineMap;
    IBOutlet UIButton* downLoadBtn;
    IBOutlet UIButton* scanBtn;
    IBOutlet UIButton* stopBtn;
    IBOutlet UIButton* removeBtn;
    IBOutlet UIButton* viewBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UITextField* cityName;
    IBOutlet UITextField* cityId;
}
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)scan:(id)sender;
-(IBAction)search:(id)sender;
-(IBAction)remove:(id)sender;
-(IBAction)viewOfflineMap:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
@end
