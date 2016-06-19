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
#import "NSVNurseTableViewCell.h"
#import "NSVIssueRecordTableViewCell.h"


#define NSVLeftAreaWidth 225.0f

#define NSVProjectLabelHeight 70.0f

#define NSVProjectHeaderHeight 33.0f

#define NSVProjectLabelBackgroundColor 0x53993f

#define NSVProjectCellBackgroundColor 0xe7eae5

#define StatusBarHeight 20.0f

#define NSVNurseListWidth 179.0f

#define NSVIssueRecordCommitButtonHeight 60.0f

static NSString * const reuseIdentifier = @"Cell";





@interface NSVMainViewController ()

// 左侧栏 //

// 记录问题
@property (nonatomic, strong) UIView* projectBgView;

@property (nonatomic, strong) UILabel* projectLabel;
@property (nonatomic, strong) UITableView* projectTableView;
@property (nonatomic, strong) UIButton* projectSwitchButton;


// 问题和人员管理
@property (nonatomic, strong) UIView* projectManagementBgView;

@property (nonatomic, strong) UILabel* projectManagementLabel;
@property (nonatomic, strong) UITableView* projectManagementTableView;
@property (nonatomic, strong) UIButton* projectManageSwitchButton;

// 查看历史记录
@property (nonatomic, strong) UIView* historyBgView;

@property (nonatomic, strong) UILabel* historyLabel;
@property (nonatomic, strong) UITableView* historyTableView;
@property (nonatomic, strong) UIButton* historySwitchButton;


// 右侧部分

// 记录问题
@property (nonatomic, strong) UIView* issueRecordBgView;
@property (nonatomic, strong) UISearchBar* issueSearchBar;
@property (nonatomic, strong) UITableView* issueTableView;
@property (nonatomic, strong) UITableView* nurseTableView;
@property (nonatomic, strong) UIButton* issueRecordCommitButton;
@property (nonatomic, strong) UIView* maskGrayLeftView;
@property (nonatomic, strong) UIView* maskGrayMidView;
@property (nonatomic, strong) UIView* maskGrayRightView;
@property (nonatomic, strong) UITableView* issueSearchResultTableView;




@property (nonatomic, weak) NSVAssessment* assessment;
@property (nonatomic, strong) NSMutableArray* nurses;
@property (nonatomic, strong) NSMutableArray* issueSearchResultArray;

@property (nonatomic, copy) NSIndexPath* lastSelectedProjectIndexPath;
@property (nonatomic, copy) NSIndexPath* lastSelectedIssueIndexPath;


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat deltaOfLeftHeight;


@end



