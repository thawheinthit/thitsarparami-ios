//
//  SingleCategoryViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 9/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewController.h"
#import "DhammaCategoryViewModel.h"
#import "Monk.h"
#import "DhammaCategory.h"
#import "MonkTableViewCell.h"
#import "MonkViewController.h"

@interface SingleCategoryViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;

@property (weak, nonatomic) IBOutlet UIView *categoryBgView;
@property (weak, nonatomic) IBOutlet UITableView *monkTblView;
@property (nonatomic, strong) DhammaCategoryViewModel *viewModel;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) MonkDhammaViewModel *monkDhammaVM;
@end
