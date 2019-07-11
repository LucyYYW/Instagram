//
//  PostCollectionCell.h
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
