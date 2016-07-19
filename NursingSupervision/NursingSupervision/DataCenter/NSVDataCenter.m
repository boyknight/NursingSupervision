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
                
                NSData* jsonData = [NSData dataWithContentsOfFile:initJsonPath];
                NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                _assessment = [[NSVAssessment alloc] init];
                
                _assessment.classifies = [NSMutableArray<NSVClassify> array];
                
                for (NSDictionary* classify in jsonObject[@"classifies"]) {
                    NSLog(@"classify: %@", classify);
                    
                    NSVClassify* c = [[NSVClassify alloc] init];
                    c.name = classify[@"name"];
                    c.projects = [NSMutableArray<NSVProject> array];
                    [_assessment.classifies addObject:c];
                    
                    for (NSDictionary* project in classify[@"projects"]) {
                        
                        NSVProject* p = [[NSVProject alloc] init];
                        p.name = project[@"name"];
                        p.issues = [NSMutableArray<NSVIssue> array];
                        
                        [c.projects addObject:p];
                        
                        for (NSDictionary* issue in project[@"issues"]) {
                            NSVIssue* i = [[NSVIssue alloc] init];
                            i.name = issue[@"name"];
                            i.namePinYinShouZiMu = issue[@"namePinYinShouZiMu"];
                            i.nameQuanPin = issue[@"nameQuanPin"];
                            i.score = [issue[@"score"] floatValue];
                            
                            [p.issues addObject:i];
                        }
                    }
                    
                }
                
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
//
//            NSVOffice* o = [[NSVOffice alloc] init];
//            o.name = @"肝胆外科";
//            o.nurses = [NSMutableArray<NSVNurse> array];
//            
//            [as.offices addObject:o];
//            
//            NSVNurse* n = [[NSVNurse alloc] init];
//            n.name = @"黎明";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"张学友";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"刘德华";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"郭富城";
//            [o.nurses addObject:n];
//            
//            
//            o = [[NSVOffice alloc] init];
//            o.name = @"内科";
//            o.nurses = [NSMutableArray<NSVNurse> array];
//            [as.offices addObject:o];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"星矢";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"冰河";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"紫龙";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"瞬";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"一辉";
//            [o.nurses addObject:n];
//            
//            
//            o = [[NSVOffice alloc] init];
//            o.name = @"眼科";
//            o.nurses = [NSMutableArray<NSVNurse> array];
//            [as.offices addObject:o];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"刘备";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"关羽";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"张飞";
//            [o.nurses addObject:n];
//            
//            n = [[NSVNurse alloc] init];
//            n.name = @"赵云";
//            [o.nurses addObject:n];
            
            
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
            NSString* jsonFileContent = [NSString stringWithContentsOfFile:self.recordsPath
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

-(nullable NSVProject*) findProjectWithIssue:(nonnull NSVIssue*)issue{
    NSVProject* project = nil;
    
    for (NSVClassify* c in self.assessment.classifies) {
        for (NSVProject* p in c.projects) {
            for (NSVIssue* i in p.issues) {
                if ([i.uid isEqualToString:issue.uid]) {
                    project = p;
                    break;
                }
            }
            
            if (project != nil) {
                break;
            }
        }
        
        if (project != nil) {
            break;
        }
    }
    
    return project;
}

-(nullable NSVClassify*) findClassifyWithIssue:(nonnull NSVIssue*)issue{
    NSVClassify* classify = nil;
    
    for (NSVClassify* c in self.assessment.classifies) {
        for (NSVProject* p in c.projects) {
            for (NSVIssue* i in p.issues) {
                if ([i.uid isEqualToString:issue.uid]) {
                    classify = c;
                    break;
                }
            }
            
            if (classify != nil) {
                break;
            }
        }
        
        if (classify != nil) {
            break;
        }
    }
    
    return classify;
}

-(nullable NSVOffice*) findOfficeWithNurse:(nonnull NSVNurse*)nurse{
    NSVOffice* office = nil;
    
    for (NSVOffice* o in self.staffs.offices) {
        for (NSVNurse* n in o.nurses) {
            if ([n.uid isEqualToString:nurse.uid]) {
                office = o;
                break;
            }
        }
        
        if(office != nil){
            break;
        }
    }
    
    return office;
}

-(NSVIssue*) findIssueByUid:(NSString*)uid{
    NSVIssue* issue = nil;
    
    for (NSVClassify* c in self.assessment.classifies) {
        for (NSVProject* p in c.projects) {
            for (NSVIssue* i in p.issues) {
                if ([i.uid isEqualToString:uid]) {
                    issue = i;
                    break;
                }
            }
            
            if (issue != nil) {
                break;
            }
        }
        
        if (issue != nil) {
            break;
        }
    }
    
    return issue;
}

-(NSVNurse*) findNurseByUid:(NSString*)uid{
    NSVNurse* nurse = nil;
    
    for (NSVOffice* o in self.staffs.offices) {
        for (NSVNurse* n in o.nurses) {
            if ([n.uid isEqualToString:uid]) {
                nurse = n;
                break;
            }
        }
        
        if(nurse != nil){
            break;
        }
    }
    
    return nurse;
}

@end
