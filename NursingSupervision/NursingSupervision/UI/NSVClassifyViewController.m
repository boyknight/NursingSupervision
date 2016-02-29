//
//  NSVClassViewController.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVClassifyViewController.h"
#import "NSVAssessment.h"
#import "NSVDataCenter.h"

#define TagOfTableViewCellTextLabel 1000

@interface NSVClassifyViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation NSVClassifyViewController

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
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, selfWidth, selfHeight - 50.0f)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 20.0f;
    
    [self.view addSubview:self.tableView];
    
    [self convertDataFrom:[NSVDataCenter defaultCenter].assessment ToDataSource:self.dataSource];
    [self.tableView reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    
    
    
    if (section < self.dataSource.count + 1) {
        
        if (section == 0){
            count = 1;
        }
        else{
            NSDictionary* classify = self.dataSource[section - 1];
            NSArray* projects = (NSArray*)classify[@"projects"];
            count = projects.count;
        }
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellid = @"cell";
    
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (indexPath.section == 0){
        cell.textLabel.text = @"全部";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else{
        NSDictionary* classify = self.dataSource[indexPath.section - 1];
        NSArray* projects = (NSArray*)classify[@"projects"];
        
        NSString* projectName = projects[indexPath.row];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = [NSString stringWithFormat:@"    %@", projectName];
    }
    

    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString* title = nil;
    if (section > 0)
    {
        NSDictionary* classify = self.dataSource[section - 1];
        title = classify[@"name"];
    }

    return title;
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20.0f;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 30.0f;
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView* headerView = (UITableViewHeaderFooterView*)view;
    
    if (headerView.textLabel.font.pointSize != 14.0f) {
        headerView.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSVProject* project = nil;
    if (indexPath.section == 0){
    }
    else{
        NSVAssessment* assessment = [NSVDataCenter defaultCenter].assessment;
        
        NSVClassify* classify = assessment.classifies[indexPath.section - 1];
        
        project = classify.projects[indexPath.row];
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(classifyViewController:projectSelected:)]) {
        [self.delegate classifyViewController:self projectSelected:project];
    }
}

#pragma mark - 重载
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGFloat selfWidth = self.view.bounds.size.width;
    CGFloat selfHeight = self.view.bounds.size.height;
    
    self.tableView.frame = CGRectMake(0.0f, 20.0f, selfWidth, selfHeight - 50.0f);
}

#pragma mark - 私有函数
-(void) convertDataFrom:(NSVAssessment*)assessment ToDataSource:(NSMutableArray*)dataSource{
    
    [dataSource removeAllObjects];
    
    for (NSVClassify* classify in assessment.classifies){
        NSMutableDictionary* classifyDict = [NSMutableDictionary dictionary];
        classifyDict[@"name"] = classify.name;
        NSMutableArray* projects = [NSMutableArray array];
        classifyDict[@"projects"] = projects;
        
        for (NSVProject* project in classify.projects) {
            [projects addObject:project.name];
        }
        
        [dataSource addObject:classifyDict];
    }
}

@end
