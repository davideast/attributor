//
//  ViewController.m
//  Attributor
//
//  Created by deast on 1/1/15.
//  Copyright (c) 2015 Firebase. All rights reserved.
//

#import "ViewController.h"
#import "TextStatsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  NSMutableAttributedString *title =
  [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
  
  [title setAttributes:@{
                         NSStrokeWidthAttributeName: @-3,
                         NSStrokeColorAttributeName: self.outlineButton.tintColor
                         }range:NSMakeRange(0, [title length])];
  [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // set font prefs on appear
  [self usePreferredFonts];
  
  // listen for when the fonts change
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self
             selector:@selector(preferredFontsChanged:)
                 name:UIContentSizeCategoryDidChangeNotification
               object:nil];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
  // stop listening when view disappears
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification
{
  [self usePreferredFonts];
}

- (void)usePreferredFonts
{
  self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
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

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"PushStats"]) {
    if([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]) {
      TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
      tsvc.textToAnalyze = self.body.attributedText;
    }
  }
}

@end
