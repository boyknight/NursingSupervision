//
//  NSVHistoryReportTableViewCell.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/7/11.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVHistoryReportTableViewCell.h"
#import "UIColor+NSVAdditions.h"

@interface NSVHistoryReportTableViewCell()

@property (nonatomic, strong) UIView* sepView;

@end

@implementation NSVHistoryReportTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.issueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.issueLabel.numberOfLines = 2;
        self.issueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.issueLabel.font = [UIFont systemFontOfSize:18.0f];
        self.issueLabel.textColor = [UIColor colorWithRGBHex:0x53993f];
        
        [self addSubview:self.issueLabel];
        
        self.projectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.projectLabel.numberOfLines = 2;
        self.projectLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.projectLabel.font = [UIFont systemFontOfSize:18.0f];
        self.projectLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
        self.projectLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.projectLabel];
        
        self.nurseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nurseLabel.numberOfLines = 2;
        self.nurseLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nurseLabel.font = [UIFont systemFontOfSize:18.0f];
        self.nurseLabel.textColor = [UIColor colorWithRGBHex:0x53993f];
        self.nurseLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nurseLabel];
        
        self.officeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.officeLabel.numberOfLines = 2;
        self.officeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.officeLabel.font = [UIFont systemFontOfSize:18.0f];
        self.officeLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
        self.officeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.officeLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.dateLabel.numberOfLines = 2;
        self.dateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.dateLabel.font = [UIFont systemFontOfSize:18.0f];
        self.dateLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dateLabel];
        
        self.sepView = [[UIView alloc] initWithFrame:CGRectZero];
        self.sepView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sepView];
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
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.issueLabel.frame = CGRectMake(15.0f, 0.0f, 180.0f, self.frame.size.height);
    self.projectLabel.frame = CGRectMake(self.issueLabel.frame.origin.x + self.issueLabel.frame.size.width + 20.0f,
                                         self.issueLabel.frame.origin.y,
                                         120.f,
                                         self.issueLabel.frame.size.height);
    self.nurseLabel.frame = CGRectMake(self.projectLabel.frame.origin.x + self.projectLabel.frame.size.width + 20.0f,
                                       self.projectLabel.frame.origin.y,
                                       79.0f,
                                       self.projectLabel.frame.size.height);
    
    self.officeLabel.frame = CGRectMake(self.nurseLabel.frame.origin.x + self.nurseLabel.frame.size.width + 20.0f,
                                        self.nurseLabel.frame.origin.y,
                                        100.0f,
                                        self.nurseLabel.frame.size.height);
    
    self.dateLabel.frame = CGRectMake(self.officeLabel.frame.origin.x + self.officeLabel.frame.size.width + 20.0f,
                                      self.officeLabel.frame.origin.y,
                                      180.0f,
                                      self.officeLabel.frame.size.height);
    
    self.sepView.frame = CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f);
}

@end
