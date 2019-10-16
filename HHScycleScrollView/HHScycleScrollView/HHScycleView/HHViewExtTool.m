//
//  SPBaseScycleTool.m
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019 胡航. All rights reserved.
//

#import "HHViewExtTool.h"

CGPoint CGRectGetCenter(CGRect rect){
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center){
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewFrameGeometry)

#pragma mark - 检索并设置原点
- (CGPoint) origin{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

#pragma mark - 检索并设置大小
- (CGSize) size{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

#pragma mark - 查询其他的位置
- (CGPoint) bottomRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

#pragma mark - 检索和设置高度，宽度，顶部，底部，左，右
- (CGFloat) height{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

#pragma mark - 移动偏移
- (void) moveBy: (CGPoint) delta{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

#pragma mark - 缩放
- (void) scaleBy: (CGFloat) scaleFactor{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

#pragma mark - 通过缩小尺寸，确保两个维度都符合给定的大小
- (void) fitInSize: (CGSize) aSize{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height)){
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width)){
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

@end

@implementation  NSArray(composeType)

- (BOOL)arrayOrOtherOfObject
{
    if ([self isKindOfClass:[NSArray class]] && [self count] > 0)
        return YES;
    else
        return NO;
}

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    if ([self arrayOrOtherOfObject])
    {
        return index < self.count ? self[index] : nil;
    }else
    {
        return nil;
    }
}

@end

