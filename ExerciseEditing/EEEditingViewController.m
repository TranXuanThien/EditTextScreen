//
//  ViewController.m
//  ExerciseEditing
//
//  Created by SarkozyTran on 2/22/16.
//  Copyright © 2016 SarkozyTran. All rights reserved.
//

#import "EEEditingViewController.h"

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
}

#pragma mark set font size for text
- (IBAction)setFontSize:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    // add attribute font size for paragraph
    [self.textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

#pragma mark set alignment for text
- (IBAction)setAlignment:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setAlignment:NSTextAlignmentRight];
    
    // add attribute alignment for paragraph
    [self.textView.textStorage addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

#pragma mark set color for text
- (IBAction)setColor:(id)sender {
    
    // get current cursor location
    [self getCursorLocation:self.textView];
    
    // add attribute color for paragraph
    [self.textView.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
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
