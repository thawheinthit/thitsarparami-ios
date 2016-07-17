//
//  Setting.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 6/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "Model.h"

@interface Setting : Model

+ (Setting *)currentSetting;

@property (nonatomic, strong) NSString *background;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSNumber *notiStatus;
@property (nonatomic, strong) NSData *pBackgroundData;

- (NSData *)getBackgroundData;
@end