@implementation NSVMainViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        self.nurses = [NSMutableArray array];
        self.issueSearchResultArray = [NSMutableArray array];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    self.deltaOfLeftHeight = self.height - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    // ------------------------ 左侧栏 ------------------------ //
    
    [self initIssueRecordOfLeftSide];
    
    [self initIssueManagementOfLeftSide];
    
    [self initHistoryOfLeftSide];
    
    // ------------------------ 左侧栏 结束 ------------------------ //
    
    
    
    // ------------------------ 右侧栏 ------------------------ //
    
    // 问题记录
    [self initIssueRecordOfRightSide];
    
    
    // ------------------------ 右侧栏 结束 ------------------------ //

    
    self.assessment = [NSVDataCenter defaultCenter].assessment;
    [self refreshNursesData];
    
    self.lastSelectedProjectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.projectTableView selectRowAtIndexPath:self.lastSelectedProjectIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
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
        count = self.nurses.count;
        NSLog(@"nurse section count: %ld", (long)count);
    }
    else if (tableView == self.projectManagementTableView){
        count = 1;
    }else if(tableView == self.issueSearchResultTableView){
        count = 1;
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
    }else if (tableView == self.nurseTableView){
        NSArray* nurses = self.nurses[section][@"nurses"];
        count = nurses.count;
    }else if (tableView == self.projectManagementTableView){
        count = 2;
    }else if (tableView == self.issueSearchResultTableView){
        count = self.issueSearchResultArray.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = nil;
    
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
        
        NSVProjectItemTableViewCell* tableCell = (NSVProjectItemTableViewCell*)cell;
        
        if (indexPath.section == 0) {
            tableCell.textLabel.text = @"全部";
        }
        else if (indexPath.section <= self.assessment.classifies.count){
            NSVClassify* classify = self.assessment.classifies[indexPath.section - 1];
            
            NSVProject* project = classify.projects[indexPath.row];
            
            tableCell.textLabel.text = project.name;
        }
    }
    else if (tableView == self.issueTableView){
        NSString* cellid = @"issue_table_cell";
        
        cell = [self.issueTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVIssueRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSVIssueRecordTableViewCell* tableCell = (NSVIssueRecordTableViewCell*)cell;

        if (self.lastSelectedProjectIndexPath.section == 0) {
            NSMutableArray* issueArray = [NSMutableArray array];
            for (NSVClassify* classify in self.assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    [issueArray addObjectsFromArray:project.issues];
                }
            }
            
            NSVIssue* issue = issueArray[indexPath.row];
            
            tableCell.issueLabel.text = issue.name;
            
        }
        else
        {
            NSVClassify* classify = self.assessment.classifies[self.lastSelectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.lastSelectedProjectIndexPath.row];
            NSVIssue* issue = project.issues[indexPath.row];
            
            tableCell.issueLabel.text = issue.name;
        }
    }
    else if (tableView == self.nurseTableView){
        NSString* cellid = @"nurse_table_cell";
        
        cell = [self.nurseTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVNurseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        NSVNurseTableViewCell* tableCell = (NSVNurseTableViewCell*)cell;
        
        NSArray* nurses = self.nurses[indexPath.section][@"nurses"];
        NSVNurse* nurse = nurses[indexPath.row];
        
        tableCell.nameLabel.text = nurse.name;
    }else if (tableView == self.projectManagementTableView){
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
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"标准 / 项目 / 问题";
        }else{
            cell.textLabel.text = @"科室 / 人";
        }
    }else if (tableView == self.issueSearchResultTableView){
        NSString* cellid = @"issue_search_result_table_cell";
        
        cell = [self.issueSearchResultTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVIssueRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSVIssueRecordTableViewCell* tableCell = (NSVIssueRecordTableViewCell*)cell;
        tableCell.isSeperatorOnTop = YES;
        
        NSVIssue* issue = self.issueSearchResultArray[indexPath.row];
        
        tableCell.issueLabel.text = issue.name;
    }
    
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray* indexArray = [NSMutableArray array];
    
    if (tableView == self.nurseTableView) {
        for (NSDictionary* info in self.nurses) {
            [indexArray addObject:info[@"pinyin"]];
        }
    }
    
    return indexArray;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat height = 0.0f;
    
    if (tableView == self.projectTableView) {
        height = NSVProjectHeaderHeight;
        
        if (section == 0) {
            height = 4.0f;
        }
    }else if (tableView == self.nurseTableView){
        height = 25.0f;
    }else if (tableView == self.issueSearchResultTableView){
        height = 0.0f;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0.0f;
    
    if (tableView == self.projectTableView) {
        height = 49.0f;
    }else if(tableView == self.projectManagementTableView){
        height = 49.0f;
    }else if(tableView == self.historyTableView){
        height = 49.0f;
    }else if (tableView == self.issueTableView){
        height = 60.0f;
    }else if (tableView == self.nurseTableView){
        height = 45.0f;
    }else if (tableView == self.issueSearchResultTableView){
        height = 60.0f;
    }
    
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView* bgView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (tableView == self.projectTableView) {
        bgView.frame = CGRectMake(0.0f, 0.0f, NSVLeftAreaWidth, NSVProjectHeaderHeight);
        bgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
        
        if (section == 0) {
            bgView.frame = CGRectMake(0.0f, 0.0f, NSVLeftAreaWidth, 4.0f);
            
        }else{
            UIView* titleLabelBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 4.0f, NSVLeftAreaWidth, 25.0f)];
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
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 4.0f, NSVLeftAreaWidth - 2.0f * 15.0f, 25.0f)];
            titleLabel.text = title;
            titleLabel.font = [UIFont systemFontOfSize:13.0f];
            titleLabel.textColor = [UIColor colorWithRGBHex:0x747474];
            
            [bgView addSubview:titleLabel];
        }
    }else if(tableView == self.nurseTableView){
        
        bgView.frame = CGRectMake(0.0f, 0.0f, NSVNurseListWidth, 45.0f);
        bgView.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
        
        NSDictionary* info = self.nurses[section];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, NSVNurseListWidth - 2.0f * 20.0f, 25.0f)];
        titleLabel.text = info[@"pinyin"];
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.textColor = [UIColor colorWithRGBHex:0x53993f];
        
        [bgView addSubview:titleLabel];
    }

    
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.projectTableView) {
        
        if (indexPath != self.lastSelectedProjectIndexPath) {
            self.lastSelectedProjectIndexPath = indexPath;
            [self.issueTableView reloadData];
        }
        

    }else if (tableView == self.issueTableView){
            self.lastSelectedIssueIndexPath = indexPath;
    }else if (tableView == self.nurseTableView){
        NSArray* selected = [self.nurseTableView indexPathsForSelectedRows];
        
        if (selected.count == 0) {
            self.issueRecordCommitButton.enabled = NO;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
        }else{
            self.issueRecordCommitButton.enabled = YES;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0x71a960];
        }
    }else if(tableView == self.issueSearchResultTableView){
        NSVIssue* issueSelected = self.issueSearchResultArray[indexPath.row];
        
        BOOL isFound = NO;
        
        NSInteger classifyIndex = 0;
        NSInteger projectIndex = 0;
        NSInteger issueIndex = 0;
        
        for (NSVClassify* classify in self.assessment.classifies) {
            projectIndex = 0;
            for (NSVProject* project in classify.projects) {
                issueIndex = 0;
                for (NSVIssue* issue in project.issues) {
                    
                    if (issue == issueSelected) {
                        // 选择
                    }
                    
                    issueIndex++;
                }
                
                projectIndex++;
            }
            
            classifyIndex++;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.nurseTableView){
        NSArray* selected = [self.nurseTableView indexPathsForSelectedRows];
        
        if (selected.count == 0) {
            self.issueRecordCommitButton.enabled = NO;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
        }else{
            self.issueRecordCommitButton.enabled = YES;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0x71a960];
        }
    }

}

