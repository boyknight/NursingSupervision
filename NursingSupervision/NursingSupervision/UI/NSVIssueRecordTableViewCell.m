//
//  NSVIssueRecordTableViewCell.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/15.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVIssueRecordTableViewCell.h"
#import "UIColor+NSVAdditions.h"

@interface NSVIssueRecordTableViewCell ()

@property (nonatomic, strong) UIView* sep;

@end

@implementation NSVIssueRecordTableViewCell

-(nonnull instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.isSeperatorOnTop = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 0.0f, self.frame.size.width - 25.0f - 5.0f, self.frame.size.height)];
        self.issueLabel.font = [UIFont systemFontOfSize:18.0f];
        self.issueLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
        [self addSubview:self.issueLabel];
        
        self.sep = [[UIView alloc] initWithFrame:CGRectMake(25.0f, self.frame.size.height - 1.0f, self.frame.size.width - 50.0f, 1.0f)];
        self.sep.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
        
        [self addSubview:self.sep];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (selected) {
        self.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    self.issueLabel.frame = CGRectMake(25.0f, 0.0f, self.frame.size.width - 25.0f - 5.0f, self.frame.size.height);
    
    if(self.isSeperatorOnTop){
        self.sep.frame = CGRectMake(25.0f, 0.0f, self.frame.size.width - 50.0f, 1.0f);
    }else{
        self.sep.frame = CGRectMake(25.0f, self.frame.size.height - 1.0f, self.frame.size.width - 50.0f, 1.0f);
    }
}

@end
