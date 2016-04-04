//
//  LoopImgView.m
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "LoopImgView.h"
#define SC_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SC_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define SC_MIDX CGRectGetMidX([UIScreen mainScreen].bounds)
#define SC_MIDY CGRectGetMidY([UIScreen mainScreen].bounds)

@implementation LoopImgView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor greenColor];
    
    CGFloat loopImgWidth  = SC_WIDTH;
    CGFloat loopImgHeight = loopImgWidth/2.0f;
    
    self.loopImg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, loopImgWidth, loopImgHeight)];
    self.loopImg.contentSize = CGSizeMake(3 * loopImgWidth, loopImgHeight);
    /* loopImg属性 */ {
        self.loopImg.showsHorizontalScrollIndicator = NO;
        self.loopImg.showsVerticalScrollIndicator = NO;
        self.loopImg.pagingEnabled = YES;
        self.loopImg.bounces = NO;
    }
    
    self.img0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, loopImgWidth, loopImgHeight)];
    self.img0.backgroundColor = [UIColor redColor];
    self.img1 = [[UIImageView alloc] initWithFrame:CGRectMake(loopImgWidth, 0, loopImgWidth, loopImgHeight)];
    self.img1.backgroundColor = [UIColor blueColor];
    self.img2 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * loopImgWidth, 0, loopImgWidth, loopImgHeight)];
    self.img2.backgroundColor = [UIColor yellowColor];
    
    [self.loopImg addSubview:self.img0];
    [self.loopImg addSubview:self.img1];
    [self.loopImg addSubview:self.img2];
    [self addSubview:self.loopImg];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
