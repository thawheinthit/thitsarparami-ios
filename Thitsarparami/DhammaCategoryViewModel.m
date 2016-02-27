//
//  DhammaCategoryViewModel.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "DhammaCategoryViewModel.h"

@implementation DhammaCategoryViewModel


-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.singleCategory = [DhammaCategory new];
    
    // Category 1
//    DhammaCategory *category1 = [[DhammaCategory alloc]init];
//    category1.categoryName = @"Category 1";
//    category1.categoryDescription = @"Category 1 Description";
//   
//    Monk *monk1= [[Monk alloc]init];
//    monk1.monkName = @"Sayardaw 1";
//    monk1.bio = @"Sayardaw 1's biography";
//    
//    Monk *monk2= [[Monk alloc]init];
//    monk2.monkName = @"Sayardaw 2";
//    monk2.bio = @"Sayardaw 2's biography";
//    
//    Monk *monk3= [[Monk alloc]init];
//    monk3.monkName = @"Sayardaw 3";
//    monk3.bio = @"Sayardaw 3's biography";
//    
//    Monk *monk4= [[Monk alloc]init];
//    monk4.monkName = @"Sayardaw 4";
//    monk4.bio = @"Sayardaw 4's biography";
//    category1.monkArray = [NSArray arrayWithObjects: monk1, monk2, monk3, monk4, nil];
//    
//    
//    // Category 2
//    
//    DhammaCategory *category2 = [[DhammaCategory alloc]init];
//    category2.categoryName = @"Category 2";
//    category2.categoryDescription = @"Category 2 Description";
//    category2.monkArray = [NSArray arrayWithObjects: monk1, monk2, nil];
//    
//    
//    // Category 3
//    DhammaCategory *category3 = [[DhammaCategory alloc]init];
//    category3.categoryName = @"Category 3";
//    category3.categoryDescription = @"Category 3 Description";
//    category3.monkArray = [NSArray arrayWithObjects: monk4, nil];
//    
//    self.categories = [NSArray arrayWithObjects: category1, category2, category3, nil];
    
    return self;
}

//-(void)sampleMonks{
//    Monk *monk1= [[Monk alloc]init];
//    monk1.monkName = @"Sayardaw 1";
//    monk1.bio = @"Sayardaw 1's biography";
//    
//    Monk *monk2= [[Monk alloc]init];
//    monk2.monkName = @"Sayardaw 2";
//    monk2.bio = @"Sayardaw 2's biography";
//    
//    Monk *monk3= [[Monk alloc]init];
//    monk3.monkName = @"Sayardaw 3";
//    monk3.bio = @"Sayardaw 3's biography";
//    
//    Monk *monk4= [[Monk alloc]init];
//    monk4.monkName = @"Sayardaw 4";
//    monk4.bio = @"Sayardaw 4's biography";
//    NSArray *monkArray =[NSArray arrayWithObjects: monk1, monk2, monk3, monk4, nil];
//    
//}


@end
