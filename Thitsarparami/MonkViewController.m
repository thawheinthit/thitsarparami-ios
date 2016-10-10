//
//  MonkViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 24/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "MonkViewController.h"

@interface MonkViewController ()

@end

@implementation MonkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"သစၥာပါရမီ(စကၤာပူ)";

    self.monkName.text = self.vm.monk.monkName;
    self.dhammaCount.text = [self.vm.monk.dhammaCount stringValue];
    
    self.monkImage.image = [UIImage imageNamed:@"loading-Icon"];
    dispatch_queue_t singleMonkQueue = dispatch_queue_create("singleMonk", nil);
    
    dispatch_async(singleMonkQueue, ^{
        
        NSURL * imageURL = [NSURL URLWithString:self.vm.monk.monkImage];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * monkImage = [UIImage imageWithData:imageData];
       
        dispatch_async(dispatch_get_main_queue(), ^{
             self.monkImage.image = monkImage;
        });
        
    });
    
    
    //Refresh
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tayarTblView addSubview:self.refreshControl];
    

}

- (void) viewWillAppear:(BOOL)animated{
    [self loadItems];
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
    [self loadItems];
    [refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.vm.monk.dhammaArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TayarCell" forIndexPath:indexPath];
    
    Dhamma *tmpDhamma = [self.vm.monk.dhammaArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tmpDhamma.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    PlayerViewController *controller = (PlayerViewController *) [navigationController visibleViewController];
    
    controller.item = [self.vm.monk.dhammaArray objectAtIndex:indexPath.row];
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadItems {

    [self.refreshControl beginRefreshing];
    [[DhammaService getDhammaByMonk:self.vm.monk] subscribeNext:^(id dhammaList) {
        self.vm.monk.dhammaArray = dhammaList;
        [self.tayarTblView reloadData];
        [self.refreshControl endRefreshing];
    }error:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];

    
    
}

#pragma mark - Mock
//
//- (NSArray *)mockMedia {
////    
////    NSMutableArray *audioList = [NSMutableArray new];
////
////        for (NSDictionary *dhammaItem in self.vm.dhammaArray) {
////            DhammaItem *newItem = [DhammaItem new];
////
////            [audioList addObject:newItem];
////        }
////
////    return audioList;
//    
//    
////    ExampleAudioItem *audio1 = [[ExampleAudioItem alloc] init];
////    audio1.author = @"Author";
////    audio1.title = @"Track 1";
////    audio1.uid = @"00000000001";
////    audio1.remotePath = @"http://thitsarparamisociety.com/wp-content/uploads/mp3/Mogoke/Selection-957/M-G%20001.MP3";
////    
////    ExampleAudioItem *audio2 = [[ExampleAudioItem alloc] init];
////    audio2.author = @"Author";
////    audio2.title = @"Track 2";
////    audio2.uid = @"00000000002";
////    audio2.remotePath = @"http://thitsarparamisociety.com/wp-content/uploads/mp3/Mogoke/Selection-957/M-G%20002.MP3";
////    
////    ExampleAudioItem *audio3 = [[ExampleAudioItem alloc] init];
////    audio3.author = @"Author";
////    audio3.title = @"Track 3";
////    audio3.uid = @"00000000003";
////    audio3.remotePath = @"http://thitsarparamisociety.com/wp-content/uploads/mp3/Mogoke/Selection-957/M-G%20003.MP3";
////    
////    
////    ExampleAudioItem *audio4 = [[ExampleAudioItem alloc]init];
////    audio4.author = @"Thitsarparami";
////    audio4.title = @"Live Stream";
////    audio4.uid = @"00000004";
////    audio4.remotePath = @"https://edge.mixlr.com/channel/nmtev";
////    
////    ExampleMediaCollection *collection = [[ExampleMediaCollection alloc] init];
////    collection.mediaItems = @[audio1, audio2, audio3, audio4];
////    collection.author = @"Author";
////    collection.title = @"Album";
//    
//    
////    return @[collection, audio1, audio2, audio3, audio4];
//    return @[];
//}

@end
