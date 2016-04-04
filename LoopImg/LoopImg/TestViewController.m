//
//  TestViewController.m
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "TestViewController.h"
#import "KLoopImg.h"

@interface TestViewController ()<UIScrollViewDelegate>
{
    NSInteger direction;
}
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)KLoopImg *loopImg;
@property(nonatomic,strong)UILabel *label;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    direction = kScrollRight;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.loopImg = [[KLoopImg alloc]initWithFrame:CGRectMake(0, 50, SC_WIDTH, SC_WIDTH/2.0)
                                         imgArray:@[@"01.png", @"02.png", @"03.png", @"04.png", @"05.png", @"hh.png"]];
    {
        self.loopImg.loopImg.delegate = self;
        self.loopImg.actArray = @[@"传颂之物", @"野良神", @"Chobits", @"海贼王", @"言叶之庭", @"中科网"];
        
        [self.loopImg pageSettingWithHeight:30 block:^(UIPageControl *page) {
            [page addTarget:self action:@selector(pageCtr) forControlEvents:UIControlEventValueChanged];
        }];
        
        [self timerFunc];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
        [self.loopImg.img1 addGestureRecognizer:tap];

    }
    [self.view addSubview:self.loopImg];
    
    /**************************************************/
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.loopImg.frame) + 50, SC_WIDTH - 40, 50)];
    {
        self.label.layer.masksToBounds = YES;
        self.label.layer.cornerRadius = 5;
        self.label.layer.borderColor = [UIColor grayColor].CGColor;
        self.label.layer.borderWidth = 0.5;
    }
    [self.view addSubview:self.label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    {
        button.frame = CGRectMake(100, CGRectGetMaxY(self.label.frame), SC_WIDTH - 200, 40);
        button.backgroundColor = [UIColor colorWithRed:1.000 green:0.697 blue:0.369 alpha:1.000];
        [button setTitle:@"更换轮播方向" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeDirection) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:button];
}

- (void)timerFunc{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setupTimer) userInfo:nil repeats:YES];
}

// 计时器方法
- (void)setupTimer{
    [self.loopImg autoLoop:kScrollJudge];
}

// 页面控制方法
- (void)pageCtr{
    NSLog(@"%ld", self.loopImg.page.currentPage);
    [self.loopImg pageChange];
}

// 点击图片响应事件
- (void)action{
    self.label.text = [self.loopImg getActArray];
}

- (void)changeDirection{
    if(direction == (kScrollRight|kScrollJudge)){
        direction = kScrollLift;
    }else{
        direction = kScrollRight;
    }
    
    [self.timer invalidate];
    [self timerFunc];

}

// 即将拖动时，关闭计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

// 完成拖动，开启计时器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.loopImg dragLoop:kScrollJudge];
    
    [self timerFunc];
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
