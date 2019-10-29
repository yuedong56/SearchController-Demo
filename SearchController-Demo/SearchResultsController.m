//
//  SearchResultsController.m
//  SearchController-Demo
//
//  Created by yuedongkui on 2019/10/29.
//  Copyright © 2019 LY. All rights reserved.
//

#import "SearchResultsController.h"

@interface SearchResultsController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *originalData;
@property (nonatomic, strong) NSArray *searchData;

@end



@implementation SearchResultsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //原始数据
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [mArr addObject:[@(i) stringValue]];
    }
    self.originalData = [mArr copy];

    
    //初始化 TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.textLabel.text = self.searchData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchResultsUpdating
//每输入一个字符都会执行一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索关键字：%@", searchController.searchBar.text);
    //searchController.searchResultsController.view.hidden = NO;
    
    //谓词搜索
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    self.searchData = [self.originalData filteredArrayUsingPredicate:preicate];
        
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UISearchController *searchVC = (UISearchController *)self.parentViewController;
    if (searchVC.searchBar.isFirstResponder) {
        [searchVC.searchBar resignFirstResponder];
    }
}

@end
