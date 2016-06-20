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

@property (nonatomic, strong, nonnull) NSVNurse* nurse;
@property (nonatomic, strong, nonnull) NSVIssue* issue;
@property (nonnull, strong, nonatomic) NSDate* recordDate;


-(nonnull instancetype) initWithNuser:(nonnull NSVNurse*) nurse issue:(nonnull NSVIssue*)issue;

@end
