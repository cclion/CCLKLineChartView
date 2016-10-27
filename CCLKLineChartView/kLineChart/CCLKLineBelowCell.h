//
//  CCLKLineBelowCell.h
//  KlineChart
//
//  Created by Crisps on 16/9/7.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLKLineData.h"
#import "CCLKLineShareData.h"

@interface CCLKLineBelowCell : UITableViewCell

@property (nonatomic, strong) CCLKLineShareData *shareData; // 必须最先赋值

@property (nonatomic, strong) CCLKLineData *data;

@end