#pragma mark - button clicked
-(void) projectSwitchButtonClicked:(UIButton*)button{
    CGFloat selfHeight = self.view.frame.size.height;
    
    CGFloat delta = selfHeight - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    if (self.projectBgView.frame.size.height <= NSVProjectLabelHeight) {
        __weak NSVMainViewController* blockSelf = self;
        
        [UIView animateWithDuration:0.3f animations:^{
            
            CGRect projectBgViewFrame = blockSelf.projectBgView.frame;
            CGRect projectManagementBgViewFrame = blockSelf.projectManagementBgView.frame;
            CGRect historybgViewFrame = blockSelf.historyBgView.frame;
            
            
            projectBgViewFrame.size.height = NSVProjectLabelHeight + delta;
            projectManagementBgViewFrame.size.height = NSVProjectLabelHeight;
            historybgViewFrame.size.height = NSVProjectLabelHeight;
            
            
            projectManagementBgViewFrame.origin.y = NSVProjectLabelHeight + delta + StatusBarHeight;
            historybgViewFrame.origin.y = 2.0f * NSVProjectLabelHeight + delta + StatusBarHeight;
            
            blockSelf.projectBgView.frame = projectBgViewFrame;
            blockSelf.projectManagementBgView.frame = projectManagementBgViewFrame;
            blockSelf.historyBgView.frame = historybgViewFrame;
        }];
    }
}

