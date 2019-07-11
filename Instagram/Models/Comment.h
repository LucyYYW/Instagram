//
//  Comment.h
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString  * _Nonnull postID;
@property (nonatomic, strong) PFUser  * _Nonnull author;
@property (nonatomic, strong) NSString  * _Nonnull commentText;

+ (void)commentPost: (NSString * _Nullable )id withText: ( NSString * _Nullable ) commentText withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
