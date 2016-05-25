//
//  NSVProjectItemTableViewCell.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/5/25.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVProjectItemTableViewCell.h"
#import "UIColor+NSVAdditions.h"

@interface NSVProjectItemTableViewCell ()

@property (nonatomic, strong) UIView* selectedBgView;

@end


@implementation NSVProjectItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.selectedBgView == nil) {
        self.selectedBgView = [[UIView alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = self.selectedBgView;
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRGBHex:0x71a960];
        self.selectedBackgroundView.layer.cornerRadius = 5.0f;
    }
    
    if (selected) {
        self.textLabel.textColor = [UIColor whiteColor];
    }else{
        self.textLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
    }
}


- (void) layoutSubviews{
    [super layoutSubviews];
    
    
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x = 25.0f;
    textLabelFrame.size.width = self.frame.size.width - 50.0f;
    self.textLabel.frame = textLabelFrame;
    
    
    if (self.selectedBgView != nil) {
        CGRect selectedBgViewFrame = self.selectedBackgroundView.frame;
        selectedBgViewFrame.origin.x = 15.0f;
        selectedBgViewFrame.size.width = self.frame.size.width - 30.0f;
        
        self.selectedBackgroundView.frame = selectedBgViewFrame;
    }
}
@end
