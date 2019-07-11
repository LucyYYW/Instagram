//
//  EditProfileViewController.h
//  Instagram
//
//  Created by lucyyyw on 7/10/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol editedProfile

- (void) didEditProfilewithImage: (UIImage* ) image;

@end

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) id<editedProfile> delegate;
@end



NS_ASSUME_NONNULL_END
