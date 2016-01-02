//
//  F3RLoginViewController.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RLoginViewController.h"
#import "AppDelegate.h"
#import "F3RFacebookUser.h"

@interface F3RLoginViewController ()

@end

@implementation F3RLoginViewController

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
                 
                 for (NSString *key in result) {
                     if ([F3RFacebookUser.user respondsToSelector:NSSelectorFromString(key)]) {
                         [F3RFacebookUser.user setValue:[result valueForKey:key] forKey:key];
                     }
                 }
                 
                 NSLog(@"%@",F3RFacebookUser.user.name);
                 
                 // mostramos el segue
                 [self performSegueWithIdentifier:@"lastPost" sender:self];
                 
             }
             
         }];
        
    }];
}


@end
