//
//  ViewController.m
//  UFP
//
//  Created by liu yu on 1/9/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "ViewController.h"

#import "Style_TableViewCell.h"

#import "UMTableViewController.h"
#import "UMWebViewController.h"
#import "UMBannerViewController.h"
#import "UMHandleViewController.h"
#import "UMGridViewController.h"
#import "UMTableViewController_New.h"
#import "UMMultiTabViewController.h"

@implementation ViewController

@synthesize tableView = _tableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    
    [_tableView release];
    _tableView = nil;
    [demoTitles release];
    demoTitles = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"样式列表";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    demoTitles = [[NSArray alloc] initWithObjects:@"BannerView", @"TableView", @"HandleView", @"WebView", @"GridView", @"TableView + New", @"MultiTabs", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)showTableView {
    
    UMTableViewController *controller = [[UMTableViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showTableView_New {
    
    UMTableViewController_New *controller = [[UMTableViewController_New alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showWebView {
    
    UMWebViewController *controller = [[UMWebViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showBannerView {
    
    UMBannerViewController *controller = [[UMBannerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showHandleView
{
    UMHandleViewController *controller = [[UMHandleViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showGridView
{
    UMGridViewController *controller = [[UMGridViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)showMultiTabView
{
    UMMultiTabViewController *controller = [[UMMultiTabViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark - UITableViewDataSource Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [demoTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UMUFPTableViewCell";
    
    Style_TableViewCell *cell = (Style_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[Style_TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [demoTitles objectAtIndex:indexPath.row];
        
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self showBannerView];
            break;
        
        case 1:
            [self showTableView];
            break;
        
        case 2:
            [self showHandleView];
            break;
            
        case 3:
            [self showWebView];
            break;
            
        case 4:
            [self showGridView];
            break;
            
        case 5:
            [self showTableView_New];
            break;
            
        case 6:
            [self showMultiTabView];
            break;
  
        default:
            break;
    }
}

@end
