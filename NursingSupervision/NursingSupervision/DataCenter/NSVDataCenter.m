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
                _assessment.classifies = [NSMutableArray<NSVClassify> array];
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
            
            NSVAllStaff* as = [[NSVAllStaff alloc] init];
            as.offices = [NSMutableArray<NSVOffice> array];
            
            NSVOffice* o = [[NSVOffice alloc] init];
            o.name = @"肝胆外科";
            o.nurses = [NSMutableArray<NSVNurse> array];
            
            [as.offices addObject:o];
            
            NSVNurse* n = [[NSVNurse alloc] init];
            n.name = @"黎明";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"张学友";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"刘德华";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"郭富城";
            [o.nurses addObject:n];
            
            
            o = [[NSVOffice alloc] init];
            o.name = @"内科";
            o.nurses = [NSMutableArray<NSVNurse> array];
            [as.offices addObject:o];
            
            n = [[NSVNurse alloc] init];
            n.name = @"星矢";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"冰河";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"紫龙";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"瞬";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"一辉";
            [o.nurses addObject:n];
            
            
            o = [[NSVOffice alloc] init];
            o.name = @"眼科";
            o.nurses = [NSMutableArray<NSVNurse> array];
            [as.offices addObject:o];
            
            n = [[NSVNurse alloc] init];
            n.name = @"刘备";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"关羽";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"张飞";
            [o.nurses addObject:n];
            
            n = [[NSVNurse alloc] init];
            n.name = @"赵云";
            [o.nurses addObject:n];
            
            
            _staffs = as;
            
            NSString* jsonString = [self.staffs toJSONString];
            [jsonString writeToFile:self.nuresesPath
                         atomically:YES
                           encoding:NSUTF8StringEncoding
                              error:nil];
        }
        else{
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:self.nuresesPath
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
            _staffs = [[NSVAllStaff alloc] initWithString:jsonFileContent error:nil];
        }
        
        // 加载问题记录
        if (![fileManager fileExistsAtPath:self.recordsPath]) {
            _records = [[NSVRecords alloc] init];
            _records.records = [NSMutableArray<NSVRecord> array];
            
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
    }
    return self;
}

-(void) addNewRecord:(nonnull NSVRecord*)record{
    if (self.records.records == nil) {
        self.records.records = [NSMutableArray<NSVRecord> array];
    }
    
    [self.records.records addObject:record];
    
    NSString* jsonString = [self.records toJSONString];
    [jsonString writeToFile:self.recordsPath
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
}

-(void) removeRecord:(nonnull NSVRecord*)record{
    if (self.records.records == nil) {
        return;
    }
    
    for (NSVRecord* r in self.records.records) {
        if ([r compare:record] == NSOrderedSame) {
            [self.records.records removeObject:r];
            break;
        }
    }
    
    NSString* jsonString = [self.records toJSONString];
    [jsonString writeToFile:self.recordsPath
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
}

-(void) save{
    NSString* jsonString = [self.assessment toJSONString];
    [jsonString writeToFile:self.assessmentPath
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
    
    jsonString = [self.staffs toJSONString];
    [jsonString writeToFile:self.nuresesPath
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
    
    jsonString = [self.records toJSONString];
    [jsonString writeToFile:self.recordsPath
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
}

@end
