//
//  NSVDataCenter.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSVAssessment.h"
#import "NSVNurses.h"
#import "NSVRecords.h"

@interface NSVDataCenter : NSObject

@property (nonatomic, strong, readonly, nonnull) NSVAssessment* assessment;
@property (nonatomic, nonnull, strong, readonly) NSVNurses* nurses;
@property (nonatomic, nonnull, strong, readonly) NSVRecords* records;

+(_Nonnull instancetype) defaultCenter;


-(void) addNewRecord:(nonnull NSVRecord*)record;

@end
