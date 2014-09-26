//
//  ADSCommentViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSCommentViewController.h"

@interface ADSCommentViewController ()

@end

@implementation ADSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Comment UX";

    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    self.textView.text = @"I haven't finished this yet.\n\nCome back later.";
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
