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
@property (weak, nonatomic) IBOutlet UILabel *selfIntroLabel;


@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUser];
    
}


/*
- (void) fetchmyLatest20Posts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = [posts mutableCopy];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            //[self.activityIndicator stopAnimating];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}
 */

- (void) updateUser{
    PFUser *user = [PFUser currentUser];
    self.userNameLabel.text = user.username;
    self.selfIntroLabel.text = user[@"selfIntro"];
    
    PFFileObject *profileImageFile = user[@"profileImage"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:urlString]];
}

- (IBAction)onEditProfile:(id)sender {
    [self performSegueWithIdentifier:@"editProfile" sender:nil];
}

- (void) didEditProfilewithImage: (UIImage* ) image{
    
    [self.profileImageView setImage:image];
    
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
