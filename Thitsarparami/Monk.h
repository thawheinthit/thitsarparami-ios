//
//  Monk.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "Model.h"

@interface Monk : Model

@property (nonatomic,strong) NSString *monkName;
@property (nonatomic,strong) NSString *monkImage;
@property (strong, nonatomic) NSNumber *dhammaCount;
@property (nonatomic,strong) NSString *bio;

@property (nonatomic, strong) NSArray *dhammaArray;


@end
