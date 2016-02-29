//
//  NSVDataCenter.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVDataCenter.h"
#import "NSVClassify.h"
#import "NSVProject.h"
#import "NSVIssue.h"
#import "NSVNurse.h"
#import "NSVRecord.h"
#import "PinYin4Objc.h"

#define NSVKeyForInitDB @"isInitDB"

@interface NSVDataCenter ()

@end

@implementation NSVDataCenter

+(instancetype) defaultCenter{
    static dispatch_once_t onceToken;
    static NSVDataCenter* dataCenter = nil;
    
    dispatch_once(&onceToken, ^{
        dataCenter = [[NSVDataCenter alloc] init];
    });
    return dataCenter;
}

-(instancetype) init{
    self = [super init];
    if (self != nil) {
        
        NSString* bundleResPath = [NSBundle mainBundle].resourcePath;
        NSString *assessmentPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"assessment.json"];
        
        NSFileManager* defaultManager = [NSFileManager defaultManager];
        if (![defaultManager fileExistsAtPath:assessmentPath]) {
            NSString* initJsonPath = [NSString stringWithFormat:@"%@/%@", bundleResPath, @"init.json"];
            if ([defaultManager fileExistsAtPath:initJsonPath]) {
                NSString* jsonFileContent = [NSString stringWithContentsOfFile:initJsonPath encoding:NSUTF8StringEncoding error:nil];
                
                [jsonFileContent writeToFile:assessmentPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                _assessment = [[NSVAssessment alloc] initWithString:jsonFileContent error:nil];
            }
        }
        else{
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:assessmentPath
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
            _assessment = [[NSVAssessment alloc] initWithString:jsonFileContent error:nil];
        }
        
        
        // 处理拼音
//        HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//        [outputFormat setToneType:ToneTypeWithoutTone];
//        [outputFormat setVCharType:VCharTypeWithV];
//        [outputFormat setCaseType:CaseTypeLowercase];
//        
//        for (NSVClassify* classify in self.assessment.classifies) {
//            for (NSVProject* project in classify.projects) {
//                for (NSVIssue* issue in project.issues) {
//                    NSArray* ignoreStringArray = @[@"/", @",", @"，", @"、", @">", @"(", @")", @"（", @"）", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
//                    
//                    NSString* issueName = issue.name;
//                    
//                    for (NSString* ignore in ignoreStringArray) {
//                        issueName = [issueName stringByReplacingOccurrencesOfString:ignore withString:@""];
//                    }
//                    
//                    NSString* issueNamePinyin=[PinyinHelper toHanyuPinyinStringWithNSString:issueName
//                                                                withHanyuPinyinOutputFormat:outputFormat
//                                                                               withNSString:@" "];
//                    
//                    NSArray* issueNameQuanPinArray = [issueNamePinyin componentsSeparatedByString:@" "];
//                    
//                    NSString* issueNameQuanPin = [issueNamePinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    
//                    NSMutableString* issueNamePinYinShou = [NSMutableString string];
//                    for (NSString* s in issueNameQuanPinArray) {
//                        if (s.length  == 0) {
//                            continue;
//                        }
//                        [issueNamePinYinShou appendString:[s substringToIndex:1]];
//                    }
//                    
//                    issue.nameQuanPin = issueNameQuanPin;
//                    issue.namePinYinShouZiMu = issueNamePinYinShou;
//                }
//            }
//        }
//        
//        [[self.assessment toJSONString] writeToFile:assessmentPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"assessment path: %@", assessmentPath);

    }
    return self;
}


@end
