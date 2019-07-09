//
//  ComposeViewController.h
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didShare:(Post *)post;

@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoVIew;
@property (weak, nonatomic) IBOutlet UITextView *wordView;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *photo;
@end

NS_ASSUME_NONNULL_END
