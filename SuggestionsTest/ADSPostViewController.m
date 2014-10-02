//
//  ADSPostViewController.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSPostViewController.h"

@interface ADSPostViewController ()

@property (nonatomic, retain) UITextView *postView;
@property (nonatomic, strong) NSLayoutConstraint *textHConstraint;

@end

@implementation ADSPostViewController

- (void)loadView
{
    [super loadView];
    
    // Create the TextView
    self.postView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.postView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    self.postView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.postView.text = @"Lorem ipsum \n\n \
        This is meant to simulate a post \n\n \
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce scelerisque massa eu vulputate ullamcorper. Ut ante ex, \
        tristique vel dolor consequat, pretium imperdiet urna. Curabitur pulvinar erat eu dignissim volutpat. Suspendisse id tellus \
        ut augue tempus dapibus vel in eros. Nullam semper pulvinar magna finibus aliquam. Vivamus ultricies in orci quis cursus. \
        Suspendisse potenti. Morbi maximus vitae urna nec suscipit. Donec tempor euismod dapibus. Sed at dui vitae tellus venenatis \
        dignissim eu interdum turpis. Nulla molestie, tellus sed aliquam rhoncus, neque mi accumsan mi, vel consectetur ante lorem \
        sed odio. Curabitur pretium cursus dolor, at laoreet dui aliquam at. Sed pharetra eros sit amet porta mattis. Donec nec \
        suscipit leo. Nam orci erat, venenatis id urna laoreet, sodales interdum enim.\n\n \
        Fusce commodo ex neque, quis consequat quam porta ut. Suspendisse vel nulla nec massa laoreet tincidunt eu vitae quam. Ut \
        eget tincidunt ex. Mauris rutrum, risus at suscipit convallis, lectus nulla volutpat ante, in rutrum sem felis et \
        nisl. Vivamus nisl tellus, bibendum id viverra ac, accumsan ut dolor. Nam ullamcorper libero diam. Proin quis neque in \
        neque ultricies euismod et at eros. Morbi pretium in sapien a auctor.\n\n \
        Nullam rutrum volutpat sapien, vel pellentesque tortor venenatis vitae. Donec ut pretium ante, vel consectetur est. Mauris \
        hendrerit orci in nisl aliquet, id semper sapien auctor. Duis quis augue vel augue consequat commodo. Interdum et malesuada \
        fames ac ante ipsum primis in faucibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque in \
        velit sit amet ornare. \n\n \
        Sed tincidunt ullamcorper vestibulum. Praesent eget augue dui. Vestibulum eu dictum ipsum, non scelerisque libero. Fusce \
        ut mauris magna. Integer vitae fringilla nisi, at fringilla sapien. Vivamus eget auctor lorem. Maecenas convallis nibh at \
        mi lacinia, eu commodo arcu tristique. Duis rutrum nibh sed metus suscipit vestibulum. \n\n \
        Type things that look like @mentions and then look in XCode's logs.\n\n \
        Suggestion table view not hooked up yet. \n\n \
        This is the end of the post.";

    self.postView.delegate = self;
    [self.scrollView addSubview:self.postView];
    [self addPostViewConstraints];
}

-(void)addPostViewConstraints
{
    // Pin the UITextView edges to the UIScrollView edges
    NSDictionary *views = @{@"textview": self.postView };    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];

    // The UITextView must have at least a width defined, so we pin it to the scrollView width
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.postView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:0]];

    // Lastly, add a height constraint reference so we can update the constraint
    // as the text grows/shrinks
    self.textHConstraint = [NSLayoutConstraint constraintWithItem:self.postView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:100.0f];
    
    [self.postView addConstraint:self.textHConstraint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Post UX";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize sizeThatShouldFitTheContent = [self.postView sizeThatFits:self.postView.frame.size];
    self.textHConstraint.constant = sizeThatShouldFitTheContent.height;
    [self.view layoutIfNeeded];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab what they picked
    Suggestion *suggestion = [self.searchResults objectAtIndex:indexPath.row];
    
    // Grow the selection by the length of the searchText
    NSRange selectionRange = self.postView.selectedRange;
    selectionRange.location -= (self.searchText.length);
    selectionRange.length += (self.searchText.length);
    self.postView.selectedRange = selectionRange;
    [self.postView replaceRange:[self.postView selectedTextRange] withText:suggestion.userLogin];    
    
    // Hide the suggestions view - we're done with it
    [self showSuggestions:NO];
}

@end
