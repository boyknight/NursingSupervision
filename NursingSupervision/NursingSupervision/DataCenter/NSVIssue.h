//
//  NSVIssue.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"

@protocol NSVIssue

@end

@interface NSVIssue : JSONModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) float score;
@property (nonatomic, strong) NSString<Optional>* nameQuanPin; // 全拼
@property (nonatomic, strong) NSString<Optional>* namePinYinShouZiMu; // 拼音首字母

@end
