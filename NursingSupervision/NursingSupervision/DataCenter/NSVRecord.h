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
#import "NSVOffice.h"
#import "NSVProject.h"
#import "NSVIssue.h"
#import "NSVNurse.h"

@protocol NSVRecord <NSObject>

@end

@interface NSVRecord : JSONModel

@property (nonatomic, strong, nonnull) NSString* uid;

@property (nonatomic, strong, nonnull) NSVNurse* nurse;
@property (nonatomic, strong, nonnull) NSVIssue* issue;
@property (nonnull, strong, nonatomic) NSDate* recordDate;

@end
