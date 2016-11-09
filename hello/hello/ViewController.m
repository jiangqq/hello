//
//  ViewController.m
//  hello
//
//  Created by admin on 2016/11/3.
//  Copyright © 2016年 jiangqq. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UITableView *leftTabelView;
@property (nonatomic, strong) UITableView *rightTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //chouchou
    if (NSFoundationVersionNumber >= 7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    button.backgroundColor = [UIColor blueColor];
    button.tag = 100;
    [button setTitle:@"点吧" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    self.redView = [[UIView alloc] init];
    self.redView.frame = CGRectMake(0, 50, self.view.frame.size.width, 0);
//    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    [self.redView addSubview:self.leftTabelView];
    [self.redView addSubview:self.rightTableView];
   
}

- (void)click:(UIButton *)button
{
    
    if (button.tag == 100) {
       
        button.tag = 101;
        [self showSpringAnimationWithDuration:0.3 animations:^{
            self.redView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50);
            self.leftTabelView.frame = CGRectMake(0, 50, self.view.frame.size.width/2, self.view.frame.size.height-50);
            self.rightTableView.frame = CGRectMake(self.view.frame.size.width/2, 50, self.view.frame.size.width/2, self.view.frame.size.height-50);
            [self.leftTabelView reloadData];
            [self.rightTableView reloadData];
            
        } completion:^{
        }];
    }else{
        button.tag = 100;
        [self showSpringAnimationWithDuration:0.3 animations:^{
            self.redView.frame = CGRectMake(0, 50, self.view.frame.size.width, 0);
            self.leftTabelView.frame = CGRectMake(0, 50, self.view.frame.size.width/2, 0);
           self.rightTableView.frame = CGRectMake(self.view.frame.size.width/2, 50, self.view.frame.size.width/2, 0);
        } completion:^{
        }];
    }
}

-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion
{
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:.8
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         if (animations) {
                             animations();
                         }
                     } completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
   
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTabelView == tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewCell"];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    if (_rightTableView == tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightTableViewCell"];
        cell.backgroundColor = [UIColor blueColor];
        return cell;
    }
    return 0;
}

#pragma mark setter&getter

- (UITableView *)leftTabelView
{
    if (!_leftTabelView) {
        _leftTabelView = [[UITableView alloc] init];
        _leftTabelView.frame = self.view.frame;
        CGRect frame = _leftTabelView.frame;
        frame.origin.y = 50;
        frame.size.width = _leftTabelView.frame.size.width/2;
        frame.size.height = 0;
        _leftTabelView.frame = frame;
        _leftTabelView.delegate = self;
        _leftTabelView.dataSource = self;
        [_leftTabelView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:@"LeftTableViewCell"];
    }
    return _leftTabelView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView) {
    _rightTableView = [[UITableView alloc] init];
    _rightTableView.frame = self.view.frame;
        CGRect frame = _rightTableView.frame;
        frame.origin.y = 50;
        frame.origin.x = self.view.frame.size.width/2;
        frame.size.height = 0;
       frame.size.width = _rightTableView.frame.size.width/2;
    _rightTableView.frame = frame;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:@"RightTableViewCell"];
}
    return _rightTableView;

}

@end
