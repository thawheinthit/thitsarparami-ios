//
//  ContactViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 27/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.currentContact = [Contact new];
    
//    self.currentContact = (Contact *)[self.contactArray objectAtIndex:0];
    // Do any additional setup after loading the view.
//    self.contactTextView.text = self.currentContact.contactInfo;
    
    self.contactTextView.text = @"သစၥာပါရမီ ဓမၼရာဇာ တရားရိပ္သာ (စကၤာပူ)\r\n\n(60) West Coast Lane, Hong Leong GardenSingapore 127790\r\n\nThitsarparami Temple\r\n\n TEL: 6524 6344, TEL: 8121 0493\r\n\r\n\nသစၥာပါရမီ ေကာ္မတီဝင္မ်ား\r\n\nဥကၠဌ\r\n\nဦးစိုးရီ – 9487 3696\r\n\nဒုဥကၠဌ\r\n\nကိုၿငိမ္းခ်မ္းေဆြ – 9691 3272\r\n\nအတြင္းေရးမွဴး\r\n\nကိုေအးမင္းထြန္း – 9145 4994\r\n\nမအိအိၿဖိဳး – 9692 3336 (တြဲဖက္အတြင္းေရးမွဴး)\r\n\nဘ႑ာေရးမွဴး\r\n\nဦးေအးျမင့္ – 9108 0763\r\n\nမၿငိမ့္သဥၨာႏုိင္ - 9726 9085 (တြဲဖက္ ဘ႑ာေရးမွဴး)\r\n\nစာရင္းစစ္\r\n\nဦးေစာသိန္း – 9487 5272\r\n\n\r\n\nသစၥာပါရမီ ဓမၼရာဇာ တရားရိပ္သာ (ရန္ကုန္)\r\n\r\nသာေကတ  (၁၀/ေျမာက္)ရပ္ကြက္၊ ဧရာဝဏ္လမ္းမႀကီး၊\r\n\r\n(EPC ဓာတ္အားေပးစက္ရံုအနီး)၊ ၃၄ မီနီဘတ္(စ္) ကားဂိတ္အဆံုး၊\r\n\r\nဘုန္းႀကီးေက်ာင္းလမ္း၊ သာေကတၿမိဳ႕နယ္၊ ရန္ကုန္ၿမိဳ႕\r\n\r\nဖုန္း -၀၉ ၄၂၀၁၀၃၇၄၂ ၊ ၀၉ ၄၅၀၀၃၅၈၈၀\r\n\r\n\nWebsite တာဝန္ခံမ်ား\r\n\r\nကိုဟိန္းလတ္မ်ဳိး – 9828 1807\r\n\r\nကိုေက်ာ္ဇင္ – 9389 8700\r\n\r\nမသီရိ – 9793 4426\r\n\r\nမဝတ္ရီ – 8112 0594\r\n\r\n\r\n\r\niOS Developer\r\n\r\nကိုေသာ္ဟိန္းသစ္ - 9837 3951";
//    [[ContactService getContact] subscribeNext:^(NSString *contact) {
//        NSLog(@"Cont %@",contact);
//        self.contactTextView.text = contact;
//    }error:^(NSError *error) {
//        NSLog(@"err");
//    }];
    
 
}

//- (void)loadItems {
//    
//    // Pull to refresh
////    [self.refreshControl beginRefreshing];
//    [[ContactService getContact] subscribeNext:^(NSArray* contactList) {
//        self.contactArray = contactList;
//        
//        
//    }error:^(NSError *error) {
//        NSLog(@"Error!");
//    }];
//    
//    
//}
//
//- (void)loadItems2 {
//    
//    
//    [[ContactService getContact] subscribeNext:^(id contactList) {
//        self.contactArray = contactList;
//        
//        
//    }error:^(NSError *error) {
//        NSLog(@"Error!");
//    }];
//    
//    
//    
//}


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

@end
