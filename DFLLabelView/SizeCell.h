//
//  SizeCell.h
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeCategoryView.h"

@interface SizeCell : UITableViewCell
@property (nonatomic , strong) SizeCategoryView *sizeView;
@property (nonatomic , strong) NSArray *sizeArray;
+ (CGFloat)getCellHeight:(NSArray *)sizeArray;
@end