-(void) projectManageSwitchButtonClicked:(UIButton*)button{
    CGFloat selfHeight = self.view.frame.size.height;
    
    CGFloat delta = selfHeight - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    if (self.projectManagementBgView.frame.size.height <= NSVProjectLabelHeight) {
        __weak NSVMainViewController* blockSelf = self;
        
        [UIView animateWithDuration:0.3f animations:^{
            
            CGRect projectBgViewFrame = blockSelf.projectBgView.frame;
            CGRect projectManagementBgViewFrame = blockSelf.projectManagementBgView.frame;
            CGRect historybgViewFrame = blockSelf.historyBgView.frame;
            
            
            projectBgViewFrame.size.height = NSVProjectLabelHeight;
            projectManagementBgViewFrame.size.height = NSVProjectLabelHeight + delta;
            historybgViewFrame.size.height = NSVProjectLabelHeight;
            
            
            projectManagementBgViewFrame.origin.y = NSVProjectLabelHeight + StatusBarHeight;
            historybgViewFrame.origin.y = 2.0f * NSVProjectLabelHeight + delta + StatusBarHeight;
            
            
            blockSelf.projectBgView.frame = projectBgViewFrame;
            blockSelf.projectManagementBgView.frame = projectManagementBgViewFrame;
            blockSelf.historyBgView.frame = historybgViewFrame;
            
        }];
    }
}

-(void) historySwitchButtonClicked:(UIButton*)button{
    CGFloat selfHeight = self.view.frame.size.height;
    
    CGFloat delta = selfHeight - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    if (self.historyBgView.frame.size.height <= NSVProjectLabelHeight) {
        __weak NSVMainViewController* blockSelf = self;
        
        [UIView animateWithDuration:0.3f animations:^{
            
            CGRect projectBgViewFrame = blockSelf.projectBgView.frame;
            CGRect projectManagementBgViewFrame = blockSelf.projectManagementBgView.frame;
            CGRect historybgViewFrame = blockSelf.historyBgView.frame;
            
            projectBgViewFrame.size.height = NSVProjectLabelHeight;
            projectManagementBgViewFrame.size.height = NSVProjectLabelHeight;
            historybgViewFrame.size.height = NSVProjectLabelHeight + delta;
            
            projectManagementBgViewFrame.origin.y = NSVProjectLabelHeight + StatusBarHeight;
            historybgViewFrame.origin.y = 2.0f * NSVProjectLabelHeight + StatusBarHeight;
            
            
            blockSelf.projectBgView.frame = projectBgViewFrame;
            blockSelf.projectManagementBgView.frame = projectManagementBgViewFrame;
            blockSelf.historyBgView.frame = historybgViewFrame;
        }];
    }
}

