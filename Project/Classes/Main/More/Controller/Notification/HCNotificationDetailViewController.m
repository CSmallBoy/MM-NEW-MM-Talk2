//
//  HCNotificationDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationDetailViewController.h"
#import "UILabel+HCLabelContentSize.h"
#import "HCButtonItem.h"
#import "HCPromisedViewController.h"

@interface HCNotificationDetailViewController ()

@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *notificationMessLab;
@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) HCButtonItem *promisedBtn;
@property (nonatomic,strong) HCButtonItem *MTalkBtn;
@property (nonatomic,strong) HCButtonItem *policeBtn;

@end

@implementation HCNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息详情";
    
    
  
 
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.userNameLab];
    [self.view addSubview: self.timeLab];
    [self.view addSubview: self.notificationMessLab];
    [self.view addSubview: self.footerView];
}


#pragma mark -- 私有方法

-(void)pushTOPromised
{
    HCPromisedViewController *promisedVC = [[HCPromisedViewController alloc]init];
    [self.navigationController pushViewController:promisedVC animated:YES];
}

-(void)ContactCustomerService
{
    [self showHUDText:@"拨打客服电话"];
}

-(void)ContactWithPolice
{
    [self showHUDText:@"拨打110"];
}

#pragma mark----Settet OR Getter
-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 74, 120, 44)];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.text = self.info.userName;
        _userNameLab.textColor = [UIColor blackColor];
        _userNameLab.font = [UIFont systemFontOfSize:16];
    }
    return _userNameLab;
}

-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200, 74, 190, 44)];
        _timeLab.textAlignment = NSTextAlignmentRight;
          _timeLab.text = self.info.time;
        _timeLab.textColor = [UIColor lightGrayColor];
        _timeLab.font = [UIFont systemFontOfSize:14];
    }
    return _timeLab;
}

-(UILabel *)notificationMessLab
{
    if (!_notificationMessLab) {
        _notificationMessLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 1000)];
           _notificationMessLab.text = self.info.notificationMessage;
        _notificationMessLab.textAlignment = NSTextAlignmentLeft;
        _notificationMessLab.textColor = [UIColor blackColor];
        _notificationMessLab.numberOfLines = 0;
        _notificationMessLab.lineBreakMode = NSLineBreakByCharWrapping;
        _notificationMessLab.font = [UIFont systemFontOfSize:14];
        
        [_notificationMessLab setFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, [_notificationMessLab contentSize].height)];
    }
    return _notificationMessLab;
}

-(UIView *)footerView
{
    if (!_footerView)
    {
        CGFloat footerViewY = MAX(SCREEN_HEIGHT-61,self.notificationMessLab.frame.size.height+120);
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,footerViewY , SCREEN_WIDTH, 60)];
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 1)];
        topView.backgroundColor = [UIColor lightGrayColor];
        [_footerView addSubview:topView];
        
        UIView *lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-1, 10, 1, 40)];
        lineViewOne.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewOne];
       
        UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2-2, 10, 1, 40)];
        lineViewTwo.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewTwo];
        
        [_footerView addSubview: self.promisedBtn];
        [_footerView addSubview: self.MTalkBtn];
        [_footerView addSubview: self.policeBtn];
    }
    return _footerView;
}

-(HCButtonItem *)promisedBtn
{
    if (!_promisedBtn)
    {
        _promisedBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"message_phone" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"一呼百应", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_promisedBtn addTarget:self action:@selector(pushTOPromised) forControlEvents:UIControlEventTouchUpInside];
    }
    return _promisedBtn;
}

-(HCButtonItem *)MTalkBtn
{
    if (!_MTalkBtn)
    {
        _MTalkBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"m-talk_Customer-Services" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"M-Talk客服", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_MTalkBtn addTarget:self action:@selector(ContactCustomerService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MTalkBtn;
}

-(HCButtonItem *)policeBtn
{
    if (!_policeBtn)
    {
        _policeBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"110" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"快速报警", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_policeBtn addTarget:self action:@selector(ContactWithPolice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _policeBtn;
}
@end