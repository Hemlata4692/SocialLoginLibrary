//
//  ViewController.m
//  LoginDemo
//
//  Created by Hema on 09/02/17.
//  Copyright © 2017 Ranosys. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FacebookConnect.h"
#import "GmailSignInConnect.h"
#import "TwitterLoginConnect.h"

#define myDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//google client id
#define kClientID    @"203484340022-n7i72bu9h19efaspim5cqb1fc18uvtlc.apps.googleusercontent.com"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] ---" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
@interface ViewController ()<FacebookDelegate,GIDSignInDelegate,GIDSignInUIDelegate>

@end

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - end

#pragma mark - Login with facebook
- (IBAction)loginFacebook:(id)sender {
    FacebookConnect *fbConnectObject = [[FacebookConnect alloc]init];
    fbConnectObject.delegate = self;
    [fbConnectObject facebookLoginWithReadPermission:self];
}

//facebook delegate method to fetch user data
- (void) facebookLoginWithReadPermissionResponse:(id)fbResult status:(int)status {
    if (status == 1) {
        [myDelegate stopIndicator];
        //fetched data from facebook login
        DLog(@"facebookResult is %@", fbResult);
        DLog(@"facebookUserEmailId: %@",[fbResult objectForKey:@"email"]);
        DLog(@"facebookUserId: %@",[fbResult objectForKey:@"id"]);
        DLog(@"facebookUserImage: %@",[[[fbResult objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]);
        DLog(@"facebookUserName: %@",[fbResult objectForKey:@"name"]);
        DLog(@"facebookUserBirthday: %@",[fbResult objectForKey:@"birthday"]);
        DLog(@"facebookUserFirtName: %@",[fbResult objectForKey:@"first_name"]);
        DLog(@"facebookUserLastName: %@",[fbResult objectForKey:@"last_name"]);
        DLog(@"facebookUserGender: %@",[fbResult objectForKey:@"gender"]);
        DLog(@"facebookUserFriendCount: %@",[[[fbResult objectForKey:@"friends"] objectForKey:@"summary"] objectForKey:@"total_count"]);
    }
    else {
        [myDelegate stopIndicator];
        //show alert if error occured
    }
}
#pragma mark - end

#pragma mark - Login with twitter
- (IBAction)loginTwitter:(id)sender {
    TwitterLoginConnect *twitterConnect = [[TwitterLoginConnect alloc]init];
    twitterConnect.delegate = self;
    [twitterConnect twitterLoginWithPermission:self];
}

//twitter delegate method to fetch user data
- (void)twitterLoginWithPermissions:(id)twitterResult status:(int)status {
    if (status == 1) {
        [myDelegate stopIndicator];
        //fetched data from twitter login
        DLog(@"twitterResult is %@", twitterResult);
    }
    else {
        [myDelegate stopIndicator];
        //show alert if error occured
    }
}
#pragma mark - end

#pragma mark - Login with gmail
- (IBAction)loginGmail:(id)sender {
    GmailSignInConnect *gmailConnect = [[GmailSignInConnect alloc]init];
    [GIDSignIn sharedInstance].delegate=self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [gmailConnect gmailLoginWithPermission:self NSString:kClientID];
}

//google sign in delegate to fetch user data
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)gmailResult withError:(NSError *)error {
    //logout user from gmail
    [[GIDSignIn sharedInstance] signOut];
    //fetch user data
    DLog(@"gmail userId is %@", gmailResult.userID);
    DLog(@"gmail name is %@", gmailResult.profile.name);
    DLog(@"gmail email is %@", gmailResult.profile.email);
    DLog(@"gmail has image is %d", gmailResult.profile.hasImage);
    if (gmailResult.profile.hasImage) {
        NSURL *ImageURL = [gmailResult.profile imageURLWithDimension:200];
        DLog(@"user image URL : %@",ImageURL);
    }
    DLog(@"gmail given name is %@", gmailResult.profile.givenName);
    DLog(@"gmail family name is %@", gmailResult.profile.familyName);
    DLog(@"gmail auth token is %@", gmailResult.authentication.idToken);
}
#pragma mark - end

@end
