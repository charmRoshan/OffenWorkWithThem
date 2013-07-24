//
//  AnnotationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "AnnotationDemoViewController.h"


@implementation AnnotationDemoViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

BMKPointAnnotation* annotation;
-(void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    if (annotation == nil) {
        annotation = [[[BMKPointAnnotation alloc]init] autorelease];
        
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        annotation.coordinate = coor;
        
        annotation.title = @"test";
        annotation.subtitle = @"此Annotation可拖拽!";
        [_mapView addAnnotation:annotation];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"renameMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* newAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (newAnnotation == nil) {
        newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        // 设置颜色
		((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
		((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
        // 设置可拖拽
		((BMKPinAnnotationView*)newAnnotation).draggable = YES;
		return newAnnotation;
    }
    
	return nil;
}

// Override
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}


- (void)dealloc {
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}


@end
