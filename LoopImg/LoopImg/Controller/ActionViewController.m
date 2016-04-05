//
//  ActionViewController.m
//  LoopImg
//
//  Created by lanou3g on 16/4/5.
//  Copyright © 2016年 Kriskee. All rights reserved.
//

#import "ActionViewController.h"
#define color arc4random()%256/255.0f

@interface ActionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *text;
@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1.000];
    self.image.image = self.img;
    self.text.text = self.str;
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