#pragma mark - 初始化界面
-(void) initIssueRecordOfLeftSide{
    // 记录问题 背景视图
    self.projectBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                  StatusBarHeight,
                                                                  NSVLeftAreaWidth,
                                                                  self.height - StatusBarHeight - 2.0f * NSVProjectLabelHeight)];
    self.projectBgView.clipsToBounds = YES;
    self.projectBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    [self.view addSubview:self.projectBgView];
    
    // 记录问题 文字标签 背景
    UIView* projectLabelBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.projectBgView.frame.size.width, NSVProjectLabelHeight)];
    projectLabelBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectLabelBackgroundColor];
    
    [self.projectBgView addSubview:projectLabelBgView];
    
    // 记录问题 图标
    UIImageView* projectIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"project_label_icon"]];
    projectIconView.frame = CGRectMake(25.0f, 23.0f, 24.0f, 24.0f);
    
    [self.projectBgView addSubview:projectIconView];
    
    // 记录问题 文字标签
    self.projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(projectIconView.frame.origin.x + projectIconView.frame.size.width + 10.0f,
                                                                  projectIconView.frame.origin.y,
                                                                  NSVLeftAreaWidth - (projectIconView.frame.origin.x + projectIconView.frame.size.width + 20.0f),
                                                                  projectIconView.frame.size.height)];
    self.projectLabel.text = @"记录问题";
    self.projectLabel.textAlignment = NSTextAlignmentLeft;
    self.projectLabel.backgroundColor = [UIColor clearColor];
    self.projectLabel.font = [UIFont systemFontOfSize:20.0f];
    self.projectLabel.textColor = [UIColor whiteColor];
    
    [self.projectBgView addSubview:self.projectLabel];
    
    // 记录问题 列表
    self.projectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                          projectLabelBgView.frame.origin.y + projectLabelBgView.frame.size.height,
                                                                          self.projectBgView.frame.size.width,
                                                                          self.projectBgView.frame.size.height - NSVProjectLabelHeight) style:UITableViewStylePlain];
    self.projectTableView.dataSource = self;
    self.projectTableView.delegate = self;
    self.projectTableView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    self.projectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.projectBgView addSubview:self.projectTableView];
    
    // 记录问题 切换 按钮
    self.projectSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.projectSwitchButton.frame = projectLabelBgView.frame;
    [self.projectSwitchButton addTarget:self action:@selector(projectSwitchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.projectBgView addSubview:self.projectSwitchButton];
}

-(void) initIssueManagementOfLeftSide{
    // 项目管理 背景页面
    self.projectManagementBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                            self.projectBgView.frame.origin.y + self.projectBgView.frame.size.height,
                                                                            NSVLeftAreaWidth,
                                                                            NSVProjectLabelHeight)];
    self.projectManagementBgView.clipsToBounds = YES;
    self.projectManagementBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    [self.view addSubview:self.projectManagementBgView];
    
    // 项目管理 文字标签 背景
    UIView* projectManagementLabelBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.projectManagementBgView.frame.size.width, NSVProjectLabelHeight)];
    projectManagementLabelBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectLabelBackgroundColor];
    
    [self.projectManagementBgView addSubview:projectManagementLabelBgView];
    
    
    // 项目管理的图标
    UIImageView* projectManagementIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"project_management_icon"]];
    projectManagementIconView.frame = CGRectMake(25.0f, 23.0f, 24.0f, 24.0f);
    
    [self.projectManagementBgView addSubview:projectManagementIconView];
    
    // 项目管理 标题文字标签
    self.projectManagementLabel = [[UILabel alloc] initWithFrame:CGRectMake(projectManagementIconView.frame.origin.x + projectManagementIconView.frame.size.width + 10.0f,
                                                                            projectManagementIconView.frame.origin.y,
                                                                            NSVLeftAreaWidth - (projectManagementIconView.frame.origin.x + projectManagementIconView.frame.size.width + 20.0f),
                                                                            projectManagementIconView.frame.size.height)];
    self.projectManagementLabel.text = @"问题和人员管理";
    self.projectManagementLabel.textAlignment = NSTextAlignmentLeft;
    self.projectManagementLabel.backgroundColor = [UIColor clearColor];
    self.projectManagementLabel.font = [UIFont systemFontOfSize:20.0f];
    self.projectManagementLabel.textColor = [UIColor whiteColor];
    
    [self.projectManagementBgView addSubview:self.projectManagementLabel];
    
    // 项目管理 列表
    self.projectManagementTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                    projectManagementLabelBgView.frame.origin.y + projectManagementLabelBgView.frame.size.height,
                                                                                    self.projectManagementBgView.frame.size.width,
                                                                                    self.deltaOfLeftHeight) style:UITableViewStylePlain];
    self.projectManagementTableView.dataSource = self;
    self.projectManagementTableView.delegate = self;
    self.projectManagementTableView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    self.projectManagementTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.projectManagementBgView addSubview:self.projectManagementTableView];
    
    
    // 项目管理 切换按钮
    self.projectManageSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.projectManageSwitchButton.frame = projectManagementLabelBgView.frame;
    [self.projectManageSwitchButton addTarget:self action:@selector(projectManageSwitchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.projectManagementBgView addSubview:self.projectManageSwitchButton];
    

}

