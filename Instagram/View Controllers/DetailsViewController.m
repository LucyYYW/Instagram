//
//  DetailsViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDetailsView];
}

- (void) setDetailsView {
    //self.profileImageView
    self.userNameLabel.text = self.post.author.username;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm  yyyy-MM-dd";
    self.dateLabel.text = [formatter stringFromDate:self.post.createdAt];
    
    [self.postImageView setImageWithURL:[NSURL URLWithString:self.post.image.url]];
    
    self.captionLabel.text = self.post.caption;
    
    self.likeLabel.text = [NSString stringWithFormat:@"%i likes",[self.post.likeCount intValue]];
     
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
