//
//  ADSPostViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSPostViewController.h"

@interface ADSPostViewController ()

@end

@implementation ADSPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Post UX";

    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    self.textView.text = @"Type things that look like @mentions and then look in XCode's logs.\n\nSuggestion table view not hooked up yet.";
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
