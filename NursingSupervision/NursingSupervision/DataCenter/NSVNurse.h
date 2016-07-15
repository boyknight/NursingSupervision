//
//  NSVNurse.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"

@protocol NSVNurse <NSObject>


@end

@interface NSVNurse : JSONModel

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* namePinyin;

@end
