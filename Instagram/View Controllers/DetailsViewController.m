//
//  DetailsViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//
#import "Parse/Parse.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "OtherProfileViewController.h"
#import "CommentViewController.h"

@interface DetailsViewController ()

@property (strong,nonatomic) NSArray* comments;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImageView setUserInteractionEnabled:YES];
    
    [self setDetailsView];
}

- (void) setDetailsView {
    //self.profileImageView
    self.userNameLabel.text = self.post.author.username;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm  yyyy-MM-dd";
    self.dateLabel.text = [formatter stringFromDate:self.post.createdAt];
    
    [self.postImageView setImageWithURL:[NSURL URLWithString:self.post.image.url]];
    
    self.captionLabel.text = self.post.caption;
    
    self.likeLabel.text = [NSString stringWithFormat:@"%i like",[self.post.likeCount intValue]];
    
    PFFileObject *userProfileFile = self.post.author[@"profileImage"];
    NSURL *url2 = [NSURL URLWithString:userProfileFile.url];
    [self.profileImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]];
    
    if (![self.post[@"likedBy"] containsObject:[PFUser currentUser].objectId]) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeWhite.png"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"likeREd.png"] forState:UIControlStateNormal];
        if ([self.post.likeCount intValue] > 1) {
            self.likeLabel.text = [self.likeLabel.text stringByAppendingString:@"s"];
        }
    }
     
}
- (IBAction)onTapLike:(id)sender {
    UIButton *likebtn = (UIButton *)sender;
    
    if (![self.post[@"likedBy"] containsObject:[PFUser currentUser].objectId])
    {
        [likebtn setImage:[UIImage imageNamed:@"likeREd"] forState:UIControlStateNormal];
        NSMutableArray *temp = [self.post[@"likedBy"] mutableCopy];
        [temp addObject:[PFUser currentUser].objectId];
        NSArray *temp2 = [NSArray arrayWithArray:temp];
        self.post[@"likedBy"] = temp2;
        self.post.likedBy = temp2;
        self.post.likeCount = [NSNumber numberWithInt:([self.post.likeCount intValue] + 1)];
        [self.post saveInBackground];
        
    }
    else
    {
        [likebtn setImage:[UIImage imageNamed:@"likeWhite"] forState:UIControlStateNormal];
        NSMutableArray *temp = [self.post[@"likedBy"] mutableCopy];
        [temp removeObject:[PFUser currentUser].objectId];
        NSArray *temp2 = [NSArray arrayWithArray:temp];
        self.post[@"likedBy"] = temp2;
        self.post.likedBy = temp2;
        self.post.likeCount = [NSNumber numberWithInt:([self.post.likeCount intValue] - 1)];
        [self.post saveInBackground];
    }
    
    self.likeLabel.text = [NSString stringWithFormat:@"%i like",[self.post.likeCount intValue]];
    if ([self.post.likeCount intValue] > 1) {
        self.likeLabel.text = [self.likeLabel.text stringByAppendingString:@"s"];
    }
    
    [self.postCell refreshCellView];
    [self.tableView reloadData];
}


- (IBAction)onTapComment:(id)sender {
    [self performSegueWithIdentifier:@"detailComment" sender:self.post];
}


- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self performSegueWithIdentifier:@"detailToUserProfile" sender:self.post.author];
}

- (void) didGetComment {
    NSLog(@"didGetComment");
}

- (void) fetchLatest20Comments {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query whereKey:@"postID" equalTo:self.post.objectId];
    
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.comments = [posts mutableCopy];
            //[self.commentTableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailToUserProfile"]){
        OtherProfileViewController *otherController = [segue destinationViewController];
        otherController.user = sender;
        
    } else if ([segue.identifier isEqualToString:@"detailComment"]) {
        UINavigationController *navigation = [segue destinationViewController];
        CommentViewController *commentController = (CommentViewController*)navigation.topViewController;
        commentController.post = sender;
        commentController.delegate = self;
    }
}


@end
