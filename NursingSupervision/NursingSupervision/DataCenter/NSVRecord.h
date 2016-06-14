//
//  NSVRecord.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"
#import "NSVClassify.h"
#import "NSVProject.h"
#import "NSVIssue.h"
#import "NSVNurse.h"

@protocol NSVRecord <NSObject>

@end

@interface NSVRecord : JSONModel

@property (nonatomic, assign) NSInteger recordId;

@property (nonatomic, strong) NSVNurse* nurse;
@property (nonatomic, strong) NSVIssue* issue;

@end
