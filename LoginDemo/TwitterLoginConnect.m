//
//  TwitterLoginConnect.m
//  SocialLogin
//
//  Created by Hema on 16/02/17.
//  Copyright © 2017 Ranosys. All rights reserved.
//

#import "TwitterLoginConnect.h"
#import "AppDelegate.h"

#define myDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@implementation TwitterLoginConnect

#pragma mark - Twitter login methods
- (void)twitterLoginWithPermission:(UIViewController *)selfVC {
    [[Twitter sharedInstance] logInWithMethods:TWTRLoginMethodWebBased completion:^(TWTRSession *session, NSError *error) {
        if (session) {
            [myDelegate showIndicator];
            [self getUserData:[session userID]];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}

//fetch user data from twitter
- (void)getUserData:(NSString *)userId {
    TWTRAPIClient *client = [[TWTRAPIClient alloc]  initWithUserID:userId];
    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                     URL:@"https://api.twitter.com/1.1/account/verify_credentials.json"
                                              parameters:@{@"include_entities":@"false",@"include_email": @"true", @"skip_status": @"true"}
                                                   error:nil];
    
    [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            [_delegate twitterLoginWithPermissions:jsonArray status:1];
        }
    }];
    //logout user
    [[[Twitter sharedInstance] sessionStore] logOutUserID:userId];
}
#pragma mark - end
@end
