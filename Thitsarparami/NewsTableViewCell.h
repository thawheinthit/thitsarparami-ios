//
//  NewsTableViewCell.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 28/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsDescription;

@end
