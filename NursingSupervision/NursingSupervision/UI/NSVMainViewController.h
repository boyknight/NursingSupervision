//
//  NSVMainCollectionViewController.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSVClassifyViewController.h"
#import "NSVManagementEditTableViewCell.h"
#import "NSVNewDialog.h"


@interface NSVMainViewController : UIViewController <UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
NSVManagementEditTableViewCellDelegate,
NSVNewDialogDelegate,
UIAlertViewDelegate>

@end
