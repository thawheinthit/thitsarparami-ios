//
//  DhammaCategoryViewModel.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "ViewModel.h"
#import "DhammaCategory.h"
#import "Monk.h"

@interface DhammaCategoryViewModel : ViewModel

@property (nonatomic,strong) NSArray *categories;

@property (nonatomic) DhammaCategory *singleCategory;


@end
