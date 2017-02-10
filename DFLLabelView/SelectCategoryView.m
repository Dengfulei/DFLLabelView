//
//  SelectCategoryView.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "SelectCategoryView.h"
#define DFLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define  MARGIN  13.0f
#define  ITEM_HRIGHT  30.0f

@interface SelectCategoryView ()
@property (nonatomic , strong) UIButton *selectButton;


@end

@implementation SelectCategoryView

- (void)setCategoryArray:(NSArray *)categoryArray {
    
    _categoryArray = categoryArray;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([SelectCategoryView getCategoryViewHeight:categoryArray]);
    }];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [categoryArray enumerateObjectsUsingBlock:^(NSString *text,NSUInteger idx,BOOL *stop) {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor yellowColor];
        [self addSubview:button];
        button.tag = idx;
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitleColor:DFLColor(35, 156, 235) forState:UIControlStateNormal];
        button.layer.cornerRadius = 15;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
//        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        long row = idx / 4;
        long column = idx % 4;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MARGIN + (MARGIN + [self itemWidth]) * column);
            make.top.equalTo(self).offset((ITEM_HRIGHT + 2 * MARGIN) * row);
            make.size.mas_equalTo(CGSizeMake([self itemWidth], ITEM_HRIGHT));
        }];
    }];
    
}



- (CGFloat)itemWidth {
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 5 * MARGIN)/4;
    
    return w;
}


+ (CGFloat)getCategoryViewHeight:(NSArray *)array {
    
    if (!array.count) {
        return 0;
    } else {
        long rowCount = (array.count + 4 - 1) / 4;
        return ITEM_HRIGHT * rowCount + (rowCount - 1) * 2 * MARGIN;
    }
}

- (void)clickButtonAction:(UIButton *)button {
   
    
    if (self.selectButton == button) {
        
    } else {
        [self.selectButton setBackgroundImage:nil forState:UIControlStateNormal];
       [button setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
        self.selectButton = button;
    }
}




@end
