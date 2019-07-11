//
//  DetailsViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    if ([self.post.likeCount intValue] == 0) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeWhite.png"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"likeREd.png"] forState:UIControlStateNormal];
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
    
    [self.postCell refreshCellView];
    [self.tableView reloadData];
}


- (IBAction)onTapComment:(id)sender {
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
