//
//  DetailsViewController.h
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostCell.h"
#import "CommentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <CommentDetailDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) PostCell *postCell;
@property (strong, nonatomic) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
