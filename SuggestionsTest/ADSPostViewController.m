//
//  ADSPostViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSPostViewController.h"

@interface ADSPostViewController ()

@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;


@end

@implementation ADSPostViewController

- (void)loadView
{
    [super loadView];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    self.textView.text = @"Type things that look like @mentions and then look in XCode's logs.\n\nSuggestion table view not hooked up yet.";
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    [self.textView setTranslatesAutoresizingMaskIntoConstraints:NO]; // we will manage the layout/constraints for this subview
    
    NSDictionary *views = @{@"textView": self.textView,
                            };
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[textView]-16@250-|" options:0 metrics:nil views:views]]; // V:|-75-[textView]-16@250-| <-- change 16 to 0 for flush
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.view addConstraint:self.bottomConstraint];
    
    // TODO: Get the nav bar height and adjust the top constraint appropriately
    
    // TODO: MAnage the textView's bottom constraint based on whether the keyboard is showing
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Post UX";
    [self observeKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    
    
    [super updateViewConstraints];
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    //NSDictionary *info = [notification userInfo];
    //NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //CGRect keyboardFrame = [kbFrame CGRectValue];
    
    //BOOL isPortrait = UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    //CGFloat height = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;
    //NSLog(@"The keyboard height is: %f", height);
        
    //NSLog(@"Updating constraints.");
    //self.keyboardHC.constant = -height;
    
    //[self.view setNeedsUpdateConstraints];
    
    //[UIView animateWithDuration:animationDuration animations:^{
    //    [self.view layoutIfNeeded];
    //}];
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    self.bottomConstraint.constant = newFrame.origin.y - CGRectGetHeight(self.view.frame) - 16 /* get rid of -16 for flush */;
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    //NSDictionary *info = [notification userInfo];
    //NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //self.keyboardHC.constant = 0;
    
    //[self.view setNeedsUpdateConstraints];
    
    //[UIView animateWithDuration:animationDuration animations:^{
    //    [self.view layoutIfNeeded];
    //}];
    
    self.bottomConstraint.constant = -16; // make 0 for flush, -16 for gap when keyboard closed
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
}

@end
