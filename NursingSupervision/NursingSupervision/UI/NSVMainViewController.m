//
//  NSVMainCollectionViewController.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVMainViewController.h"
#import "NSVClassifyViewController.h"
#import "NSVIssueViewController.h"

@interface NSVMainViewController ()

@end

@implementation NSVMainViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) classifyViewController:(NSVClassifyViewController*)classifyViewController projectSelected:(NSVProject*)project{
    [self.issueViewController setProjectFilter:project];
}

@end
