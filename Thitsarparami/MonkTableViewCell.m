//
//  MonkTableViewCell.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 23/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "MonkTableViewCell.h"
#import "Utility.h"

@implementation MonkTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [Utility imageWithImage:self.monkImage.image scaledToSize:CGSizeMake(32.00, 32.00)];
    [Utility scaleTheImage:self.monkImage.image];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
