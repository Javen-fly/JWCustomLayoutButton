//
//  JWCustomLayoutButton.m
//  JWCustomLayoutButtonDemo
//
//  Created by 吴建文 on 2018/1/10.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWCustomLayoutButton.h"
typedef NS_ENUM(NSInteger,JWIconPositionType) {
    JWIconPositionTypeLeft = 0,
    JWIconPositionTypeRight,
    JWIconPositionTypeTop,
    JWIconPositionTypeBottom
};

@interface JWCustomLayoutButton()
{
    JWIconPositionType type;
    CGFloat speace;
}


@end

@implementation JWCustomLayoutButton


/** 图片在左，标题在右 */
- (void)setIconInLeft
{
    [self setIconInLeftWithSpacing:0.f];
}
/** 图片在右，标题在左 */
- (void)setIconInRight
{
    [self setIconInRightWithSpacing:0.f];
}
/** 图片在上，标题在下 */
- (void)setIconInTop
{
    [self setIconInTopWithSpacing:0.f];
}
/** 图片在下，标题在上 */
- (void)setIconInBottom
{
    [self setIconInBottomWithSpacing:0.f];
}

//** 可以自定义图片和标题间的间隔 */
- (void)setIconInLeftWithSpacing:(CGFloat)Spacing
{
    type = JWIconPositionTypeLeft;
    speace = Spacing;
}
- (void)setIconInRightWithSpacing:(CGFloat)Spacing
{
    type = JWIconPositionTypeRight;
    speace = Spacing;
}
- (void)setIconInTopWithSpacing:(CGFloat)Spacing
{
    type = JWIconPositionTypeTop;
    speace = Spacing;
}
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing
{
    type = JWIconPositionTypeBottom;
    speace = Spacing;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentSize = self.bounds.size;
    
    //获取imageView,titleLabel的大小
    CGSize imageViewSize = self.imageView.bounds.size;
    CGSize titleLabelSize = self.titleLabel.bounds.size;
    
    //计算实际文本、图片的大小
    CGSize textSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.titleLabel.font}
                                                         context:nil].size;
    CGSize imageSize = self.imageView.image.size;
    
    CGSize textframeSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    CGSize imageframeSize = CGSizeMake(ceilf(imageSize.width), ceilf(imageSize.height));
    
    //分情况判断
    switch (type) {
        case JWIconPositionTypeTop:
        {
            //图上文下
            CGFloat totalHeight = (imageViewSize.height + textframeSize.height + speace);
            
            //宽度足够
            if (contentSize.width >= imageframeSize.width && contentSize.width >= textframeSize.width) {
                if (contentSize.height >= totalHeight) {
                    //高度都足够
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < totalHeight && contentSize.height >= (totalHeight - speace))
                {
                    //高度不足，但是高度大于等于image高度与title高度的和
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < (totalHeight - speace))
                {
                    //高度不足，并且高度小于等于image高度与title高度的和,但是大于image的高度
                    CGFloat totalContentHeight = totalHeight - speace;
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalContentHeight * 2 - titleLabelSize.height - totalHeight), 0);
                    self.titleLabel.hidden = _textOverflowHidden;
                }
            }
            
            //宽度大于图片宽度，小于文字宽度
            else if (contentSize.width >= imageframeSize.width && contentSize.width < textframeSize.width)
            {
                if (contentSize.height >= totalHeight) {
                    //高度都足够
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < totalHeight && contentSize.height >= (totalHeight - speace))
                {
                    //高度不足，但是高度大于等于image高度与title高度的和
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < (totalHeight - speace))
                {
                    //高度不足，并且高度小于等于image高度与title高度的和,但是大于image的高度
                    CGFloat totalContentHeight = totalHeight - speace;
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, - textframeSize.width);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageViewSize.width, - (totalContentHeight * 2 - titleLabelSize.height - totalHeight), 0);
                    self.titleLabel.hidden = _textOverflowHidden;
                }
            }
            
            //宽度大于图片宽度
            else if (contentSize.width < imageframeSize.width )//&& contentSize.width >= textframeSize.width)
            {
                if (contentSize.height >= totalHeight) {
                    //高度都足够
                    self.imageView.bounds = CGRectMake(0, 0, contentSize.width, imageframeSize.height);
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, 0.0);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageframeSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < totalHeight && contentSize.height >= (totalHeight - speace))
                {
                    //高度不足，但是高度大于等于image高度与title高度的和
                    self.imageView.bounds = CGRectMake(0, 0, contentSize.width, imageframeSize.height);
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, 0.0);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageframeSize.width, - (totalHeight - titleLabelSize.height), 0);
                }
                else if(contentSize.height < (totalHeight - speace))
                {
                    //高度不足，并且高度小于等于image高度与title高度的和,但是大于image的高度
                    CGFloat totalContentHeight = totalHeight - speace;
                    CGFloat imageH = imageframeSize.height > contentSize.height?contentSize.height:imageframeSize.height;
                    self.imageView.bounds = CGRectMake(0, 0, contentSize.width, imageH);
                    totalHeight = contentSize.height;
                    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageViewSize.height), 0.0, 0.0, 0.0);
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageframeSize.width, - (totalContentHeight * 2 - titleLabelSize.height - totalHeight), 0);
                    self.titleLabel.hidden = _textOverflowHidden;
                }
            }
            
        }
            break;
        case JWIconPositionTypeRight:
        {
            CGFloat totalWidth = textframeSize.width + imageframeSize.width + speace;
            CGFloat originalWidth = titleLabelSize.width + imageViewSize.width;
            if (contentSize.width >= totalWidth) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(originalWidth/2-imageViewSize.width + totalWidth/2)*2);
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(originalWidth/2 - (textframeSize.width - totalWidth/2))*2, 0.0, 0.0);
            }
            
        }
            break;
        case JWIconPositionTypeLeft:
        {
            CGFloat totalWidth = textframeSize.width + imageframeSize.width + speace;
            //            CGFloat originalWidth = titleLabelSize.width + imageViewSize.width;
            if (contentSize.width >= totalWidth) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -speace, 0.0, 0.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -speace);
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

//autolayout 没有设置宽高时，展示的大小
- (CGSize)intrinsicContentSize
{
    CGSize textSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.titleLabel.font}
                                                         context:nil].size;
    CGSize imageSize = self.imageView.image.size;
    
    CGFloat textW = ceilf(textSize.width);
    CGFloat textH = ceilf(textSize.height);
    CGFloat imageW = ceilf(imageSize.width);
    CGFloat imageH = ceilf(imageSize.height);
    
    switch (type) {
        case JWIconPositionTypeLeft:case JWIconPositionTypeRight:
        {
            CGFloat totalW = textW + imageW + speace;
            CGFloat height = textH > imageH?textH:imageH;
            return CGSizeMake(totalW, height);
        }
        case JWIconPositionTypeTop:case JWIconPositionTypeBottom:
        {
            CGFloat width = textW > imageW?textW:imageW;
            CGFloat totalHeight = textH + imageH + speace;
            return CGSizeMake(width, totalHeight);
        }
        default:
            break;
    }
    return [super intrinsicContentSize];
}

@end
