//
//  ViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "RootViewController.h"
#import "MapViewDemoViewController.h"
#import "PoiSearchDemoViewController.h"
#import "BusLineSearchViewController.h"
#import "RouteSearchDemoViewController.h"
#import "LocationDemoViewController.h"
#import "OfflineDemoViewController.h"
#import "OverlayDemoViewController.h"
#import "AnnotationDemoViewController.h"
#import "GeocodeDemoViewController.h"
#import "CustomOverlayDemoViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _demoNameArray = [[NSArray alloc]initWithObjects:
					  @"MapViewDemo",
					  @"LocationDemo",
					  @"AnnotationDemo",
					  @"OverlayDemo",
					  @"PoiSearchDemo",
					  @"RouteSearchDemo",
					  @"ReverseGeocodeDemo",
					  @"OfflineDemo",
                      @"BusLineSearchDemo",
                      @"CustomOverlayDemo",
					  nil];

    NSMutableArray *array = [[NSMutableArray alloc] init];
	
	MapViewDemoViewController *mapviewDemoController = [[[MapViewDemoViewController alloc] init] autorelease];
	mapviewDemoController.title = @"MapViewDemo";
	
	LocationDemoViewController *locationDemoController = [[[LocationDemoViewController alloc] init] autorelease];
	locationDemoController.title = @"LocationDemo";
	
	AnnotationDemoViewController *annotationDemoController = [[[AnnotationDemoViewController alloc] init] autorelease];
	annotationDemoController.title = @"AnnotationDemo";
	
	OverlayDemoViewController *overlayDemoController = [[[OverlayDemoViewController alloc] init] autorelease];
	overlayDemoController.title = @"OverlayDemo";
	
	PoiSearchDemoViewController *poiSearchDemoController = [[[PoiSearchDemoViewController alloc] init] autorelease];
	poiSearchDemoController.title = @"PoiSearchDemo";
	
	RouteSearchDemoViewController *routeSearchDemoController = [[[RouteSearchDemoViewController alloc] init] autorelease];
	routeSearchDemoController.title = @"RouteSearchDemo";
	
	GeocodeDemoViewController *geocodeDemoController = [[[GeocodeDemoViewController alloc] init] autorelease];
	geocodeDemoController.title = @"ReverseGeocodeDemo";
    
    	
	OfflineDemoViewController *offlineDemo = [[[OfflineDemoViewController alloc] init] autorelease];
	offlineDemo.title = @"OfflineDemo";
    
    BusLineSearchViewController *buslineDemo = [[[BusLineSearchViewController alloc] init] autorelease];
	buslineDemo.title = @"BusLineSearchDemo";
    
    CustomOverlayDemoViewController *customOverlayDemo = [[[CustomOverlayDemoViewController alloc] init] autorelease];
    customOverlayDemo.title = @"CustomOverlayDemo";
	
	[array addObject:mapviewDemoController];
	[array addObject:locationDemoController];
	[array addObject:annotationDemoController];
	[array addObject:overlayDemoController];
	[array addObject:poiSearchDemoController];
	[array addObject:routeSearchDemoController];
	[array addObject:geocodeDemoController];
	[array addObject:offlineDemo];
    [array addObject:buslineDemo];
    [array addObject:customOverlayDemo];
	_viewControllerArray = array;
	
	self.title = NSLocalizedString(@"BaiduMapApiDemo", @"BaiduMapApiDemo title");
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _demoNameArray.count;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaiduMapApiDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[_demoNameArray objectAtIndex:indexPath.section] copy];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = [_viewControllerArray objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:viewController animated:YES];

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[_demoNameArray release];
    [_viewControllerArray release];
    [super dealloc];
}

@end
