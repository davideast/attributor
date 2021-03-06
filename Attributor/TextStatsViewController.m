//
//  TextStatsViewController.m
//  Attributor
//
//  Created by deast on 1/2/15.
//  Copyright (c) 2015 Firebase. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  // if someone updates the UI while I'm not on screen
  // check for the window in the case that the outlets are set
  if (self.view.window)[self updateUI];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
  _textToAnalyze = textToAnalyze;
  [self updateUI];
}

- (void)updateUI
{
  self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)[[self charactersWithAttributeName:NSForegroundColorAttributeName] length]];
  self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", (unsigned long)[[self charactersWithAttributeName:NSStrokeWidthAttributeName] length]];
  
}

- (NSAttributedString *)charactersWithAttributeName:(NSString *)attributeName
{
  NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
  
  unsigned long index = 0;
  
  while (index < [self.textToAnalyze length]) {
    NSRange range;
    id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
    if (value) {
      [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
      index = range.location + range.length; // jump to the end of the range
    } else {
      // the attribute was not set move on
      index++;
    }
  }
  
  
  return characters;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
