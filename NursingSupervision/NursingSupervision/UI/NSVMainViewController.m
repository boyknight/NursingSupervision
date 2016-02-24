//
//  NSVMainCollectionViewController.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVMainViewController.h"
#import "NSVClassViewController.h"
#import "NSVIssueViewController.h"

@interface NSVMainViewController ()

@end

@implementation NSVMainViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSVClassViewController* classVC = [[NSVClassViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController* classNC = [[UINavigationController alloc] initWithRootViewController:classVC];
    
    NSVIssueViewController* issueVC = [[NSVIssueViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController* issueNC = [[UINavigationController alloc] initWithRootViewController:issueVC];
    
    self.viewControllers = @[classNC, issueNC];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
