//
//  CategoryViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 4/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "CategoryViewController.h"
#import "MonkTableViewCell.h"
#import "CategoryService.h"
#import "MonkViewController.h"
#import "SingleCategoryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


//#import "MonkTableViewCell.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"သစၥာပါရမီ(စကၤာပူ)";
    

//    UIImage *addImage = [UIImage imageNamed:@"logo-top"];
//    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addButton setFrame:CGRectMake(0, 0, addImage.size.width, addImage.size.height)];
//    [addButton setBackgroundImage:addImage forState:UIControlStateNormal];
//    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
//    
//    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
    //Refresh
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.categoryTblView addSubview:self.refreshControl];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.viewModel = [DhammaCategoryViewModel new];
    self.vm = [MonkDhammaViewModel new];
    self.monk = [Monk new];
    
    [self loadItems];

}

- (void)viewWillAppear:(BOOL)animated{
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    [tabBarController setDelegate:self];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadItems];
    [refreshControl endRefreshing];
}

- (void)loadItems {
    
    // Pull to refresh
    
    [self.refreshControl beginRefreshing];
    [[CategoryService getAllCategory] subscribeNext:^(NSArray *categoryList) {
        self.viewModel.categories = categoryList;
        [self.categoryTblView reloadData];
        [self.refreshControl endRefreshing];
    }error:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return tableData.count;
    
    DhammaCategory *tmpCategory = [self.viewModel.categories objectAtIndex:section];
    return tmpCategory.monkArray.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    DhammaCategory *tmpCategory = [self.viewModel.categories objectAtIndex:section];
    return tmpCategory.categoryName;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [headerView setBackgroundColor:[Utility colorFromHexString:@"#f1f1f1"]];
    headerView.alpha = 0.98;
    
    UILabel *categoryTitle = [[UILabel alloc] init];
    categoryTitle.frame = CGRectMake(20, 4, tableView.bounds.size.width - 10, 20);
    categoryTitle.font = [UIFont boldSystemFontOfSize:12];

    categoryTitle.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(tableView.bounds.size.width - 56, 5, 58 , 20)];
    [button setTitle:@"See All" forState:UIControlStateNormal];
    [button setTitleColor:[Utility colorFromHexString:@"#993D3D"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    
    //Pass section id with tag
    button.tag = section;
    
    [button addTarget:self action:@selector(buttonPressed :) forControlEvents:UIControlEventTouchUpInside];
    

    [headerView addSubview:button];
    
    [headerView addSubview:categoryTitle];


    
    return headerView;
}

- (void)buttonPressed:(UIButton *)sender
{
    
    SingleCategoryViewController *singleCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"singleCategory"];

    DhammaCategory *tmpCategory = [self.viewModel.categories objectAtIndex:sender.tag];
    
    self.viewModel.singleCategory = tmpCategory;
    singleCategoryVC.viewModel = self.viewModel;
    
    [self.navigationController pushViewController:singleCategoryVC animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    DhammaCategory *tmpCategory = [self.viewModel.categories objectAtIndex:indexPath.section];
    
    Monk *tmpMonk = tmpCategory.monkArray[indexPath.row];
    
    
    MonkTableViewCell *tblViewCell = (MonkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    
//    
//    tblViewCell.monkImage.image = [UIImage imageNamed:@"loading-Icon"];
//    
//    
//    // Load the image with an GCD block executed in another thread
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL *imageURL = [NSURL URLWithString:tmpMonk.monkImage];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//        
//        if (imageData) {
//            UIImage *offersImage = [UIImage imageWithData:imageData];
//            if (offersImage) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    MonkTableViewCell *tblViewCell = (MonkTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//                    
//                    if (tblViewCell) {
//                        tblViewCell.monkImage.image = offersImage;
//                    }
//                });
//            }
//        }
//    });
//    
    
    
    
    tblViewCell.tayarCount.text = [tmpMonk.dhammaCount stringValue];
    tblViewCell.monkName.text= tmpMonk.monkName;
    
 
    
    
    NSURL *imageURL = [NSURL URLWithString:tmpMonk.monkImage];
    
    
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    [tblViewCell.monkImage sd_setImageWithURL:imageURL
                      placeholderImage:[UIImage imageNamed:@"loading-Icon"]];


    
    
    
    
//        dispatch_queue_t imageQueue= dispatch_queue_create("imageQueue", nil);
//    
//    
//        dispatch_async(imageQueue, ^{
//            
//            NSURL *imageURL = [NSURL URLWithString:tmpMonk.monkImage];
//            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//            UIImage *monkImage = [UIImage imageWithData:imageData];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                MonkTableViewCell *tblViewCell = (MonkTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//                if (tblViewCell) {
//                    tblViewCell.monkImage.image = monkImage;
//                }
//            });
//        });
    
    
    
    
    return tblViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toMonk"]) {
        MonkViewController *destination = segue.destinationViewController;
        NSIndexPath *path = [self.categoryTblView indexPathForSelectedRow];
        
        DhammaCategory *tmpCategory = [self.viewModel.categories objectAtIndex:path.section];
        
        self.vm.monk = tmpCategory.monkArray[path.row];
        destination.vm = self.vm;
        
        
        
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

- (IBAction)playLive:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    PlayerViewController *controller = (PlayerViewController *) [navigationController visibleViewController];
    
    DhammaItem *itemTmp = [DhammaItem new];
    itemTmp.uid = @"1";
    itemTmp.title = @"24 Hours Live Radio";
    itemTmp.remotePath = @"https://edge.mixlr.com/channel/nmtev";
    itemTmp.author = @"Thitsarparami";
    controller.item = itemTmp;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


//- (void)tabBar:(UITabBar *)tabBar
// didSelectItem:(UITabBarItem *)item{
//    NSLog(@"aaaa");
//    if(item.tag == 1){
//        item.badgeValue = nil;
//        NSLog(@"adsfas");
//    }
//}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    UITabBar *tabBar = tabBarController.tabBar;
    
    
    if(tabBar.items[1])
    {
        UITabBarItem *itemToBadge = tabBar.items[1];
        itemToBadge.badgeValue = nil;
        NSLog(@"%@",viewController);
    }


}

@end
