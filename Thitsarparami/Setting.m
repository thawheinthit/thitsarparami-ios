//
//  Setting.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 6/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "Setting.h"

@implementation Setting
static Setting *pCurrentSetting;

+ (Setting *)currentSetting {
    if (!pCurrentSetting) {
        pCurrentSetting = [Setting new];
    }
    return pCurrentSetting;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.background = @"background-login";
    }
    return self;
}

- (NSData *)getBackgroundData {
    if (self.pBackgroundData) {
        return self.pBackgroundData;
    }
    return self.pBackgroundData;
}

@end
