//
//  NSVManagementEditTableViewCell.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/21.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVManagementEditTableViewCell.h"
#import "UIColor+NSVAdditions.h"

@interface NSVManagementEditTableViewCell ()

@property (nonatomic, strong, nonnull) UITextField* nameTextField;
@property (nonatomic, strong, nonnull) UITextField* scoreTextField;
@property (nonatomic, strong, nonnull) UIView*  sepView;

@end

@implementation NSVManagementEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self != nil) {
        self.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.layer.borderWidth = 1.0f;
        self.nameTextField.layer.cornerRadius = 8.0f;
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        [self addSubview:self.nameTextField];
        
        
        self.scoreTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.scoreTextField.backgroundColor = [UIColor whiteColor];
        self.scoreTextField.layer.borderWidth = 1.0f;
        self.scoreTextField.layer.cornerRadius = 8.0f;
        self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.scoreTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        [self addSubview:self.scoreTextField];
        
        self.sepView = [[UIView alloc] initWithFrame:CGRectZero];
        self.sepView.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
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

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat nameWidth = (NSInteger)(self.frame.size.width * 0.65f);
    CGFloat scoreWidth = (NSInteger)(self.frame.size.width * 0.1f);
    
    self.nameTextField.frame = CGRectMake(55.0f, 10.0f, nameWidth, 40.0f);
    self.scoreTextField.frame = CGRectMake(self.nameTextField.frame.origin.x + self.nameTextField.frame.size.width + 15.0f, 10.0f, scoreWidth, 40.0f);
    self.sepView.frame = CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f);
    
    CGRect accessoryViewFrame = self.accessoryView.frame;
    accessoryViewFrame.origin.x = self.frame.size.width - 25.0f - accessoryViewFrame.size.width;
    
    self.accessoryView.frame = accessoryViewFrame;
    
}

@end
