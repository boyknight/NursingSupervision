//
//  NSVIssueViewController.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSVProject.h"

@interface NSVIssueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

-(void) setProjectFilter:(NSVProject*)projectFilter;

@end
