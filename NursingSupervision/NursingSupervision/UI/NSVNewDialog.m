//
//  NSVNewDialog.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVNewDialog.h"
#import "UIColor+NSVAdditions.h"


@interface NSVNewDialog ()

@property (nonatomic, strong) UIView* dialogBgView;
@property (nonatomic, strong) UILabel* dialogTitleLabel;
@property (nonatomic, strong) UITextField* nameTextField;
@property (nonatomic, strong) UITextField* scoreTextField;
@property (nonatomic, strong) UIButton* okButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) UIView* sepLineV;
@property (nonatomic, strong) UIView* sepLineH;

@end

@implementation NSVNewDialog

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil){
        self.showScore = NO;
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f];
        
        self.dialogBgView = [[UIView alloc] initWithFrame:CGRectZero];
        self.dialogBgView.layer.cornerRadius = 16.0f;
        self.dialogBgView.layer.masksToBounds = YES;
        self.dialogBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dialogBgView];
        
        self.dialogTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.dialogTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.dialogTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.dialogBgView addSubview:self.dialogTitleLabel];
        
        
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.nameTextField.backgroundColor = [UIColor whiteColor];
        self.nameTextField.font = [UIFont systemFontOfSize:14.0f];
        self.nameTextField.layer.borderWidth = 1.0f;
        self.nameTextField.layer.borderColor = [UIColor colorWithRGBHex:0xe2e2e0].CGColor;
        self.nameTextField.layer.borderWidth = 1.0f;
        self.nameTextField.layer.cornerRadius = 8.0f;
        self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15.0f, 0.0f, 0.0f);
        [self.dialogBgView addSubview:self.nameTextField];
        
        self.scoreTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.scoreTextField.font = [UIFont systemFontOfSize:14.0f];
        [self.dialogBgView addSubview:self.scoreTextField];
        
        self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.dialogBgView addSubview:self.okButton];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.dialogBgView addSubview:self.cancelButton];
        
        
        self.sepLineV = [[UIView alloc] initWithFrame:CGRectZero];
        self.sepLineV.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
        [self.dialogBgView addSubview:self.sepLineV];
        
        self.sepLineH = [[UIView alloc] initWithFrame:CGRectZero];
        self.sepLineH.backgroundColor = [UIColor colorWithRGBHex:0xe2e2e0];
        [self.dialogBgView addSubview:self.sepLineH];
        
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat bgWidth = 300.0f;
    CGFloat bgHeight = 225.0f;
    
    self.dialogBgView.frame = CGRectMake( (NSInteger)((selfWidth - bgWidth) / 2.0f),
                                         (NSInteger)((selfHeight - bgHeight) / 2.0f),
                                         bgWidth,
                                         bgHeight);
    
    self.dialogTitleLabel.frame = CGRectMake(0.0f, 20.0f, bgWidth, 16.0f);
    
    self.nameTextField.frame = CGRectMake(25.0f, self.dialogTitleLabel.frame.origin.y + self.dialogTitleLabel.frame.size.height + 25.0f, bgWidth - 2.0f * 25.0f, 28.0f);
    
    if (self.showScore) {
        self.scoreTextField.frame = CGRectMake(25.0f, self.nameTextField.frame.origin.y + self.nameTextField.frame.size.height + 10.0f, bgWidth - 2.0f * 25.0f, 28.0f);
    }else{
        self.scoreTextField.frame = CGRectZero;
    }
    
    self.okButton.frame = CGRectMake((NSInteger)( bgWidth / 2.0f ), bgHeight - 50.0f, (NSInteger)( bgWidth / 2.0f ), 50.0f);
    
    self.cancelButton.frame = CGRectMake(0.0f, bgHeight - 50.0f, (NSInteger)( bgWidth / 2.0f ), 50.0f);
}

-(void) setTitle:(NSString*)title{
    self.dialogTitleLabel.text = title;
}

-(void) setNamePlaceHolder:(NSString*)placeHolder{
    self.nameTextField.placeholder = placeHolder;
}

@end
