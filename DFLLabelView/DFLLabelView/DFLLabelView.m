//
//  DFLLabelView.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLLabelView.h"

CGFloat const START_X = 10.0f;                      //起始x位置
CGFloat const HORIZONTAL_PADDING = 10.0f;           //  字体距离标签左右两边间隙
const CGFloat VERTICAL_PADDING = 10.0f;             //  字体距离标签上下两边间隙
const CGFloat LABEL_PADDING = 10.0f;                 //  标签之间的间隙
const CGFloat TOP_BOTTOM_PADDING = 10.0f;            //  上下底部间隙
@interface DFLLabelView ()

@end


@implementation DFLLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTexts:(NSArray *)texts {
    
    _texts = texts;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([DFLLabelView calculateViewHeightWithTextArray:texts]);
    }];
    __block CGRect previousFrame = CGRectZero;
    previousFrame.origin.y = TOP_BOTTOM_PADDING;
    [texts enumerateObjectsUsingBlock:^(NSString *title,NSUInteger idx,BOOL *stop){
        UIButton *button = [self configuratioButtonWithIndex:idx title:title];
        [self addSubview:button];
        CGSize title_Size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        if (title_Size.width > 120) {
            title_Size.width = 120;
        }
        title_Size.width  += HORIZONTAL_PADDING;
        title_Size.height += VERTICAL_PADDING;
        CGRect currentLabelFrame = CGRectZero;
        if (previousFrame.origin.x + previousFrame.size.width + title_Size.width > [UIScreen mainScreen].bounds.size.width - 2 * START_X) {
            
            currentLabelFrame.origin = CGPointMake(START_X, CGRectGetMaxY(previousFrame) + LABEL_PADDING);
            
        } else {
            
            currentLabelFrame.origin = CGPointMake(CGRectGetMaxX(previousFrame)+ LABEL_PADDING, CGRectGetMinY(previousFrame));
        }
        currentLabelFrame.size = title_Size;
        previousFrame = currentLabelFrame;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(currentLabelFrame.origin.x);
            make.top.equalTo(self).offset(currentLabelFrame.origin.y);
            make.size.mas_equalTo(currentLabelFrame.size);
            
        }];
        NSLog(@"currentLabelFrame.origin.x==%f",currentLabelFrame.origin.x);
    }];
    
}

+ (CGFloat)calculateViewHeightWithTextArray:(NSArray *)array {
    if (array.count == 0) {
        return 0;
    } else {
        __block CGRect  previousFrame = CGRectZero;
        previousFrame.origin.y = TOP_BOTTOM_PADDING;
        [array enumerateObjectsUsingBlock:^(NSString *text,NSUInteger idx,BOOL *stop){
            
            CGSize size_str = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            if (size_str.width > 120) {
                size_str.width = 120;
            }
            size_str.width  += HORIZONTAL_PADDING;
            size_str.height += VERTICAL_PADDING;
            CGRect newFrame = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + size_str.width  > [UIScreen mainScreen].bounds.size.width - 2 * START_X) {
                newFrame.origin = CGPointMake(START_X,CGRectGetMaxY(previousFrame) + LABEL_PADDING);
            } else {
                newFrame.origin = CGPointMake(CGRectGetMaxX(previousFrame)+ LABEL_PADDING, CGRectGetMinY(previousFrame));
            }
            newFrame.size = size_str;
            previousFrame = newFrame;
            
        }];
        return CGRectGetMaxY(previousFrame) + TOP_BOTTOM_PADDING;
    }
}

- (UIButton *) configuratioButtonWithIndex:(NSInteger)index title:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] init];
    button.tag = 100 +index;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor whiteColor];
//    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.masksToBounds = YES;
    
    return button;
}
@end
