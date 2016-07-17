//
//  SingleCategoryViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 9/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "SingleCategoryViewController.h"
#import "CategoryService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SingleCategoryViewController ()

@end

@implementation SingleCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.viewModel.singleCategory.categoryName;
    
    self.categoryImage.image = [UIImage imageNamed:@"loading-Icon"];
    dispatch_queue_t categoryImageQueue = dispatch_queue_create("categoryImageQueue", nil);
    
    dispatch_async(categoryImageQueue, ^{
        NSURL * imageURL = [NSURL URLWithString:self.viewModel.singleCategory.categoryImage];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * categoryImage = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.categoryImage.image = categoryImage;
        });
        
    });
    
    
    
    self.categoryBgView.backgroundColor = [Utility colorFromHexString:@"#e0c375"];
    //Refresh
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.monkTblView addSubview:self.refreshControl];
    
    self.monkDhammaVM = [MonkDhammaViewModel new];
    
    [self loadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
    [self loadItems];
    [refreshControl endRefreshing];
}
- (void)loadItems {
    
    // Pull to refresh
    [self.refreshControl beginRefreshing];
    [[CategoryService getMonkByCategory:self.viewModel.singleCategory] subscribeNext:^(id monks) {
        self.monkArray = monks;
        [self.monkTblView reloadData];
        [self.refreshControl endRefreshing];
    }error:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.monkArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Monk *tmpMonk = [self.monkArray objectAtIndex:indexPath.row];
    
    MonkTableViewCell *tblViewCell = (MonkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    tblViewCell.monkName.text= tmpMonk.monkName;
    
    tblViewCell.tayarCount.text = [tmpMonk.dhammaCount stringValue];
    NSURL * imageURL = [NSURL URLWithString:tmpMonk.monkImage];
    
    [tblViewCell.monkImage sd_setImageWithURL:imageURL
                             placeholderImage:[UIImage imageNamed:@"loading-Icon"]];

    
    return tblViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toMonkFromSingleCategory"]) {
        MonkViewController *destination = segue.destinationViewController;
        NSIndexPath *path = [self.monkTblView indexPathForSelectedRow];
        
        Monk *tmpMonk = [self.monkArray objectAtIndex:path.row];
        self.monkDhammaVM.monk = tmpMonk;
        destination.vm = self.monkDhammaVM;
        
        
        
    }
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
