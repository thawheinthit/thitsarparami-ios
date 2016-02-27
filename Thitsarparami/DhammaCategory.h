//
//  DhammaCategory.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "Model.h"
#import "Monk.h"

@interface DhammaCategory : Model

@property (strong,nonatomic) NSString *categoryName;
@property (strong,nonatomic) NSString *categoryDescription;
@property (strong,nonatomic) NSString *categoryImage;
@property (strong,nonatomic) NSArray *monkArray;
@property (strong,nonatomic) Monk *monk;

@end
