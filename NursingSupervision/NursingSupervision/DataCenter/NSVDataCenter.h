//
//  NSVDataCenter.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSVAssessment.h"
#import "NSVRecords.h"
#import "NSVAllStaff.h"

@interface NSVDataCenter : NSObject

@property (nonatomic, strong, readonly, nonnull) NSVAssessment* assessment;
//@property (nonatomic, nonnull, strong, readonly) NSVNurses* nurses;
@property (nonatomic, nonnull, strong, readonly) NSVAllStaff* staffs;
@property (nonatomic, nonnull, strong, readonly) NSVRecords* records;

+(_Nonnull instancetype) defaultCenter;

-(void) save;

-(void) addNewRecord:(nonnull NSVRecord*)record;

-(nullable NSVProject*) findProjectWithIssue:(nonnull NSVIssue*)issue;
-(nullable NSVClassify*) findClassifyWithIssue:(nonnull NSVIssue*)issue;
-(nullable NSVOffice*) findOfficeWithNurse:(nonnull NSVNurse*)nurse;

-(nullable NSVIssue*) findIssueByUid:(NSString*)uid;
-(nullable NSVNurse*) findNurseByUid:(NSString*)uid;

@end
