//
//  PostCell.m
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImageView setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    // TODO: Call method on delegate
    [self.delegate didTapUserProfilePic:self.post.author];
    
}

- (IBAction)onTapDetailsBtn:(id)sender {
    [self.delegate didTapDetailsOnCell:self];
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
    
    [self refreshCellView];
}


- (IBAction)onTapComment:(id)sender {
}

- (void) refreshCellView {
    self.userNameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    NSURL *url = [NSURL URLWithString:self.post.image.url];
    [self.postImageView setImageWithURL:url];
    
    PFFileObject *userProfileFile = self.post.author[@"profileImage"];
    NSURL *url2 = [NSURL URLWithString:userProfileFile.url];
    [self.profileImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ ago",self.post.createdAt.shortTimeAgoSinceNow];
    
    
    NSString *likeText = [NSString stringWithFormat:@"%i like",[self.post.likeCount intValue]];
    if ([self.post.likeCount intValue] > 1) {
        likeText = [likeText stringByAppendingString:@"s"];
    }
    NSString *commentText = [NSString stringWithFormat:@"  %i comment", [self.post.commentCount intValue]];
    if ([self.post.commentCount intValue] > 1) {
        commentText = [commentText stringByAppendingString:@"s"];
    }
    
    self.likeLabel.text = [likeText stringByAppendingString:commentText];
        
    
    
    
}



@end
