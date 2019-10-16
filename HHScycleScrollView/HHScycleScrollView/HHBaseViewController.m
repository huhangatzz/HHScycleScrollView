//
//  ViewController.m
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019 胡航. All rights reserved.
//

#import "HHBaseViewController.h"
#import "HHBaseScycleScrollView.h"
#import "HHViewExtTool.h"

#define IsIPhone_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define ScreenWidth               [UIScreen mainScreen].bounds.size.width
#define NaviStatusHeight          (IsIPhone_X ? 88 : 64)                    // 状态栏+导航栏高度

@interface HHBaseViewController ()<BaseScycleScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) HHBaseScycleScrollView *scyleScrollView1;//本地轮播1
@property (nonatomic , strong) HHBaseScycleScrollView *scyleScrollView2;//网络图片样式1
@property (nonatomic , strong) HHBaseScycleScrollView *scyleScrollView3;//网络图片样式2


@end

@implementation HHBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"轮播图";
    
    [self createUpScrollView];
    
    //展示本地
    [self showScycleLocalImage];
    
    //展示网络图片样式一
    [self showScycleNetworkImageOne];
    
    //展示网络图片样式一
    [self showScycleNetworkImageTwo];
}

- (void)createUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

//本地图片展示
- (void)showScycleLocalImage
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"1、轮播本地图片";
    [self.scrollView addSubview:titleLabel];
    
    NSMutableArray *images = [NSMutableArray new];
    for (int i = 0; i < 3; i ++)
    {
        NSString *imgName = [NSString stringWithFormat:@"WechatIMG%d.jpeg",i + 1];
        NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"localImage.bundle/%@", imgName]];
         UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [images addObject:image];
    }
    NSArray *titles = @[@"毕节百里杜鹃",@"家里好热啊!",@"还是喜欢钓鱼,悠闲自在"];
    
    HHBaseScycleScrollView *scyleScrollView = [[HHBaseScycleScrollView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom, ScreenWidth, 150) imageW:ScreenWidth leftX:0];
    scyleScrollView.delegate = (id <BaseScycleScrollViewDelegate>)self;
    scyleScrollView.images = images;//展示图片数组
    scyleScrollView.titles = titles;//展示标题数组
    scyleScrollView.currentPageIndicatorTintColor = [UIColor redColor];//圆点目前颜色
    scyleScrollView.pageIndicatorTintColor = [UIColor lightGrayColor];//圆点正常颜色
    scyleScrollView.intervalTime = 6;//切换下张图片延迟时间
    [self.scrollView addSubview:scyleScrollView];
    self.scyleScrollView1 = scyleScrollView;
}

//展示网络图片样式一
- (void)showScycleNetworkImageOne
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.scyleScrollView1.bottom, ScreenWidth - 40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"2、轮播网络图片样式1";
    [self.scrollView addSubview:titleLabel];
    
     NSArray *images = @[@"http://c.hiphotos.baidu.com/baike/pic/item/d1a20cf431adcbefd4018f2ea1af2edda3cc9fe5.jpg",@"http://img3.duitang.com/uploads/item/201605/28/20160528202026_BvuWP.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118823131&di=aa588a997ac0599df4e87ae39ebc7406&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F08%2F20160508154653_AQavc.png"];
    NSArray *titles = @[@"网络图片1",@"网络图片2",@"网络图片3"];
    
    HHBaseScycleScrollView *scyleScrollView = [[HHBaseScycleScrollView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom, ScreenWidth, 150) imageW:ScreenWidth leftX:0];
    scyleScrollView.delegate = (id <BaseScycleScrollViewDelegate>)self;
    scyleScrollView.images = images;//展示图片数组
    scyleScrollView.titles = titles;//展示标题数组
    scyleScrollView.currentPageIndicatorTintColor = [UIColor redColor];//圆点目前颜色
    scyleScrollView.pageIndicatorTintColor = [UIColor lightGrayColor];//圆点正常颜色
    scyleScrollView.intervalTime = 6;//切换下张图片延迟时间
    [self.scrollView addSubview:scyleScrollView];
    self.scyleScrollView2 = scyleScrollView;
}

//展示网络图片样式2
- (void)showScycleNetworkImageTwo
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.scyleScrollView2.bottom, ScreenWidth - 40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"3、轮播网络图片样式2";
    [self.scrollView addSubview:titleLabel];
    
     NSArray *images = @[@"http://c.hiphotos.baidu.com/baike/pic/item/d1a20cf431adcbefd4018f2ea1af2edda3cc9fe5.jpg",@"http://img3.duitang.com/uploads/item/201605/28/20160528202026_BvuWP.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118823131&di=aa588a997ac0599df4e87ae39ebc7406&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F08%2F20160508154653_AQavc.png"];
    NSArray *titles = @[@"网络图片1",@"网络图片2",@"网络图片3"];
    
    HHBaseScycleScrollView *scyleScrollView = [[HHBaseScycleScrollView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom, ScreenWidth, 150) imageW:ScreenWidth - 30 leftX:15];
    scyleScrollView.delegate = (id <BaseScycleScrollViewDelegate>)self;
    scyleScrollView.images = images;//展示图片数组
    scyleScrollView.titles = titles;//展示标题数组
    scyleScrollView.currentPageIndicatorTintColor = [UIColor redColor];//圆点目前颜色
    scyleScrollView.pageIndicatorTintColor = [UIColor lightGrayColor];//圆点正常颜色
    scyleScrollView.cornerRadius = 5;
    scyleScrollView.intervalTime = 6;//切换下张图片延迟时间
    [self.scrollView addSubview:scyleScrollView];
    self.scyleScrollView3 = scyleScrollView;
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, scyleScrollView.bottom);
}

#pragma mark - BaseScycleScrollViewDelegate
- (void)baseScycleScrollView:(HHBaseScycleScrollView *)scyleView index:(NSInteger)index
{
    NSString *imgIndex = [NSString stringWithFormat:@"点击了第%ld张图片",index];
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:imgIndex preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alerVC addAction:sureAction];
    [self presentViewController:alerVC animated:YES completion:nil];
}

@end
