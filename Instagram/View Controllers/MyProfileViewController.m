//
//  MyProfileViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/10/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "MyProfileViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

@interface MyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUser];
    
}

- (void) updateUser{
    PFUser *user = [PFUser currentUser];
    self.userNameLabel.text = user.username;
    
    PFFileObject *profileImageFile = user[@"imageProfile"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]];
}

- (IBAction)onEditProfile:(id)sender {
    [self performSegueWithIdentifier:@"editProfile" sender:nil];
}

- (void) didEditProfile{
    [self updateUser];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"editProfile"]) {
        EditProfileViewController *editController = [segue destinationViewController];
        editController.delegate = self;
    }
}


@end
