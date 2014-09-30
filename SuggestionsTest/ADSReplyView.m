//
//  ADSReplyView.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/30/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "ADSReplyView.h"

@interface ADSReplyView()

@property (nonatomic, retain) UITextView *replyTextView;
@property (nonatomic, strong) NSLayoutConstraint *textHConstraint;

@end

@implementation ADSReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.replyTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        self.replyTextView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.9 alpha:0.9];
        self.replyTextView.translatesAutoresizingMaskIntoConstraints = NO;
        self.replyTextView.text = @"This is a test reply.  You can edit this.\n\nAnd it even supports multi-line text.";
    
        [self addSubview:self.replyTextView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    // TODO: Use constraints instead
    CGSize frameSize = self.frame.size;
    [self.replyTextView setFrame:CGRectMake(8, 8, frameSize.width - 96, frameSize.height - 16)];
}

@end
