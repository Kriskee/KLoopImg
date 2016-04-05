//
//  TestViewController.m
//  LoopImg
//
//  Created by lanou3g on 16/4/4.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "TestViewController.h"
#import "KLoopImg.h"
#import "ActionViewController.h"
#define pageHeight 30

typedef NS_ENUM(NSInteger, EAction){
    kChangeDirection,
    kChangePush,
};

@interface TestViewController ()<UIScrollViewDelegate>
{
    NSInteger direction;
    CGFloat navigationMaxY;
    EAction isAction;
}
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)KLoopImg *loopImg;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *subLab;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.124 blue:0.232 alpha:1.000];
    self.automaticallyAdjustsScrollViewInsets = NO;
    navigationMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.051 green:0.056 blue:0.231 alpha:1.000];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    self.navigationItem.title = @"LoopImg Demo";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    isAction = kChangeDirection;
    direction = kScrollRight;
    
    [self createLoopImg];
    
    self.subLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loopImg.frame) - pageHeight, 100, pageHeight)];
    {
        self.subLab.textAlignment = NSTextAlignmentCenter;
        self.subLab.textColor = [UIColor whiteColor];
        self.subLab.text = [self.loopImg getElementOfActArray];
    }
    [self.view addSubview:self.subLab];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.loopImg.frame) + 50, SC_WIDTH - 40, 50)];
    {
        self.label.layer.masksToBounds = YES;
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.layer.cornerRadius = 5;
        self.label.layer.borderColor = [UIColor grayColor].CGColor;
        self.label.layer.borderWidth = 0.5;
    }
    [self.view addSubview:self.label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    {
        button.frame = CGRectMake(100, CGRectGetMaxY(self.label.frame) + 50, SC_WIDTH - 200, 40);
        button.backgroundColor = [UIColor colorWithRed:1.000 green:0.697 blue:0.369 alpha:1.000];
        [button setTitle:@"更换轮播方向" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeDirection) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    {
        button2.frame = CGRectMake(100, CGRectGetMaxY(button.frame) + 50, SC_WIDTH - 200, 40);
        button2.backgroundColor = [UIColor colorWithRed:0.394 green:1.000 blue:0.393 alpha:1.000];
        [button2 setTitle:@"更换点击事件" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:button2];
}

// 创建轮播图
- (void)createLoopImg{
    NSArray *imgArray;
    NSArray *strArray;
    /* 图片数组·图片名数组 */{
        UIImage *img0 = [UIImage imageNamed:@"01.png"];
        UIImage *img1 = [UIImage imageNamed:@"02.png"];
        UIImage *img2 = [UIImage imageNamed:@"03.png"];
        UIImage *img3 = [UIImage imageNamed:@"04.png"];
        UIImage *img4 = [UIImage imageNamed:@"05.png"];
        UIImage *img5 = [UIImage imageNamed:@"hh.png"];
        imgArray = @[img0, img1, img2, img3, img4, img5, [UIImage imageNamed:@"new.jpeg"]];
        strArray = @[@"01.png", @"02.png", @"03.png", @"04.png", @"05.png", @"hh.png", @"new.jpeg"];
    }
        
    self.loopImg = [[KLoopImg alloc]initWithFrame:CGRectMake(0, navigationMaxY, SC_WIDTH, SC_WIDTH/2.0)
                                         imgArray:imgArray
                                        direction:direction];
    {
        self.loopImg.loopImg.delegate = self;
        self.loopImg.actArray = @[@"传颂之物", @"野良神", @"Chobits", @"海贼王", @"言叶之庭", @"中科网", @"初音ミク"];
        
        [self.loopImg pageSettingWithHeight:pageHeight block:^(UIPageControl *page) {
            [page addTarget:self action:@selector(pageCtr) forControlEvents:UIControlEventValueChanged];
        }];
        
        [self timerFunc];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
        [self.loopImg.img1 addGestureRecognizer:tap];
        
    }
    [self.view addSubview:self.loopImg];
    
    [self.view bringSubviewToFront:self.subLab];
    self.subLab.text = [self.loopImg getElementOfActArray];
}

// 计时器方法
- (void)timerFunc{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setupTimer) userInfo:nil repeats:YES];
}

// 计时器方法
- (void)setupTimer{
    [self.loopImg autoLoop];
    self.subLab.text = [self.loopImg getElementOfActArray];
    NSLog(@"测试");
}

// 页面控制方法
- (void)pageCtr{
    NSLog(@"%ld", self.loopImg.page.currentPage);
    [self.loopImg pageChange];
    self.subLab.text = [self.loopImg getElementOfActArray];
}

// 点击图片响应事件
- (void)action{
    if(isAction == kChangeDirection){
        self.label.text = [self.loopImg getElementOf:self.loopImg.actArray];
    }else if(isAction == kChangePush){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ActionViewController *AVC = [storyBoard instantiateViewControllerWithIdentifier:@"AVC"];
        [self.navigationController pushViewController:AVC animated:YES];
        if([[self.loopImg.imgArray firstObject] isKindOfClass:[NSString class]]){
            AVC.img = [UIImage imageNamed:[self.loopImg getElementOfImgArray]];
        }else{
            AVC.img = [self.loopImg getElementOfImgArray];
        }
        AVC.str = [self.loopImg getElementOfActArray];
    }
}

// 更改轮播方向
- (void)changeDirection{
    if(direction == kScrollRight){
        direction = kScrollLift;
    }else{
        direction = kScrollRight;
    }
    
    self.loopImg = nil;
    [self.timer invalidate];
    [self createLoopImg];
}

// 更换响应事件
- (void)changeAction{
    switch (isAction) {
        case kChangeDirection:
            isAction = kChangePush;
            break;
        case kChangePush:
            isAction = kChangeDirection;
        default:
            break;
    }
}

// 即将拖动时，关闭计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

// 完成拖动，开启计时器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.loopImg dragLoop];
    
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
