//
//  ADSBaseViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSBaseViewController.h"
#import "Suggestion.h"
#import "SuggestionsTableViewCell.h"

@interface ADSBaseViewController ()

@end

@implementation ADSBaseViewController

- (void)loadView
{
    [super loadView];
    // Temporary data to initialize array
    // This will actually come from the REST API instead
    
    self.suggestions = [[NSMutableArray alloc] initWithObjects:
                        [Suggestion suggestionWithUserlogin:@"alans19231"
                                             andDisplayName:@"Alan Shephard"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/31bebfb2e302d673a7ada29e4d449b78"]],
                        [Suggestion suggestionWithUserlogin:@"dekes19241"
                                             andDisplayName:@"Deke Slayton"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/d2b4119ddf895bd7e9eb2fad53396eec"]],
                        [Suggestion suggestionWithUserlogin:@"gordonc19271"
                                             andDisplayName:@"Gordon Cooper"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/9d7158527cccb23c82f065f7f572d49d"]],
                        [Suggestion suggestionWithUserlogin:@"gusg19261"
                                             andDisplayName:@"Gus Grissom"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/f02eda5a5457466a1c09008d11000a08"]],
                        [Suggestion suggestionWithUserlogin:@"johng19211"
                                             andDisplayName:@"John Glenn"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/31bebfb2e302d673a7ada29e4d449b78"]],
                        [Suggestion suggestionWithUserlogin:@"scottc19251"
                                             andDisplayName:@"Scott Carpenter"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/d2b4119ddf895bd7e9eb2fad53396eec"]],
                        [Suggestion suggestionWithUserlogin:@"wallys19231"
                                             andDisplayName:@"Wally Schirra"
                                                andImageURL:[NSURL URLWithString:@"http://s.gravatar.com/avatar/9d7158527cccb23c82f065f7f572d49d"]],
                        nil];
    
    // Create the ScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.8 blue:0.8 alpha:0.3];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.scrollView];
    
    // Pin the UISCrollView edges to the super view edges
    NSDictionary *views = @{@"scrollview": self.scrollView };    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    // Register for keyboard notifications so we can resize our view the iOS7 way
    // (so that it continues to appear underneath the semi-transparent keyboard)
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // Setup the table view
    //self.suggestionsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    //self.suggestionsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //self.suggestionsTableView.dataSource = self;
    //self.suggestionsTableView.delegate = self;
    
    //UINib *nib = [UINib nibWithNibName:@"SuggestionsTableViewCell" bundle:nil];
    //[self.suggestionsTableView registerNib:nib forCellReuseIdentifier:@"SuggestionsTableViewCell"];
    
    //[self.suggestionsTableView setTranslatesAutoresizingMaskIntoConstraints:NO]; // we will manage the layout/constraints for this subview
    
    // add the table view?
    //[self.view addSubview:self.suggestionsTableView];    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // TODO: Scroll text caret into view
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // Eventually this delegate should move up into ADSXXXViewController and that should then
    // call something like filterSuggestions(keypress, word) (see below)
    
    // Look to the "left" until we
    // 1) hit the beginning of the text (location 0)
    // 2) hit a linefeed
    // 3) hit a space
    
    NSLog(@"in ADSBaseViewController shouldChangeTextInRange: text:%@ loc:%lu len:%lu", text, (unsigned long)range.location, range.length);
    
    unsigned long currentLocation = range.location;
    bool done = false;
    NSMutableString *currentWord = [NSMutableString new];
    
    // if they just typed a space, nothing to do
    // if they just typed a line feed, fall through too
    
    if ([text isEqualToString:@" "]) {
        // fall through
    } else if ([text isEqualToString:@"\n"]) {
        // fall through
    } else {
        do {
            currentLocation--;

            if (-1 == currentLocation) {
                // we've run out of text, so we're done
                done = true;
            } else {
                // get the character at that location
                // TODO: Better handle weird characters like .-)( etc
                NSRange charRange = NSMakeRange(currentLocation, 1);
                NSString *charAtRange = [textView.text substringWithRange:charRange];
                if ([charAtRange isEqualToString:@" "]) {
                    done = true;
                } else if ([charAtRange isEqualToString:@"\n"]) {
                    done = true;
                } else {
                    [currentWord insertString:charAtRange atIndex:0];
                }
            }
        } while (!done);

        // Lastly, add whatever they just typed
        [currentWord appendString:text];
    }
    
    NSLog( @"currentChar = %@, currentWord = %@", text, currentWord);
    
    // This code should move into a separate method on ADSBaseViewController
    // which could be rewritten as a category - then ADSPostViewController and ADSCommentViewController
    // could simply call something like onContentChanged(keypress, word) to let
    // ADSBaseViewController open/update/close the suggestions view
    
    // translate this into a call to filterSuggestions(keypress, word)
    
    if ([text isEqualToString:@"@"]) {
        if ([text isEqualToString:currentWord]) {
            NSLog(@"WOULD HAVE OPENED SUGGESTIONS");
            [self showSuggestions:YES];
        }
    } else {
        if ([currentWord hasPrefix:@"@"]) {
            NSLog(@"I AM STILL IN A MENTION AND SHOULD UPDATE SUGGESTIONS");
        } else {
            NSLog(@"I SHOULD CLOSE THE SUGGESTIONS");
            [self showSuggestions:NO];
        }
    }
    
    return YES;
}

// https://github.com/slackhq/SlackTextViewController/blob/master/Source/Classes/SLKTextViewController.m

- (void)showSuggestions:(BOOL)show
{
    // CGFloat viewHeight = show ? 140.0 : 0.0;
    
    // DONT DO THIS - USE CONSTRAINTS INSTEAD
    //self.suggestionsTableView.frame = CGRectMake(0, 0, 
    //                                             CGRectGetWidth(self.view.bounds), 
    //                                            viewHeight);
    if (show) {
        //[self.view bringSubviewToFront:self.suggestionsTableView];
    } else {
        //[self.view sendSubviewToBack:self.suggestionsTableView];
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // todo : filtering
    return [self.suggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // todo : filtering
    SuggestionsTableViewCell *cell = [self.suggestionsTableView dequeueReusableCellWithIdentifier:@"SuggestionsTableViewCell" forIndexPath:indexPath];
    
    Suggestion *suggestion = nil;
    
    suggestion = [self.suggestions objectAtIndex:indexPath.row];

    cell.usernameLabel.text = @"@";
    cell.usernameLabel.text = [cell.usernameLabel.text stringByAppendingString:suggestion.userLogin];
    cell.displayNameLabel.text = suggestion.displayName;
    
    cell.imageView.image = [UIImage imageNamed:@"gravatar.png"];
    
    return cell;
}

#pragma mark - View lifecycle



- (void)dealloc
{
    self.scrollView = nil;
    
    //self.suggestionsTableView.delegate = nil;
    //self.suggestionsTableView.dataSource = nil;
    //self.suggestionsTableView = nil;
}

@end
