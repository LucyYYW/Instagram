//
//  ComposeViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "ComposeViewController.h"
#import "HomeTimelineViewController.h"
#import "UITextView+Placeholder.h"
#import "Post.h"

@interface ComposeViewController () <UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoVIew.image = self.photo;
    
    self.wordView.delegate = self;
    // Do any additional setup after loading the view.
    self.wordView.placeholder = @"Write a caption...";
    self.wordView.placeholderColor = [UIColor lightGrayColor]; // optional
    
    
}

- (IBAction)onTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion: nil];
}


- (IBAction)onTapPost:(id)sender {
    [Post postUserImage:self.photo withCaption:self.wordView.text withCompletion:^(BOOL succeeded, NSError *_Nullable error) {
        if (error != nil) {
            NSLog(@"User post failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User posted successfully");
            [self.delegate didShare];
        }
    }];
    [self dismissViewControllerAnimated:true completion: nil];
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
