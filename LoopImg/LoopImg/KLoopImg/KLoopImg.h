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

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray*)array direction:(EScrollDirection)direction;

/**
 * 自动轮播
 * @param direction 方向
 */
- (void)autoLoop;

/**
 * 拖动图片
 * @param direction 方向
 */
- (void)dragLoop;

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
 * 获取数组元素
 */
- (id)getElementOf:(NSArray*)arrayType;

- (id)getElementOfActArray;

- (id)getElementOfImgArray;

/**
 * 更换轮播方向
 */
- (void)changeDirection;
@end
