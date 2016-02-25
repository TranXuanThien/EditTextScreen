//
//  EEProcessParagraph.h
//  ExerciseEditing
//
//  Created by SarkozyTran on 2/25/16.
//  Copyright © 2016 SarkozyTran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define FONT_COLOR_FIRST [UIColor blackColor]
#define FONT_COLOR_SECOND [UIColor greenColor]
#define FONT_COLOR_THIRD [UIColor brownColor]

@interface EEProcessParagraph : NSObject

/*!
 @abstract Get range of paragraph in uitextview
 @return range of paragraph.
 */
+ (NSRange)detectParagraph:(NSUInteger)location inView:(UITextView *)textView;

/*!
 @abstract Get current cursor location in paragraph
 @return Value current cursor location.
 */
+ (NSRange) getCursorLocation:(UITextView *)inView;

/*!
 @abstract Set font-size for paragraph
 */
- (void) setFontSizeParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView;

/*!
 @abstract Set alignment for paragraph
 */
- (void) setAlignmentParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView;

/*!
 @abstract Set color for paragraph
 */
- (void) setColorParagraph:(NSRange)rangeParagraph inView:(UITextView *)textView;

@end
