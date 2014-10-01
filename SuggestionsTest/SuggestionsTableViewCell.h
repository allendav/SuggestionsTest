//
//  SuggestionsTableViewCell.h
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionsTableViewCell : UITableViewCell
{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *displayNameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end
