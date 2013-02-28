//
//  ViewController.m
//  coretext
//
//  Created by Leonid on 28.02.13.
//  Copyright (c) 2013 Leonid. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@implementation CoreTextView

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSDictionary *attributes = @{[UIFont systemFontOfSize:16] : (NSString *)kCTFontAttributeName};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Hello" attributes:attributes];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    
    CGPathRef path = CGPathCreateWithRect(self.frame, NULL);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), path, NULL);
    CFRelease(path);
    
    CTFrameDraw(textFrame, UIGraphicsGetCurrentContext());
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
