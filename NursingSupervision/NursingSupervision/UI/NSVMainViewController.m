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
#import "NSVManagementEditTableViewCell.h"

#import "NSVNewDialog.h"
#import "SIAlertView.h"


#define NSVLeftAreaWidth 225.0f

#define NSVProjectLabelHeight 70.0f

#define NSVProjectHeaderHeight 33.0f

#define NSVProjectLabelBackgroundColor 0x53993f

#define NSVProjectCellBackgroundColor 0xe7eae5

#define StatusBarHeight 20.0f

#define NSVNurseListWidth 179.0f

#define NSVIssueRecordCommitButtonHeight 60.0f

static NSString * const reuseIdentifier = @"Cell";


typedef enum{
    NSVPanMgmClassifyLevel = 0,
    NSVPanMgmProjectLevel = 1,
    NSVPanMgmIssueLevel = 2
} NSVProjectLevel;

typedef enum{
    NSVPanMgmOfficeLevel = 0,
    NSVPanMgmNurseLevel = 1
} NSVNurseLevel;

typedef enum{
    NSVPanMgmProject,
    NSVPanMgmNurse
}NSVPanMgmType;


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


@property (nonatomic, strong) UILabel* pickDateLabel;
@property (nonatomic, strong) UILabel* pickStartDateLable;
@property (nonatomic, strong) UILabel* startDateLabel;
@property (nonatomic, strong) UILabel* pickEndDateLable;
@property (nonatomic, strong) UILabel* endDateLabel;

@property (nonatomic, strong) UILabel* pickIssueLabel;
@property (nonatomic, strong) UIImageView* pickIssueIconView;
@property (nonatomic, strong) UIButton* pickIssueButton;
@property (nonatomic, strong) UIButton* removePickedIssueButton;
@property (nonatomic, strong) UILabel* pickNurseLable;
@property (nonatomic, strong) UIImageView* pickNurseIconView;
@property (nonatomic, strong) UIButton* pickNurseButton;
@property (nonatomic, strong) UIButton* removePickedNurseButton;

@property (nonatomic, strong) UIButton* exportHistoryButton;


@property (nonatomic, strong) NSDate* historyStartDate;
@property (nonatomic, strong) NSDate* historyEndDate;


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

// 问题和人员管理
@property (nonatomic, strong) UIView* projectAndNurseManagementBgView;
@property (nonatomic, strong) UIView* panMgmNavView;
@property (nonatomic, strong) UILabel* panMgmNavTitleLabel;
@property (nonatomic, strong) UIButton* panMgmNavBackButton;
@property (nonatomic, strong) UIButton* panMgmNavNewButton;
@property (nonatomic, strong) UIButton* panMgmNavEditButton;
@property (nonatomic, strong) UITableView* panMgmProjectTableView;
@property (nonatomic, assign) NSVPanMgmType panMgmType;
@property (nonatomic, assign) NSVProjectLevel panMgmProjectLevel;
@property (nonatomic, assign) NSVNurseLevel panMgmNurseLevel;
@property (nonatomic, strong) NSIndexPath* panMgnProjectIndexPath;
@property (nonatomic, strong) NSIndexPath* panMgnNurseIndexPath;
@property (nonatomic, strong) NSVNewDialog* dialogForNew;

// 报表


@property (nonatomic, strong) NSMutableArray* nurses;
@property (nonatomic, strong) NSMutableArray* issueSearchResultArray;

