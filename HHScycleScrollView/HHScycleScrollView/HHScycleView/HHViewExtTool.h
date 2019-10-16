//
//  SPBaseScycleTool.h
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019 胡航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//视图
@interface UIView (ViewFrameGeometry)

@property CGPoint origin;
@property CGSize size;

@property CGFloat x;
@property CGFloat y;
@property CGFloat centerX;
@property CGFloat centerY;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end

@interface NSArray(composeType)

/*
* 是否是数组类型
*
*/
- (BOOL)arrayOrOtherOfObject;

/*
* 返回位于索引处的对象，或在超出界限时返回nil。
* 它类似于' objectAtIndex: '，但它抛出异常。
*
* index 索引位于index的对象。
*/
- (id)objectOrNilAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
