//
//  ADSBaseViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSBaseViewController.h"
#import "SuggestionsTableViewCell.h"

@interface ADSBaseViewController ()

@end

@implementation ADSBaseViewController

- (void)loadView
{
    [super loadView];
    // Temporary data to initialize array
    // This will actually come from the REST API instead
    
    self.searchText = @"";
    
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
    
    // Initial state
    self.searchResults = [self.suggestions mutableCopy];
    
    // Add the ScrollView and its constraints
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.8 blue:0.8 alpha:0.3];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    [self addScrollViewConstraints];
    
    // Add the suggestions view and its constraints
    self.suggestionsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.suggestionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.suggestionsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.suggestionsTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.suggestionsTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    self.suggestionsTableView.contentMode = UIViewContentModeBottom;
    self.suggestionsTableView.dataSource = self;
    self.suggestionsTableView.delegate = self;
    
    [self.suggestionsTableView registerClass:[SuggestionsTableViewCell class] forCellReuseIdentifier:@"SuggestionsTableViewCell"];
    
    //UINib *nib = [UINib nibWithNibName:@"SuggestionsTableViewCell" bundle:nil];
    //[self.suggestionsTableView registerNib:nib forCellReuseIdentifier:@"SuggestionsTableViewCell"];
    [self.view addSubview:self.suggestionsTableView];
    [self addSuggestionsViewConstraints];
    [self showSuggestions:NO];
}

-(void)addScrollViewConstraints
{
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

- (void)addSuggestionsViewConstraints
{
    // Pin the suggestions view left and right edges to the super view edges
    NSDictionary *views = @{@"suggestionsview": self.suggestionsTableView };    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[suggestionsview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    // Pin the suggestions view top and bottom to the super view top and bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[suggestionsview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];    
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
                // TODO: Better handle characters like .-)( etc
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
    
    [self filterSuggestionsForKeyPress:text inWord:currentWord];
    
    return YES;
}

-(void)filterSuggestionsForKeyPress:(NSString *)keypress inWord:(NSString *)word
{
    // This code should move into a separate method on ADSBaseViewController
    // which could be rewritten as a category - then ADSPostViewController and ADSCommentViewController
    // could simply call something like onContentChanged(keypress, word) to let
    // ADSBaseViewController open/update/close the suggestions view
    
    // translate this into a call to filterSuggestions(keypress, word)
    
    if ([keypress isEqualToString:@"@"]) {
        if ([keypress isEqualToString:word]) {
            [self updateSearchResultsForText:@""];
            [self.suggestionsTableView reloadData];
            [self showSuggestions:YES];
        }
    } else {
        if ([word hasPrefix:@"@"]) {
            [self updateSearchResultsForText:[word substringFromIndex:1]];
            [self.suggestionsTableView reloadData];
            [self showSuggestions:YES];
        } else {
            [self updateSearchResultsForText:@""];
            [self.suggestionsTableView reloadData];
            [self showSuggestions:NO];
        }
    }
}


- (void)updateSearchResultsForText:(NSString *)text
{
    // Save how we got here
    self.searchText = text;
    
    if (0 == text.length) {
        self.searchResults = [self.suggestions mutableCopy];
    } else {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(displayName contains[c] %@) OR (userLogin contains[c] %@)",
                                        text, text];
        self.searchResults = [[self.suggestions filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    }
}
             
- (void)showSuggestions:(BOOL)show
{
    if (show) {
        self.suggestionsTableView.hidden = NO;
        [self.view bringSubviewToFront:self.suggestionsTableView];
    } else {
        [self updateSearchResultsForText:@""];
        self.suggestionsTableView.hidden = YES;
        [self.view sendSubviewToBack:self.suggestionsTableView];
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestionsTableViewCell *cell = [self.suggestionsTableView dequeueReusableCellWithIdentifier:@"SuggestionsTableViewCell" forIndexPath:indexPath];    
    Suggestion *suggestion = nil;
    
    suggestion = [self.searchResults objectAtIndex:indexPath.row];        
    
    cell.usernameLabel.text = @"@";
    cell.usernameLabel.text = [cell.usernameLabel.text stringByAppendingString:suggestion.userLogin];
    cell.displayNameLabel.text = suggestion.displayName;
    cell.avatarImageView.image = [UIImage imageNamed:@"gravatar.png"]; // TODO actual gravatar
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Child classes should override this method to do something with the 
    // selected suggestion.
    
    // The child class implementation should then call showSuggestions:NO when it is done
    // with its unique logic to hide the suggestions view and reset the search results, ala
    [self showSuggestions:NO];
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
