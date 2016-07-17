//
//  PlayerViewController.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 24/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "PlayerViewController.h"
#import <AUMediaPlayer/AUMediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>


static void *AUMediaPlaybackCurrentTimeObservationContext = &AUMediaPlaybackCurrentTimeObservationContext;
static void *AUMediaPlaybackDurationObservationContext = &AUMediaPlaybackDurationObservationContext;
static void *AUMediaPlaybackTimeValidityObservationContext = &AUMediaPlaybackTimeValidityObservationContext;

@interface PlayerViewController ()<UIActionSheetDelegate> {
    NSUInteger _currentItemDuration;
    BOOL _playbackTimesAreValid;
}

@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIButton *repeatButton;
@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;


@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MarqueeLabel *titleLabel;



@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *receiverItem;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    
//    self.titleLabel.marqueeType = MLContinuous;
//    self.titleLabel.animationCurve = UIViewAnimationOptionCurveEaseInOut;
//    
    self.titleLabel.marqueeType= MLContinuous;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    self.titleLabel.scrollDuration = 8.0;
    self.titleLabel.fadeLength = 15.0f;
    self.titleLabel.leadingBuffer = 20.0f;
    
    [self musicPlayerStateChanged:nil];
//
//    [self updateShuffleAndRepeatButtons];
        [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    
//
    
    if (!self.item) {
        
        [self.closeBtn setEnabled:NO];
        self.playButton.hidden = YES;
        self.pauseButton.hidden = NO;
        
        UIAlertController * alert= [UIAlertController
                                      alertControllerWithTitle:@"Notice"
                                      message:@"No audio file selected. Player will automatically play dhmma live stream."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        DhammaItem *itemTmp = [DhammaItem new];
                                        itemTmp.uid = @"1";
                                        itemTmp.title = @"24 Hours Live Radio";
                                        itemTmp.remotePath = @"https://edge.mixlr.com/channel/nmtev";
                                        itemTmp.author = @"Thitsarparami";
                                        self.item = itemTmp;
                                        
                                        [self playOrPause];
                                        
                                    }];

        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        [self playOrPause];
    }
}

- (void)playOrPause{
    AUMediaPlayer *player = [AUMediaPlayer sharedInstance];
    if (player.playbackStatus == AUMediaPlaybackStatusPlayerInactive || (self.item && ![[player.nowPlayingItem uid] isEqualToString:self.item.uid])) {
        NSError *error;
        [player playItem: self.item error:&error];
    } else if (player.playbackStatus == AUMediaPlaybackStatusPlaying) {
        [player pause];
    } else {
        [player play];
    }

}

- (IBAction)shareButton:(id)sender{
    [self shareContent];
}
-(void)shareContent{
    
//    NSString * message = @"My too cool Son";
    
//    UIImage * image = [UIImage imageNamed:@"mingon-sayardaw"];
    
    NSURL *dhammaURL = [NSURL URLWithString:self.item.remotePath];
    
//    NSArray * shareItems = @[message, myWebsite, image ];
//    NSArray * excludeActivities = @[UIActivityTypePostToWeibo,
//                                     UIActivityTypeMessage,
//                                     UIActivityTypeMail,
//                                     UIActivityTypePrint,
//                                     UIActivityTypeCopyToPasteboard,
//                                     UIActivityTypeAssignToContact,
//                                     UIActivityTypeSaveToCameraRoll,
//                                     UIActivityTypeAddToReadingList,
//                                     UIActivityTypePostToFlickr,
//                                     UIActivityTypePostToVimeo,
//                                     UIActivityTypePostToTencentWeibo,
//                                     UIActivityTypeAirDrop];
//    
//    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
//    avc.excludedActivityTypes = excludeActivities;
//    
//    [self presentViewController:avc animated:YES completion:nil];
    
    SLComposeViewController * fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [fbSheetOBJ setInitialText:self.item.dhammaTitle];
    [fbSheetOBJ addURL:dhammaURL];
    
    
    [fbSheetOBJ setCompletionHandler:^(SLComposeViewControllerResult result) {
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                NSLog(@"Post Canceled :(");
                break;
            case SLComposeViewControllerResultDone:
                NSLog(@"Sucessfully Post :)");
                break;
                
            default:
                break;
        }
    }];
    
    [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    
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


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
    
    AUMediaPlayer *player = [self player];
    [player addObserver:self forKeyPath:@"currentPlaybackTime" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:AUMediaPlaybackCurrentTimeObservationContext];
    [player addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:AUMediaPlaybackDurationObservationContext];
    [player addObserver:self forKeyPath:@"playbackTimesAreValid" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:AUMediaPlaybackTimeValidityObservationContext];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(musicPlayerStateChanged:)
                                                 name:kAUMediaPlaybackStateDidChangeNotification
                                               object:nil];
    
    
    
    
    
    id<AUMediaItem>item = [[self player] nowPlayingItem];
//    self.titleLabel.text = [item author];
    self.titleLabel.text = [item title];

    
    

}


#pragma mark - Player

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AUMediaPlayer *player = [AUMediaPlayer sharedInstance];
    [player removeObserver:self forKeyPath:@"currentPlaybackTime" context:AUMediaPlaybackCurrentTimeObservationContext];
    [player removeObserver:self forKeyPath:@"duration" context:AUMediaPlaybackDurationObservationContext];
    [player removeObserver:self forKeyPath:@"playbackTimesAreValid" context:AUMediaPlaybackTimeValidityObservationContext];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kAUMediaPlaybackStateDidChangeNotification
                                                  object:nil];
}

