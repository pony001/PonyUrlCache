//
//  ViewController.m
//  PonyUrlCache
//
//  Created by 马明晗 on 15/8/6.
//  Copyright (c) 2015年 马明晗. All rights reserved.
//

#import "ViewController.h"
#import "RESTEngine.h"

@interface ViewController ()
- (IBAction)tapTest:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapTest:(id)sender {
    [[RESTEngine sharedManager] sendRequest:@"http://test.maminghan.cn/send.php"
                                    setBody:@{@"uid":@"111",@"pc":@"111222"}
                                finishBlock:^(NSString *request) {
                                        
                                    } failBlock:^(NSString *request) {
                                        
                                    } isPost:YES];
}
@end
