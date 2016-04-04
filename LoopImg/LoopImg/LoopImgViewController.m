//
//  LoopImgViewController.m
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "LoopImgViewController.h"

@interface LoopImgViewController ()<UIScrollViewDelegate>
{
    @private
    int count0;
    int count1;
    int count2;
    int count;
}

@property(nonatomic,strong)NSArray *imgArray;
@property(nonatomic,strong)NSArray *actArray;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation LoopImgViewController
- (void)loadView{
    [super loadView];
    self.LIV = [[LoopImgView alloc] initWithFrame:self.view.frame];
    self.view = self.LIV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        count0 = 0;
        count1 = 1;
        count2 = 2;
    }
    
    self.imgArray = @[@"01.png", @"02.png", @"03.png", @"04.png", @"05.png"];
    self.actArray = @[@"传颂之物", @"野良神", @"Chobits", @"海贼王", @"言叶之庭"];
    count = (int)self.imgArray.count;
    
    self.LIV.loopImg.delegate = self;
    self.LIV.loopImg.contentOffset = CGPointMake(LOOPIMG_W, 0);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setupTimer) userInfo:nil repeats:YES];
    /* 轮播图设置 */ {
        self.LIV.img0.image = [UIImage imageNamed:self.imgArray[count0]];
        self.LIV.img1.image = [UIImage imageNamed:self.imgArray[count1]];
        self.LIV.img2.image = [UIImage imageNamed:self.imgArray[count2]];
    }
    
    
}

- (void)setupTimer{
    [UIView animateWithDuration:0.2 animations:^{
        self.LIV.loopImg.contentOffset = CGPointMake(2 * LOOPIMG_W, 0);
    }];
    
    [self imgChange];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(self.LIV.loopImg.contentOffset.x == 0){
        [self imgChange2];
    }else if(self.LIV.loopImg.contentOffset.x == 2 * LOOPIMG_W){
        [self imgChange];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setupTimer) userInfo:nil repeats:YES];
}

- (void)imgChange{
    self.LIV.loopImg.contentOffset = CGPointMake(LOOPIMG_W, 0);
    count0 = count1;
    count1 = count2;
    count2 = (count2 + 1 == self.imgArray.count) ? 0: count2 + 1;
    
    /* 轮播图 改变*/ {
        self.LIV.img0.image = [UIImage imageNamed:self.imgArray[count0]];
        self.LIV.img1.image = [UIImage imageNamed:self.imgArray[count1]];
        self.LIV.img2.image = [UIImage imageNamed:self.imgArray[count2]];
    }
    
    NSLog(@"%@ %d %d %d", self.actArray[count1], count0, count1, count2);
}

/* 向右 */
- (void)imgChange2{
    self.LIV.loopImg.contentOffset = CGPointMake(LOOPIMG_W, 0);
    count2 = count1;
    count1 = count0;
    count0 = (count0 == 0) ? count - 1: count0 - 1;
    
    /* 轮播图 改变*/ {
        self.LIV.img0.image = [UIImage imageNamed:self.imgArray[count0]];
        self.LIV.img1.image = [UIImage imageNamed:self.imgArray[count1]];
        self.LIV.img2.image = [UIImage imageNamed:self.imgArray[count2]];
    }
    
    NSLog(@"%@ %d %d %d", self.actArray[count1], count0, count1, count2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
