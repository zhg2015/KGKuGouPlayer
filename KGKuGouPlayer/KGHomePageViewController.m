//
//  KGHomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "KGHomePageViewController.h"
#import "KGHomePageMusicTableViewCell.h"

//定义一个枚举enum,用枚举来区分三个不同的选项,自定义enum类型
typedef enum {
    eMyMusic = 0,
    eNetMusic,
    eMoreFounction
}eMusicSel;

@interface KGHomePageViewController ()

@property(weak,nonatomic)UITableViewCell * curselecedCell;
@property(strong,nonatomic)NSMutableArray * cellStatus;
@property(assign,nonatomic)NSInteger curselectedRow;
@property(strong,nonatomic)NSArray * cellContents;

//用枚举来区分三个不同的选项
@property(assign,nonatomic)eMusicSel musicSel;

@end

@implementation KGHomePageViewController

-(NSMutableArray *)cellStatus{
    if (_cellStatus == nil) {
        _cellStatus = [NSMutableArray array];
        
        NSString * fileName = @"MyMusicSelList.plist";
        switch (_musicSel) {
            case eMyMusic:
                fileName = @"MyMusicSelList.plist";
                break;
            case eNetMusic:
                fileName = @"webMusicList.plist";
                break;
            case eMoreFounction:
                fileName = @"MoreList.plist";
                break;
            default:
                break;
        }
        _cellContents = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:nil]];
       //NSArray * arrays = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MyMusicSelList.plist" ofType:nil]];
        for (int i= 0 ; i<_cellContents.count; i++) {
            NSDictionary * dict = @{@"selected":@0};
            KGMusicCellStatus * status = [KGMusicCellStatus musicCellStatusWithDict:dict];
            [_cellStatus addObject:status];
        }
    }
    return _cellStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //设置tabelFooterView为空，则没有文字的cell下边就不会出现分割线。
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //默认选中的是“我的音乐”
    [self myMusic:_myMusicButton];
    _curselectedRow= -1;
    

}
-(void)viewWillAppear:(BOOL)animated{
        self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
        self.navigationController.navigationBar.hidden = NO;
}
//一 必须实现的代理方法；
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellStatus.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * Id = @"homeListcell";//1.1
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Id];//1.2纯代码创建cell的取Id；
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];//1.3
//    }
//    cell.selectionStyle = UITableViewCellStyleDefault;//点击cell不变灰。
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.text = @"text";
//    cell.textLabel.textColor = [UIColor whiteColor];
    KGHomePageMusicTableViewCell * cell =[KGHomePageMusicTableViewCell homePageMusicTableViewCellWithTableView:tableView];
    cell.status = self.cellStatus[indexPath.row];
    if (_cellContents !=nil) {
        cell.textLabel.text = _cellContents[indexPath.row];

    }
    return cell;
}
//一

//点击cell被选中，模型是不变的，需要通过模型刷新cell，就不会产生重复利用问题。建立模型和cell；
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_curselecedCell !=nil) {
//        _curselecedCell.textLabel.textColor = [UIColor whiteColor];
//    }
//    UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    selectedCell.textLabel.textColor = [UIColor orangeColor];
//    _curselecedCell = selectedCell;
    
//    KGMusicCellStatus * status = self.cellStatus[indexPath.row];
//    status.selected = YES;
//     [self.tableView reloadData];
    if (_curselectedRow >= 0) {
        KGMusicCellStatus * oldstatus = self.cellStatus[_curselectedRow];
        oldstatus.selected = NO;
    }
    KGMusicCellStatus * status = self.cellStatus[indexPath.row];
    status.selected = YES;
    _curselectedRow = indexPath.row;
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"toLocalMusic" sender:nil];
    
}

//cell不被选中
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGMusicCellStatus * status = self.cellStatus[indexPath.row];
    status.selected = NO;
     [self.tableView reloadData];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 登录
- (IBAction)logon:(UIButton *)sender {
}
#pragma mark 注册
- (IBAction)signIn:(UIButton *)sender {
}

#pragma mark 切换开关
- (IBAction)switchButton:(UIButton *)sender {
    sender.selected = !sender.selected;

    
}

#pragma mark 我的音乐
- (IBAction)myMusic:(UIButton *)sender {
    sender.selected = YES;
    _netMusicButton.selected = NO;
    _moreFunctionButton.selected = NO;
    _musicSel = eMyMusic;//用枚举标记选中的选项
    _cellStatus= nil;
    _curselectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
}

#pragma mark 网络音乐
- (IBAction)netMusic:(UIButton *)sender {
    sender.selected = YES;
    _myMusicButton.selected = NO;
    _moreFunctionButton.selected = NO;
    _musicSel = eNetMusic;
    _cellStatus= nil;//内容为空时刷新
    _curselectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);

}

#pragma mark 更多功能
- (IBAction)moreFunction:(UIButton *)sender {
    sender.selected = YES;
    _netMusicButton.selected = NO;
    _myMusicButton.selected = NO;
    _musicSel = eMoreFounction;
    _cellStatus= nil;
    _curselectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
}
@end
