//
//  NSVNewDialog.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSVNewDialog : UIView

@property (nonatomic, assign) BOOL showScore;

-(void) setTitle:(NSString*)title;
-(void) setNamePlaceHolder:(NSString*)placeHolder;


@end
