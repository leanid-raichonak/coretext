//
//  ViewController.m
//  coretext
//
//  Created by Leonid on 28.02.13.
//  Copyright (c) 2013 Leonid. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

#define LoremIpsum @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla pharetra eleifend iaculis. Vivamus dictum adipiscing pretium. Phasellus orci lacus, dictum non placerat et, auctor non libero. Fusce at sapien nibh. Morbi diam nulla, posuere eu ornare id, vehicula ut justo. Curabitur molestie luctus sapien at rhoncus. Ut vel diam eu nisl pharetra porta eleifend eget risus.\nSed sagittis, lacus eu tempor aliquet, tellus ante tempus nulla, euismod imperdiet ante metus in nibh. Suspendisse pharetra cursus imperdiet. Duis a dui dui. Vestibulum vehicula hendrerit dapibus. Sed lobortis mi non leo ullamcorper consectetur. Mauris in sapien vel mi fermentum adipiscing. Proin eget accumsan dui."

//#define Example_0
//#define Example_1
//#define Example_2
//#define Example_3
//#define Example_4
//#define Example_5
//#define Example_6
//#define Example_7
//#define Example_8
#define Example_9

@implementation CoreTextView

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
#ifdef Example_0
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    [attributedString drawInRect:rect];
#endif
    
#ifdef Example_1
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    [attributedString drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
#endif
    
#ifdef Example_2
    
    CTParagraphStyleSetting paragraphSettings[] = (CTParagraphStyleSetting[]){
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(float_t), (float_t[]){ 40.0f } },
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierHeadIndent, sizeof(float_t), (float_t[]){ 20.0f } },
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierParagraphSpacing, sizeof(float_t), (float_t[]){ 30.0f } }
    };
    id paragraphStyle = (__bridge_transfer id)CTParagraphStyleCreate(paragraphSettings, sizeof(paragraphSettings) / sizeof(paragraphSettings[0]));
    
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:14],
                                     (NSString *)kCTKernAttributeName : @(3.0),
                                     (NSString *)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle),
                                     (NSString *)kCTParagraphStyleAttributeName : paragraphStyle};
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CTFrameDraw(textFrame, context);
#endif
    
#ifdef Example_3
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CTFrameDraw(textFrame, context);
#endif
    
#ifdef Example_4
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(path, NULL, (CGRect){CGPointZero, CGSizeMake(suggestedSize.width, suggestedSize.height / 2)});
    CGPathAddEllipseInRect(path, NULL, (CGRect){0, suggestedSize.height / 2, CGSizeMake(suggestedSize.width, suggestedSize.height / 2)});
    
    NSDictionary *frameAttributes = @{(NSString *)kCTFramePathFillRuleAttributeName : @(kCTFramePathFillEvenOdd)};
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, (__bridge CFDictionaryRef)frameAttributes);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CTFrameDraw(textFrame, context);
    CFRelease(path);
#endif
    
#ifdef Example_5
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGAffineTransform t1 = CGAffineTransformMakeRotation(M_PI_4);
    CGPathAddEllipseInRect(path, &t1, CGRectMake(20, -200, 400, 130));
    CGPathAddRect(path, &t1, CGRectMake(50, -150, 200, 200));
    
    NSDictionary *frameAttributes = @{(NSString *)kCTFramePathFillRuleAttributeName : @(kCTFramePathFillWindingNumber)};
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, (__bridge CFDictionaryRef)frameAttributes);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CTFrameDraw(textFrame, context);
    CFRelease(path);
#endif
    
#ifdef Example_6
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformMakeRotation(M_PI_4));
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CTFrameDraw(textFrame, context);
#endif
    
#ifdef Example_7
    CTParagraphStyleSetting paragraphSettings[] = (CTParagraphStyleSetting[]){
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(float_t), (float_t[]){ 20.0f } }
    };
    id paragraphStyle = (__bridge_transfer id)CTParagraphStyleCreate(paragraphSettings, sizeof(paragraphSettings) / sizeof(paragraphSettings[0]));
    
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16], (NSString *)kCTParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:LoremIpsum attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);

    CFArrayRef lines = CTFrameGetLines(textFrame);
    for (CFIndex i = 0, linesCount = CFArrayGetCount(lines); i < linesCount; ++i) {
        CGPoint lineOrigin = CGPointZero;
        CTFrameGetLineOrigins(textFrame, CFRangeMake(i, 1), &lineOrigin);
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
        CTLineDraw(CFArrayGetValueAtIndex(lines, i), context);
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(CFArrayGetValueAtIndex(lines, i), &ascent, &descent, &leading);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y);
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y + ascent);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y + ascent);
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y - descent);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y - descent);
        CGContextStrokePath(context);
    }
