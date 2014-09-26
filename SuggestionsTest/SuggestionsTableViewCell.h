//
//  SuggestionsTableViewCell.h
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
