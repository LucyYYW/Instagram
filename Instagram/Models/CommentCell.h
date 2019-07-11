//
//  CommentCell.h
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commenterImageView;

@property (weak, nonatomic) IBOutlet UILabel *commentTextLabel;


@end

NS_ASSUME_NONNULL_END
