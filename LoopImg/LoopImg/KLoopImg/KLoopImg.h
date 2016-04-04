//
//  KLoopImg.h
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//
/*
 * 三个页面以上的轮播图
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EScrollDirection){
    kScrollLift,
    kScrollRight,
    kScrollJudge,
};

@interface KLoopImg : UIView
{
    @public
    int count;
    int count0;
    int count1;
    int count2;
}
@property(nonatomic,strong)UIScrollView *loopImg;
@property(nonatomic,strong)UIImageView *img0;
@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSArray *imgArray;
@property(nonatomic,strong)NSArray *actArray;

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray*)array;

/**
 * 自动轮播
 * @param direction 方向
 */
- (void)autoLoop:(EScrollDirection)direction;

/**
 * 拖动图片
 * @param direction 方向
 */
- (void)dragLoop:(EScrollDirection)direction;

/**
 * 页码控制设置
 * @param height 高度
 * @param black 设置块
 */
- (void)pageSettingWithHeight:(CGFloat)height block:(void(^)(UIPageControl* page))block;

/**
 * 页码控制
 */
- (void)pageChange;

/**
 * 获取事件数组
 */
- (id)getActArray;
@end
