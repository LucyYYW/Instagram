//
//  HomeTimelineViewController.h
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTimelineViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,ComposeViewControllerDelegate /*,UITableViewDelegate, UITableViewDataSource*/>

@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIImage *editedImage;

@end

NS_ASSUME_NONNULL_END
