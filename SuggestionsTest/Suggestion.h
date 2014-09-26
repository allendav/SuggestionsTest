//
//  Suggestion.h
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Suggestion : NSObject

@property (nonatomic, strong) NSString *userLogin;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSURL *imageURL;

+ (id)suggestionWithUserlogin:(NSString*)userLogin
               andDisplayName:(NSString *)displayName
                  andImageURL:(NSURL *)imageURL;

@end