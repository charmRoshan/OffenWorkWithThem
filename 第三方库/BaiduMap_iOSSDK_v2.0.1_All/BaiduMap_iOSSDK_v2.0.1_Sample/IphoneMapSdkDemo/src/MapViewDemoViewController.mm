//
//  MapViewDemoController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-3-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "MapViewDemoViewController.h"
#import "BMapKit.h"

@implementation MapViewDemoViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
@synthesize yPos;
@synthesize xPos;
@synthesize segment;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

-(IBAction)changeMapType:(id)sender
{
    int index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _mapView.mapType = BMKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = BMKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = BMKMapTypeTrafficOn;
            break;
        case 3:
            _mapView.mapType = BMKMapTypeTrafficAndSatellite;
            break;
        default:
            break;
    }
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    CGPoint pt;
    if (((UITextField*)sender).tag == 101) {
        NSString* x = [NSString stringWithFormat:@"%@",((UITextField*)sender).text];
         pt = CGPointMake([x floatValue], _mapView.compassPosition.y);
        
    }
    if (((UITextField*)sender).tag == 102) {
        NSString* y = [NSString stringWithFormat:@"%@",((UITextField*)sender).text];
        pt = CGPointMake(_mapView.compassPosition.x, [y floatValue]);
        
    }
    [_mapView setCompassPosition:pt];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    //[mapView saveStateInstance];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    NSLog(@"%@",mapPoi.text);
}


- (void)dealloc {
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@end
