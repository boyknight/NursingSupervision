//
//  NSVRecord.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCLModel.h"
#import "NSVClass.h"
#import "NSVProject.h"
#import "NSVIssue.h"
#import "NSVNurse.h"

@interface NSVRecord : OCLModel

@property (nonatomic, assign) NSInteger recordId;

@property (nonatomic, strong) NSVNurse* nurse;
@property (nonatomic, strong) NSVIssue* issue;

@end
