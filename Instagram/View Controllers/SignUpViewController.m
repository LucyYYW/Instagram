//
//  SignUpViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "Post.h"


@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) UIAlertController *alert;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"All fields should be non-empty!"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [self.alert addAction:okAction];
    
}
- (IBAction)tapOutside:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didSignUp:(id)sender {
    
    [self registerUser];
}
- (IBAction)didNeedLogIn:(id)sender {
    [self performSegueWithIdentifier:@"signuplogin" sender:nil];
}


- (void)registerUser {
    
    if ([self.userNameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""] || [self.emailField.text isEqualToString:@""]) {
        [self presentViewController:self.alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.userNameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    

    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            PFUser *user = [PFUser currentUser];
            user[@"profileImage"] = [Post getPFFileFromImage:[UIImage imageNamed:@"profilePlaceholder"] withName:@"profileImage"];
            user[@"selfIntro"] = @"This user hasn't ";
            [user saveInBackground];
            //manually segue to logged in view
            [self performSegueWithIdentifier:@"signuplogin" sender:nil];
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