-(void) initHistoryOfLeftSide{
    // 历史 背景视图
    self.historyBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                  2.0f * NSVProjectLabelHeight + self.deltaOfLeftHeight + StatusBarHeight,
                                                                  NSVLeftAreaWidth,
                                                                  NSVProjectLabelHeight)];
    self.historyBgView.clipsToBounds = YES;
    self.historyBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    [self.view addSubview:self.historyBgView];
    
    // 历史 文字标签 背景
    UIView* historyLabelBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NSVLeftAreaWidth, NSVProjectLabelHeight)];
    historyLabelBgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectLabelBackgroundColor];
    
    [self.historyBgView addSubview:historyLabelBgView];
    
    // 历史 图标
    UIImageView* historyIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history_label_icon"]];
    historyIconView.frame = CGRectMake(25.0f, 23.0f, 24.0f, 24.0f);
    
    [self.historyBgView addSubview:historyIconView];
    
    
    // 历史 标题文字 标签
    self.historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(historyIconView.frame.origin.x + historyIconView.frame.size.width + 10.0f,
                                                                  historyIconView.frame.origin.y,
                                                                  NSVLeftAreaWidth - (historyIconView.frame.origin.x + historyIconView.frame.size.width + 20.0f),
                                                                  historyIconView.frame.size.height)];
    self.historyLabel.text = @"查看历史记录";
    self.historyLabel.textAlignment = NSTextAlignmentLeft;
    self.historyLabel.backgroundColor = [UIColor clearColor];
    self.historyLabel.font = [UIFont systemFontOfSize:20.0f];
    self.historyLabel.textColor = [UIColor whiteColor];
    
    [self.historyBgView addSubview:self.historyLabel];
    
    // 历史 列表
    self.historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                          NSVProjectLabelHeight,
                                                                          NSVLeftAreaWidth,
                                                                          self.deltaOfLeftHeight) style:UITableViewStylePlain];
    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
    self.historyTableView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.historyBgView addSubview:self.historyTableView];
    
    // 历史 切换按钮
    self.historySwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.historySwitchButton.frame = historyLabelBgView.frame;
    [self.historySwitchButton addTarget:self action:@selector(historySwitchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.historyBgView addSubview:self.historySwitchButton];
}

