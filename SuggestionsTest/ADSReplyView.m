//
//  ADSReplyView.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/30/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSReplyView.h"

@interface ADSReplyView()

@property (nonatomic, strong) NSLayoutConstraint *textHConstraint;

@end

@implementation ADSReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.replyTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        // style it similar to the WP iOS app
        self.replyTextView.backgroundColor = [UIColor whiteColor];
        [self.replyTextView.layer setBorderColor:[[UIColor colorWithRed:0.639 green:0.725 blue:0.792 alpha:1.0] CGColor]];
        [self.replyTextView.layer setBorderWidth:1];
        self.replyTextView.layer.cornerRadius = 6;
        self.replyTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.replyTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
        self.replyTextView.text = @"This is a test reply.  You can edit this.\n\nAnd it even supports multi-line text.";
    
        [self addSubview:self.replyTextView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    // TODO: Use constraints instead
    CGSize frameSize = self.frame.size;
    [self.replyTextView setFrame:CGRectMake(8, 8, frameSize.width - 64, frameSize.height - 16)];
}

@end
