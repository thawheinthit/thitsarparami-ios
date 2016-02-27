//
//  CategoryService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 28/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "DhammaCategory.h"
#import "Monk.h"
#import "MonkService.h"

@interface CategoryService : APIClient

+ (RACSignal*)getAllCategory;
+ (RACSignal*)getMonkByCategory:(DhammaCategory *)categoryModel;

+ (void)configureCategory:(DhammaCategory *)categoryModel withDictionary:(NSDictionary*)dictionary;

@end
