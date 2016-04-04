//
//  KLoopImg.m
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "KLoopImg.h"

@interface KLoopImg ()
{
    @private
    CGFloat loopImgWidth;
    CGFloat loopImgHeight;
}
@end

@implementation KLoopImg

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray*)array{
    self = [super initWithFrame:frame];
    if(self){
        self.imgArray = array;
        count = (int)self.imgArray.count;
        count0 = 0;
        count1 = 1;
        count2 = 2;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor whiteColor];
    
    loopImgWidth  = self.frame.size.width;
    loopImgHeight = self.frame.size.height;
    
    self.loopImg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, loopImgWidth, loopImgHeight)];
    self.loopImg.contentSize = CGSizeMake(3 * loopImgWidth, loopImgHeight);
    /* 属性 */ {
        self.loopImg.contentOffset = CGPointMake(loopImgWidth, 0);
        self.loopImg.showsHorizontalScrollIndicator = NO;
        self.loopImg.showsVerticalScrollIndicator = NO;
        self.loopImg.pagingEnabled = YES;
        self.loopImg.bounces = NO;
    }
    
    self.img0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, loopImgWidth, loopImgHeight)];
    self.img1 = [[UIImageView alloc] initWithFrame:CGRectMake(loopImgWidth, 0, loopImgWidth, loopImgHeight)];
    self.img1.userInteractionEnabled = YES;
    self.img2 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * loopImgWidth, 0, loopImgWidth, loopImgHeight)];
    
    [self.loopImg addSubview:self.img0];
    [self.loopImg addSubview:self.img1];
    [self.loopImg addSubview:self.img2];
    [self addSubview:self.loopImg];
    
    self.img0.image = [UIImage imageNamed:_imgArray[count0]];
    self.img1.image = [UIImage imageNamed:_imgArray[count1]];
    self.img2.image = [UIImage imageNamed:_imgArray[count2]];
    
    self.page = [UIPageControl new];
    self.page.alpha = 0;
    [self addSubview:self.page];

}

#pragma mark - 自动轮播
- (void)autoLoop:(EScrollDirection)direction{
    [UIView animateWithDuration:0.2 animations:^{
        if(direction == (kScrollLift|kScrollJudge)){
            self.loopImg.contentOffset = CGPointMake(2 * loopImgWidth, 0);
        }else if(direction == kScrollRight){
            self.loopImg.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    [self dragLoop:direction];
}

#pragma mark - 拖动图片
- (void)dragLoop:(EScrollDirection)direction{
    if(direction == kScrollJudge){
        if(self.loopImg.contentOffset.x == 0){
            [self scroll:kScrollRight];
        }else if(self.loopImg.contentOffset.x == 2 * loopImgWidth){
            [self scroll:kScrollLift];
        }
    }else{
        [self scroll:direction];
    }
}

#pragma mark - 拖动方向
- (void)scroll:(EScrollDirection)direction{
    self.loopImg.contentOffset = CGPointMake(LOOPIMG_W, 0);
    if(direction == kScrollLift){
        count0 = count1;
        count1 = count2;
        count2 = (count2 + 1 == self.imgArray.count) ? 0: count2 + 1;
    }else if(direction == kScrollRight){
        count2 = count1;
        count1 = count0;
        count0 = (count0 == 0) ? count - 1: count0 - 1;
    }
    {
        self.img0.image = [UIImage imageNamed:self.imgArray[count0]];
        self.img1.image = [UIImage imageNamed:self.imgArray[count1]];
        self.img2.image = [UIImage imageNamed:self.imgArray[count2]];
    }
    
    self.page.currentPage = count1 == 0 ? count - 1 : count1 - 1;
}

#pragma mark - 页码控制器设置
- (void)pageSettingWithHeight:(CGFloat)height block:(void(^)(UIPageControl* page))block{
    self.page.alpha = 1;
    self.page.frame = CGRectMake(0, loopImgHeight - height, loopImgWidth, height);
    self.page.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    self.page.pageIndicatorTintColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.page.numberOfPages = count;
    if(block != nil){
        block(self.page);
    }
    else {/* 安全判断 */}
}

#pragma mark - 页码控制
- (void)pageChange{
    count1 = (int)(self.page.currentPage == count - 1 ? 0 : self.page.currentPage + 1);
    count0 = (count1 - 1 < 0) ? count - 1 : count1 - 1;
    count2 = (count1 + 1 == count) ? 0 : count1 + 1;
    {
        self.img0.image = [UIImage imageNamed:self.imgArray[count0]];
        self.img1.image = [UIImage imageNamed:self.imgArray[count1]];
        self.img2.image = [UIImage imageNamed:self.imgArray[count2]];
    }
}

#pragma mark - 获取事件数组元素
- (id)getActArray{
    return self.actArray[count1];
}
@end
