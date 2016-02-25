//
//  EEProcessParagraph.m
//  ExerciseEditing
//
//  Created by SarkozyTran on 2/25/16.
//  Copyright © 2016 SarkozyTran. All rights reserved.
//

#import "EEProcessParagraph.h"
#import "Enums.h"

@implementation EEProcessParagraph

+ (NSRange)detectParagraph:(NSUInteger)location inView:(UITextView *)textView {
    
    // get paragraphs in UITextView
    NSArray *paragraphs = [textView.text componentsSeparatedByString:@"\n"];
    
    NSRange range;
    for (int i = 0; i < paragraphs.count; i++) {
        if (location >= [textView.text rangeOfString:paragraphs[i]].location) {
            if (i + 1 < paragraphs.count) {
                if (location <= [textView.text rangeOfString:paragraphs[i + 1]].location) {
                    range = [textView.text rangeOfString:paragraphs[i]];
                }
            } else {
                range = [textView.text rangeOfString:paragraphs[i]];
            }
        }
    }
    return range;
}

#pragma mark get cursor location
+ (NSRange) getCursorLocation:(UITextView *)inView {
    return [self detectParagraph:inView.selectedRange.location inView:inView];
}

- (void) setFontSizeParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView {
    // get current attribute of cursor location
    NSDictionary *dic = [textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];
    
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
    [textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

- (void) setAlignmentParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView {
    // get current attribute of cursor location
    NSDictionary *dic = [textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    
    // change alignment left - center - right
    if ([[dic objectForKey:NSParagraphStyleAttributeName] alignment] == 2) {
        [paragrahStyle setAlignment:0];
    } else {
        [paragrahStyle setAlignment:[[dic objectForKey:NSParagraphStyleAttributeName] alignment] + 1];
    }
    
    // add attribute alignment for paragraph
    [textView.textStorage addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

- (void) setColorParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView {
    // get current attribute of cursor location
    NSDictionary *dic = [textView.textStorage attributesAtIndex:rangeParagraph.location effectiveRange:nil];
    
    // color of cursor location
    UIColor *currentColor = [dic objectForKey:NSForegroundColorAttributeName];
    
    // new color to set color for paragraph
    UIColor *newColor;
    
    // change color black - green - brown
    if ([currentColor isEqual:FONT_COLOR_FIRST]) {
        newColor = FONT_COLOR_SECOND;
    } else if ([currentColor isEqual:FONT_COLOR_SECOND]) {
        newColor = FONT_COLOR_THIRD;
    } else {
        newColor = FONT_COLOR_FIRST;
    }
    
    // add attribute color for paragraph
    [textView.textStorage addAttribute:NSForegroundColorAttributeName value:newColor range:NSMakeRange(rangeParagraph.location, rangeParagraph.length)];
}

@end