@property (nonatomic, copy) NSIndexPath* selectedProjectIndexPath;
@property (nonatomic, copy) NSVIssue* selectedIssue;


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
    
    self.historyStartDate = [NSDate date];
    self.historyEndDate = [NSDate date];
    
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    self.deltaOfLeftHeight = self.height - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    self.panMgmType = NSVPanMgmProject;
    self.panMgmProjectLevel = NSVPanMgmClassifyLevel;
    self.panMgnProjectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    // ------------------------ 左侧栏 ------------------------ //
    
    [self initIssueRecordOfLeftSide];
    
    [self initIssueManagementOfLeftSide];
    
    [self initHistoryOfLeftSide];
    
    // ------------------------ 左侧栏 结束 ------------------------ //
    
    
    
    // ------------------------ 右侧栏 ------------------------ //
    
    // 问题和人员管理
    [self initProjectAndNurseManagementOfRightSide];
    
    // 问题记录
    [self initIssueRecordOfRightSide];
    
    
    // ------------------------ 右侧栏 结束 ------------------------ //

    
    [self refreshNursesData];
    
    [self.projectTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 0;
    
    if (tableView == self.projectTableView) {
        count = [NSVDataCenter defaultCenter].assessment.classifies.count + 1;
    }
    else if (tableView == self.issueTableView){
        count = 1;
    }
    else if (tableView == self.nurseTableView){
        count = self.nurses.count;
    }
    else if (tableView == self.projectManagementTableView){
        count = 1;
    }else if(tableView == self.issueSearchResultTableView){
        count = 1;
    }else if (tableView == self.panMgmProjectTableView){
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
        else if (section <= [NSVDataCenter defaultCenter].assessment.classifies.count){
            NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[section - 1];
            count = classify.projects.count;
        }
    }
    else if (tableView == self.issueTableView){
        if (self.selectedProjectIndexPath.section == 0) {
            for (NSVClassify* classify in [NSVDataCenter defaultCenter].assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    count += project.issues.count;
                }
            }
        }
        else{
            NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[self.selectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.selectedProjectIndexPath.row];
            
            count = project.issues.count;
        }
    }else if (tableView == self.nurseTableView){
        NSArray* nurses = self.nurses[section][@"nurses"];
        count = nurses.count;
    }else if (tableView == self.projectManagementTableView){
        count = 2;
    }else if (tableView == self.issueSearchResultTableView){
        count = self.issueSearchResultArray.count;
    }else if (tableView == self.panMgmProjectTableView){
        
        // 项目 编辑
        if (self.panMgmType == NSVPanMgmProject) {
            // 分类
            if (self.panMgmProjectLevel == NSVPanMgmClassifyLevel) {
                count = [NSVDataCenter defaultCenter].assessment.classifies.count;
            }
            // 项目
            else if (self.panMgmProjectLevel == NSVPanMgmProjectLevel){
                NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                
                count = c.projects.count;
            }
            // 问题
            else if (self.panMgmProjectLevel == NSVPanMgmIssueLevel){
                NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                NSVProject* p  = c.projects[self.panMgnProjectIndexPath.row];
                
                count = p.issues.count;
            }

        }
        // 护士 编辑
        else if (self.panMgmType == NSVPanMgmNurse){
            if (self.panMgmNurseLevel == NSVPanMgmOfficeLevel){
                count = [NSVDataCenter defaultCenter].staffs.offices.count;
                
            }else if (self.panMgmNurseLevel == NSVPanMgmNurseLevel){
                NSVOffice* office = [NSVDataCenter defaultCenter].staffs.offices[self.panMgnNurseIndexPath.section];
                count = office.nurses.count;
            }
        }
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = nil;
    
    // 左侧 项目列表
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
        else if (indexPath.section <= [NSVDataCenter defaultCenter].assessment.classifies.count){
            NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[indexPath.section - 1];
            
            NSVProject* project = classify.projects[indexPath.row];
            
            tableCell.textLabel.text = project.name;
        }
    }
    
    // 右侧 问题记录列表
    else if (tableView == self.issueTableView){
        NSString* cellid = @"issue_table_cell";
        
        cell = [self.issueTableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[NSVIssueRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSVIssueRecordTableViewCell* tableCell = (NSVIssueRecordTableViewCell*)cell;

        if (self.selectedProjectIndexPath.section == 0) {
            NSMutableArray* issueArray = [NSMutableArray array];
            for (NSVClassify* classify in [NSVDataCenter defaultCenter].assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    [issueArray addObjectsFromArray:project.issues];
                }
            }
            
            NSVIssue* issue = issueArray[indexPath.row];
            
            tableCell.issueLabel.text = issue.name;
            
        }
        else
        {
            NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[self.selectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.selectedProjectIndexPath.row];
            NSVIssue* issue = project.issues[indexPath.row];
            
            tableCell.issueLabel.text = issue.name;
        }
    }
    
    // 右侧 护士列表
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
    }
    // 左侧 项目编辑列表
    else if (tableView == self.projectManagementTableView){
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
    }
    // 右侧 搜索结果列表
    else if (tableView == self.issueSearchResultTableView){
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
    // 右侧 项目编辑列表
    else if (tableView == self.panMgmProjectTableView) {
        
        // 项目编辑
        if(self.panMgmType == NSVPanMgmProject){
            NSString* cellid = @"issue_edit_table_cell";
            
            cell = [self.panMgmProjectTableView dequeueReusableCellWithIdentifier:cellid];
            
            if (cell == nil) {
                cell = [[NSVManagementEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            NSVManagementEditTableViewCell* tableCell = (NSVManagementEditTableViewCell*)cell;
            tableCell.delegate = self;
            
            if (self.panMgmProjectLevel == NSVPanMgmClassifyLevel) {
                NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[indexPath.row];
                tableCell.name = c.name;
                tableCell.score = nil;
                tableCell.level = [NSNumber numberWithInteger:NSVPanMgmClassifyLevel];
                tableCell.row = indexPath.row;
                tableCell.showIndicator = YES;
            }else if (self.panMgmProjectLevel == NSVPanMgmProjectLevel){
                NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                NSVProject* p = c.projects[indexPath.row];
                
                tableCell.name = p.name;
                tableCell.score = nil;
                tableCell.level = [NSNumber numberWithInteger:NSVPanMgmProjectLevel];
                tableCell.row = indexPath.row;
                tableCell.showIndicator = YES;
            }else if (self.panMgmProjectLevel == NSVPanMgmIssueLevel){
                NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                NSVProject* p = c.projects[self.panMgnProjectIndexPath.row];
                
                NSVIssue* i = p.issues[indexPath.row];
                
                tableCell.name = i.name;
                tableCell.score = [NSNumber numberWithFloat:i.score];
                tableCell.level = [NSNumber numberWithInteger:NSVPanMgmIssueLevel];
                tableCell.row = indexPath.row;
                tableCell.showIndicator = NO;
            }
        }
        
        // 护士编辑
        else if (self.panMgmType == NSVPanMgmNurse){
            NSString* cellid = @"issue_edit_table_cell";
            
            cell = [self.panMgmProjectTableView dequeueReusableCellWithIdentifier:cellid];
            
            if (cell == nil) {
                cell = [[NSVManagementEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            NSVManagementEditTableViewCell* tableCell = (NSVManagementEditTableViewCell*)cell;
            tableCell.delegate = self;
            
            if (self.panMgmNurseLevel == NSVPanMgmOfficeLevel) {
                NSVOffice* o = [NSVDataCenter defaultCenter].staffs.offices[indexPath.row];
                tableCell.name = o.name;
                tableCell.score = nil;
                tableCell.level = [NSNumber numberWithInteger:NSVPanMgmOfficeLevel];
                tableCell.row = indexPath.row;
                tableCell.showIndicator = YES;
                
            }
            else if (self.panMgmNurseLevel == NSVPanMgmNurseLevel){
                NSVOffice* o = [NSVDataCenter defaultCenter].staffs.offices[self.panMgnNurseIndexPath.section];
                NSVNurse* n = o.nurses[indexPath.row];
                
                tableCell.name = n.name;
                tableCell.score = nil;
                tableCell.level = [NSNumber numberWithInteger:NSVPanMgmNurseLevel];
                tableCell.row = indexPath.row;
                tableCell.showIndicator = NO;
            }
        }
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL canMove = NO;
    
    if (tableView == self.panMgmProjectTableView) {
        canMove = YES;
    }
    
    return canMove;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (tableView == self.panMgmProjectTableView) {
        
        // 编辑项目
        if (self.panMgmType == NSVPanMgmProject) {
            switch (self.panMgmProjectLevel) {
                case NSVPanMgmClassifyLevel:{
                    NSMutableArray* classfies = [NSVDataCenter defaultCenter].assessment.classifies;
                    
                    NSVClassify* source = classfies[sourceIndexPath.row];
                    
                    if (sourceIndexPath.row > destinationIndexPath.row) {
                        [classfies removeObjectAtIndex:sourceIndexPath.row];
                        [classfies insertObject:source atIndex:destinationIndexPath.row];
                    }else{
                        [classfies removeObjectAtIndex:sourceIndexPath.row];
                        [classfies insertObject:source atIndex:destinationIndexPath.row];
                    }
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.projectTableView reloadData];
                    
                }
                    break;
                    
                case NSVPanMgmProjectLevel:{
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                    
                    NSMutableArray* projects = c.projects;
                    
                    
                    NSVProject* source = projects[sourceIndexPath.row];
                    
                    if (sourceIndexPath.row > destinationIndexPath.row) {
                        [projects removeObjectAtIndex:sourceIndexPath.row];
                        [projects insertObject:source atIndex:destinationIndexPath.row];
                    }else{
                        [projects removeObjectAtIndex:sourceIndexPath.row];
                        [projects insertObject:source atIndex:destinationIndexPath.row];
                    }
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.projectTableView reloadData];
                    
                }
                    break;
                    
                case NSVPanMgmIssueLevel:{
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                    
                    NSVProject* p = c.projects[self.panMgnProjectIndexPath.row];
                    
                    NSMutableArray* issues = p.issues;
                    
                    
                    NSVProject* source = issues[sourceIndexPath.row];
                    
                    if (sourceIndexPath.row > destinationIndexPath.row) {
                        [issues removeObjectAtIndex:sourceIndexPath.row];
                        [issues insertObject:source atIndex:destinationIndexPath.row];
                    }else{
                        [issues removeObjectAtIndex:sourceIndexPath.row];
                        [issues insertObject:source atIndex:destinationIndexPath.row];
                    }
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.issueTableView reloadData];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        // 编辑护士
        else if (self.panMgmType == NSVPanMgmNurse){
            switch (self.panMgmNurseLevel) {
                case NSVPanMgmOfficeLevel:{
                    
                    NSMutableArray* offices = [NSVDataCenter defaultCenter].staffs.offices;
                    
                    NSVOffice* source = offices[sourceIndexPath.row];
                    
                    [offices removeObjectAtIndex:sourceIndexPath.row];
                    [offices insertObject:source atIndex:destinationIndexPath.row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.nurseTableView reloadData];
                    
                }
                    break;
                    
                case NSVPanMgmNurseLevel:{
                    
                    
                    NSVOffice* office = [NSVDataCenter defaultCenter].staffs.offices[self.panMgnNurseIndexPath.section];
                    NSMutableArray* nurses = office.nurses;
                    
                    NSVOffice* source = nurses[sourceIndexPath.row];
                    
                    [nurses removeObjectAtIndex:sourceIndexPath.row];
                    [nurses insertObject:source atIndex:destinationIndexPath.row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self refreshNursesData];
                    [self.nurseTableView reloadData];
                }
                    break;
                    
                default:{
                    
                }
                    break;
            }
        }
        

        
        NSLog(@"from: %ld, %ld; to: %ld, %ld", (long)sourceIndexPath.section, (long)sourceIndexPath.row, (long)destinationIndexPath.section, (long)destinationIndexPath.row);
    }
}

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCellAccessoryType type = UITableViewCellAccessoryNone;
//    if (tableView == self.panMgmProjectTableView) {
//        type = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    
//    return type;
//}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.panMgmProjectTableView) {
    }
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
    }else if (tableView == self.projectManagementTableView){
        height = 4.0f;
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
    }else if (tableView == self.panMgmProjectTableView){
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
                else if (section <= [NSVDataCenter defaultCenter].assessment.classifies.count){
                    NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[section - 1];
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
    }else if (tableView == self.projectManagementTableView){
        bgView.frame = CGRectMake(0.0f, 0.0f, NSVLeftAreaWidth, 4.0f);
        bgView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
        
    }

    
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 左侧 项目列表
    if (tableView == self.projectTableView) {
        
        if (indexPath != self.selectedProjectIndexPath) {
            self.selectedProjectIndexPath = indexPath;
            [self.issueTableView reloadData];
        }
    }
    // 左侧 项目管理列表
    else if (tableView == self.projectManagementTableView){
        
        
        if (indexPath.row == 0) {
            if(self.panMgmType != NSVPanMgmProject){
                self.panMgmType = NSVPanMgmProject;
                
                [self.panMgmProjectTableView setEditing:NO animated:YES];
                [self.panMgmProjectTableView reloadData];
                
                [self refreshPanMgmButtonStatus];
                
            }
            
        }else if (indexPath.row == 1){
            
            if (self.panMgmType != NSVPanMgmNurse) {
                self.panMgmType = NSVPanMgmNurse;
                
                [self refreshNursesData];
                [self.panMgmProjectTableView setEditing:NO animated:YES];
                [self.panMgmProjectTableView reloadData];
                
                [self refreshPanMgmButtonStatus];
            }
            
        }
        
    }
    // 右侧 问题记录列表
    else if (tableView == self.issueTableView){
        
        NSVIssue* issue = nil;
        
        if (self.selectedProjectIndexPath.section == 0) {
            NSMutableArray* issueArray = [NSMutableArray array];
            for (NSVClassify* classify in [NSVDataCenter defaultCenter].assessment.classifies) {
                for (NSVProject* project in classify.projects) {
                    [issueArray addObjectsFromArray:project.issues];
                }
            }
            
            issue = issueArray[indexPath.row];
            
        }
        else
        {
            NSVClassify* classify = [NSVDataCenter defaultCenter].assessment.classifies[self.selectedProjectIndexPath.section - 1];
            NSVProject* project = classify.projects[self.selectedProjectIndexPath.row];
            issue = project.issues[indexPath.row];
        }
        
        
        if(self.selectedIssue != issue){
            self.selectedIssue = issue;
            [self.nurseTableView reloadData];
            self.issueRecordCommitButton.enabled = NO;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
        }
        
    }
    // 右侧 护士列表
    else if (tableView == self.nurseTableView){
        NSArray* selected = [self.nurseTableView indexPathsForSelectedRows];
        
        if (selected.count == 0) {
            self.issueRecordCommitButton.enabled = NO;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
        }else{
            self.issueRecordCommitButton.enabled = YES;
            self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0x71a960];
        }
    }
    
    // 右侧 问题搜索结果列表
    else if(tableView == self.issueSearchResultTableView){
        NSVIssue* issueSelected = self.issueSearchResultArray[indexPath.row];
        
        [self selectProjectAndIssue:issueSelected];
        [self searchBarCancelButtonClicked:self.issueSearchBar];
    }
    
    // 右侧 项目和护士编辑列表
    else if (tableView == self.panMgmProjectTableView){
        
        if (self.panMgmType == NSVPanMgmProject) {
            if (!self.panMgmProjectTableView.isEditing) {
                NSLog(@"select cell index path: %ld, %ld, level: %ld", (long)indexPath.section, (long)indexPath.row, (long)self.panMgmProjectLevel);
                
                if (self.panMgmProjectLevel == NSVPanMgmClassifyLevel) {
                    self.panMgmProjectLevel = NSVPanMgmProjectLevel;
                    self.panMgmNavTitleLabel.text = @"项目";
                    self.panMgnProjectIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
                    
                    [self.panMgmProjectTableView reloadData];
                    
                    self.panMgmNavBackButton.enabled = YES;
                    
                }else if (self.panMgmProjectLevel == NSVPanMgmProjectLevel){
                    self.panMgmProjectLevel = NSVPanMgmIssueLevel;
                    self.panMgmNavTitleLabel.text = @"问题";
                    
                    NSInteger section = self.panMgnProjectIndexPath.section;
                    self.panMgnProjectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:section];
                    
                    [self.panMgmProjectTableView reloadData];
                    self.panMgmNavBackButton.enabled = YES;
                }
            }
        }
        
        else if (self.panMgmType == NSVPanMgmNurse){
            if (!self.panMgmProjectTableView.isEditing) {
                NSLog(@"select cell index path: %ld, %ld, level: %ld", (long)indexPath.section, (long)indexPath.row, (long)self.panMgmProjectLevel);
                
                if (self.panMgmNurseLevel == NSVPanMgmOfficeLevel) {
                    self.panMgmNurseLevel = NSVPanMgmNurseLevel;
                    
                    self.panMgmNavTitleLabel.text = @"人员";
                    
                    self.panMgnNurseIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
                    
                    [self.panMgmProjectTableView reloadData];
                    
                    self.panMgmNavBackButton.enabled = YES;
                }
            }
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    
    if (tableView == self.panMgmProjectTableView) {
        style = UITableViewCellEditingStyleNone;
    }
    
    return style;
}


#pragma mark - button clicked
-(void) projectSwitchButtonClicked:(UIButton*)button{
    
    CGFloat selfHeight = self.view.frame.size.height;
    
    CGFloat delta = selfHeight - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    if (self.projectBgView.frame.size.height <= NSVProjectLabelHeight) {
        // 右侧视图
//        CGRect issueRecordBgViewFrame = self.issueRecordBgView.frame;
//        issueRecordBgViewFrame.origin.y = self.height;
//        self.issueRecordBgView.frame = issueRecordBgViewFrame;
        [self.view bringSubviewToFront:self.issueRecordBgView];
        
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
            
//            // 右侧视图
//            CGRect bgViewFrame = self.issueRecordBgView.frame;
//            bgViewFrame.origin.y = StatusBarHeight;
//            
//            self.issueRecordBgView.frame = bgViewFrame;
            
        }];
    }
    

}

-(void) projectManageSwitchButtonClicked:(UIButton*)button{
    

    
    CGFloat selfHeight = self.view.frame.size.height;
    
    CGFloat delta = selfHeight - 3.0f * NSVProjectLabelHeight - StatusBarHeight;
    
    if (self.projectManagementBgView.frame.size.height <= NSVProjectLabelHeight) {
        
//        // 右侧视图
//        CGRect manageBgViewFrame = self.projectAndNurseManagementBgView.frame;
//        manageBgViewFrame.origin.y = self.height;
//        self.projectAndNurseManagementBgView.frame = manageBgViewFrame;
        [self.view bringSubviewToFront:self.projectAndNurseManagementBgView];
        
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
            
            
//            // 右侧视图
//            CGRect bgViewFrame = self.projectAndNurseManagementBgView.frame;
//            bgViewFrame.origin.y = StatusBarHeight;
//            
//            self.projectAndNurseManagementBgView.frame = bgViewFrame;
            
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

-(void) issueRecordCommitButtonClicked:(UIButton*)button{
    if (self.selectedIssue == nil) {
        [self showMessageBox:@"请先选择一个问题。"];
        return;
    }
    
    NSArray* selectedNurseCells = [self.nurseTableView indexPathsForSelectedRows];
    
    for (NSIndexPath* index in selectedNurseCells) {
        NSVNurse* n = self.nurses[index.row];
        
        NSVRecord* record = [[NSVRecord alloc] initWithNuser:n issue:self.selectedIssue];
        [[NSVDataCenter defaultCenter] addNewRecord:record];
    }
    
    [self.nurseTableView reloadData];
    
    self.issueRecordCommitButton.enabled = NO;
    self.issueRecordCommitButton.backgroundColor = [UIColor colorWithRGBHex:0xd7d7d5];
    
    [self showMessageBox:@"成功记录！"];
    
    
}

-(void) panMgmNavEditButtonClicked:(UIButton*)button{
    if (self.panMgmProjectTableView.isEditing) {
        self.panMgmNavNewButton.alpha = 1.0f;
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [self.panMgmProjectTableView setEditing:NO animated:YES];
        [self.panMgmProjectTableView reloadData];
    }else{
        self.panMgmNavNewButton.alpha = 0.0f;
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [self.panMgmProjectTableView setEditing:YES animated:YES];
        [self.panMgmProjectTableView reloadData];
    }
}


-(void) panMgmNavNewButtonClicked:(UIButton*)button{
    [self showNewDialog];
}

-(void) panMgmNavBackButtonClicked:(UIButton*)button{
    [self.panMgmProjectTableView setEditing:NO animated:YES];
    self.panMgmNavNewButton.alpha =  1.0f;
    
    if(self.panMgmType == NSVPanMgmProject){
        if (self.panMgmProjectLevel == NSVPanMgmProjectLevel) {
            self.panMgmProjectLevel = NSVPanMgmClassifyLevel;
            button.enabled = NO;
            [self.panMgmProjectTableView reloadData];
            
            self.panMgmNavTitleLabel.text = @"标准";
            
            
        }else if (self.panMgmProjectLevel == NSVPanMgmIssueLevel) {
            self.panMgmProjectLevel = NSVPanMgmProjectLevel;
            [self.panMgmProjectTableView reloadData];
            
            self.panMgmNavTitleLabel.text = @"项目";
        }
    }
    
    else if (self.panMgmType == NSVPanMgmNurse){
        if (self.panMgmNurseLevel == NSVPanMgmNurse) {
            self.panMgmNurseLevel = NSVPanMgmOfficeLevel;
            button.enabled = NO;
            
            [self.panMgmProjectTableView reloadData];
            
            self.panMgmNavTitleLabel.text = @"科室";
        }
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
    
    [self.projectManagementTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
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
    
    
    // 选时间 文字标签
    self.pickDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                   historyLabelBgView.frame.origin.y + historyLabelBgView.frame.size.height + 9.0f,
                                                                   self.historyBgView.frame.size.width,
                                                                   25.0f)];
    NSString* pickDateLabelText = @"选时间";
    self.pickDateLabel.backgroundColor = [UIColor colorWithRGBHex:0xd6dbd2];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:pickDateLabelText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, pickDateLabelText.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGBHex:0x747474] range:NSMakeRange(0, pickDateLabelText.length)];
    
    NSMutableParagraphStyle* style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.headIndent = 15.0f;
    style.tailIndent = -15.0f;
    style.firstLineHeadIndent = 15.0f;
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, pickDateLabelText.length)];
    
    self.pickDateLabel.attributedText = attrString;
    
    [self.historyBgView addSubview:self.pickDateLabel];
    
    // 开始时间 文字标签
    self.pickStartDateLable = [[UILabel alloc] initWithFrame:CGRectMake(25.0f,
                                                                        self.pickDateLabel.frame.origin.y + self.pickDateLabel.frame.size.height + 4.0f,
                                                                        30.0f,
                                                                        25.0f)];
    
    NSString* pickStartDateLabelText = @"开始";
    self.pickDateLabel.backgroundColor = [UIColor clearColor];
    attrString = [[NSMutableAttributedString alloc] initWithString:pickStartDateLabelText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, pickDateLabelText.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGBHex:0x36363d] range:NSMakeRange(0, pickDateLabelText.length)];
    
//    NSMutableParagraphStyle* style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.headIndent = 15.0f;
//    style.tailIndent = -15.0f;
//    style.firstLineHeadIndent = 15.0f;
//    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, pickDateLabelText.length)];
    
    self.pickDateLabel.attributedText = attrString;
    [self.historyBgView addSubview:self.pickStartDateLable];
    
//    // 历史 列表
//    self.historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
//                                                                          NSVProjectLabelHeight,
//                                                                          NSVLeftAreaWidth,
//                                                                          self.deltaOfLeftHeight) style:UITableViewStylePlain];
//    self.historyTableView.dataSource = self;
//    self.historyTableView.delegate = self;
//    self.historyTableView.backgroundColor = [UIColor colorWithRGBHex:NSVProjectCellBackgroundColor];
//    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    [self.historyBgView addSubview:self.historyTableView];
    
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
    [self.issueRecordCommitButton addTarget:self action:@selector(issueRecordCommitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
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

-(void) initProjectAndNurseManagementOfRightSide{
    self.projectAndNurseManagementBgView = [[UIView alloc] initWithFrame:CGRectMake(NSVLeftAreaWidth, StatusBarHeight, self.width - NSVLeftAreaWidth, self.height - StatusBarHeight)];
    self.projectAndNurseManagementBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.projectAndNurseManagementBgView];
    
    // 顶部导航栏
    self.panMgmNavView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.width - NSVLeftAreaWidth, 44.0f)];
    self.panMgmNavView.backgroundColor = [UIColor whiteColor];
    
    [self.projectAndNurseManagementBgView addSubview:self.panMgmNavView];
    
    // 顶部导航分隔线
    UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, self.projectAndNurseManagementBgView.frame.size.width, 1.0f)];
    
    sep.backgroundColor = [UIColor colorWithRGBHex:0xc0c0c0];
    [self.projectAndNurseManagementBgView addSubview:sep];
    
    
    // 返回按钮
    self.panMgmNavBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.panMgmNavBackButton.frame = CGRectMake(25.0f, 0.0f, 40.0f, 44.0f);
    [self.panMgmNavBackButton setTitle:@"返回" forState:UIControlStateNormal];
    self.panMgmNavBackButton.enabled = NO;
    [self.panMgmNavBackButton addTarget:self action:@selector(panMgmNavBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.panMgmNavView addSubview:self.panMgmNavBackButton];
    
    // 编辑按钮
    self.panMgmNavEditButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.panMgmNavEditButton.frame = CGRectMake(self.panMgmNavView.frame.size.width - 85.0f, 0.0f, 60.0f, 44.0f);
    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.panMgmNavEditButton.enabled = YES;
    self.panMgmNavEditButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.panMgmNavEditButton addTarget:self action:@selector(panMgmNavEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.panMgmNavView addSubview:self.panMgmNavEditButton];

    // 新建按钮 panMgmNavNewButton
    self.panMgmNavNewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.panMgmNavNewButton.frame = CGRectMake(self.panMgmNavView.frame.size.width - 85.0f - 60.0f - 10.0f, 0.0f, 60.0f, 44.0f);
    [self.panMgmNavNewButton setTitle:@"新建" forState:UIControlStateNormal];
    self.panMgmNavNewButton.enabled = YES;
    self.panMgmNavNewButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.panMgmNavNewButton addTarget:self action:@selector(panMgmNavNewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.panMgmNavView addSubview:self.panMgmNavNewButton];
    
    // 导航栏 标题
    self.panMgmNavTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.panMgmNavBackButton.frame.origin.x + self.panMgmNavBackButton.frame.size.width + 20.0f,
                                                                         0.0f,
                                                                         self.width - NSVLeftAreaWidth - 2.0f * (self.panMgmNavBackButton.frame.origin.x + self.panMgmNavBackButton.frame.size.width + 20.0f),
                                                                         44.0f)];
    self.panMgmNavTitleLabel.text = @"标准";
    self.panMgmNavTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    self.panMgmNavTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.panMgmNavTitleLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
    [self.panMgmNavView addSubview:self.panMgmNavTitleLabel];
    
    // 项目管理列表
    self.panMgmProjectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, self.width - NSVLeftAreaWidth, self.height - 44.0f - StatusBarHeight) style:UITableViewStylePlain];
    
    self.panMgmProjectTableView.delegate = self;
    self.panMgmProjectTableView.dataSource =self;
    self.panMgmProjectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.panMgmProjectTableView setEditing:YES animated:YES];
    
    self.panMgmProjectTableView.allowsSelectionDuringEditing = YES;
    
    [self.projectAndNurseManagementBgView addSubview:self.panMgmProjectTableView];
    
    self.panMgmProjectLevel = NSVPanMgmClassifyLevel;
}

