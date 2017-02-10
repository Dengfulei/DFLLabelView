//
//  CategoryCell.h
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCategoryView.h"
@interface CategoryCell : UITableViewCell
@property (nonatomic , strong) NSArray *categorys;
+ (CGFloat)getCellHeight:(NSArray *)category;
@end
