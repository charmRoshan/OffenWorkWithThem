//
//  OfflineDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-16.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "OfflineDemoViewController.h"

@implementation OfflineDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _offlineMap = [[BMKOfflineMap alloc]init];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _offlineMap.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _offlineMap.delegate = nil; // 不用时，置nil
}


- (IBAction)search:(id)sender
{
    //根据城市名获取城市信息，得到cityID
    NSArray* city = [_offlineMap searchCity:cityName.text];
    if (city.count > 0) {
        BMKOLSearchRecord* oneCity = [city objectAtIndex:0];
        cityId.text =  [NSString stringWithFormat:@"%d", oneCity.cityID];
    }
}

-(IBAction)start:(id)sender
{
    [_offlineMap start:[cityId.text floatValue]];
}

-(IBAction)stop:(id)sender
{
    [_offlineMap pause:[cityId.text floatValue]];
}

-(IBAction)scan:(id)sender
{
    [_offlineMap scan:NO];
}
-(IBAction)remove:(id)sender
{
    [_offlineMap remove:[cityId.text floatValue]];
}
-(IBAction)viewOfflineMap:(id)sender
{
    //获取本地已经下载的所有离线包
    NSArray* localMapInfo = [_offlineMap getAllUpdateInfo];
    if (localMapInfo != nil) {
        BMKOLUpdateElement* item = [localMapInfo objectAtIndex:0];
        [_mapView setCenterCoordinate:item.pt];
    }
    
}

- (void)onGetOfflineMapState:(int)type withState:(int)state
{
    
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        //导入成功state个离线包，导入成功后会回调此类型
    }
    
}

- (void)dealloc {
    [super dealloc];
    if (_offlineMap != nil) {
        [_offlineMap release];
        _offlineMap = nil;
    }
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
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
