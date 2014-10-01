//
//  ADSBaseViewController.h
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Suggestion.h"

@interface ADSBaseViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, atomic) NSString *searchText;
@property (strong, atomic) NSMutableArray *suggestions;
@property (strong, atomic) NSMutableArray *searchResults;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *suggestionsTableView;

- (void)showSuggestions:(BOOL)show;

@end
