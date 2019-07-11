//
//  CommentViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/11/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "CommentViewController.h"
#import "UITextView+Placeholder.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.commentTextView.delegate = self;
    // Do any additional setup after loading the view.
    self.commentTextView.placeholder = [NSString stringWithFormat:@"Reply to %@ here", self.post.author.username];
    self.commentTextView.placeholderColor = [UIColor lightGrayColor]; // optional
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)onReply:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
