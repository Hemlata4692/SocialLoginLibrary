//
//  TwitterLoginConnect.h
//  SocialLogin
//
//  Created by Hema on 16/02/17.
//  Copyright © 2017 Ranosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@protocol TwitterDelegate <NSObject>
@optional
- (void)twitterLoginWithPermissions:(id)twitterResult status:(int)status;
@end


@interface TwitterLoginConnect : NSObject{
    id <TwitterDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
- (void)twitterLoginWithPermission:(UIViewController *)selfVC;

@end
