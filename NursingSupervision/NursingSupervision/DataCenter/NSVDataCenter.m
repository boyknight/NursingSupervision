//
//  NSVDataCenter.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVDataCenter.h"
#import "OLCMigrator.h"
#import "NSVClass.h"
#import "NSVProject.h"
#import "NSVPosition.h"
#import "NSVIssue.h"
#import "NSVNurse.h"
#import "NSVRecord.h"

#define NSVKeyForInitDB @"isInitDB"

@interface NSVDataCenter ()

@property (nonatomic, strong) OLCMigrator* db;

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
        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString* dbPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"ns.sqlite"];
        
        NSFileManager* defaultManager = [NSFileManager defaultManager];
        if ([defaultManager fileExistsAtPath:dbPath]) {
            [defaultManager removeItemAtPath:dbPath error:nil];
        }
        
        NSLog(@"数据库目录: %@", dbPath);
        
        // 初始化数据库
        self.db = [OLCMigrator sharedInstance:@"ns.sqlite" version:[NSNumber numberWithInt:1] enableDebug:NO];
        [self.db initDb];
        
        [self.db makeTable:[NSVClass class]];
        [self.db makeTable:[NSVProject class]];
        [self.db makeTable:[NSVIssue class]];
        [self.db makeTable:[NSVNurse class]];
        [self.db makeTable:[NSVRecord class]];
        
        BOOL isInitDB = [[NSUserDefaults standardUserDefaults] boolForKey:NSVKeyForInitDB];
        isInitDB = NO;
        if (!isInitDB) {
            // 加入初始化数据
            NSDictionary* classArray = @[
                                    @{
                                        @"name":@"病区管理",
                                        @"project":@[
                                            @{
                                                @"name":@"病区环境",
                                                @"score":@30,
                                                @"position":@[
                                                        @{
                                                            @"requirement":@"护士仪表端庄，挂牌上岗",
                                                            @"position":@"护士",
                                                            @"issue":@[
                                                                @{
                                                                    @"name":@"染发",
                                                                    @"score":@0.5
                                                                },
                                                                @{
                                                                    @"name":@"头发散乱",
                                                                    @"score":@0.5
                                                                },
                                                                @{
                                                                    @"name":@"衣帽脏",
                                                                    @"score":@0.5
                                                                },
                                                                @{
                                                                    @"name":@"指甲长",
                                                                    @"score":@0.5
                                                                },
                                                                @{
                                                                    @"name":@"涂指甲油",
                                                                    @"score":@0.5
                                                                },
                                                                @{
                                                                    @"name":@"穿亮色袜子",
                                                                    @"score":@0.5
                                                                }
                                                            ] // issue
                                                        },// position
                                                        @{
                                                            @"requirement":@"病室整洁、安静、舒适、完全",
                                                            @"position":@"病房",
                                                            @"issue":@[
                                                                    @{
                                                                        @"name":@"病室环境杂乱，不整洁",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病室地面有水渍",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"床位陪客人数平均超过 2位/病床 以上",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病区不节约用电",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病房吵杂",
                                                                        @"score":@0.5
                                                                        }
                                                            ] // issue
                                                        },// position
                                                        @{
                                                            @"requirement":@"各工作室物品放置有序（办公室、治疗室、换药室、检查室）",
                                                            @"position":@"病房",
                                                            @"issue":@[
                                                                    @{
                                                                        @"name":@"病室环境杂乱，不整洁",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病室地面有水渍",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"床位陪客人数平均超过 2位/病床 以上",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病区不节约用电",
                                                                        @"score":@0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病房吵杂",
                                                                        @"score":@0.5
                                                                        }
                                                            ] // issue
                                                        },// position
                                                        
                                                ]
                                                
                                            },// project
                                            @{
                                                @"name":@"药物管理",
                                                @"score":30,
                                                @"position":@[
                                                        @{
                                                            @"requirement":@"护士仪表端庄，挂牌上岗",
                                                            @"position":@"护士",
                                                            @"issue":@[
                                                                    @{
                                                                        @"name":@"染发",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"头发散乱",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"衣帽脏",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"指甲长",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"涂指甲油",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"穿亮色袜子",
                                                                        @"score":0.5
                                                                        }
                                                                    ] // issue
                                                            },// position
                                                        @{
                                                            @"requirement":@"病室整洁、安静、舒适、完全",
                                                            @"position":@"病房",
                                                            @"issue":@[
                                                                    @{
                                                                        @"name":@"病室环境杂乱，不整洁",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病室地面有水渍",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"床位陪客人数平均超过 2位/病床 以上",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病区不节约用电",
                                                                        @"score":0.5
                                                                        },
                                                                    @{
                                                                        @"name":@"病房吵杂",
                                                                        @"score":0.5
                                                                        }
                                                                    ] // issue
                                                            },// position
                                                        ]
                                                
                                                },// project
                                        ]
                                    },// class
                                    
                                    @{
                                        @"name":@"分级护理",
                                        @"project":@[]
                                    },// class
                                    @{
                                        @"name":@"护理急救",
                                        @"project":@[]
                                    },// class
                                    @{
                                        @"name":@"护理文书",
                                        @"project":@[]
                                    },// class
                                    @{
                                        @"name":@"消毒隔离",
                                        @"project":@[]
                                    },// class
                                    @{
                                        @"name":@"护理安全与护理查对",
                                        @"project":@[]
                                    },// class
                                    @{
                                        @"name":@"健康教育",
                                        @"project":@[]
                                    },// class
                                    
                            ];
            
            NSInteger classId = 1;
            NSInteger projectId = 1;
            NSInteger positionId = 1;
            NSInteger issueId = 1;
            
            
            for (NSDictionary* classDict in classArray) {
                
                NSVClass* c = [[NSVClass alloc] init];
                
                c.classId = classId;
                c.name = classDict["name"];
                [c save];
                
                
                NSArray* projectArray = classDict["project"];
                for (NSDictionary* projectDict in projectArray) {
                    
                    NSVProject* project = [[NSVProject alloc] init];
                    
                    project.classId = c.classId;
                    project.projectId = projectId;
                    project.name = projectDict["name"];
                    project.score = projectDict["score"];
                    [project save];
                    
                    NSArray* positionArray = projectDict["position"];
                    
                    for (NSDictionary* positionDict in positionArray) {
                        
                        NSVPosition* position = [[NSVPosition alloc] init];
                        
                        position.classId = c.classId;
                        position.projectId = project.projectId;
                        position.positionId = positionId;
                        
                        position.requirement = positionDict[@"requirement"];
                        position.position = positionDict[@"position"];
                        
                        [position save];
                        
                        NSArray* issueArray = positionDict[@"issue"];
                        for (NSDictionary* issueDict in issueArray) {
                            
                            NSVIssue* issue = [[NSVIssue alloc] init];
                            
                            issue.classId = c.classId;
                            issue.projectId = project.projectId;
                            issue.positionId = position.positionId;
                            issue.issueId = issueId;
                            
                            issue.name = issueDict[@"name"];
                            issue.score = issueDict[@"score"];
                            
                            [issue save];
                            
                            issueId++;
                        }
                        
                        positionId++;
                    }
                    
                    projectId++;
                }
                
                
                classId++;
            }
            
            
            
            NSMutableArray* classArray = [NSMutableArray array];
            
            // 子分类
            // 病区管理
            NSArray* n1 = @[@"病区环境",
                            @"药物管理",
                            @"护理安全"];
            
            NSArray* n2 = @[];
            
            
            for (NSString* n in n1) {
                NSVProject* s = [[NSVProject alloc] init];
                
                s.cid = c1.cid;
            }
            
            NSInteger sid = 1;
            NSVProject* s11 = [[NSVProject alloc] init];
            s11.cid = c1.cid;
            s11.sid = sid;
            s11.name = @"病区环境";
            [s11 save];
            sid++;
            
            NSVProject* s12 = [[NSVProject alloc] init];
            s12.cid = c1.cid;
            s12.sid = sid;
            s12.name = @"药物管理";
            [s12 save];
            sid++;
            
            NSVProject* s13 = [[NSVProject alloc] init];
            s13.cid = c1.cid;
            s13.sid = sid;
            s13.name = @"护理安全";
            [s13 save];
            sid++;
            
            // 分级护理
            NSVProject* s21 = [[NSVProject alloc] init];
            s21.cid = c2.cid;
            s21.sid = sid;
            s21.name = @"床单位";
            [s21 save];
            sid++;
            
            NSVProject* s22 = [[NSVProject alloc] init];
            s22.cid = c2.cid;
            s22.sid = sid;
            s22.name = @"基础护理";
            [s22 save];
            sid++;
            
            NSVProject* s23 = [[NSVProject alloc] init];
            s23.cid = c2.cid;
            s23.sid = sid;
            s23.name = @"导管护理";
            [s23 save];
            sid++;
            
            NSVProject* s24 = [[NSVProject alloc] init];
            s24.cid = c2.cid;
            s24.sid = sid;
            s24.name = @"压疮预防";
            [s24 save];
            sid++;
            
            NSVProject* s25 = [[NSVProject alloc] init];
            s25.cid = c2.cid;
            s25.sid = sid;
            s25.name = @"安全护理";
            [s25 save];
            sid++;
            
            NSVProject* s26 = [[NSVProject alloc] init];
            s26.cid = c2.cid;
            s26.sid = sid;
            s26.name = @"掌握病情";
            [s26 save];
            sid++;
            
            // 护理急救
            NSVProject* s31 = [[NSVProject alloc] init];
            s31.cid = c3.cid;
            s31.sid = sid;
            s31.name = @"氧气设备";
            [s31 save];
            sid++;
            
            NSVProject* s32 = [[NSVProject alloc] init];
            s32.cid = c3.cid;
            s32.sid = sid;
            s32.name = @"吸引器";
            [s32 save];
            sid++;
            
            NSVProject* s33 = [[NSVProject alloc] init];
            s33.cid = c3.cid;
            s33.sid = sid;
            s33.name = @"抢救车";
            [s33 save];
            sid++;
            
            NSVProject* s34 = [[NSVProject alloc] init];
            s34.cid = c3.cid;
            s34.sid = sid;
            s34.name = @"抢救仪器";
            [s34 save];
            sid++;
            
            // 护理文书
            NSVProject* s41 = [[NSVProject alloc] init];
            s41.cid = c4.cid;
            s41.sid = sid;
            s41.name = @"体温单";
            [s41 save];
            sid++;
            
            NSVProject* s42 = [[NSVProject alloc] init];
            s42.cid = c4.cid;
            s42.sid = sid;
            s42.name = @"医嘱单";
            [s42 save];
            sid++;
            
            NSVProject* s43 = [[NSVProject alloc] init];
            s43.cid = c4.cid;
            s43.sid = sid;
            s43.name = @"一般护理记录单";
            [s43 save];
            sid++;
            
            NSVProject* s44 = [[NSVProject alloc] init];
            s44.cid = c4.cid;
            s44.sid = sid;
            s44.name = @"危重护理记录单";
            [s44 save];
            sid++;
            
            NSVProject* s45 = [[NSVProject alloc] init];
            s45.cid = c4.cid;
            s45.sid = sid;
            s45.name = @"手术护理记录单";
            [s45 save];
            sid++;
            
            NSVProject* s46 = [[NSVProject alloc] init];
            s46.cid = c4.cid;
            s46.sid = sid;
            s46.name = @"术前访视和评估记录单";
            [s46 save];
            sid++;
            
            NSVProject* s47 = [[NSVProject alloc] init];
            s47.cid = c4.cid;
            s47.sid = sid;
            s47.name = @"各类护理评估表";
            [s47 save];
            sid++;
            
            NSVProject* s48 = [[NSVProject alloc] init];
            s48.cid = c4.cid;
            s48.sid = sid;
            s48.name = @"各类交接登记表";
            [s48 save];
            sid++;
            
            NSVProject* s49 = [[NSVProject alloc] init];
            s49.cid = c4.cid;
            s49.sid = sid;
            s49.name = @"护理计划单";
            [s49 save];
            sid++;
            
            NSVProject* s410 = [[NSVProject alloc] init];
            s410.cid = c4.cid;
            s410.sid = sid;
            s410.name = @"护理措施实施知情同意书";
            [s410 save];
            sid++;
            
            NSVProject* s411 = [[NSVProject alloc] init];
            s411.cid = c4.cid;
            s411.sid = sid;
            s411.name = @"健康教育表";
            [s411 save];
            sid++;
            
            NSVProject* s412 = [[NSVProject alloc] init];
            s412.cid = c4.cid;
            s412.sid = sid;
            s412.name = @"病室日志";
            [s412 save];
            sid++;
            
            // 消毒隔离
            NSVProject* s51 = [[NSVProject alloc] init];
            s51.cid = c5.cid;
            s51.sid = sid;
            s51.name = @"无菌操作";
            [s51 save];
            sid++;
            
            NSVProject* s52 = [[NSVProject alloc] init];
            s52.cid = c5.cid;
            s52.sid = sid;
            s52.name = @"无菌物品保管";
            [s52 save];
            sid++;
            
            NSVProject* s53 = [[NSVProject alloc] init];
            s53.cid = c5.cid;
            s53.sid = sid;
            s53.name = @"消毒隔离";
            [s53 save];
            sid++;
            
            NSVProject* s54 = [[NSVProject alloc] init];
            s54.cid = c5.cid;
            s54.sid = sid;
            s54.name = @"污物处理";
            [s54 save];
            sid++;
            
            // 护理安全与护理查对
            NSVProject* s61 = [[NSVProject alloc] init];
            s61.cid = c6.cid;
            s61.sid = sid;
            s61.name = @"监控管理";
            [s61 save];
            sid++;
            
            NSVProject* s62 = [[NSVProject alloc] init];
            s62.cid = c6.cid;
            s62.sid = sid;
            s62.name = @"风险管理";
            [s62 save];
            sid++;
            
            NSVProject* s63 = [[NSVProject alloc] init];
            s63.cid = c6.cid;
            s63.sid = sid;
            s63.name = @"特殊药品管理";
            [s63 save];
            sid++;
            
            NSVProject* s64 = [[NSVProject alloc] init];
            s64.cid = c6.cid;
            s64.sid = sid;
            s64.name = @"环境管理";
            [s64 save];
            sid++;
            
            NSVProject* s65 = [[NSVProject alloc] init];
            s65.cid = c6.cid;
            s65.sid = sid;
            s65.name = @"培训考核";
            [s65 save];
            sid++;
            
            NSVProject* s66 = [[NSVProject alloc] init];
            s66.cid = c6.cid;
            s66.sid = sid;
            s66.name = @"职业防护";
            [s66 save];
            sid++;
            
            NSVProject* s67 = [[NSVProject alloc] init];
            s67.cid = c6.cid;
            s67.sid = sid;
            s67.name = @"身份识别";
            [s67 save];
            sid++;
            
            NSVProject* s68 = [[NSVProject alloc] init];
            s68.cid = c6.cid;
            s68.sid = sid;
            s68.name = @"治疗查对";
            [s68 save];
            sid++;
            
            NSVProject* s69 = [[NSVProject alloc] init];
            s69.cid = c6.cid;
            s69.sid = sid;
            s69.name = @"给药";
            [s69 save];
            sid++;
            
            NSVProject* s610 = [[NSVProject alloc] init];
            s610.cid = c6.cid;
            s610.sid = sid;
            s610.name = @"输血查对";
            [s610 save];
            sid++;
            
            NSVProject* s611 = [[NSVProject alloc] init];
            s611.cid = c6.cid;
            s611.sid = sid;
            s611.name = @"标本采集查对";
            [s611 save];
            sid++;
            
            NSVProject* s612 = [[NSVProject alloc] init];
            s612.cid = c6.cid;
            s612.sid = sid;
            s612.name = @"青霉素查对";
            [s612 save];
            sid++;
            
            NSVProject* s613 = [[NSVProject alloc] init];
            s613.cid = c6.cid;
            s613.sid = sid;
            s613.name = @"医嘱执行查对";
            [s613 save];
            sid++;
            
            NSVProject* s614 = [[NSVProject alloc] init];
            s614.cid = c6.cid;
            s614.sid = sid;
            s614.name = @"无菌操作";
            [s614 save];
            sid++;
            
            NSVProject* s615 = [[NSVProject alloc] init];
            s615.cid = c6.cid;
            s615.sid = sid;
            s615.name = @"无菌操作";
            [s615 save];
            sid++;
            
            NSVProject* s616 = [[NSVProject alloc] init];
            s616.cid = c6.cid;
            s616.sid = sid;
            s616.name = @"无菌操作";
            [s616 save];
            sid++;
            
            NSVProject* s617 = [[NSVProject alloc] init];
            s617.cid = c6.cid;
            s617.sid = sid;
            s617.name = @"无菌操作";
            [s617 save];
            sid++;
            
            NSVProject* s618 = [[NSVProject alloc] init];
            s618.cid = c6.cid;
            s618.sid = sid;
            s618.name = @"无菌操作";
            [s618 save];
            sid++;

            
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:NSVKeyForInitDB];
        }
        
        // for debug
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:NSVKeyForInitDB];
        
    }
    return self;
}


@end
