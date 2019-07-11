//
//  Comment.m
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@dynamic postID;
@dynamic author;
@dynamic commentText;


+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (void)commentPost: (NSString * _Nullable )id withText: ( NSString * _Nullable ) commentText withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Comment *newComment = [Comment new];
    newComment.postID = id;
    newComment.author = [PFUser currentUser];
    newComment.commentText = commentText;
    
    [newComment saveInBackgroundWithBlock: completion];
}





@end
