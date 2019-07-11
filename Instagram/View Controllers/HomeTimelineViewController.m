//
//  HomeTimelineViewController.m
//  Instagram
//
//  Created by lucyyyw on 7/8/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "PFFileObject.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "InfiniteScrollActivityView.h"
#import "DateTools.h"
#import "OtherProfileViewController.h"



@interface HomeTimelineViewController ()

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeTimelineViewController
InfiniteScrollActivityView* loadingMoreView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isMoreDataLoading = false;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    [self fetchLatest20Posts];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchLatest20Posts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
    
}

- (void) fetchLatest20Posts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = [posts mutableCopy];
            
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}


- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}


- (IBAction)onTapPost:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    //imagePickerVC1.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.editedImage = info[UIImagePickerControllerEditedImage];
    
    
    // Do something with the images (based on your use case)
    self.editedImage = [self resizeImage:self.editedImage withSize:CGSizeMake(400, 400)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{[self performSegueWithIdentifier:@"compose" sender:self];}];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) didShare{
    //[self.posts insertObject: post atIndex:0];
    [self fetchLatest20Posts];
    [self.tableView reloadData];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    
    cell.likeLabel.text = [NSString stringWithFormat:@"%i like",[post.likeCount intValue]];
    if (![post[@"likedBy"] containsObject:[PFUser currentUser].objectId]) {
        [cell.likeButton setImage:[UIImage imageNamed:@"likeWhite.png"] forState:UIControlStateNormal];
        
    } else {
        [cell.likeButton setImage:[UIImage imageNamed:@"likeREd.png"] forState:UIControlStateNormal];
        if ([cell.post.likeCount intValue] > 1) {
            cell.likeLabel.text = [cell.likeLabel.text stringByAppendingString:@"s"];
        }
        
    }
    
    
    cell.userNameLabel.text = post.author.username;
    cell.captionLabel.text = post.caption;
    NSURL *url = [NSURL URLWithString:post.image.url];
    [cell.postImageView setImageWithURL:url];
    
    PFFileObject *userProfileFile = post.author[@"profileImage"];
    NSURL *url2 = [NSURL URLWithString:userProfileFile.url];
    [cell.profileImageView setImageWithURL:url2];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ ago",post.createdAt.shortTimeAgoSinceNow];
    
   
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(void) didTapDetailsOnCell:(PostCell *)cell {
    NSLog(@"receivetap");
    [self performSegueWithIdentifier:@"viewDetails" sender:cell];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            // Update position of loadingMoreView, and start loading indicator
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            loadingMoreView.frame = frame;
            [loadingMoreView startAnimating];
            
            // Code to load more results
            [self loadMoreData];
        }
    }
}

- (void) loadMoreData {
    Post *lastPost = [self.posts lastObject];
    NSDate *earliest = lastPost.createdAt;
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    
    [query whereKey:@"createdAt" lessThan:earliest];
    
    
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.isMoreDataLoading = false;
            // Stop the loading indicator
            [loadingMoreView stopAnimating];
            // do something with the array of object returned by the call
            [self.posts addObjectsFromArray:posts];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    
}
- (void) didTapUserProfilePic:(PFUser *) user{
    [self performSegueWithIdentifier:@"homeToUserProfile" sender:user];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"compose"]) {
        UINavigationController *navigation = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigation.topViewController;
        composeController.delegate = sender;
        composeController.photo = self.editedImage;
        
    } else if ([segue.identifier isEqual:@"viewDetails"]) {
        DetailsViewController *detailsController = [segue destinationViewController];
        PostCell *cell = sender;
        detailsController.post = cell.post;
        detailsController.postCell = cell;
        detailsController.tableView = self.tableView;
    } else if ([segue.identifier isEqualToString:@"homeToUserProfile"]) {
        OtherProfileViewController *otherController = [segue destinationViewController];
        otherController.user = (PFUser*) sender;
    }
}






@end
