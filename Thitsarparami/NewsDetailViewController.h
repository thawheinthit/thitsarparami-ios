//
//  NewsDetailViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 21/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewController.h"
#import "News.h"

@interface NewsDetailViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *newsContent;
@property (strong, nonatomic) News *currentNews;

@end
