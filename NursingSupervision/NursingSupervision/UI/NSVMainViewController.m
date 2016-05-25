//
//  NSVMainCollectionViewController.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//
//

//
#import "NSVMainViewController.h"
#import "NSVDataCenter.h"

#import "UIColor+NSVAdditions.h"

#import "NSVProjectItemTableViewCell.h"


#define NSVProjectAreaWidth 225.0f

#define NSVProjectLabelHeight 70.0f

#define NSVProjectHeaderHeight 33.0f

#define NSVProjectLabelBackgroundColor 0x53993f

#define NSVProjectCellBackgroundColor 0xe7eae5


@interface NSVMainViewController ()

@property (nonatomic, strong) UIView* projectBgView;
@property (nonatomic, strong) UIView* issueBgView;
@property (nonatomic, strong) UIView* nurseBgView;

@property (nonatomic, strong) UILabel* projectLabel;
@property (nonatomic, strong) UILabel* issueLabel;
@property (nonatomic, strong) UILabel* nurseLabel;

@property (nonatomic, strong) UISearchBar* issueSearchBar;

@property (nonatomic, strong) UITableView* projectTableView;
@property (nonatomic, strong) UITableView* issueTableView;
@property (nonatomic, strong) UITableView* nurseTableView;

@property (nonatomic, weak) NSVAssessment* assessment;
@property (nonatomic, copy) NSIndexPath* lastSelectedProjectIndexPath;
@property (nonatomic, copy) NSIndexPath* lastSelectedIssueIndexPath;

@property (nonatomic, strong) UIButton* projectSwitchButton;
@property (nonatomic, strong) UIButton* issueManageSwitchButton;
@property (nonatomic, strong) UIButton* historySwitchButton;

@end

@implementation NSVMainViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat selfWidth = self.view.frame.size.width;
    CGFloat selfHeight = self.view.frame.size.height;
    
    
    CGFloat statusBarHeight = 20.0f;
    
    
    // 项目背景视图
    self.projectBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                  statusBarHeight,
                                                                  NSVProjectAreaWidth,
                                                                  selfHeight - statusBarHeight)];
    self.projectBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    
    [self.view addSubview:self.projectBgView];
    
    // 项目 文字标签
    self.projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.projectBgView.frame.size.width, NSVProjectLabelHeight)];
    self.projectLabel.text = @"记录问题";
    self.projectLabel.textAlignment = NSTextAlignmentCenter;
    self.projectLabel.backgroundColor = [UIColor colorWithRGBHex:NSVProjectLabelBackgroundColor];
    self.projectLabel.font = [UIFont systemFontOfSize:20.0f];
    self.projectLabel.textColor = [UIColor whiteColor];

    [self.projectBgView addSubview:self.projectLabel];
    
    
    // 项目 图标
    UIImageView* projectIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"project_label_icon"]];
    projectIconView.frame = CGRectMake(25.0f, 23.0f, 24.0f, 24.0f);
    
    [self.projectBgView addSubview:projectIconView];
    
    
    // 项目 列表
    self.projectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                          self.projectLabel.frame.origin.y + self.projectLabel.frame.size.height,
                                                                          self.projectBgView.frame.size.width,
                                                                          self.projectBgView.frame.size.height - self.projectLabel.frame.size.height - 2.0f * NSVProjectLabelHeight) style:UITableViewStylePlain];
    self.projectTableView.dataSource = self;
    self.projectTableView.delegate = self;
    self.projectTableView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    self.projectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.projectBgView addSubview:self.projectTableView];
    
    // 项目切换 按钮
    self.projectSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.projectSwitchButton.frame = self.projectLabel.frame;
    [self.projectSwitchButton addTarget:self action:@selector(projectSwitchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.projectBgView addSubview:self.projectSwitchButton];
    
    
    
    // 
    
    
    
    
    
    // 问题 背景视图
    self.issueBgView = [[UIView alloc] initWithFrame:CGRectMake(self.projectBgView.frame.origin.x + self.projectBgView.frame.size.width,
                                                                  statusBarHeight,
                                                                  selfWidth - self.projectBgView.frame.size.width,
                                                                  selfHeight - statusBarHeight)];
    
    [self.view addSubview:self.issueBgView];
    
    
    // 问题 文字标签
    self.issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.issueBgView.frame.size.width, 40.0f)];
    self.issueLabel.backgroundColor = [UIColor lightGrayColor];
    self.issueLabel.text = @"问题";
    self.issueLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.issueBgView addSubview:self.issueLabel];
    
    // 问题 搜索
    self.issueSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,
                                                                        self.issueLabel.frame.origin.y + self.issueLabel.frame.size.height,
                                                                        self.issueBgView.frame.size.width,
                                                                        44.0f)];
    self.issueSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.issueBgView addSubview:self.issueSearchBar];
    
    
    // 问题 列表
    self.issueTableView= [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                       self.issueSearchBar.frame.origin.y + self.issueSearchBar.frame.size.height,
                                                                       self.issueBgView.frame.size.width,
                                                                       self.issueBgView.frame.size.height - self.issueLabel.frame.size.height - self.issueSearchBar.frame.size.height)
                                                      style:UITableViewStylePlain];
    
    self.issueTableView.dataSource = self;
    self.issueTableView.delegate = self;
    [self.issueBgView addSubview:self.issueTableView];
    
    
    
    // 护士 背景视图
    self.nurseBgView = [[UIView alloc] initWithFrame:CGRectMake(self.issueBgView.frame.origin.x + self.issueBgView.frame.size.width + 20.0f,
                                                                statusBarHeight,
                                                                200.0f,
                                                                selfHeight - statusBarHeight)];
    
    self.nurseBgView.backgroundColor = [UIColor redColor];
    self.nurseBgView.layer.shadowOffset = CGSizeMake(-5, 5);
    self.nurseBgView.layer.shadowRadius = 5;
    self.nurseBgView.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.nurseBgView];
    
    
    // 护士 文字标签
    self.nurseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.nurseBgView.frame.size.width, 40.0f)];
    self.nurseLabel.backgroundColor = [UIColor lightGrayColor];
    self.nurseLabel.text = @"责任人";
    self.nurseLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.nurseBgView addSubview:self.nurseLabel];

    
    // 护士 列表
    self.nurseTableView= [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                       self.nurseLabel.frame.origin.y + self.nurseLabel.frame.size.height,
                                                                       self.nurseBgView.frame.size.width,
                                                                       self.nurseBgView.frame.size.height - self.nurseLabel.frame.size.height)
                                                      style:UITableViewStylePlain];
    
    
    [self.nurseBgView addSubview:self.nurseTableView];
    
    self.assessment = [NSVDataCenter defaultCenter].assessment;
    
    self.lastSelectedProjectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    
