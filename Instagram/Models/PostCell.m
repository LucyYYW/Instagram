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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (IBAction)onTapDetailsBtn:(id)sender {
    [self.detailDelegate didTapDetailsOnCell:self];
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
    
    if (![self.post[@"likedBy"] containsObject:[PFUser currentUser].objectId]) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeWhite.png"] forState:UIControlStateNormal];
        
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"likeREd.png"] forState:UIControlStateNormal];
        
    }
    self.likeLabel.text = [NSString stringWithFormat:@"%i like",[self.post.likeCount intValue]];
    
}
@end
