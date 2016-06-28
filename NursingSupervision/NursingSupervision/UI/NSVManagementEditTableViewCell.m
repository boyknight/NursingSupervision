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
        self.showIndicator = NO;
        
        
        // 内容编辑框
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.layer.borderWidth = 1.0f;
        self.nameTextField.layer.cornerRadius = 8.0f;
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        self.nameTextField.textColor = [UIColor colorWithRGBHex:0x36363d];
        [self.nameTextField addTarget:self action:@selector(nameTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.nameTextField];
        
        // 分数编辑框
        self.scoreTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.scoreTextField.backgroundColor = [UIColor whiteColor];
        self.scoreTextField.layer.borderWidth = 1.0f;
        self.scoreTextField.layer.cornerRadius = 8.0f;
        self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.scoreTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        self.scoreTextField.textColor = [UIColor colorWithRGBHex:0x36363d];
        self.scoreTextField.delegate = self;
        [self.scoreTextField addTarget:self action:@selector(scoreTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.scoreTextField];
        
        // 删除按钮
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self.nameTextField resignFirstResponder];
    [self.scoreTextField resignFirstResponder];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scoreWidth = 107.0f;
    CGFloat marginOfControls = 15.0f;
    CGFloat marginOfSides = 25.0f;
    CGFloat indicatorWidth = 8.0f;
    CGFloat indicatorHeight = 13.0f;
    CGFloat deleteWidth = 21.0f;
    CGFloat reorderWidth = 15.0f;
    CGFloat textFieldHeight = 40.0f;
    
    if (self.isEditing) {
        
        // 删除 按钮
        self.deleteButton.alpha = 1.0f;
        self.deleteButton.frame = CGRectMake(self.frame.size.width - (marginOfSides + reorderWidth + marginOfControls +  deleteWidth), 19.0f, deleteWidth, deleteWidth);
        
        // 分数
        if (self.score == nil) {
            self.scoreTextField.alpha = 0.0f;
        }else{
            self.scoreTextField.alpha = 1.0f;
            self.scoreTextField.text = [NSString stringWithFormat:@"%@", self.score];
            
            self.scoreTextField.userInteractionEnabled = YES;
            self.scoreTextField.backgroundColor = [UIColor whiteColor];
            self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        }
        
        self.scoreTextField.frame = CGRectMake(self.deleteButton.frame.origin.x - (marginOfControls + scoreWidth),
                                               (NSInteger)((self.frame.size.height - textFieldHeight) / 2.0f),
                                               scoreWidth,
                                               textFieldHeight);
        
        // 内容
        CGRect nameTextFieldFrame;
        nameTextFieldFrame.origin.x = marginOfSides;
        nameTextFieldFrame.origin.y = self.scoreTextField.frame.origin.y;
        
        if (self.score == nil) {
            nameTextFieldFrame.size.width = self.frame.size.width - marginOfSides - (self.frame.size.width - self.deleteButton.frame.origin.x + marginOfControls);
        }else{
            nameTextFieldFrame.size.width = self.frame.size.width - marginOfSides - (self.frame.size.width - self.scoreTextField.frame.origin.x + marginOfControls);
        }
        
        nameTextFieldFrame.size.height = textFieldHeight;
        
        self.nameTextField.frame = nameTextFieldFrame;
        self.nameTextField.text = self.name;
        self.nameTextField.userInteractionEnabled = YES;
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;

        self.rightIconImageView.alpha = 0.0f;
        self.rightIconImageView.frame = CGRectMake(self.frame.size.width - (marginOfSides + indicatorWidth),
                                                   (NSInteger)((self.frame.size.height - indicatorHeight) / 2.0f),
                                                   indicatorWidth,
                                                   indicatorHeight);
        
    }else{
        // 删除 按钮
        self.deleteButton.alpha = 0.0f;
        self.deleteButton.frame = CGRectMake(self.frame.size.width - (marginOfSides + reorderWidth + marginOfControls +  deleteWidth), 19.0f, deleteWidth, deleteWidth);
        
        // 分数
        if (self.score == nil) {
            self.scoreTextField.alpha = 0.0f;
        }else{
            self.scoreTextField.alpha = 1.0f;
            self.scoreTextField.text = [NSString stringWithFormat:@"%@", self.score];
            
            self.scoreTextField.userInteractionEnabled = NO;
            self.scoreTextField.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
            self.scoreTextField.layer.borderColor = [UIColor colorWithRGBHex:0xf1f1f1].CGColor;
        }
        
        self.scoreTextField.frame = CGRectMake(self.deleteButton.frame.origin.x - (marginOfControls + scoreWidth),
                                               (NSInteger)((self.frame.size.height - textFieldHeight) / 2.0f),
                                               scoreWidth,
                                               textFieldHeight);
        
        // 内容
        CGRect nameTextFieldFrame;
        nameTextFieldFrame.origin.x = marginOfSides;
        nameTextFieldFrame.origin.y = self.scoreTextField.frame.origin.y;
        
        if (self.score == nil) {
            nameTextFieldFrame.size.width = self.frame.size.width - marginOfSides - (self.frame.size.width - self.deleteButton.frame.origin.x + marginOfControls);
        }else{
            nameTextFieldFrame.size.width = self.frame.size.width - marginOfSides - (self.frame.size.width - self.scoreTextField.frame.origin.x + marginOfControls);
        }
        
        nameTextFieldFrame.size.height = textFieldHeight;
        
        self.nameTextField.frame = nameTextFieldFrame;
        self.nameTextField.text = self.name;
        self.nameTextField.userInteractionEnabled = NO;
        self.nameTextField.backgroundColor = [UIColor colorWithRGBHex:0xf1f1f1];
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xf1f1f1].CGColor;
        
        self.rightIconImageView.alpha = 0.0f;
        self.rightIconImageView.frame = CGRectMake(self.frame.size.width - (marginOfSides + indicatorWidth),
                                                   (NSInteger)((self.frame.size.height - indicatorHeight) / 2.0f),
                                                   indicatorWidth,
                                                   indicatorHeight);
        
        
        
        self.rightIconImageView.alpha = 1.0f;
        self.rightIconImageView.frame = CGRectMake(self.frame.size.width - (marginOfSides + indicatorWidth),
                                                   (NSInteger)((self.frame.size.height - indicatorHeight) / 2.0f),
                                                   indicatorWidth,
                                                   indicatorHeight);
        if (!self.showIndicator) {
            self.rightIconImageView.alpha = 0.0f;
        }
    }
    
    self.sepView.frame = CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f);
}

-(void) nameTextFieldChanged:(UITextField*)textField{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableViewCell:nameTextChanged:level:indexPathRow:)]) {
        [self.delegate tableViewCell:self nameTextChanged:textField.text level:self.level indexPathRow:self.row];
    }
}

-(void) scoreTextFieldChanged:(UITextField*)textField{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableViewCell:scoreTextChanged:level:indexPathRow:)]) {
        [self.delegate tableViewCell:self scoreTextChanged:textField.text level:self.level indexPathRow:self.row];
    }
}

-(void) deleteButtonClicked:(UIButton*) button{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableViewCell:deleteButtonClickedWithLevel:indexPathRow:)]) {
        [self.delegate tableViewCell:self deleteButtonClickedWithLevel:self.level indexPathRow:self.row];
    }
}

-(void) setPlaceHolder:(NSString*)placeHolder{
    self.nameTextField.placeholder = placeHolder;
}

@end
