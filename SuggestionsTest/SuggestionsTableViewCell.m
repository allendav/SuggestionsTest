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
        
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor colorWithRed:0 green:0.737 blue:0.961 alpha:1.0]];
        [_usernameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [_usernameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:_usernameLabel];

        _displayNameLabel = [[UILabel alloc] init];
        [_displayNameLabel setTextColor:[UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.0]];
        [_displayNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]];
        [_displayNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        _displayNameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_displayNameLabel];

        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"gravatar.png"];
        [_avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:_avatarImageView];

        NSDictionary *views = @{@"contentview": self.contentView,
                                @"username": _usernameLabel,
                                @"displayname": _displayNameLabel,
                                @"avatar": _avatarImageView };
        
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
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_usernameLabel
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:0]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_displayNameLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView
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