#endif
    
#ifdef Example_8
    CTParagraphStyleSetting paragraphSettings[] = (CTParagraphStyleSetting[]){
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(float_t), (float_t[]){ 20.0f } }
    };
    id paragraphStyle = (__bridge_transfer id)CTParagraphStyleCreate(paragraphSettings, sizeof(paragraphSettings) / sizeof(paragraphSettings[0]));
    
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16], (NSString *)kCTParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"First text האוניברסיטה העברית בירושלים\nsecond test line" attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CFArrayRef lines = CTFrameGetLines(textFrame);
    for (CFIndex i = 0, linesCount = CFArrayGetCount(lines); i < linesCount; ++i) {
        CGPoint lineOrigin = CGPointZero;
        CTFrameGetLineOrigins(textFrame, CFRangeMake(i, 1), &lineOrigin);
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
        CTLineDraw(CFArrayGetValueAtIndex(lines, i), context);
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(CFArrayGetValueAtIndex(lines, i), &ascent, &descent, &leading);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y);
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y + ascent);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y + ascent);
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, 0, lineOrigin.y - descent);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), lineOrigin.y - descent);
        CGContextStrokePath(context);
    }
#endif
    
#ifdef Example_9
    CTParagraphStyleSetting paragraphSettings[] = (CTParagraphStyleSetting[]){
        (CTParagraphStyleSetting){ kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(float_t), (float_t[]){ 20.0f } }
    };
    id paragraphStyle = (__bridge_transfer id)CTParagraphStyleCreate(paragraphSettings, sizeof(paragraphSettings) / sizeof(paragraphSettings[0]));
    
    NSDictionary *textAttributes = @{(NSString *)kCTFontAttributeName : [UIFont systemFontOfSize:16], (NSString *)kCTParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"First text האוניברסיטה העברית בירושלים\nsecond test line" attributes:textAttributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX), NULL);
    
    CGPathRef path = CGPathCreateWithRect((CGRect){CGPointZero, suggestedSize}, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -suggestedSize.height);
    
    CFArrayRef lines = CTFrameGetLines(textFrame);
    for (CFIndex i = 0, linesCount = CFArrayGetCount(lines); i < linesCount; ++i) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGPoint lineOrigin = CGPointZero;
        CTFrameGetLineOrigins(textFrame, CFRangeMake(i, 1), &lineOrigin);
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
        
        CFArrayRef glyphRuns = CTLineGetGlyphRuns(line);
        for (CFIndex j = 0, runsCount = CFArrayGetCount(glyphRuns); j < runsCount; ++j) {
            
            CTRunRef run = CFArrayGetValueAtIndex(glyphRuns, j);
            CGPoint runOrigin = CGPointZero;
            CTRunGetPositions(run, CFRangeMake(0, 1), &runOrigin);
            
            CTRunDraw(run, context, CFRangeMake(0, 0));
            
            CGFloat ascent, descent, leading;
            double width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
                        
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextMoveToPoint(context, runOrigin.x, runOrigin.y + lineOrigin.y);
            CGContextAddLineToPoint(context, runOrigin.x + width, runOrigin.y + lineOrigin.y);
            CGContextStrokePath(context);
            
            CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
            CGContextMoveToPoint(context, runOrigin.x, runOrigin.y + lineOrigin.y + ascent);
            CGContextAddLineToPoint(context, runOrigin.x + width, runOrigin.y + lineOrigin.y + ascent);
            CGContextStrokePath(context);
            
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
            CGContextMoveToPoint(context, runOrigin.x + lineOrigin.x, runOrigin.y + lineOrigin.y - descent);
            CGContextAddLineToPoint(context, runOrigin.x + width, runOrigin.y + lineOrigin.y - descent);
            CGContextStrokePath(context);
        }
    }
#endif
    
    CGContextRestoreGState(context);
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
