//
//  MonkDhammaViewModel.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 31/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewModel.h"
#import "Monk.h"
#import "Dhamma.h"

@interface MonkDhammaViewModel : ViewModel

@property (nonatomic, strong) Monk *monk;
@property (nonatomic, strong) NSArray *dhammaArray;

@end
