//
//  NSVSubClass.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"
#import "NSVIssue.h"

@protocol NSVProject

@end

@interface NSVProject : JSONModel

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSMutableArray<NSVIssue>* issues;

@end
