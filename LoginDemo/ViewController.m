//
//  ViewController.m
//  LoginDemo
//
//  Created by Hema on 09/02/17.
//  Copyright © 2017 Ranosys. All rights reserved.
//

#import "ViewController.h"
#import "FacebookConnect.h"
#import "AppDelegate.h"

#define myDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] ---" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
@interface ViewController ()<FacebookDelegate>

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

//facebook delegate method
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
}
#pragma mark - end

- (IBAction)loginGmail:(id)sender {
}
#pragma mark - end

@end
