//
//  CategoryService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 28/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "CategoryService.h"

@implementation CategoryService

+ (RACSignal *)getAllCategory {
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [self getAllRequest];
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [subject sendNext:[[[responseObject[@"data"][@"category"] rac_sequence] map:^id(NSDictionary* categoryDictionary) {
            
            DhammaCategory * category = [DhammaCategory new];
            [self configureCategory:category withDictionary:categoryDictionary];
            return category;
            
        }] array]];
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:[self getAFNetworkingErrorMessage:error]];
    }];
    return subject;
}
+ (RACSignal*)getMonkByCategory:(DhammaCategory *)categoryModel{
    RACReplaySubject *subject = [RACReplaySubject subject];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [self getAllRequestByCategory:categoryModel];
    
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"get all items %@", responseObject);
        
        NSArray * itemsArray = [[[responseObject[@"data"][@"monk_list"] rac_sequence] map:^id(NSDictionary *monkData) {
            
            Monk *tmpMonk = [Monk new];
            [self configureMonk:tmpMonk withDictionary:monkData];
            return tmpMonk;
            
        }] array];
        
        [subject sendNext:itemsArray];
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
        [subject sendError:[self getAFNetworkingErrorMessage:error withOperation:operation]];
    }];
    
    return subject;

}


+ (NSString*)getAllRequest {
    return [NSString stringWithFormat:@"%@%@", APIPath, APICategory];
}

+ (NSString *)getAllRequestByCategory:(DhammaCategory *)categoryModel {
    NSString *subPath = [NSString stringWithFormat:APICategoryByID, categoryModel.objectId];
    return [NSString stringWithFormat:@"%@%@", APIPath, subPath];
}

+ (void)configureMonkForSingleCategory:(DhammaCategory *)categoryModel withDictionary:(NSDictionary*)dictionary{
//    categoryModel.objectId = dictionary[@"id"];
//    categoryModel.categoryName = dictionary[@"name"];
//
    categoryModel.categoryName  = [self getStringFromDictionary:dictionary WithKey:@"name"];
    categoryModel.categoryDescription = [self getStringFromDictionary:dictionary WithKey:@"description"];
//
    if (dictionary[@"monk_list"] && [dictionary[@"monk_list"] isKindOfClass:[NSArray class]] && [dictionary[@"monk_list"] count] > 0) {
        
        //        NSArray *tmpArray = dictionary[@"dhamma_list"];
        NSMutableArray *monkList = [NSMutableArray new];
        if (dictionary[@"monk_list"] != [NSNull null]) {
            for (NSDictionary *monk in dictionary[@"monk_list"]) {
                Monk *tmpMonk = [Monk new];
                [self configureMonk:tmpMonk withDictionary:monk];
                [monkList addObject:tmpMonk];
            }
        }
        categoryModel.monkArray = monkList;

    }
}

+ (void)configureCategory:(DhammaCategory*)categoryModel withDictionary:(NSDictionary*)dictionary {
    categoryModel.objectId = dictionary[@"id"];
    categoryModel.categoryName = dictionary[@"name"];
    categoryModel.categoryImage = dictionary[@"image"];
    
    NSMutableArray *monkList = [NSMutableArray new];
    if (dictionary[@"monk_list"] != [NSNull null]) {
        for (NSDictionary *monk in dictionary[@"monk_list"]) {
            Monk *newMonk = [Monk new];
            [MonkService configureMonk:newMonk withDictionary:monk];
            [monkList addObject:newMonk];
        }
    }
    categoryModel.monkArray = [monkList copy];
    
    
}

+ (void)configureMonk:(Monk *)monkModel withDictionary:(NSDictionary *)dictionary{
    
    //    dhammaModel.objectId  = [self getNumberFromDictionary:dictionary WithKey:@"id"];
    monkModel.objectId = [self getNumberFromDictionary:dictionary WithKey:@"id"];
    monkModel.monkName  = [self getStringFromDictionary:dictionary WithKey:@"name"];
    monkModel.monkImage = [self getStringFromDictionary:dictionary WithKey:@"image"];
    monkModel.dhammaCount = [self getNumberFromDictionary:dictionary WithKey:@"count"];

    
    
}



@end
