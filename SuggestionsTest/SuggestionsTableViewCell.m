//
//  SuggestionsTableViewCell.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "SuggestionsTableViewCell.h"

@implementation SuggestionsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        
        self.usernameLabel = [[UILabel alloc] init];
        [self.usernameLabel setTextColor:[UIColor colorWithRed:0 green:0.737 blue:0.961 alpha:1.0]];
        [self.usernameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [self.usernameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.usernameLabel];

        self.displayNameLabel = [[UILabel alloc] init];
        [self.displayNameLabel setTextColor:[UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.0]];
        [self.displayNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]];
        [self.displayNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.displayNameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.displayNameLabel];

        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.image = [UIImage imageNamed:@"gravatar.png"];
        [self.avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.avatarImageView];

        NSDictionary *views = @{@"contentview": self.contentView,
                                @"username": self.usernameLabel,
                                @"displayname": self.displayNameLabel,
                                @"avatar": self.avatarImageView };
        
        // Horizontal spacing
        NSArray *horizConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[avatar(32)]-16-[username]-[displayname]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:views];
        [self.contentView addConstraints:horizConstraints];
        
        // Vertical height constraint
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentview(==48)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        
        // Vertically constrain centers of each element
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:0]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.displayNameLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0]];

        
    }
    return self;
}

@end
