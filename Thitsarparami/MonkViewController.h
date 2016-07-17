//
//  MonkViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 24/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewController.h"
#import "Dhamma.h"
#import "PlayerViewController.h"
#import "DhammaCategoryViewModel.h"
#import "Monk.h"
#import "MonkDhammaViewModel.h"
#import "MonkService.h"
#import "DhammaService.h"

@interface MonkViewController : ViewController<UITableViewDelegate,UITableViewDataSource>{

    
    NSArray *mainArray;

}
@property (weak, nonatomic) IBOutlet UITableView *tayarTblView;
@property (weak, nonatomic) IBOutlet UILabel *monkName;
@property (weak, nonatomic) IBOutlet UILabel *dhammaCount;

@property (weak, nonatomic) IBOutlet UIImageView *monkImage;

@property (nonatomic, strong) Monk *monk;
@property (nonatomic, strong) MonkDhammaViewModel *vm;

@property (weak, nonatomic) IBOutlet UILabel *dhammaLabel;
@property (weak, nonatomic) IBOutlet UILabel *testUni;

@property (nonatomic,strong) UIRefreshControl *refreshControl;

@end