#pragma mark - 私有函数
-(void) refreshNursesData{
    
    // 清空本地缓存
    [self.nurses removeAllObjects];
    
    NSArray* pinyinArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    
    NSMutableArray* nurses = [NSMutableArray array];
    
    for (NSVOffice* office in [NSVDataCenter defaultCenter].staffs.offices) {
        for (NSVNurse* n in office.nurses) {
            [nurses addObject:n];
        }
    }
    
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
    
    for (NSVClassify* classify in [NSVDataCenter defaultCenter].assessment.classifies) {
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
    NSInteger classifyIndex = 1;
    NSInteger projectIndex = 0;
    NSInteger issueIndex = 0;
    
    for (NSVClassify* classify in [NSVDataCenter defaultCenter].assessment.classifies) {
        projectIndex = 0;
        for (NSVProject* project in classify.projects) {
            issueIndex = 0;
            for (NSVIssue* i in project.issues) {
                
                if (i == issue) {
                    NSIndexPath* projectIndexPath = [NSIndexPath indexPathForRow:projectIndex inSection:classifyIndex];
                    
                    [self.projectTableView selectRowAtIndexPath:projectIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                    
                    [self tableView:self.projectTableView didSelectRowAtIndexPath:projectIndexPath];
                    
                    
                    NSIndexPath* issueIndexPath = [NSIndexPath indexPathForRow:issueIndex inSection:0];
                    
                    [self.issueTableView selectRowAtIndexPath:issueIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                    
                    [self tableView:self.issueTableView didSelectRowAtIndexPath:issueIndexPath];
                    
                    return;
                }
                
                issueIndex++;
            }
            
            projectIndex++;
        }
        
        classifyIndex++;
    }
}

-(void) showMessageBox:(NSString*)message{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@""
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"好的"
                                         otherButtonTitles:nil];
    [alert show];
}

-(void) refreshPanMgmButtonStatus{
    if (self.panMgmType == NSVPanMgmProject) {
        switch (self.panMgmProjectLevel) {
            case NSVPanMgmClassifyLevel:{
                if (self.panMgmProjectTableView.isEditing) {
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"完成" forState:UIControlStateNormal];
                }else{
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
                }
                
                self.panMgmNavTitleLabel.text = @"标准";
            }
                break;
                
            case NSVPanMgmProjectLevel:{
                if (self.panMgmProjectTableView.isEditing) {
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"完成" forState:UIControlStateNormal];
                }else{
                    self.panMgmNavBackButton.enabled = YES;
                    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
                }
                self.panMgmNavTitleLabel.text = @"项目";
            }
                break;
                
            case NSVPanMgmIssueLevel:{
                if (self.panMgmProjectTableView.isEditing) {
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"完成" forState:UIControlStateNormal];
                }else{
                    self.panMgmNavBackButton.enabled = YES;
                    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
                }
                self.panMgmNavTitleLabel.text = @"问题";
            }
                break;
                
            default:
                break;
        }
    }
    
    else if(self.panMgmType == NSVPanMgmNurse){
        switch (self.panMgmNurseLevel) {
            case NSVPanMgmOfficeLevel:{
                if (self.panMgmProjectTableView.isEditing) {
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"完成" forState:UIControlStateNormal];
                }else{
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
                }
                
                self.panMgmNavTitleLabel.text = @"科室";
            }
                break;
                
            case NSVPanMgmNurseLevel:{
                if (self.panMgmProjectTableView.isEditing) {
                    self.panMgmNavBackButton.enabled = NO;
                    [self.panMgmNavEditButton setTitle:@"完成" forState:UIControlStateNormal];
                }else{
                    self.panMgmNavBackButton.enabled = YES;
                    [self.panMgmNavEditButton setTitle:@"编辑" forState:UIControlStateNormal];
                }
                self.panMgmNavTitleLabel.text = @"人员";
            }
                break;
                
            default:
                break;
        }
    }
}




