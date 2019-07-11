//
//  PostCell.h
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCell.h"

@protocol PostCellDetailsDelegate;


NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic)  Post * _Nonnull post;

@property (nonatomic, weak) id<PostCellDetailsDelegate> detailDelegate;
@end

@protocol PostCellDetailsDelegate
-(void) didTapDetailsOnCell: (PostCell *) cell;
@end

NS_ASSUME_NONNULL_END
