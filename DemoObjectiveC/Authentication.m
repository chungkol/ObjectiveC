//
//  Authentication.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/24/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "Authentication.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "AFNetwokingManager.h"
@interface Authentication ()<GIDSignInUIDelegate, GIDSignInDelegate>

@end

@implementation Authentication

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signOut];

}
- (IBAction)hanldeButton:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
            //do somtihng
            [self loginWithFacebook];
        case 102:
            [[GIDSignIn sharedInstance] signIn];
        case 104:
            [self testAPI];
        default:
            break;
    }
    
}
- (void) testAPI {
    AFNetwokingManager *manager = [[AFNetwokingManager alloc] init];
    [manager request:@"http://itunes.apple.com/search?media=music&entity=song&term=swift" param:nil header:nil completion:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSLog(@"data %@" , result);

        }else {
            NSLog(@"error %@" , error);
        }
    }];
}
//MARK: login with facebook
- (void) loginWithFacebook {
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (!error) {
            if (result.isCancelled) {
                NSLog(@"%@" , @"cancel");
            }else {
                if ([result.grantedPermissions containsObject:@"email"])
                {
                    NSLog(@"result is:%@",result);
                    [self getFacebookUserData];
                }
            }
        }else {
            NSLog(@"Facebook login error: %@" , error);
        }
    }];
}
- (void) getFacebookUserData {

    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);

        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name, picture.type(large), email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
    }
}
//MARK: login with google
-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error) {
        NSLog(@"error %@", error );
    }else {
        NSLog(@"user %@", user.profile );

    }
}
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated: YES completion:nil];
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"disconect %@", error );
}
//extension AccountViewController: GIDSignInDelegate, GIDSignInUIDelegate {
//    //google
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            print("error \(error.localizedDescription)")
//            return
//        }else {
//            let userId = user.userID// For client-side use only!
//            let fullName = user.profile.name
//            let email = user.profile.email
//            let image = user.profile.imageURL(withDimension: 100)
//            
//            print(userId)
//            print(fullName)
//            print(email)
//            print(image)
//            self.showActivity(isShow: true)
//            ManagerData.instance.loginSocial(username: userId!, password: "", email: email!, phone: "", type_user: 0, type_login: 2, displayname: fullName!, success: { (msg) in
//                self.showAlert(msg: "đăng ký tài khoản \(msg.displayname) thành công \n ")
//            },fail: { msg in
//                self.showAlert(msg: msg)
//            })
//        }
//    }
//    func signIn(signIn: GIDSignIn!,
//                presentViewController viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//        
//    }
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        //        myActivityIndicator.stopAnimating()
//    }
//    
//    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        print("dimiss")
//        self.dismiss(animated: true, completion: nil)
//        
//    }
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        print("diddisconnect")
//    }
//    
//    func autoLoginGoogle() {
//        GIDSignIn.sharedInstance().signInSilently()
//    }
//}

@end
