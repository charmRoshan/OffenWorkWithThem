//
//  OverlayDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-4-19.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "OverlayDemoViewController.h"

@implementation OverlayDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加圆形覆盖物
	CLLocationCoordinate2D coor;
	coor.latitude = 39.915;
	coor.longitude = 116.404;
	BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
	[_mapView addOverlay:circle];
    
    // 添加多边形覆盖物
	CLLocationCoordinate2D coords[4] = {0};
	coords[0].latitude = 39.915;
	coords[0].longitude = 116.404;
	coords[1].latitude = 39.815;
	coords[1].longitude = 116.404;
	coords[2].latitude = 39.815;
	coords[2].longitude = 116.504;
    coords[3].latitude = 39.915;
	coords[3].longitude = 116.504;
	BMKPolygon* polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
	[_mapView addOverlay:polygon];
    
    //添加折线覆盖物
    CLLocationCoordinate2D coors[2] = {0};
	coors[0].latitude = 39.895;
	coors[0].longitude = 116.354;
	coors[1].latitude = 39.815;
	coors[1].longitude = 116.304;
	BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
	[_mapView addOverlay:polyline];
    
    [_mapView setZoomLevel:11];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[[BMKCircleView alloc] initWithOverlay:overlay] autorelease];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
		return circleView;
    }

    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
		return polylineView;
    }
	
	if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[[BMKPolygonView alloc] initWithOverlay:overlay] autorelease];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =2.0;
		return polygonView;
    }
	return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}

@end
