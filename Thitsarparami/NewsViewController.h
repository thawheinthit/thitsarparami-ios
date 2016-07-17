//
//  NewsViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 28/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewController.h"
#import "NewsTableViewCell.h"
#import "News.h"

@interface NewsViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (strong, nonatomic) NSArray *newsArray;

@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end
