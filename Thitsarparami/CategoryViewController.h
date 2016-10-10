//
//  CategoryViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 4/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "DhammaCategoryViewModel.h"
#import "DhammaCategory.h"
#import "Monk.h"
#import "MonkDhammaViewModel.h"
#import "Utility.h"
#import "NewsViewController.h"

@interface CategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTblView;
@property (weak, nonatomic)  NewsViewController *newsVC;
@property (nonatomic, strong) DhammaCategoryViewModel *viewModel;
@property (nonatomic, strong) Monk *monk;
@property (nonatomic, strong) MonkDhammaViewModel *vm;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

- (IBAction)playLive:(id)sender;


@end
