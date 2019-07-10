//
//  MyProfileViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/10/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)onEditProfile:(id)sender {
    [self performSegueWithIdentifier:@"editProfile" sender:nil];
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
