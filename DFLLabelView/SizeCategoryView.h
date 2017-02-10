//
//  SizeCategoryView.h
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface SizeCategoryView : UIView

@property (nonatomic , strong) UILabel *sizeTypeLabel;
@property (nonatomic , strong) NSArray *sizeArray;
+ (CGFloat)getCategoryViewHeight:(NSArray *)array;
@end
