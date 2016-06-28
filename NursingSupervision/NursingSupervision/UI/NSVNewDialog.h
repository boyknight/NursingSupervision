//
//  NSVNewDialog.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSVNewDialog;

@protocol NSVNewDialogDelegate <NSObject>

-(void) dialogOkButtonClicked:(NSVNewDialog*)dialog nameField:(NSString*)name scoreField:(NSString*)score panMgmType:(NSInteger)type panMgmLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath;
-(void) dialogCancelButtonClicked:(NSVNewDialog*)dialog;

@end

@interface NSVNewDialog : UIView

@property (nonatomic, assign) BOOL showScore;
@property (nonatomic, assign) NSInteger panMgmType;
@property (nonatomic, assign) NSInteger panMgmLevel;

@property (nonatomic, weak) id<NSVNewDialogDelegate> delegate;
@property (nonatomic, strong) NSIndexPath* indexPath;

+(instancetype) dialogWithFrame:(CGRect)frame
                          Title:(NSString*)title
                      showScore:(BOOL)showScore
                       delegate:(id<NSVNewDialogDelegate>) delegate;


-(void) setTitle:(NSString*)title;

-(void) setNamePlaceHolder:(NSString*)placeHolder;
-(void) setScorePlaceHolder:(NSString*)placeHolder;
-(void) setShowScoreTextField:(BOOL)isShow;


@end
