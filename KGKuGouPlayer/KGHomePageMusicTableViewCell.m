//
//  KGHomePageMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "KGHomePageMusicTableViewCell.h"

@implementation KGHomePageMusicTableViewCell
+(instancetype)homePageMusicTableViewCellWithTableView:(UITableView *)tableView{
    static NSString * Id = @"homeListcell";//1.1
    KGHomePageMusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Id];//1.2纯代码创建cell的取Id；
    if (cell == nil) {
        cell = [[KGHomePageMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];//1.3
    }
    cell.selectionStyle = UITableViewCellStyleDefault;//点击cell不变灰。
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)setStatus:(KGMusicCellStatus *)status{
    if (status.selected) {
        self.textLabel.textColor = [UIColor orangeColor];
    }else{
        self.textLabel.textColor = [UIColor whiteColor];
    }
}
@end
