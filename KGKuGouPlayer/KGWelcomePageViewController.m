//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "KGWelcomePageViewController.h"

@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置scrollView 包括显示的图片以及contentSize。
    [self setUpScrollView];//函数是按功能封装的。
    //设置pageControl的点数。
    _pageControl.numberOfPages = 5;
}

#pragma  mark 设置scrollView 包括显示的图片以及contentSize。
-(void)setUpScrollView{
    for (int i = 0; i<5; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        NSString * imageName = [NSString stringWithFormat:@"introduction_%i",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        if (i==4) {
            //添加“开启音乐之旅”按钮，
            [self addStartButton:imageView];//在这里封装一个函数, 传递一个参数，把第五个view传过去。
        }

        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   NSUInteger number = (NSUInteger)_scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage =  number;
}
#pragma mark 添加“开启音乐之旅”按钮
-(void)addStartButton:(UIImageView * )imageView{
    UIButton * startButton = [[UIButton alloc]init];
    startButton.frame = CGRectMake(100.f, 100.f, 100.f, 30.f);
    startButton.backgroundColor = [UIColor redColor];
    [imageView addSubview:startButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
