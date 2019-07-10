//
//  PostCell.m
//  Instagram
//
//  Created by lucyyyw on 7/9/19.
//  Copyright © 2019 lucyyyw. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}
- (IBAction)onTapDetailsBtn:(id)sender {
    [self.detailDelegate didTapDetailsOnCell:self];

}


@end
