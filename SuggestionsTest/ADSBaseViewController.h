//
//  ADSBaseViewController.h
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSBaseViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *suggestionsTableView;
@property (strong, nonatomic) NSMutableArray *suggestions;

@end
