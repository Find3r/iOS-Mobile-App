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
#import <SSKeychain.h>
#import <SSKeychainQuery.h>
#import "F3RLastPostViewController.h"

@interface F3RLoginViewController ()
{
    MSClient *client;
}
@end

@implementation F3RLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{

    
    
     [super viewDidAppear:animated];

    /*
    // se llama la función que carga las credenciales
    // devuelve true si existen false caso contrario
    // en caso que no existan entonces realizamos el login
    if ([self loadAuthInfo])
    {
       
        // mostramos el segue
        [self performSegueWithIdentifier:@"lastPost" sender:self];

    }
   
    */
    
}



- (IBAction)loginFacebook:(id)sender {
    NSLog(@"Btn Click");
    
    
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
                 
                 // salvamos los datos
                 [self saveAuthInfo];
                 
                 // mostramos el segue
                 [self performSegueWithIdentifier:@"lastPost" sender:self];
                 
             }
             
         }];
        
    }];
    
}


- (void) saveAuthInfo {
    [SSKeychain setPassword:client.currentUser.mobileServiceAuthenticationToken forService:@"find3r" account:client.currentUser.userId];
}


- (BOOL)loadAuthInfo {
    NSString *userid = [[SSKeychain accountsForService:@"find3r"][0] valueForKey:@"acct"];
    if (userid) {
        NSLog(@"userid: %@", userid);
        client.currentUser = [[MSUser alloc] initWithUserId:userid];
        client.currentUser.mobileServiceAuthenticationToken = [SSKeychain passwordForService:@"find3r" account:userid];
       
        
        return YES;
    }
    
    return NO;
}


@end
