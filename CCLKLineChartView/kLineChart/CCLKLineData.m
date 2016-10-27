//
//  CCLKLineData.m
//  KlineChart
//
//  Created by Crisps on 16/8/24.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineData.h"

@implementation CCLKLineData

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)max{
    
    return (self.closeprice > _openprice) ? _closeprice : _openprice;
    
}

- (CGFloat)min{
    
    return (self.closeprice > _openprice) ? _openprice : _closeprice;
    
}

- (BOOL)isRise{
    return self.openprice >= self.closeprice;
}

@end
