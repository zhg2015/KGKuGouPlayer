//
//  KGHomePageViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGHomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *icon;
- (IBAction)logon:(UIButton *)sender;
- (IBAction)signIn:(UIButton *)sender;
- (IBAction)switchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *myMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *netMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *moreFunctionButton;
- (IBAction)myMusic:(UIButton *)sender;
- (IBAction)netMusic:(UIButton *)sender;
- (IBAction)moreFunction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end
