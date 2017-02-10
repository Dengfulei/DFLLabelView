//
//  SizeCell.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "SizeCell.h"

@implementation SizeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.sizeView = [SizeCategoryView new];
        [self.contentView addSubview:self.sizeView];
        [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
        }];
    }
    return self;
}

- (void)setSizeArray:(NSArray *)sizeArray {
    _sizeArray = sizeArray;
    self.sizeView.sizeArray = sizeArray;
}

+ (CGFloat)getCellHeight:(NSArray *)sizeArray {
    
    return 24 +  18 + [SizeCategoryView getCategoryViewHeight:sizeArray];
}

@end
