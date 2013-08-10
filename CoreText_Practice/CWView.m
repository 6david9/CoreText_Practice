//
//  CWView.m
//  CoreText_Practice
//
//  Created by ly on 8/10/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "CWView.h"

@implementation CWView

#ifndef DRAW_TEXT
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _myStr = [[NSAttributedString alloc] initWithString:@"klajsdlfjasdlfjalsdfjkalsdkfjlaskdfjlasdjflasjdflasdjfkasjdfkajsdfjkaskdfjajdfkalsdjflasjdfkajsdlfkjadsfklj"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _myStr = [[NSAttributedString alloc] initWithString:@"人类能否在木卫二“欧罗巴”星球上生活？来自美国宇航局的专家认为这颗木星具有较大的“宜居”潜力，未来可能适合人类居住。下一步，科学家将发射探测器对 木卫二的冰下海洋进行调查，确定其厚度和分布情况，有研究认为木卫二的海洋可能与地球相似，也具有一定的盐度。美国宇航局喷气推进实验室博士罗伯特·帕帕 拉多认为派遣探测器降落木卫二表面是一个非常有远见的行星科学目标，同时也是一个困难的技术挑战。\n\nasdfasdf"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.myStr);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [self.myStr length]),
                                                CGPathCreateWithRect(CGRectMake(0, 0, 320, 400), &CGAffineTransformIdentity),
                                                NULL);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -400);
    
    CTFrameDraw(frame, context);
}
#else
/* Callbacks */
void MyDeallocationCallback( void* refCon ){
    
}
CGFloat MyGetAscentCallback( void *refCon ){
    return 10.0;
}
CGFloat MyGetDescentCallback( void *refCon ){
    return 4.0;
}
CGFloat MyGetWidthCallback( void* refCon ){
    return 125;
}

- (void)drawRect:(CGRect)rect {
    // create an attributed string
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:@"This is my delegate space"];
    
    // create the delegate
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.dealloc = MyDeallocationCallback;
    callbacks.getAscent = MyGetAscentCallback;
    callbacks.getDescent = MyGetDescentCallback;
    callbacks.getWidth = MyGetWidthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, NULL);
    
    // set the delegate as an attribute
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attrString, CFRangeMake(19, 1), kCTRunDelegateAttributeName, delegate);
    
    // create a frame and draw the text
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrString.length),
                                                CGPathCreateWithRect(CGRectMake(0, 0, 320, 400),
                                                &CGAffineTransformIdentity), NULL);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSetTextPosition(context, 0.0, 0.0);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -400);
    
    CTFrameDraw(frame, context);
}
#endif

@end
