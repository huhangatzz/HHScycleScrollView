//
//  HHBaseScycleScrollView.h
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019年 胡航. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PageControlAligment)
{
    PageControlAligmentIsCenter = 0,//圆点显示中间
    PageControlAligmentIsRight      //圆点显示右边
};

@class HHBaseScycleScrollView;
@protocol BaseScycleScrollViewDelegate <NSObject>

- (void)baseScycleScrollView:(HHBaseScycleScrollView *)scyleView index:(NSInteger)index;

@end

@interface HHBaseScycleScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame imageW:(CGFloat)imageW leftX:(CGFloat)leftX;

/** 图片数组(先加载图片数组,否则圆点位置会无效) */
@property (nonatomic,strong)NSArray *images;

/** 占位图片 */
@property (nonatomic,strong)UIImage *placeHolderImg;

/** 标题数组 */
@property (nonatomic,strong)NSArray *titles;

/** 延迟时间 */
@property (nonatomic,assign)NSTimeInterval intervalTime;

/** 目前这张图片 */
@property (nonatomic,strong)UIImageView *currentImageView;

/** 目前图片位置 */
@property (nonatomic,assign)NSInteger currentImgIndex;

/** 圆点位置 */
@property (nonatomic,assign)PageControlAligment pageAligment;

/** 图片圆角,当有间距时可以使用 */
@property (nonatomic,assign)CGFloat cornerRadius;

/** 目前页时小圆点显示的颜色 */
@property (nonatomic,strong)UIColor *currentPageIndicatorTintColor;

/** 小圆点正常时候的颜色,默认白色 */
@property (nonatomic,strong)UIColor *pageIndicatorTintColor;

/** 协议 */
@property (nonatomic,assign)id<BaseScycleScrollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
