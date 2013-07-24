//
//  UMMultiTabViewController.m
//  UFP
//
//  Created by liuyu on 3/20/13.
//  Copyright (c) 2013 Realcent. All rights reserved.
//

#import "UMMultiTabViewController.h"
#import "UMTableViewCell.h"

#define NECESSARY_APPKEY @"4f7046375270156912000011"
#define RECOMMEND_APPKEY @"4f7046375270156912000011"
#define    MARKET_APPKEY @"4f7046375270156912000011"

#define CELLHEIGHT 70.0

@interface UMMultiTabViewController ()

@end

@implementation UMMultiTabViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (_mCurrentUMTableView != _mNecessaryTableView)
    {
        _mNecessaryTableView.delegate = nil;
        [_mNecessaryTableView removeFromSuperview];
        [_mNecessaryTableView release];
        _mNecessaryTableView = nil;
    }
    
    if (_mCurrentUMTableView != _mRecommendTableView)
    {
        _mRecommendTableView.delegate = nil;
        [_mRecommendTableView removeFromSuperview];
        [_mRecommendTableView release];
        _mRecommendTableView = nil;
    }
    
    if (_mCurrentUMTableView != _mMarketTableView)
    {
        _mMarketTableView.delegate = nil;
        [_mMarketTableView removeFromSuperview];
        [_mMarketTableView release];
        _mMarketTableView = nil;
    }
}

- (void)dealloc {
    _mNecessaryTableView.dataLoadDelegate = nil;
    [_mNecessaryTableView release];
    _mNecessaryTableView = nil;
    _mRecommendTableView.dataLoadDelegate = nil;
    [_mRecommendTableView release];
    _mRecommendTableView = nil;
    _mMarketTableView.dataLoadDelegate = nil;
    [_mMarketTableView release];
    _mMarketTableView = nil;
    
    [super dealloc];
}

#pragma mark - title view init

- (void)initTitleView {
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:1];
    [imgDic1 setObject:@"装机必备" forKey:@"Title"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:1];
    [imgDic2 setObject:@"热门推荐" forKey:@"Title"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:1];
    [imgDic3 setObject:@"市场专区" forKey:@"Title"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic1,imgDic2,imgDic3,nil];
    
    _mTabBar = [[UMTabBar alloc] initWithFrame:CGRectMake(0, 6, 192, 31) buttonImages:imgArr selectedImage:[UIImage imageNamed:@"um_itemSel.png"]];
    [_mTabBar setBackgroundImage:[UIImage imageNamed:@"um_itemsBg.png"]];
    _mTabBar.delegate = self;
    self.navigationItem.titleView = _mTabBar;
    [_mTabBar release];
}

- (void)initRefreshButton {
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [[refreshButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [refreshButton setImage:[UIImage imageNamed:@"um_reload.png"] forState:UIControlStateNormal];
    [refreshButton setImage:[UIImage imageNamed:@"um_reloadSel.png"] forState:UIControlStateHighlighted];
    refreshButton.bounds = CGRectMake(0, 0, 36.0f, 19.0f);
    [refreshButton addTarget:self action:@selector(reloadPromoterData) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *refreshBtnItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    self.navigationItem.rightBarButtonItem = refreshBtnItem;
    [refreshBtnItem release];
}

- (void)tabBar:(UMTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    BOOL needLoadingView = NO;
    
    switch (index) {
        case 0:
            if (!_mNecessaryTableView)
            {
                _mNecessaryTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain appkey:NECESSARY_APPKEY slotId:nil currentViewController:self];
                _mNecessaryTableView.tag = 0;
                _mNecessaryTableView.mRequestCount = 15;
                _mNecessaryTableView.delegate = self;
                _mNecessaryTableView.dataSource = self;
                _mNecessaryTableView.rowHeight = CELLHEIGHT;
                _mNecessaryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                _mNecessaryTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
                [_mNecessaryTableView requestPromoterDataInBackground];
                [self.view addSubview:_mNecessaryTableView];
                
                needLoadingView = YES;
            }
            _mCurrentUMTableView = _mNecessaryTableView;
            break;
            
        case 1:
            if (!_mRecommendTableView)
            {
                _mRecommendTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain appkey:RECOMMEND_APPKEY slotId:nil currentViewController:self];
                _mRecommendTableView.tag = 1;
                _mRecommendTableView.mRequestCount = 15;
                _mRecommendTableView.delegate = self;
                _mRecommendTableView.dataSource = self;
                _mRecommendTableView.rowHeight = CELLHEIGHT;
                _mRecommendTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                _mRecommendTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
                [_mRecommendTableView requestPromoterDataInBackground];
                [self.view addSubview:_mRecommendTableView];
                
                needLoadingView = YES;
            }
            _mCurrentUMTableView = _mRecommendTableView;
            break;
            
        case 2:
            if (!_mMarketTableView)
            {
                _mMarketTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain appkey:MARKET_APPKEY slotId:nil currentViewController:self];
                _mMarketTableView.tag = 2;
                _mMarketTableView.mRequestCount = 15;
                _mMarketTableView.delegate = self;
                _mMarketTableView.dataSource = self;
                _mMarketTableView.rowHeight = CELLHEIGHT;
                _mMarketTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                _mMarketTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
                [_mMarketTableView requestPromoterDataInBackground];
                [self.view addSubview:_mMarketTableView];
                
                needLoadingView = YES;
            }
            _mCurrentUMTableView = _mMarketTableView;
            break;
            
        default:
            break;
    }
    
    [self.view bringSubviewToFront:_mCurrentUMTableView];

    [_mCurrentUMTableView reloadData];
}

