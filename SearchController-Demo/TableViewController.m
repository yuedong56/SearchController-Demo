//
//  TableViewController.m
//  SearchController-Demo
//
//  Created by yuedongkui on 2019/10/29.
//  Copyright © 2019 LY. All rights reserved.
//

#import "TableViewController.h"
#import "SearchResultsController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *tableData;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchResultsController *resultsController;

@end



@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)];
    self.navigationItem.leftBarButtonItem = item;
    
    //数据
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [mArr addObject:[@(i) stringValue]];
    }
    self.tableData = [mArr copy];

    //初始化 TableView
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    //初始化 SearchController
    {
        self.resultsController = [[SearchResultsController alloc] init];
        
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];
//        self.searchController.searchResultsUpdater = self.resultsController;
//        self.searchController.delegate = self;
//        self.searchController.searchBar.delegate = self;

        self.searchController.obscuresBackgroundDuringPresentation = YES; //搜索时，背景色半透明
        self.searchController.hidesNavigationBarDuringPresentation = YES; //搜索时，隐藏导航栏
        
        self.navigationItem.searchController = self.searchController; //iOS11 后，可以放在导航栏
        
        //self.navigationItem.hidesSearchBarWhenScrolling = NO; //刚开始显示
        self.definesPresentationContext = YES;//解决搜索时iOS13以下系统点哪都没反应的问题
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //self.navigationItem.hidesSearchBarWhenScrolling = YES; //刚开始显示后，再设置为滑动隐藏
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

#pragma mark -
- (void)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.textLabel.text = self.tableData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
