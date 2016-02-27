//
//  ViewModel.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.errorBag = [NSMutableArray new];
    }
    return self;
}

@end
