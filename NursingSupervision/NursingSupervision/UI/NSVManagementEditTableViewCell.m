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
@property (nonatomic, strong, nonnull) UIButton* deleteButton;
@property (nonatomic, strong, nonnull) UIButton* reorderButton;
@property (nonatomic, strong, nonnull) UIImageView* rightIconImageView;

@end

@implementation NSVManagementEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self != nil) {
        self.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.editingAccessoryType = UITableViewCellAccessoryNone;
        
        
        // 内容编辑框
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.layer.borderWidth = 1.0f;
        self.nameTextField.layer.cornerRadius = 8.0f;
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        self.nameTextField.textColor = [UIColor colorWithRGBHex:0x36363d];
        [self addSubview:self.nameTextField];
        
        // 分数编辑框
        self.scoreTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.scoreTextField.backgroundColor = [UIColor whiteColor];
        self.scoreTextField.layer.borderWidth = 1.0f;
        self.scoreTextField.layer.cornerRadius = 8.0f;
        self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.scoreTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        self.scoreTextField.textColor = [UIColor colorWithRGBHex:0x36363d];
        [self addSubview:self.scoreTextField];
        
        // 排序按钮
        self.reorderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reorderButton setImage:[UIImage imageNamed:@"reorder_icon"] forState:UIControlStateNormal];
        [self addSubview:self.reorderButton];
        
        // 删除按钮
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        [self addSubview:self.deleteButton];
        
        // 下一级 指示图标
        self.rightIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator_icon"]];
        [self addSubview:self.rightIconImageView];
        
        // 分隔线
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

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    self.showsReorderControl = NO;
    self.editingAccessoryView = editing ? [[UIImageView alloc] initWithImage:nil] : nil;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    if (self.isEditing) {
        self.reorderButton.alpha = 1.0f;
        self.reorderButton.frame = CGRectMake(25.0f, 19.0f, 21.0f, 21.0f);
        
        
        CGRect nameTextFieldFrame;
        nameTextFieldFrame.origin.x = self.reorderButton.frame.origin.x + self.reorderButton.frame.size.width + 15.0f;
        nameTextFieldFrame.origin.y = 10.0f;
        
        if (self.score == nil) {
            nameTextFieldFrame.size.width = self.frame.size.width - nameTextFieldFrame.origin.x - (15.0f + 21.0f + 25.0f);
        }else{
            nameTextFieldFrame.size.width = self.frame.size.width - nameTextFieldFrame.origin.x - (15.0f + 107.0f + 15.0f + 21.0f + 25.0f);
        }
        
        nameTextFieldFrame.size.height = 40.0f;
        
        self.nameTextField.frame = nameTextFieldFrame;
        self.nameTextField.text = self.name;
        self.nameTextField.userInteractionEnabled = YES;
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        
        if (self.score == nil) {
            self.scoreTextField.alpha = 0.0f;
        }else{
            self.scoreTextField.alpha = 1.0f;
            self.scoreTextField.text = [NSString stringWithFormat:@"%@", self.score];
            
            self.scoreTextField.userInteractionEnabled = YES;
            self.scoreTextField.backgroundColor = [UIColor whiteColor];
            self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        }
        
        self.scoreTextField.frame = CGRectMake(self.frame.size.width - (107.0f + 15.0f + 21.0f + 25.0f), 10.0f, 107.0f, 40.0f);
        
        self.deleteButton.alpha = 1.0f;
        self.deleteButton.frame = CGRectMake(self.frame.size.width - (25.0f + 21.0f), 19.0f, 21.0f, 21.0f);
        
        self.rightIconImageView.alpha = 0.0f;
        self.rightIconImageView.frame = CGRectMake(self.frame.size.width - 33.0f, 23.0f, 8.0f, 13.0f);
        
    }else{
        self.reorderButton.alpha = 0.0f;
        self.reorderButton.frame = CGRectMake(25.0f, 19.0f, 21.0f, 21.0f);
        
        CGRect nameTextFieldFrame;
        nameTextFieldFrame.origin.x = 25.0f;
        nameTextFieldFrame.origin.y = 10.0f;
        
        if (self.score == nil) {
            nameTextFieldFrame.size.width = self.frame.size.width - nameTextFieldFrame.origin.x - 48.0f;
        }else{
            nameTextFieldFrame.size.width = self.frame.size.width - nameTextFieldFrame.origin.x - 48.0f - (107.0f + 15.0f);
        }
        
        nameTextFieldFrame.size.height = 40.0f;
        
        self.nameTextField.frame = nameTextFieldFrame;
        self.nameTextField.text = self.name;
        self.nameTextField.userInteractionEnabled = NO;
        self.nameTextField.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xf1f1f1].CGColor;
        
        
        if (self.score == nil) {
            self.scoreTextField.alpha = 0.0f;
        }else{
            self.scoreTextField.alpha = 1.0f;
            self.scoreTextField.text = [NSString stringWithFormat:@"%@", self.score];
            self.scoreTextField.userInteractionEnabled = NO;
            self.scoreTextField.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
            self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xf1f1f1].CGColor;
        }
        
        self.scoreTextField.frame = CGRectMake(self.frame.size.width - (25.0f + 8.0f + 107.0f + 15.0f), 10.0f, 107.0f, 40.0f);
        
        self.deleteButton.alpha = 0.0f;
        self.deleteButton.frame = CGRectMake(self.frame.size.width - 46.0f, 19.0f, 21.0f, 21.0f);
        
        self.rightIconImageView.alpha = 1.0f;
        self.rightIconImageView.frame = CGRectMake(self.frame.size.width - (25.0f + 8.0f), 23.0f, 8.0f, 13.0f);
    }
    
    self.sepView.frame = CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f);
}

@end
