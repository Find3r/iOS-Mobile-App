//
//  LoginViewController.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "F3RFacebookUser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginFacebook:(id)sender {
    NSLog(@"Btn Click");
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    [client loginWithProvider:@"facebook" controller:self animated:YES completion:^(MSUser *user, NSError *error) {
       
        // se realiza el login
        [client invokeAPI:@"userlogin"
            body:nil
            HTTPMethod:@"GET"
            parameters:nil
            headers:nil
            completion:
                ^(NSDictionary *result,
                    NSHTTPURLResponse *response,
                    NSError *error)
            {
                if(error) { // error is nil if no error occured
                    NSLog(@"ERROR %@", error);
                }
                else
                {
                       
                    F3RFacebookUser *user = [[F3RFacebookUser alloc] init];
                       
                    for (NSString *key in result) {
                        if ([user respondsToSelector:NSSelectorFromString(key)]) {
                            [user setValue:[result valueForKey:key] forKey:key];
                        }
                    }
                
                    NSLog(@"%@",user.name);
                       
                }
                   
                   
            }];

    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
