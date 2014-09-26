//
//  Suggestion.m
//  SuggestionsTest
//
//  Created by Allen Snook on 9/25/14.
//  Copyright (c) 2014 Automattic. All rights reserved.
//

#import "Suggestion.h"

@implementation Suggestion

+ (id)suggestionWithUserlogin:(NSString*)userLogin
               andDisplayName:(NSString *)displayName
                  andImageURL:(NSURL *)imageURL
{    
    Suggestion *newSuggestion = [[self alloc] init];
    
    newSuggestion.userLogin = userLogin;
    newSuggestion.displayName = displayName;
    newSuggestion.imageURL = imageURL;
    
    return newSuggestion;
}

@end