- (void)backToPrevious
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadPromoterData {
    
    [_mCurrentUMTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_mCurrentUMTableView requestPromoterDataInBackground];
}

- (void)initNavigationBar:(UINavigationBar *)bar
{
    UINavigationBar *navBar = bar;
    navBar.barStyle = UIBarStyleBlackTranslucent;
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [navBar setBackgroundImage:[UIImage imageNamed:@"um_navigationbarBg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:
                                  [UIImage imageNamed:@"um_navigationbarBg.png"]];
        imageView.frame = navBar.bounds;
        imageView.backgroundColor = [UIColor clearColor];
        [navBar insertSubview:imageView atIndex:0];
        [imageView release];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTitleView];
    [self initNavigationBar:self.navigationController.navigationBar];
    [self initRefreshButton];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    _mNecessaryTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain appkey:NECESSARY_APPKEY slotId:nil currentViewController:self];
    _mNecessaryTableView.tag = 0;
    _mNecessaryTableView.mRequestCount = 15;
    _mNecessaryTableView.delegate = self;
    _mNecessaryTableView.dataSource = self;
    _mNecessaryTableView.rowHeight = CELLHEIGHT;
    _mNecessaryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mNecessaryTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
    
    [self.view addSubview:_mNecessaryTableView];
    
    _mCurrentUMTableView = _mNecessaryTableView;    
    [_mNecessaryTableView requestPromoterDataInBackground];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource Delegate methods

- (NSArray *)getPromoterDataForTableView:(UITableView *)tableView
{
    switch (tableView.tag) {
        case 0:
            return _mNecessaryTableView.mPromoterDatas;
            
        case 1:
            return _mRecommendTableView.mPromoterDatas;
            
        case 2:
            return _mMarketTableView.mPromoterDatas;
            
        default:
            return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *promoterData = [self getPromoterDataForTableView:tableView];
    
    if (!_mCurrentUMTableView.mIsAllLoaded && [promoterData count] > 0)
    {
        return [promoterData count] + 1;
    }
    else if (_mCurrentUMTableView.mIsAllLoaded && [promoterData count] > 0)
    {
        return [promoterData count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UMUFPTableViewCell";
    
    NSArray *promoterData = [self getPromoterDataForTableView:tableView];
    
    if (indexPath.row < [promoterData count])
    {
        UMTableViewCell *cell = (UMTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UMTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        
        NSDictionary *promoter = [promoterData objectAtIndex:indexPath.row];
        cell.textLabel.text = [promoter valueForKey:@"title"];
        cell.detailTextLabel.text = [promoter valueForKey:@"ad_words"];
        [cell setImageURL:[promoter valueForKey:@"icon"]];
        return cell;
    }
    else
    {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UMUFPTableViewCell2"];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UMUFPTableViewCell2"] autorelease];
            UIView *bgimageSel = [[[UIView alloc] initWithFrame:cell.bounds] autorelease];
            bgimageSel.backgroundColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1.0];
            cell.selectedBackgroundView = bgimageSel;
        }
        
        for (UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }
        
        UILabel *addMoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 30)] autorelease];
        addMoreLabel.textColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1.0];
        addMoreLabel.backgroundColor = [UIColor clearColor];
        addMoreLabel.textAlignment = UITextAlignmentCenter;
        addMoreLabel.font = [UIFont boldSystemFontOfSize:14];
        addMoreLabel.text = @"加载中...";
        [cell.contentView addSubview:addMoreLabel];
        
        UIActivityIndicatorView *loadingIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        loadingIndicator.backgroundColor = [UIColor clearColor];
        loadingIndicator.frame = CGRectMake(115, 20, 30, 30);
        [loadingIndicator startAnimating];
        [cell.contentView addSubview:loadingIndicator];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *promoterData = [self getPromoterDataForTableView:tableView];
    
    if (indexPath.row < [promoterData count])
    {
        NSDictionary *promoter = [promoterData objectAtIndex:indexPath.row];
        [_mCurrentUMTableView didClickPromoterAtIndex:promoter index:indexPath.row];
    }
}

#pragma mark - UMTableViewDataLoadDelegate methods

- (void)UMUFPTableViewDidLoadDataFinish:(UMUFPTableView *)tableView promoters:(NSArray *)promoters {
    
    NSArray *promoterData = tableView.mPromoterDatas;
    
    if ([promoters count] > 0)
    {        
        [tableView reloadData];
    }
    else if ([promoterData count])
    {
        [tableView reloadData];
    }
}

- (void)UMUFPTableView:(UMUFPTableView *)tableView didLoadDataFailWithError:(NSError *)error {
    
    NSArray *promoterData = tableView.mPromoterDatas;
    
    if ([promoterData count])
    {
        [tableView reloadData];
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    UIEdgeInsets contentInset = scrollView.contentInset;
    
    float y = contentOffset.y + bounds.size.height - contentInset.bottom;
    if (y > contentSize.height-30)
    {
        [_mCurrentUMTableView requestMorePromoterInBackground];
    }    
}

@end
