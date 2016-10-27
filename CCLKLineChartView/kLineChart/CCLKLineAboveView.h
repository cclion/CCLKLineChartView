//
//  CCLKLineAboveView.h
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLKLineShareData.h"

@protocol CCLKLineAboveViewDelegate <NSObject>

- (void)KLineViewDidScroll:(UITableView*)tableView;

- (void)reloadDate:(UITableView*)tableView;

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSIndexPath *)indexPath andTableView:(UITableView*)tableView;

@end


@interface CCLKLineAboveView : UITableView

@property (nonatomic, strong) CCLKLineShareData *shareData;

- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLKLineShareData *)shareData;

@property (nonatomic, weak) id<CCLKLineAboveViewDelegate>  kDelegate;

- (void)drawWithLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSIndexPath *)indexPath;


@end
