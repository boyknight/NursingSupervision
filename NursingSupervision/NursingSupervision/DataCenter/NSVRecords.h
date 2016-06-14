//
//  NSVRecords.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/14.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NSVRecord.h"

@interface NSVRecords : JSONModel

@property (nonatomic, strong) NSArray<NSVRecord>* records;

@end
