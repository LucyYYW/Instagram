//
//  EditProfileViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/10/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


/*
@property (weak, nonatomic) NSString *usernameOriginal;
@property (weak, nonatomic) NSString *imageURLOriginal;
*/
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *user = [PFUser currentUser];
    self.userNameField.placeholder = user.username;
    //self.usernameOriginal = user.username;
    
    PFFileObject *profileImageFile = user[@"imageProfile"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]];
    //self.imageURLOriginal = urlString;
    
    
    
}
- (IBAction)onChangeProfieImage:(id)sender {
}
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onSave:(id)sender {
    PFUser *user = [PFUser currentUser];
    user.username = self.userNameField.text;
    //user[@"profilePlaceholder"] = ***
    [user saveInBackground];
    [self.delegate didEditProfile];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapOutside:(id)sender {
    [self.view endEditing:YES];
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
