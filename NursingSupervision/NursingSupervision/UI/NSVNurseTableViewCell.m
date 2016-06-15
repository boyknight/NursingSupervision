//
//  NSVNurseTableViewCell.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/14.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVNurseTableViewCell.h"
#import "UIColor+NSVAdditions.h"

@interface NSVNurseTableViewCell ()

@property (nonatomic, strong) UIImageView* iconView;

@end

@implementation NSVNurseTableViewCell

-(nonnull instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self != nil) {
        
        self.backgroundColor = [UIColor colorWithRGBHex:0xfafafa];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nurse_unselected"]];
        self.iconView.frame = CGRectMake(20.0f, 14.0f, 16.0f, 16.0f);
        
        [self addSubview:self.iconView];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 15.0f,
                                                                   self.iconView.frame.origin.y,
                                                                   self.frame.size.width - (self.iconView.frame.origin.x + self.iconView.frame.size.width + 15.0f),
                                                                   self.iconView.frame.size.height)];
        self.nameLabel.textColor = [UIColor colorWithRGBHex:0x36363d];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0f];;
        
        [self addSubview:self.nameLabel];
        
        
        
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if(selected){
        self.iconView.image = [UIImage imageNamed:@"nurse_selected"];
    }else{
        self.iconView.image = [UIImage imageNamed:@"nurse_unselected"];
    }
}

@end
