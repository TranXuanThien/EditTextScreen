//
//  ViewController.m
//  ExerciseEditing
//
//  Created by SarkozyTran on 2/22/16.
//  Copyright © 2016 SarkozyTran. All rights reserved.
//

#import "EEEditingViewController.h"

#define FONT_SIZE_SMALL 15
#define FONT_SIZE_MEDIUM 20
#define FONT_SIZE_LARGE 25

@interface EEEditingViewController ()<UITextViewDelegate>
{
    NSRange rangeParagraph;
}

@end

@implementation EEEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load tool bar custom
    self.textView.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"EEToolBarCustom" owner:self options:nil] firstObject];
    
    // set init data for text view
    self.textView.text = @"con cua con ca\ncon ga con meo\ncon heo con bo";
    
    // init attribute for uitextview
    self.textView.textColor = [UIColor blackColor];
    self.textView.textAlignment = NSTextAlignmentLeft;
}

#pragma mark set font size for text
- (IBAction)setFontSize:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    // get current attribute of cursor location
    NSDictionary *dic = [self.textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];
    
    CGFloat fontSize;
    
    // change font size small - medium - large
    if ([dic[NSFontAttributeName] isEqual:[UIFont systemFontOfSize:FONT_SIZE_MEDIUM]]) {
        fontSize = FONT_SIZE_LARGE;
    } else if ([dic[NSFontAttributeName] isEqual:[UIFont systemFontOfSize:FONT_SIZE_LARGE]]) {
        fontSize = FONT_SIZE_SMALL;
    } else {
        fontSize = FONT_SIZE_MEDIUM;
    }
    
    // add attribute font size for paragraph
    [self.textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

#pragma mark set alignment for text
- (IBAction)setAlignment:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    // get current attribute of cursor location
    NSDictionary *dic = [self.textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];

    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    
    // change alignment left - center - right
    if ([[dic objectForKey:NSParagraphStyleAttributeName] alignment] == 2) {
        [paragrahStyle setAlignment:0];
    } else {
        [paragrahStyle setAlignment:[[dic objectForKey:NSParagraphStyleAttributeName] alignment] + 1];
    }

    // add attribute alignment for paragraph
    [self.textView.textStorage addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

#pragma mark set color for text
- (IBAction)setColor:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    // get current attribute of cursor location
    NSDictionary *dic = [self.textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];
    
    // color of cursor location
    UIColor *currentColor = [dic objectForKey:NSForegroundColorAttributeName];
    
    // new color to set color for paragraph
    UIColor *newColor;

    // change color black - green - brown
    if ([currentColor isEqual:[UIColor blackColor]]) {
        newColor = [UIColor greenColor];
    } else if ([currentColor isEqual:[UIColor greenColor]]) {
        newColor = [UIColor brownColor];
    } else {
        newColor = [UIColor blackColor];
    }

    // add attribute color for paragraph
    [self.textView.textStorage addAttribute:NSForegroundColorAttributeName value:newColor range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

#pragma mark get range of paragraph
- (NSRange)detectParagraph:(NSUInteger)location {
    
    // get paragraphs in UITextView
    NSArray *paragraphs = [self.textView.text componentsSeparatedByString:@"\n"];
    
    NSRange range;
    for (int i = 0; i < paragraphs.count; i++) {
        if (location >= [self.textView.text rangeOfString:paragraphs[i]].location) {
            if (i + 1 < paragraphs.count) {
                if (location <= [self.textView.text rangeOfString:paragraphs[i + 1]].location) {
                    range = [self.textView.text rangeOfString:paragraphs[i]];
                }
            } else {
                range = [self.textView.text rangeOfString:paragraphs[i]];
            }
        }
    }
    return range;
}

#pragma mark get cursor location
- (void) getCursorLocation:(UITextView *)inView {
    rangeParagraph = [self detectParagraph:inView.selectedRange.location];
}

@end
