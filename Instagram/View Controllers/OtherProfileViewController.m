//
//  OtherProfileViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "OtherProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"
#import "PostCollectionCell.h"

@interface OtherProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *userPosts;

@end

@implementation OtherProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self generateUserInfo];
}

- (void) generateUserInfo {
    self.userNameLabel.text = self.user.username;
    self.bioLabel.text = self.user[@"selfIntro"];
    
    PFFileObject *profileImageFile = self.user[@"profileImage"];
    NSString *urlString = profileImageFile.url;
    [self.profileImageVIew setImageWithURL:[NSURL URLWithString:urlString]];
    
    [self fetchUserLatest20Posts];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OtherPostCollectionCell" forIndexPath:indexPath];
    Post *post = self.userPosts[indexPath.item];
    
    NSURL *url = [NSURL URLWithString:post.image.url];
    [cell.postImageView setImageWithURL:url];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.userPosts.count;
}


- (void) fetchUserLatest20Posts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query whereKey:@"author" equalTo:self.user];
    
    //query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.userPosts = [posts mutableCopy];
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
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