-(void) showNewDialog{
    self.dialogForNew = [[NSVNewDialog alloc] initWithFrame:self.view.bounds];
    
    switch (self.panMgmType) {
        case NSVPanMgmProject:{
            switch (self.panMgmProjectLevel) {
                case NSVPanMgmClassifyLevel:{
                    [self.dialogForNew setTitle:@"新建标准"];
                    [self.dialogForNew setNamePlaceHolder:@"标准名称"];
                    [self.dialogForNew setShowScoreTextField:NO];
                    self.dialogForNew.panMgmLevel = self.panMgmProjectLevel;
                    self.dialogForNew.indexPath = self.panMgnProjectIndexPath;
                }
                    break;
                    
                case NSVPanMgmProjectLevel:{
                    [self.dialogForNew setTitle:@"新建项目"];
                    [self.dialogForNew setNamePlaceHolder:@"项目名称"];
                    [self.dialogForNew setShowScoreTextField:NO];
                    self.dialogForNew.panMgmLevel = self.panMgmProjectLevel;
                    self.dialogForNew.indexPath = self.panMgnProjectIndexPath;
                }
                    break;
                    
                case NSVPanMgmIssueLevel:{
                    [self.dialogForNew setTitle:@"新建问题"];
                    [self.dialogForNew setNamePlaceHolder:@"问题名称"];
                    [self.dialogForNew setScorePlaceHolder:@"分值"];
                    [self.dialogForNew setShowScoreTextField:YES];
                    self.dialogForNew.panMgmLevel = self.panMgmProjectLevel;
                    self.dialogForNew.indexPath = self.panMgnProjectIndexPath;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;

        case NSVPanMgmNurse:{
            switch (self.panMgmNurseLevel) {
                case NSVPanMgmOfficeLevel:{
                    [self.dialogForNew setTitle:@"新建科室"];
                    [self.dialogForNew setNamePlaceHolder:@"科室名称"];
                    [self.dialogForNew setShowScoreTextField:NO];
                    self.dialogForNew.panMgmLevel = self.panMgmNurseLevel;
                    self.dialogForNew.indexPath = self.panMgnNurseIndexPath;
                }
                    break;
                    
                case NSVPanMgmNurseLevel:{
                    [self.dialogForNew setTitle:@"新建人员"];
                    [self.dialogForNew setNamePlaceHolder:@"姓名"];
                    [self.dialogForNew setShowScoreTextField:NO];
                    self.dialogForNew.panMgmLevel = self.panMgmNurseLevel;
                    self.dialogForNew.indexPath = self.panMgnNurseIndexPath;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    self.dialogForNew.panMgmType = self.panMgmType;
    
    self.dialogForNew.delegate = self;
    [self.view addSubview:self.dialogForNew];
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

#pragma mark - 响应键盘事件
-(void) keyboardWillShow:(NSNotification*)notification{
}

-(void) keyboardWillHide:(NSNotification*)notification{
    CGRect panBgViewFrame = self.projectAndNurseManagementBgView.frame;
    panBgViewFrame.size.height = self.view.frame.size.height - StatusBarHeight;
    self.projectAndNurseManagementBgView.frame = panBgViewFrame;
    
    CGRect panProjectTableViewFrame = self.panMgmProjectTableView.frame;
    panProjectTableViewFrame.size.height = self.view.frame.size.height - StatusBarHeight - 44.0f;
    self.panMgmProjectTableView.frame = panProjectTableViewFrame;
}

-(void) keyboardWillChange:(NSNotification*)notification{
    
    if (self.panMgmProjectTableView.isEditing) {
        NSDictionary *userInfo = [notification userInfo];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        
        CGRect panBgViewFrame = self.projectAndNurseManagementBgView.frame;
        panBgViewFrame.size.height = self.view.frame.size.height - StatusBarHeight - keyboardRect.size.height;
        self.projectAndNurseManagementBgView.frame = panBgViewFrame;
        
        
        CGRect panProjectTableViewFrame = self.panMgmProjectTableView.frame;
        panProjectTableViewFrame.size.height = self.view.frame.size.height - StatusBarHeight - 44.0f - keyboardRect.size.height;
        self.panMgmProjectTableView.frame = panProjectTableViewFrame;
    }else if (self.dialogForNew != nil){
        
        NSDictionary *userInfo = [notification userInfo];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        
        CGRect dialogFrame = self.dialogForNew.frame;
        dialogFrame.size.height = self.view.frame.size.height - StatusBarHeight - keyboardRect.size.height;
        self.dialogForNew.frame = dialogFrame;
    }
}

#pragma mark - NSVManagementEditTableViewCellDelegate

-(void) tableViewCell:(NSVManagementEditTableViewCell*)cell nameTextChanged:(NSString*)text level:(NSNumber*)level indexPathRow:(NSInteger)row{
    if(self.panMgmProjectLevel == [level integerValue]){
        if (self.panMgmProjectLevel == NSVPanMgmClassifyLevel) {
            NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[row];
            
            c.name = text;
            
            [[NSVDataCenter defaultCenter] save];
            
            [self.projectTableView reloadData];
        }else if(self.panMgmProjectLevel == NSVPanMgmProjectLevel){
            NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
            
            NSVProject* p = c.projects[row];
            
            p.name = text;
            
            [[NSVDataCenter defaultCenter] save];
            
            [self.projectTableView reloadData];
        }else if (self.panMgmProjectLevel == NSVPanMgmIssueLevel){
            NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
            
            NSVProject* p = c.projects[self.panMgnProjectIndexPath.row];
            
            NSVIssue* i = p.issues[row];
            
            i.name = text;
            
            [[NSVDataCenter defaultCenter] save];
            
            [self.issueTableView reloadData];
        }
    }
}

-(void) tableViewCell:(NSVManagementEditTableViewCell*)cell scoreTextChanged:(NSString*)text level:(NSNumber*)level indexPathRow:(NSInteger)row{
    if(self.panMgmProjectLevel == [level integerValue]){
        if (self.panMgmProjectLevel == NSVPanMgmIssueLevel){
            NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
            
            NSVProject* p = c.projects[self.panMgnProjectIndexPath.row];
            
            NSVIssue* i = p.issues[row];
            
            i.score = [text floatValue];
            
            [[NSVDataCenter defaultCenter] save];
            
            [self.issueTableView reloadData];
        }
    }
}

-(void) tableViewCell:(NSVManagementEditTableViewCell*)cell deleteButtonClickedWithLevel:(NSNumber*)level indexPathRow:(NSInteger)row{
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@""
                                                   message:@"确定要删除吗?"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    alert.tag = row;
    [alert show];
    

}

#pragma mark - NSVNewDialogDelegate

-(void) dialogOkButtonClicked:(NSVNewDialog*)dialog nameField:(NSString *)name scoreField:(NSString *)score panMgmType:(NSInteger)type panMgmLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath{
    [self.panMgmProjectTableView reloadData];
    
    
    switch (type) {
        case NSVPanMgmProject:{
            switch (level) {
                case NSVPanMgmClassifyLevel:{
                    
                    NSVClassify* c = [[NSVClassify alloc] init];
                    c.name = name;
                    c.projects = [NSMutableArray<NSVProject> array];
                    
                    [[NSVDataCenter defaultCenter].assessment.classifies addObject:c];
                    [[NSVDataCenter defaultCenter] save];
                    [self.panMgmProjectTableView reloadData];
                    [self.projectTableView reloadData];
                    
                }
                    break;
                    
                case NSVPanMgmProjectLevel:{
                    NSVProject* p = [[NSVProject alloc] init];
                    p.name = name;
                    p.issues = [NSMutableArray<NSVIssue> array];
                    
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[indexPath.section];
                    [c.projects addObject:p];
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.panMgmProjectTableView reloadData];
                    [self.projectTableView reloadData];
                }
                    break;
                    
                case NSVPanMgmIssueLevel:{
                    NSVIssue* i = [[NSVIssue alloc] init];
                    i.name = name;
                    i.score = [score floatValue];
                    
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[indexPath.section];
                    NSVProject* p = c.projects[indexPath.row];
                    
                    [p.issues addObject:i];
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.panMgmProjectTableView reloadData];
                    [self.issueTableView reloadData];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case NSVPanMgmNurse:{
            switch (level) {
                case NSVPanMgmOfficeLevel:{
                    NSVOffice* o = [[NSVOffice alloc] init];
                    o.name = name;
                    o.nurses = [NSMutableArray<NSVNurse> array];
                    
                    [[NSVDataCenter defaultCenter].staffs.offices addObject:o];
                    [[NSVDataCenter defaultCenter] save];
                    [self.panMgmProjectTableView reloadData];
                    [self.nurseTableView reloadData];
                }
                    break;
                    
                case NSVPanMgmNurseLevel:{
                    NSVNurse* n = [[NSVNurse alloc] init];
                    n.name = name;
                    
                    NSVOffice* o = [NSVDataCenter defaultCenter].staffs.offices[indexPath.section];
                    
                    [o.nurses addObject:n];
                    
                    [[NSVDataCenter defaultCenter] save];
                    [self.panMgmProjectTableView reloadData];
                    
                    [self refreshNursesData];
                    [self.nurseTableView reloadData];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    self.dialogForNew = nil;
}

-(void) dialogCancelButtonClicked:(NSVNewDialog*)dialog{
    self.dialogForNew = nil;
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex != 1) {
        return;
    }
    
    NSInteger row = alertView.tag;
    
    switch (self.panMgmType) {
        case NSVPanMgmProject:{
//            if(self.panMgmProjectLevel == [level integerValue]){
                if (self.panMgmProjectLevel == NSVPanMgmClassifyLevel) {
                    [[NSVDataCenter defaultCenter].assessment.classifies removeObjectAtIndex:row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    
                    [self.panMgmProjectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self.projectTableView reloadData];
                    
                    
                }else if(self.panMgmProjectLevel == NSVPanMgmProjectLevel){
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                    
                    [c.projects removeObjectAtIndex:row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    
                    [self.panMgmProjectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    
                    [self.projectTableView reloadData];
                }else if (self.panMgmProjectLevel == NSVPanMgmIssueLevel){
                    NSVClassify* c = [NSVDataCenter defaultCenter].assessment.classifies[self.panMgnProjectIndexPath.section];
                    
                    NSVProject* p = c.projects[self.panMgnProjectIndexPath.row];
                    
                    [p.issues removeObjectAtIndex:row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    
                    [self.panMgmProjectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    
                    [self.issueTableView reloadData];
                }
//            }
        }
            break;
            
            
        case NSVPanMgmNurse:{
//            if(self.panMgmNurseLevel == [level integerValue]){
                if (self.panMgmNurseLevel == NSVPanMgmOfficeLevel) {
                    [[NSVDataCenter defaultCenter].staffs.offices removeObjectAtIndex:row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    
                    [self.panMgmProjectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self refreshNursesData];
                    [self.nurseTableView reloadData];
                    
                    
                }else if(self.panMgmNurseLevel == NSVPanMgmNurseLevel){
                    NSVOffice* o = [NSVDataCenter defaultCenter].staffs.offices[self.panMgnNurseIndexPath.section];
                    
                    [o.nurses removeObjectAtIndex:row];
                    
                    [[NSVDataCenter defaultCenter] save];
                    
                    
                    [self.panMgmProjectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self.panMgmProjectTableView reloadData];
                    
                    [self refreshNursesData];
                    [self.nurseTableView reloadData];
                }
//            }
        }
            break;
            
        default:
            break;
    }


}

@end
