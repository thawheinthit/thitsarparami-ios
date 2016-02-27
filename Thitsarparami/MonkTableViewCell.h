//
//  MonkTableViewCell.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 23/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monkName;

@property (weak, nonatomic) IBOutlet UIImageView *monkImage;
@property (weak, nonatomic) IBOutlet UILabel *tayarCount;

@end
