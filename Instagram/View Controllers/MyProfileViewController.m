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
#import "PostCollectionCell.h"

@interface MyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *selfIntroLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *myPosts;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1))/ postersPerLine;
    CGFloat itemHeight = itemWidth;
     
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
     
    
    
    // Do any additional setup after loading the view.
    [self updateUser];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    Post *post = self.myPosts[indexPath.item];
    
    NSURL *url = [NSURL URLWithString:post.image.url];
    [cell.postImageView setImageWithURL:url];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.myPosts.count;
}



- (void) fetchmyLatest20Posts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    
    //query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.myPosts = [posts mutableCopy];
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}


- (void) updateUser{
    PFUser *user = [PFUser currentUser];
    self.userNameLabel.text = user.username;
    self.selfIntroLabel.text = user[@"selfIntro"];
    
    PFFileObject *profileImageFile = user[@"profileImage"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:urlString]];
    
    [self fetchmyLatest20Posts];
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
