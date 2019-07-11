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
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *user = [PFUser currentUser];
    self.userNameField.placeholder = user.username;
    
    PFFileObject *profileImageFile = user[@"imageProfile"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]];
    
}
- (IBAction)onChangeProfieImage:(id)sender {
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
