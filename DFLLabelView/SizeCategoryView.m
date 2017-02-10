//
//  SizeCategoryView.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "SizeCategoryView.h"

CGFloat  margin = 13.0f;
CGFloat  ItemHeight = 28.0f;

@interface SizeCategoryView ()
@property (nonatomic , strong) UIView *sizeView;
@property (nonatomic , strong) UIButton *selectButton;
@end

@implementation SizeCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.sizeTypeLabel = [UILabel new];
        self.sizeTypeLabel.textAlignment = NSTextAlignmentCenter;
        self.sizeTypeLabel.font = [UIFont systemFontOfSize:12];
        self.sizeTypeLabel.text = @"颜色:";
//        self.sizeTypeLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.sizeTypeLabel];
        [self.sizeTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(margin);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake([self itemWidth], ItemHeight));
        }];
        
        self.sizeView = [UIView new];
        [self addSubview:self.sizeView];
//        self.sizeView.backgroundColor = [UIColor redColor];
        [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sizeTypeLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
        }];
    }
    return self;
}
- (void)setSizeArray:(NSArray *)sizeArray {
    
    _sizeArray = sizeArray;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo([SizeCategoryView getCategoryViewHeight:sizeArray]);
    }];
    [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([SizeCategoryView getCategoryViewHeight:sizeArray]);
    }];
    [self.sizeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [sizeArray enumerateObjectsUsingBlock:^(NSString *title,NSUInteger idx,BOOL *stop){
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor yellowColor];
        [self.sizeView addSubview:button];
        button.tag = idx;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 14;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        long row = idx / 4;
        long column = idx % 4;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sizeView).offset(margin + (margin + [self itemWidth]) * column);
            make.top.equalTo(self.sizeView).offset((ItemHeight + margin) * row);
            make.size.mas_equalTo(CGSizeMake([self itemWidth], ItemHeight));
        }];

    }];
    
    
}

- (CGFloat)itemWidth {
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 6 * margin) / 5;
    return w;
}

+ (CGFloat)getCategoryViewHeight:(NSArray *)array {
    
    if (!array.count) {
        return 0;
    } else {
        long rowCount = (array.count + 4 - 1) / 4;
        return ItemHeight * rowCount + (rowCount - 1) * margin;
    }
}

- (void)clickButtonAction:(UIButton *)button {
    if (!button.selected) {
        [button setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    } else {
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
}

@end


