//
//  NSVIssue.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCLModel.h"

@interface NSVIssue : OCLModel

@property (nonatomic, assign) NSInteger classId;
@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, assign) NSInteger issueId;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger score;

@end