//- (void)setPlayerLayer {
//    AVPlayerLayer *layer = (AVPlayerLayer *)self.playbackView.layer;
//    [layer setPlayer:[self player].player];
//}

- (IBAction)playPauseAction:(id)sender {
    AUMediaPlayer *player = [AUMediaPlayer sharedInstance];
    if (player.playbackStatus == AUMediaPlaybackStatusPlayerInactive || (self.item && ![[player.nowPlayingItem uid] isEqualToString:self.item.uid])) {
        NSError *error;
//        if (self.collection) {
//            [player playItemQueue:self.collection error:&error];
//        } else {
            [player playItem: self.item error:&error];
//            [self setPlayerLayer];
//        }
    } else if (player.playbackStatus == AUMediaPlaybackStatusPlaying) {
        [player pause];
    } else {
        [player play];
    }
    NSLog(@"Current time: %lu, Duration: %lu", (unsigned long)player.currentPlaybackTime, (unsigned long)player.duration);
}

- (IBAction)prevAction:(id)sender {
    [[self player] playPrevious];
}

- (IBAction)nextAction:(id)sender {
    [[self player] playNext];
}
- (IBAction)repeatAction:(id)sender {
    AUMediaPlayer *player = [self player];
    if (player.repeat) {
        [[self player] toggleRepeatMode];
    } else {
        [[self player] toggleRepeatMode];
    }
    
    [self updateShuffleAndRepeatButtons];
}
- (IBAction)shuffleAction:(id)sender {
    AUMediaPlayer *player = [self player];
    if (player.shuffle) {
        [player setShuffleOn:NO];
    } else {
        [player setShuffleOn:YES];
    }
    
    [self updateShuffleAndRepeatButtons];
}

- (IBAction)didSlide:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [[self player] seekToMoment:slider.value];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == AUMediaPlaybackTimeValidityObservationContext) {
        BOOL playbackTimesValidaity = [change[NSKeyValueChangeNewKey] boolValue];
        _playbackTimesAreValid = playbackTimesValidaity;
        if (!playbackTimesValidaity) {
            self.leftTimeLabel.text = @"00:00";
            self.rightTimeLabel.text = @"00:00";
        }
    } else if (context == AUMediaPlaybackCurrentTimeObservationContext) {
        NSUInteger currentPlaybackTime = [change[NSKeyValueChangeNewKey] integerValue];
        [self updatePlaybackProgressSliderWithTimePassed:currentPlaybackTime];
        self.leftTimeLabel.text = [self convertTime:currentPlaybackTime];
    } else if (context == AUMediaPlaybackDurationObservationContext) {
        NSUInteger currentDuration = [change[NSKeyValueChangeNewKey] integerValue];
        _currentItemDuration = currentDuration;
        self.rightTimeLabel.text = [self convertTime:currentDuration];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (AUMediaPlayer *)player {
    return [AUMediaPlayer sharedInstance];
}

- (void)updatePlaybackProgressSliderWithTimePassed:(NSUInteger)time {
    if (_playbackTimesAreValid && _currentItemDuration > 0) {
        self.slider.value = (float)time/(float)_currentItemDuration;
    } else {
        self.slider.value = 0.0;
    }
}

- (NSString*)convertTime:(NSInteger)time
{
    NSInteger minutes = time / 60;
    NSInteger seconds = time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

- (void)musicPlayerStateChanged:(NSNotification *)notification {
    [self updateNowPlayingInfo];
    [self updateButtonsForStatus:[[AUMediaPlayer sharedInstance] playbackStatus]];
}

- (void)updateButtonsForStatus:(AUMediaPlaybackStatus)status {
    if (status == AUMediaPlaybackStatusPlaying) {
//        [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        self.playButton.hidden = YES;
        self.pauseButton.hidden = NO;
    } else {
//        [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        self.playButton.hidden = NO;
        self.pauseButton.hidden = YES;
    }
}

- (void)updateNowPlayingInfo {
    id<AUMediaItem>item = [[self player] nowPlayingItem];
    self.authorLabel.text = [item author];
    self.titleLabel.text = [item title];
}

- (void)updateShuffleAndRepeatButtons {
    AUMediaPlayer *player = [AUMediaPlayer sharedInstance];
    if (player.shuffle) {
        [self.shuffleButton setTitle:@"Shuffle on" forState:UIControlStateNormal];
        NSLog(@"Shuffle on");
    } else {
        [self.shuffleButton setTitle:@"Shuffle off" forState:UIControlStateNormal];
        NSLog(@"Shuffle off");
    }
    switch (player.repeat) {
        case AUMediaRepeatModeOn:
            [self.repeatButton setTitle:@"Repeat on" forState:UIControlStateNormal];
            break;
        case AUMediaRepeatModeOff:
            [self.repeatButton setTitle:@"Repeat off" forState:UIControlStateNormal];
            break;
        case AUMediaRepeatModeOneSong:
            [self.repeatButton setTitle:@"Repeat one" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)selectReceiver:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Receiver", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:@"No receiver", @"Chromecast", nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
