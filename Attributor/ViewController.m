//
//  ViewController.m
//  Attributor
//
//  Created by deast on 1/1/15.
//  Copyright (c) 2015 Firebase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
  [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                value:sender.backgroundColor
                                range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender
{
  [self.body.textStorage addAttributes:@{
                                         NSStrokeWidthAttributeName: @-3,
                                         NSStrokeColorAttributeName: [UIColor blackColor]
                                         }
                                 range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(UIButton *)sender
{
  [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                   range:self.body.selectedRange];
}

@end
