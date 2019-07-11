//
//  CommentViewController.h
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommentDetailDelegate

- (void) didGetComment;

@end

@interface CommentViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) Post *post;

@property (nonatomic, weak) id<CommentDetailDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