-(void) initIssueRecordOfRightSide{
    
    
    // 记录问题 背景视图
    self.issueRecordBgView = [[UIView alloc] initWithFrame:CGRectMake(NSVLeftAreaWidth,
                                                                      StatusBarHeight,
                                                                      self.width - NSVLeftAreaWidth,
                                                                      self.height - StatusBarHeight)];
    [self.view addSubview:self.issueRecordBgView];
    
    // 问题记录 搜索栏
    self.issueSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,
                                                                        0.0f,
                                                                        self.issueRecordBgView.frame.size.width - NSVNurseListWidth,
                                                                        44.0f)];
    self.issueSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.issueSearchBar.placeholder = @"请输入关键词或项目名称搜索问题";
    self.issueSearchBar.backgroundColor = [UIColor whiteColor];
    self.issueSearchBar.showsCancelButton = YES;
    self.issueSearchBar.delegate = self;
    [self.issueRecordBgView addSubview:self.issueSearchBar];
    
    
    // 问题记录列表
    self.issueTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                       self.issueSearchBar.frame.origin.y + self.issueSearchBar.frame.size.height,
                                                                       self.issueSearchBar.frame.size.width,
                                                                       self.issueRecordBgView.frame.size.height - self.issueSearchBar.frame.size.height)
                                                      style:UITableViewStylePlain];
    
    self.issueTableView.dataSource = self;
    self.issueTableView.delegate = self;
    self.issueTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.issueRecordBgView addSubview:self.issueTableView];
    
    // 分隔线
    UIView* sepView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.issueTableView.frame.origin.y, self.issueTableView.frame.size.width, 1.0f)];
    sepView.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
    
    [self.issueRecordBgView addSubview:sepView];
    
    // 护士列表
    self.nurseTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.issueRecordBgView.frame.size.width - NSVNurseListWidth,
                                                                       0.0f,
                                                                       NSVNurseListWidth,
                                                                       self.issueRecordBgView.frame.size.height - NSVIssueRecordCommitButtonHeight)
                                                      style:UITableViewStylePlain];
    
    self.nurseTableView.dataSource = self;
    self.nurseTableView.delegate = self;
    self.nurseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nurseTableView.backgroundColor = [UIColor colorWithRGBHex:0xfafafa];
    self.nurseTableView.allowsMultipleSelection = YES;
    [self.issueRecordBgView addSubview:self.nurseTableView];
    
    // 提交按钮
    
    self.issueRecordCommitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.issueRecordCommitButton.frame = CGRectMake(self.nurseTableView.frame.origin.x,
                                                    self.nurseTableView.frame.origin.y + self.nurseTableView.frame.size.height,
                                                    NSVNurseListWidth,
                                                    NSVIssueRecordCommitButtonHeight);
    [self.issueRecordCommitButton setTitle:@"提    交" forState:UIControlStateNormal];
    [self.issueRecordCommitButton setTitleColor:[UIColor colorWithRGBHex:0x747474] forState:UIControlStateDisabled];
    [self.issueRecordCommitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
    self.issueRecordCommitButton.enabled = NO;
    [self.issueRecordBgView addSubview:self.issueRecordCommitButton];
    
    // 分隔线
    sepView = [[UIView alloc] initWithFrame:CGRectMake(self.nurseTableView.frame.origin.x, 0.0f, 1.0f, self.issueRecordBgView.frame.size.height)];
    sepView.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
    
    [self.issueRecordBgView addSubview:sepView];
    
    // 搜索 遮罩 左侧 半透灰 视图
    self.maskGrayLeftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NSVLeftAreaWidth, self.height)];
    self.maskGrayLeftView.backgroundColor = [UIColor blackColor];
    self.maskGrayLeftView.alpha = 0.4f;
    
    // 搜索 遮罩 中间 半透灰 视图
    self.maskGrayMidView = [[UIView alloc] initWithFrame:CGRectMake(NSVLeftAreaWidth, self.issueSearchBar.frame.size.height + 20.0f, self.width - NSVLeftAreaWidth - NSVNurseListWidth, self.height)];
    self.maskGrayMidView.backgroundColor = [UIColor blackColor];
    self.maskGrayMidView.alpha = 0.4f;
    
    // 搜索 遮罩 右侧 半透灰 视图
    self.maskGrayRightView = [[UIView alloc] initWithFrame:CGRectMake(self.width - NSVNurseListWidth, 0.0f, NSVNurseListWidth, self.height)];
    self.maskGrayRightView.backgroundColor = [UIColor blackColor];
    self.maskGrayRightView.alpha = 0.4f;
    
    // 搜索结果 列表
    self.issueSearchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(NSVLeftAreaWidth,
                                                                                    self.maskGrayMidView.frame.origin.y,
                                                                                    self.maskGrayMidView.frame.size.width,
                                                                                    240.0f) style:UITableViewStylePlain];
    self.issueSearchResultTableView.delegate = self;
    self.issueSearchResultTableView.dataSource = self;
    self.issueSearchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 私有函数
