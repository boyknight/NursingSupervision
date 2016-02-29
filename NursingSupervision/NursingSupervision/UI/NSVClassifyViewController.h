//
//  NSVClassViewController.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSVProject.h"

@class NSVClassifyViewController;


@protocol NSVClassifyViewControllerDelegate <NSObject>

-(void) classifyViewController:(NSVClassifyViewController*)classifyViewController projectSelected:(NSVProject*)project;

@end

@interface NSVClassifyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<NSVClassifyViewControllerDelegate> delegate;

@end
