//
//  CategoryCell.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell ()
@property (nonatomic , strong) SelectCategoryView *categoryview;

@end

@implementation CategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.categoryview = [SelectCategoryView new];
        [self.contentView addSubview:self.categoryview];
        [self.categoryview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(18);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            
        }];
    }
    return self;
}

- (void)setCategorys:(NSArray *)categorys {
    _categorys = categorys;
    self.categoryview.categoryArray = _categorys;
}

+ (CGFloat)getCellHeight:(NSArray *)category {
    
    return 18 + 40 + [SelectCategoryView getCategoryViewHeight:category];
}

@end