-(void) refreshNursesData{
    
    // 清空本地缓存
    [self.nurses removeAllObjects];
    
    NSArray* pinyinArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    NSArray* nurses = [NSVDataCenter defaultCenter].nurses.nurses;
    
    
    // 按拼音首字母排序
    for (NSString* py in pinyinArray) {
        NSMutableDictionary* d = [NSMutableDictionary dictionary];
        
        NSMutableArray* ns = [NSMutableArray array];
        
        for (NSVNurse* nurse in nurses) {
            if ([py isEqualToString:[nurse.namePinyin uppercaseString]]) {
                [ns addObject:nurse];
            }
        }
        
        
        if (ns.count > 0) {
            d[@"pinyin"] = py;
            d[@"nurses"] = ns;
            
            [self.nurses addObject:d];
        }
    }
    
    [self.nurseTableView reloadData];
}

-(void) startSearchIssue{
    
    [self.view addSubview:self.maskGrayLeftView];
    [self.view addSubview:self.maskGrayMidView];
    [self.view addSubview:self.maskGrayRightView];
    
    [self.view addSubview:self.issueSearchResultTableView];
    
}

-(void) endSearchIssue{
    self.issueSearchBar.text = @"";
    [self.issueSearchResultArray removeAllObjects];
    [self.issueSearchResultTableView reloadData];
    
    [self.maskGrayLeftView removeFromSuperview];
    [self.maskGrayMidView removeFromSuperview];
    [self.maskGrayRightView removeFromSuperview];
    
    [self.issueSearchResultTableView removeFromSuperview];
}

-(NSArray*) searchIssueWithKeyword:(NSString*)keyword{
    
    NSMutableArray* startMatchArray = [NSMutableArray array];
    NSMutableArray* middleMatchArray = [NSMutableArray array];
    
    
    NSMutableArray* result = [NSMutableArray array];
    
    for (NSVClassify* classify in self.assessment.classifies) {
        for (NSVProject* project in classify.projects) {
            for (NSVIssue* issue in project.issues) {
                
                NSRange r = [issue.namePinYinShouZiMu localizedStandardRangeOfString:[keyword lowercaseString]];
                if (r.location == 0) {
                    [startMatchArray addObject:issue];
                    continue;
                }else if(r.location > 0 && r.location != NSNotFound){
                    [middleMatchArray addObject:issue];
                    continue;
                }
                
                r = [issue.nameQuanPin localizedStandardRangeOfString:[keyword lowercaseString]];
                if (r.location == 0) {
                    [startMatchArray addObject:issue];
                    continue;
                }else if(r.location > 0 && r.location != NSNotFound){
                    [middleMatchArray addObject:issue];
                    continue;
                }
                
                r = [issue.name localizedStandardRangeOfString:[keyword lowercaseString]];
                if (r.location == 0) {
                    [startMatchArray addObject:issue];
                    continue;
                }else if(r.location > 0 && r.location != NSNotFound){
                    [middleMatchArray addObject:issue];
                    continue;
                }
            }
        }
    }
    
    [result addObjectsFromArray:startMatchArray];
    [result addObjectsFromArray:middleMatchArray];
    
    return result;
}

-(void) selectProjectAndIssue:(NSVIssue*)issue{
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.issueSearchBar resignFirstResponder];
    
    [self endSearchIssue];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self startSearchIssue];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText == nil || searchText.length == 0) {
        [self.issueSearchResultArray removeAllObjects];
        [self.issueSearchResultTableView reloadData];
        

    }else{
        
        [self.issueSearchResultArray removeAllObjects];
        [self.issueSearchResultArray addObjectsFromArray:[self searchIssueWithKeyword:searchText]];
        [self.issueSearchResultTableView reloadData];
    }
    
    
}

@end
