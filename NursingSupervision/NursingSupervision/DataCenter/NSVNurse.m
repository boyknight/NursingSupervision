//
//  NSVNurse.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVNurse.h"
#import "NSString+SHA.h"
#import "PinYin4Objc.h"

@implementation NSVNurse

-(instancetype) init{
    self = [super init];
    
    if (self != nil) {
        self.uid = [NSString sha256Uid];
    }
    
    return self;
}

-(void) setName:(NSString *)name{
    _name = name;
    
    // 转换姓的拼音
    
    NSString* firstWord = [name substringToIndex:1];
    
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    
    NSString* firstWordPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:firstWord
                                                withHanyuPinyinOutputFormat:outputFormat
                                                               withNSString:@" "];
    self.namePinyin = [firstWordPinyin substringToIndex:1];
}

@end
