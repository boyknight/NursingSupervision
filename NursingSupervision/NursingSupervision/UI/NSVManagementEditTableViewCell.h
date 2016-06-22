//
//  NSVManagementEditTableViewCell.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/21.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSVManagementEditTableViewCell;

@protocol NSVManagementEditTableViewCellDelegate <NSObject>

-(void) tableViewCell:(NSVManagementEditTableViewCell*)cell nameTextChanged:(NSString*)text level:(NSNumber*)level indexPathRow:(NSInteger)row;
-(void) tableViewCell:(NSVManagementEditTableViewCell*)cell scoreTextChanged:(NSString*)text level:(NSNumber*)level indexPathRow:(NSInteger)row;

@end


@interface NSVManagementEditTableViewCell : UITableViewCell

@property (nonatomic, strong) NSNumber* score;
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSNumber* level;
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, weak) id<NSVManagementEditTableViewCellDelegate> delegate;

@end
