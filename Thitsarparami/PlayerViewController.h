//
//  PlayerViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 24/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dhamma.h"
#import "MarqueeLabel.h"

@interface PlayerViewController : UIViewController

@property (nonatomic, strong) Dhamma *item;
@property (nonatomic, strong) ExampleMediaCollection *collection;
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;
- (IBAction)shareButton:(id)sender;

@end
