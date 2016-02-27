//
//  ViewModel.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface ViewModel : NSObject

@property (strong, nonatomic) NSMutableArray *errorBag;

@property (nonatomic) BOOL isLoading;

@end
