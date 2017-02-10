//
//  SelectCategoryView.h
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"


@interface SelectCategoryView : UIView

@property (nonatomic, strong) NSArray *categoryArray;

+ (CGFloat)getCategoryViewHeight:(NSArray *)array;
@end