//    NSLog(@"project bg view frame: %@, issue: %@, nurse: %@", NSStringFromCGRect(self.projectBgView.frame), NSStringFromCGRect(self.issueBgView.frame), NSStringFromCGRect(self.nurseBgView.frame));
//    
//    self.projectLabel.frame = CGRectMake(0.0f, 0.0f, self.projectBgView.frame.size.width, 40.0f);
//    self.issueLabel.frame = CGRectMake(0.0f, 0.0f, self.issueBgView.frame.size.width, 40.0f);
//    self.nurseLabel.frame = CGRectMake(0.0f, 0.0f, self.nurseBgView.frame.size.width, 40.0f);
//    
//    NSLog(@"project label view frame: %@, issue: %@, nurse: %@", NSStringFromCGRect(self.projectLabel.frame), NSStringFromCGRect(self.issueLabel.frame), NSStringFromCGRect(self.nurseLabel.frame));
//    
//    self.projectTableView.frame = CGRectMake(0.0f,
//                                             self.projectLabel.frame.origin.y + self.projectLabel.frame.size.height,
//                                             self.projectBgView.frame.size.width,
//                                             self.projectBgView.frame.size.height - self.projectLabel.frame.size.height);
//    
//    self.issueTableView.frame = CGRectMake(0.0f,
//                                           self.issueLabel.frame.origin.y + self.issueLabel.frame.size.height,
//                                           self.issueBgView.frame.size.width,
//                                           self.issueBgView.frame.size.height - self.issueLabel.frame.size.height);
//    
//    self.nurseTableView.frame = CGRectMake(0.0f,
//                                           self.nurseLabel.frame.origin.y + self.nurseLabel.frame.size.height,
//                                           self.nurseBgView.frame.size.width,
//                                           self.nurseBgView.frame.size.height - self.nurseLabel.frame.size.height);
//    
//    NSLog(@"project table view frame: %@, issue: %@, nurse: %@", NSStringFromCGRect(self.projectTableView.frame), NSStringFromCGRect(self.issueTableView.frame), NSStringFromCGRect(self.nurseTableView.frame));
//    
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 0;
    
    if (tableView == self.projectTableView) {
        count = self.assessment.classifies.count + 1;
    }
    else if (tableView == self.issueTableView){
        count = 1;
    }
    else if (tableView == self.nurseTableView){
        
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    
    if (tableView == self.projectTableView) {
        if (section == 0) {
            count = 1;
        }
        else if (section <= self.assessment.classifies.count){
            NSVClassify* classify = self.assessment.classifies[section - 1];
            count = classify.projects.count;
        }
    }
    else if (tableView == self.issueTableView){
        if (self.lastSelectedProjectIndexPath.section == 0) {
            for (NSVClassify* classify in self.assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    count += project.issues.count;
                }
            }
        }
        else{
            NSVClassify* classify = self.assessment.classifies[self.lastSelectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.lastSelectedProjectIndexPath.row];
            
            count = project.issues.count;
        }
    }
    else if (tableView == self.nurseTableView){
        
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSVProjectItemTableViewCell* cell = nil;
    
    if (tableView == self.projectTableView) {
        NSString* cellid = @"project_table_cell";
        
        cell = [self.projectTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVProjectItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            [cell setIndentationWidth:25.0f];
        }
        
        if (indexPath.section == 0) {
            cell.textLabel.text = @"全部";
        }
        else if (indexPath.section <= self.assessment.classifies.count){
            NSVClassify* classify = self.assessment.classifies[indexPath.section - 1];
            
            NSVProject* project = classify.projects[indexPath.row];
            
            cell.textLabel.text = project.name;
        }
    }
    else if (tableView == self.issueTableView){
        NSString* cellid = @"issue_table_cell";
        
        cell = [self.projectTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVProjectItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        if (self.lastSelectedProjectIndexPath.section == 0) {
            NSMutableArray* issueArray = [NSMutableArray array];
            for (NSVClassify* classify in self.assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    [issueArray addObjectsFromArray:project.issues];
                }
            }
            
            NSVIssue* issue = issueArray[indexPath.row];
            
            cell.textLabel.text = issue.name;
            
        }
        else
        {
            NSVClassify* classify = self.assessment.classifies[self.lastSelectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.lastSelectedProjectIndexPath.row];
            NSVIssue* issue = project.issues[indexPath.row];
            
            cell.textLabel.text = issue.name;
        }
    }
    else if (tableView == self.nurseTableView){
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = NSVProjectHeaderHeight;
    
    if (section == 0) {
        height = 4.0f;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NSVProjectAreaWidth, NSVProjectHeaderHeight)];
    bgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    
    if (section == 0) {
        bgView.frame = CGRectMake(0.0f, 0.0f, NSVProjectAreaWidth, 4.0f);
        
    }else{
        UIView* titleLabelBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 4.0f, NSVProjectAreaWidth, 25.0f)];
        titleLabelBgView.backgroundColor = [UIColor colorWithRGBHex:0xd6dbd2];
        
        [bgView addSubview:titleLabelBgView];
        
        NSString* title = nil;
        
        if (tableView == self.projectTableView) {
            if (section == 0) {
            }
            else if (section <= self.assessment.classifies.count){
                NSVClassify* classify = self.assessment.classifies[section - 1];
                title = classify.name;
            }
        }
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 4.0f, NSVProjectAreaWidth - 2.0f * 15.0f, 25.0f)];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.textColor = [UIColor colorWithRGBHex:0x747474];
        
        [bgView addSubview:titleLabel];
    }
    
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.projectTableView) {
        
        if (indexPath != self.lastSelectedProjectIndexPath) {
            self.lastSelectedProjectIndexPath = indexPath;
            [self.issueTableView reloadData];
            
            if (self.nurseBgView.frame.origin.x < self.view.frame.size.width) {
                
                CGRect newNurseBgViewFrame = self.nurseBgView.frame;
                newNurseBgViewFrame.origin.x += (newNurseBgViewFrame.size.width + 20);
                
                [UIView animateWithDuration:0.2f animations:^{
                    self.nurseBgView.frame = newNurseBgViewFrame;
                }];
                
                [self loadViewIfNeeded];
            }
        }
        

    }
    else if (tableView == self.issueTableView){
        
        if (indexPath != self.lastSelectedIssueIndexPath) {
            CGRect newNurseBgViewFrame = self.nurseBgView.frame;
            
            if (self.nurseBgView.frame.origin.x >= self.view.frame.size.width) {
                
                newNurseBgViewFrame.origin.x -= (newNurseBgViewFrame.size.width + 20);
                [UIView animateWithDuration:0.2f animations:^{
                    self.nurseBgView.frame = newNurseBgViewFrame;
                    [self loadViewIfNeeded];
                }];
            }
            
            self.lastSelectedIssueIndexPath = indexPath;

        }
    }
}

#pragma mark - button clicked
-(void) projectSwitchButtonClicked:(UIButton*)button{
    NSLog(@"project button clicked");
}

@end
