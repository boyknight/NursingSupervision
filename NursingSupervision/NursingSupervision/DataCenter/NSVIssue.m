//
//  NSVIssue.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVIssue.h"
#import "NSString+SHA.h"
#import "Pinyin4Objc.h"

@implementation NSVIssue

-(instancetype) init{
    self = [super init];
    
    if (self != nil) {
        self.uid = [NSString sha256Uid];
    }
    
    return self;
}

-(void) setName:(NSString *)name{
    _name = [name copy];
    
    HanyuPinyinOutputFormat *outputFormatForQuan = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormatForQuan setToneType:ToneTypeWithoutTone];
    [outputFormatForQuan setVCharType:VCharTypeWithV];
    [outputFormatForQuan setCaseType:CaseTypeLowercase];
    
    self.nameQuanPin = [PinyinHelper toHanyuPinyinStringWithNSString:self.name
                                         withHanyuPinyinOutputFormat:outputFormatForQuan
                                                        withNSString:@""];
    
    
    NSMutableString* namePinyin = [NSMutableString string];
    for (int i = 0; i < self.name.length; i++) {
        
        NSString* word = [self.name substringWithRange:NSMakeRange(i, 1)];
        NSString* py = [PinyinHelper toHanyuPinyinStringWithNSString:word
                                         withHanyuPinyinOutputFormat:outputFormatForQuan
                                                        withNSString:@""];
        
        if (py != nil && py.length > 0) {
            [namePinyin appendString:[py substringToIndex:1]];
        }
    }
    
    self.namePinYinShouZiMu = namePinyin;
}

@end
