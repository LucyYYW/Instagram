//
//  LoginViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) UIAlertController *alert;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                     message:@"Invalid username or password mismatch."
                                              preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [self.alert addAction:okAction];
    
}
- (IBAction)didTapOutside:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didLogIn:(id)sender {
    [self loginUser];
}
- (IBAction)needSIgnUp:(id)sender {
    [self performSegueWithIdentifier:@"loginsignup" sender:nil];
}

- (void)loginUser {
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self presentViewController:self.alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
            
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"gethome" sender:nil];
        }
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
