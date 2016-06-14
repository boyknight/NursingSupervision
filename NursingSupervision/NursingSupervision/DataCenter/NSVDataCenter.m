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

@property (nonatomic, strong) NSString* assessmentPath;
@property (nonatomic, strong) NSString* nuresesPath;
@property (nonatomic, strong) NSString* recordsPath;

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
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        NSString* bundleResPath = [NSBundle mainBundle].resourcePath;
        self.assessmentPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"assessment.json"];
        self.nuresesPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"nurses.json"];
        self.recordsPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"records.json"];
        
        // 加载问题
        
        if (![fileManager fileExistsAtPath:self.assessmentPath]) {
            NSString* initJsonPath = [NSString stringWithFormat:@"%@/%@", bundleResPath, @"init.json"];
            if ([fileManager fileExistsAtPath:initJsonPath]) {
                NSString* jsonFileContent = [NSString stringWithContentsOfFile:initJsonPath encoding:NSUTF8StringEncoding error:nil];
                
                [jsonFileContent writeToFile:self.assessmentPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                _assessment = [[NSVAssessment alloc] initWithString:jsonFileContent error:nil];
            }
            else{
                _assessment = [[NSVAssessment alloc] init];
                _assessment.classifies = [NSArray<NSVClassify> array];
            }
            
            NSString* jsonString = [self.assessment toJSONString];
            [jsonString writeToFile:self.assessmentPath
                         atomically:YES
                           encoding:NSUTF8StringEncoding
                              error:nil];
        }
        else{
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:self.assessmentPath
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
            _assessment = [[NSVAssessment alloc] initWithString:jsonFileContent error:nil];
        }
        
        // 加载护士
        if (![fileManager fileExistsAtPath:self.nuresesPath]) {
            
            NSVNurse* n1 = [[NSVNurse alloc] init];
            n1.name = @"黎明";
            
            NSVNurse* n2 = [[NSVNurse alloc] init];
            n2.name = @"张学友";
            
            NSVNurse* n3 = [[NSVNurse alloc] init];
            n3.name = @"步惊云";
            
            NSVNurse* n4 = [[NSVNurse alloc] init];
            n4.name = @"聂风";
            
            NSVNurse* n5 = [[NSVNurse alloc] init];
            n5.name = @"李丽";
            
            NSVNurse* n6 = [[NSVNurse alloc] init];
            n6.name = @"陈胜";
            
            
            
            _nurses = [[NSVNurses alloc] init];
            _nurses.nurses = [NSArray<NSVNurse> array];
            
            _nurses.nurses = @[n1, n2, n3, n4, n5, n6];
            
            
            NSString* jsonString = [self.nurses toJSONString];
            [jsonString writeToFile:self.nuresesPath
                         atomically:YES
                           encoding:NSUTF8StringEncoding
                              error:nil];
        }
        else{
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:self.nuresesPath
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
            _nurses = [[NSVNurses alloc] initWithString:jsonFileContent error:nil];
        }
        
        // 加载问题记录
        if (![fileManager fileExistsAtPath:self.recordsPath]) {
            _records = [[NSVRecords alloc] init];
            _records.records = [NSArray<NSVRecord> array];
            
            NSString* jsonString = [self.records toJSONString];
            [jsonString writeToFile:self.recordsPath
                         atomically:YES
                           encoding:NSUTF8StringEncoding
                              error:nil];
        }
        else{
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:self.nuresesPath
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
            _records = [[NSVRecords alloc] initWithString:jsonFileContent error:nil];
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
        
        NSLog(@"assessment path: %@", self.assessmentPath);

    }
    return self;
}


@end
