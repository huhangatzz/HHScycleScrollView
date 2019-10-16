//
//  SPScycleScrollView.m
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019年 胡航. All rights reserved.
//

#import "HHBaseScycleScrollView.h"
#import "HHViewExtTool.h"
#import <UIImageView+WebCache.h>

#define SCYLE_WIDTH CGRectGetWidth(self.frame)
#define SCYLE_HEIGHT CGRectGetHeight(self.frame)

@interface HHBaseScycleScrollView()<UIScrollViewDelegate>

/** 滑动视图 */
@property (nonatomic,strong)UIScrollView *scrollView;
/** 小圆点控制器 */
@property (nonatomic,strong)UIPageControl *pageControl;
/** 延时器 */
@property (nonatomic,strong)NSTimer *delayTimer;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLabel;
/** 标题背景视图 */
@property (nonatomic , strong) UIView *titleView;
/** 图片宽度 */
@property (nonatomic,assign)CGFloat imageSetWidth;
/** 距离左边距离 */
@property (nonatomic , assign) CGFloat  leftSetX;

/** 上一张图片 */
@property (nonatomic,strong)UIImageView *beforeImageView;
/** 上一张图片位置 */
@property (nonatomic,assign)NSUInteger beforeImgIndex;

/** 下一张图片 */
@property (nonatomic,strong)UIImageView *nextImageView;
/** 下一张图片的位置 */
@property (nonatomic,assign)NSInteger nextImgIndex;

@end

@implementation HHBaseScycleScrollView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame imageW:(CGFloat)imageW leftX:(CGFloat)leftX
{
    if (self = [super initWithFrame:frame])
    {
        self.intervalTime = 3;
        _imageSetWidth = imageW;
        _leftSetX = leftX;
        [self setupScycleView];
    }
    return self;
}

#pragma mark 创建视图
- (void)setupScycleView
{
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.decelerationRate = 0;
    scrollView.contentSize = CGSizeMake(SCYLE_WIDTH * 3, SCYLE_HEIGHT);
    scrollView.contentOffset = CGPointMake(SCYLE_WIDTH, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.currentPage = self.currentImgIndex;
    pageControl.enabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    //创建3个UIImageView
    [self setupThreeImageView];
}

- (void)setupThreeImageView
{
    //上一张图片
    UIImageView *beforeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.leftSetX, self.leftSetX, self.imageSetWidth, SCYLE_HEIGHT - 2 * self.leftSetX)];
    [self.scrollView addSubview:beforeImageView];
    self.beforeImageView = beforeImageView;
    
    //目前图片
    UIImageView *currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCYLE_WIDTH + self.leftSetX, self.leftSetX, self.imageSetWidth, SCYLE_HEIGHT - 2 * self.leftSetX)];
    currentImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:currentImageView];
    self.currentImageView = currentImageView;
    //给目前图片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheCurrentImgAction:)];
    [currentImageView addGestureRecognizer:tap];
    
    //下一张图片
    UIImageView *nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCYLE_WIDTH * 2 + self.leftSetX, self.leftSetX, self.imageSetWidth, SCYLE_HEIGHT - 2 * self.leftSetX)];
    [self.scrollView addSubview:nextImageView];
    self.nextImageView = nextImageView;
    
    //创建文本信息
    [self createUpTitleMessageView];
}

- (void)createUpTitleMessageView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(self.leftSetX, SCYLE_HEIGHT - self.leftSetX - 24, self.imageSetWidth, 24)];
    titleView.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.25];
    titleView.hidden = YES;
    [self addSubview:titleView];
    self.titleView = titleView;
    
    //标题Label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.hidden = YES;
    [titleView addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
}

//停止定时器
- (void)stopTimer
{
    [self.delayTimer invalidate];
    _delayTimer = nil;
}

#pragma mark - 图片数组
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    if (images.count == 0) return;
    
    [self stopTimer];
    
    if (self.images.count == 1)
    {
        self.scrollView.scrollEnabled = NO;
        self.pageControl.hidden = YES;
        
        //更新图片位置
        [self updateScycelScrollViewImageIndex];
    }else
    {
        self.scrollView.scrollEnabled = YES;
        self.pageControl.hidden = NO;
        
        self.currentImgIndex = 0;
        self.pageControl.currentPage = self.currentImgIndex;
        self.pageControl.numberOfPages = images.count;
        self.pageControl.frame = CGRectMake(SCYLE_WIDTH - 15 * images.count - self.leftSetX, SCYLE_HEIGHT - self.leftSetX - 24, 10 * images.count, 24);
        
        //创建延时器
        [self renewSetDelayTimer];
        
        //更新图片位置
        [self updateScycelScrollViewImageIndex];
    }
}

