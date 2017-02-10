//
//  CategoryModel.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/10.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (instancetype)initWithText:(NSString *)text {
    
    if (self = [super init]) {
        _text = text;
    }
    return self;
}

@end
