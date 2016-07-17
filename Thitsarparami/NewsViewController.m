//
//  NewsViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 28/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsService.h"
#import "NewsDetailViewController.h"

@interface NewsViewController()
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Refresh
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.newsTableView addSubview:self.refreshControl];
    
    
    [self loadItems];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    
    
    
    NSLog(@"Count %lu",[self.newsArray count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.newsArray count];
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
    [self loadItems];
    [refreshControl endRefreshing];
}



- (void)loadItems {
    
    [self.refreshControl beginRefreshing];
    [[NewsService getAllNews] subscribeNext:^(NSArray * newsList) {
        self.newsArray = newsList;
        [self.newsTableView reloadData];
        [self.refreshControl endRefreshing];
    }error:^(NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"Error");
    }];
    
    
    
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     UITableViewCell *newsCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
     
     // Configure the cell...
     News *tmpNews = [self.newsArray objectAtIndex:indexPath.row];
     newsCell.textLabel.text = tmpNews.newsTitle;     
     return newsCell;
 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"newsDetail"]) {
        NewsDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *path = [self.newsTableView indexPathForSelectedRow];
        
        News *tmpNews = [self.newsArray objectAtIndex:path.row];
        destination.currentNews = tmpNews;
        
        
        
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetail"];
//
//    
////    controller.item = [self.vm.monk.dhammaArray objectAtIndex:indexPath.row];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [self pushViewController:navigationController animated:YES completion:nil];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
