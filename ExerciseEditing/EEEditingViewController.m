//
//  ViewController.m
//  ExerciseEditing
//
//  Created by SarkozyTran on 2/22/16.
//  Copyright © 2016 SarkozyTran. All rights reserved.
//

#import "EEEditingViewController.h"
#import "EEProcessParagraph.h"

@interface EEEditingViewController ()<UITextViewDelegate>
{
    NSRange rangeParagraph;
    EEProcessParagraph *processParagraph;
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
    
    processParagraph = [[EEProcessParagraph alloc] init];
}

#pragma mark set font size for text
- (IBAction)setFontSize:(id)sender {
    
    // get range of paragraph at current cursor location
    rangeParagraph = [EEProcessParagraph getCursorLocation:self.textView];
    
    // add attribute font size for paragraph
    [processParagraph setFontSizeParagraph:rangeParagraph inView:self.textView];
}

#pragma mark set alignment for text
- (IBAction)setAlignment:(id)sender {
    
    // get range of paragraph at current cursor location
    rangeParagraph = [EEProcessParagraph getCursorLocation:self.textView];
    
    // set alignment for paragraph
    [processParagraph setAlignmentParagraph:rangeParagraph inView:self.textView];
}

#pragma mark set color for text
- (IBAction)setColor:(id)sender {
    
    // get range of paragraph at current cursor location
    rangeParagraph = [EEProcessParagraph getCursorLocation:self.textView];
    
    // add attribute color for paragraph
    [processParagraph setColorParagraph:rangeParagraph inView:self.textView];
}

@end
