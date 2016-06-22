//
//  NSVAssessment.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/28.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "JSONModelLib.h"

#import "NSVClassify.h"

@interface NSVAssessment : JSONModel

@property (nonatomic, strong) NSMutableArray<NSVClassify>* classifies;

@end
