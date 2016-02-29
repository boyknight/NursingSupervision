//
//  NSVIssueViewController.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVIssueViewController.h"
#import "NSVAssessment.h"
#import "NSVDataCenter.h"

@interface NSVIssueViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation NSVIssueViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        self.dataSource = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat selfWidth = self.view.bounds.size.width;
    CGFloat selfHeight = self.view.bounds.size.height;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 20.0f, selfWidth, 30.0f)];
    [self.view addSubview:self.searchBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, selfWidth, selfHeight - 50.0f)
                                                  style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self convertDataFrom:[NSVDataCenter defaultCenter].assessment ToDataSource:self.dataSource];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellid = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    NSDictionary* issue = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@分", issue[@"name"], issue[@"score"]];
    
    return cell;
}

#pragma mark - 重载
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    CGFloat selfWidth = self.view.bounds.size.width;
    CGFloat selfHeight = self.view.bounds.size.height;
    
    self.searchBar.frame = CGRectMake(0.0f, 20.0f, selfWidth, 30.0f);
    self.tableView.frame = CGRectMake(0.0f, 50.0f, selfWidth, selfHeight - 50.0f);
    NSLog(@"bounds: %@", NSStringFromCGRect(self.view.bounds));
}

#pragma mark - 私有函数
-(void) convertDataFrom:(NSVAssessment*)assessment ToDataSource:(NSMutableArray*)dataSource{
    [dataSource removeAllObjects];
    
    for (NSVClassify* classify in assessment.classifies){
        for (NSVProject* project in classify.projects) {
            for (NSVIssue* issue in project.issues) {
                
                [dataSource addObject:@{@"name":issue.name, @"score":issue.score}];
            }
        }
    }
}

#pragma mark - 公有函数
-(void) setProjectFilter:(NSVProject*)projectFilter{
    
    [self.dataSource removeAllObjects];
    
    NSVAssessment* assessment = [NSVDataCenter defaultCenter].assessment;
    
    for (NSVClassify* classify in assessment.classifies){
        for (NSVProject* project in classify.projects) {
            
            if (projectFilter == nil){
            }
            else
            {
                if (projectFilter != project) {
                    continue;
                }
            }
            
            for (NSVIssue* issue in project.issues) {
                [self.dataSource addObject:@{@"name":issue.name, @"score":issue.score}];
            }
        }
    }
    
    [self.tableView reloadData];
    
}
@end