#pragma mark 更新图片位置
- (void)updateScycelScrollViewImageIndex
{
    if (self.images.count > 0)
    {
        [self addTheImageUrlStr:[self.images objectOrNilAtIndex:self.beforeImgIndex] imageView:_beforeImageView];
        [self addTheImageUrlStr:[self.images objectOrNilAtIndex:self.currentImgIndex] imageView:_currentImageView];
        [self addTheImageUrlStr:[self.images objectOrNilAtIndex:self.nextImgIndex] imageView:_nextImageView];
    }else
    {
        //没有图片,给目前图片位置设置为0
        _currentImgIndex = 0;
    }
    
    if ([self.titles arrayOrOtherOfObject])
    {
        self.titleLabel.frame = CGRectMake(10, 0, self.titleView.width - 15 * self.images.count  - 20  - self.leftSetX, 24);
        self.titleLabel.text = [self.titles objectOrNilAtIndex:_currentImgIndex];
    }
    
    _pageControl.currentPage = _currentImgIndex;
}

#pragma mark 解析图片并添加到imageView上
- (void)addTheImageUrlStr:(id)object imageView:(UIImageView *)imageView
{
    if ([object isKindOfClass:[NSString class]] && [object length] > 0)
    {
        NSString *urlStr = (NSString *)object;
        NSURL *photoUrl = [NSURL URLWithString:urlStr];
        [imageView sd_setImageWithURL:photoUrl placeholderImage:self.placeHolderImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.image = image ? image : self.placeHolderImg;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }];
    } else if ([object isKindOfClass:[UIImage class]])
    {
        UIImage *localImg = (UIImage *)object;
        imageView.image = localImg;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
    }
}

#pragma mark 延时器执行方法
- (void)useTimerIntervalUpdateScrollViewContentOffSet:(NSTimer *)timer
{
    [self.scrollView setContentOffset:CGPointMake(SCYLE_WIDTH * 2, 0) animated:YES];
}

#pragma mark 点击图片执行方法
- (void)clickTheCurrentImgAction:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(baseScycleScrollView:index:)])
        [self.delegate baseScycleScrollView:self index:_currentImgIndex];
}

#pragma mark 手动拖拽时响应方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.delayTimer invalidate];
    _delayTimer = nil;
}

#pragma mark 滑动结束时停止动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark 减速滑动时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int offSet = floor(scrollView.contentOffset.x);
    if (offSet == 0)
    {
        self.currentImgIndex = self.beforeImgIndex;
    }else if (offSet == SCYLE_WIDTH * 2)
    {
        self.currentImgIndex = self.nextImgIndex;
    }
    
    //更新图片位置
    [self updateScycelScrollViewImageIndex];
    
    //设置偏移量
    scrollView.contentOffset = CGPointMake(SCYLE_WIDTH, 0);
    
    //重新设置延时器
    if (_delayTimer == nil)
    {
        [self renewSetDelayTimer];
    }
}

#pragma mark 重新设置延时器
- (void)renewSetDelayTimer
{
    //添加延迟器
    self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(useTimerIntervalUpdateScrollViewContentOffSet:) userInfo:nil repeats:YES];
    //加入事件循环中
    [[NSRunLoop mainRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];
}

//上一张图片位置
- (NSUInteger)beforeImgIndex
{
    if (self.currentImgIndex == 0)
        return self.images.count - 1;
    else
        return self.currentImgIndex - 1;
}

//下一张图片的位置
- (NSInteger)nextImgIndex
{
    if (self.currentImgIndex < (self.images.count - 1))
        return self.currentImgIndex + 1;
    else
        return 0;
}

#pragma mark 设置标题
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    //添加标题
    if ([titles arrayOrOtherOfObject])
    {
        if (self.cornerRadius > 0) [self dealimageView:self.titleView];
        
        self.titleView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        self.titleLabel.frame = CGRectMake(10, 0, self.titleView.width - 15 * self.images.count  - 20  - self.leftSetX, 24);
        self.titleLabel.text = [titles objectOrNilAtIndex:_currentImgIndex];
        
    }
}

#pragma mark 设置圆点正常颜色
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

#pragma mark 设置圆点目前颜色
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

#pragma mark 小圆点显示位置
- (void)setPageAligment:(PageControlAligment)pageAligment
{
    _pageAligment = pageAligment;
    if (pageAligment == PageControlAligmentIsCenter)
        self.pageControl.center = CGPointMake(self.center.x, _pageControl.center.y);
}

#pragma mark 设置占位图片
- (void)setPlaceHolderImg:(UIImage *)placeHolderImg
{
    _placeHolderImg = placeHolderImg;
    
    if (placeHolderImg)
    {
        self.beforeImageView.image = placeHolderImg;
        self.currentImageView.image = placeHolderImg;
        self.nextImageView.image = placeHolderImg;
    }
}

- (void)setIntervalTime:(NSTimeInterval)intervalTime
{
    _intervalTime = intervalTime;
    
    //停止定时
    [self stopTimer];
    
    //重新设置定时器
    [self renewSetDelayTimer];
}

#pragma mark - 设置图片圆角
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    [self dealimageView:_beforeImageView];
    [self dealimageView:_currentImageView];
    [self dealimageView:_nextImageView];
    [self dealimageView:self.titleView];
}

- (void)dealimageView:(UIView *)view
{
    view.layer.cornerRadius = _cornerRadius;
    view.layer.masksToBounds = YES;
}

@end
