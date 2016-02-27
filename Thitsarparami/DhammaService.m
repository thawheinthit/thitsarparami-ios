//
//  DhammaService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 31/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "DhammaService.h"

@implementation DhammaService
+ (RACSignal*)getDhammaByMonk:(Monk *)monk{
//    
//        RACReplaySubject *subject = [RACReplaySubject subject];
//    
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSString *request = [self getAllDhammaByMonk:monk];
//    
//        [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"JSON: %@", responseObject);
//            [subject sendNext:[[[responseObject[@"data"] rac_sequence] map:^id(NSDictionary* monkDictionary) {
//                
//                Monk * tmpMonk = [Monk new];
//                [self configureMonk:tmpMonk withDictionary:monkDictionary];
//                return tmpMonk;
//                
//            }] array]];
//            [subject sendCompleted];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [subject sendError:[self getAFNetworkingErrorMessage:error]];
//        }];
//        return subject;
    
//    NSLog(@"+ [GET get merchant %@]", monk.objectId);
    RACReplaySubject *subject = [RACReplaySubject subject];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [self getAllDhammaByMonk:monk];
    
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"get all items %@", responseObject);
        
        NSArray * itemsArray = [[[responseObject[@"data"][@"dhamma_list"] rac_sequence] map:^id(NSDictionary *monkDhammaData) {
            
            Dhamma *newDhamma = [Dhamma new];
            [self configureDhamma:newDhamma withDictionary:monkDhammaData];
            return newDhamma;
            
        }] array];
        
        [subject sendNext:itemsArray];
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
        [subject sendError:[self getAFNetworkingErrorMessage:error withOperation:operation]];
    }];
    
    return subject;
}

+ (NSString *)getAllDhammaByMonk:(Monk*)monk {
        NSString *subPath = [NSString stringWithFormat:APIMonkByID, monk.objectId];
        return [NSString stringWithFormat:@"%@%@", APIPath, subPath];
}

//+ (void)configureCategory:(DhammaCategory*)categoryModel withDictionary:(NSDictionary*)dictionary {
//    categoryModel.objectId = dictionary[@"id"];
//    categoryModel.categoryName = dictionary[@"name"];
//    
//    
//    NSMutableArray *monkList = [NSMutableArray new];
//    if (dictionary[@"monk_list"] != [NSNull null]) {
//        for (NSDictionary *monk in dictionary[@"monk_list"]) {
//            Monk *newMonk = [Monk new];
//            [MonkService configureMonk:newMonk withDictionary:monk];
//            [monkList addObject:newMonk];
//        }
//    }
//    categoryModel.monkArray = [monkList copy];
//    
//    
//}



+ (void)configureMonk:(Monk *)monkModel withDictionary:(NSDictionary*)dictionary{
//    monkModel.objectId = dictionary[@"id"];
//    monkModel.monkName = dictionary[@"monk_name"];
    monkModel.monkName  = [self getStringFromDictionary:dictionary WithKey:@"monk_name"];
    monkModel.monkImage = [self getStringFromDictionary:dictionary WithKey:@"image"];
    
//    NSLog(@"Data %@",dictionary);
    
    if (dictionary[@"dhamma_list"] && [dictionary[@"dhamma_list"] isKindOfClass:[NSArray class]] && [dictionary[@"dhamma_list"] count] > 0) {
        
//        NSArray *tmpArray = dictionary[@"dhamma_list"];
        NSMutableArray *dhammaList = [NSMutableArray new];
        if (dictionary[@"dhamma_list"] != [NSNull null]) {
                for (NSDictionary *dhamma in dictionary[@"dhamma_list"]) {
                    Dhamma *tmpDhamma = [Dhamma new];
                    [self configureDhamma:tmpDhamma withDictionary:dhamma];
                    [dhammaList addObject:tmpDhamma];
                }
            }
            monkModel.dhammaArray = dhammaList;
//        monkModel.dhammaArray = tmpArray;
    }
    
//    
//    NSMutableArray *dhammaList = [NSMutableArray new];
//    if (dictionary[@"dhamma_list"] != [NSNull null]) {
//        for (NSDictionary *dhamma in dictionary[@"dhamma_list"]) {
//            Dhamma *tmpDhamma = [Dhamma new];
//            [self configureDhamma:tmpDhamma withDictionary:dhamma];
//            [dhammaList addObject:tmpDhamma];
//        }
//    }
//    monkModel.dhammaArray = [dhammaList copy];
    
}


+ (void)configureDhamma:(Dhamma *)dhammaModel withDictionary:(NSDictionary *)dictionary{
    
//    dhammaModel.objectId  = [self getNumberFromDictionary:dictionary WithKey:@"id"];
    dhammaModel.uid = [self getStringFromDictionary:dictionary WithKey:@"id"];
    dhammaModel.title  = [self getStringFromDictionary:dictionary WithKey:@"title"];
    dhammaModel.remotePath = [self getStringFromDictionary:dictionary WithKey:@"link"];
    dhammaModel.author = @"test";
    
    
}


//+ (void)setMerchant:(QBMerchant *)merchant withDictionary:(NSDictionary *)dictionary {
//    merchant.name = [self getStringFromDictionary:dictionary WithKey:@"merchant_name"];
//    merchant.email = [self getStringFromDictionary:dictionary WithKey:@"email"];
//    merchant.phone = [self getStringFromDictionary:dictionary WithKey:@"phone"];
//    merchant.address = [self getStringFromDictionary:dictionary WithKey:@"address"];
//    if (dictionary[@"merchant_img"] && [dictionary[@"merchant_img"] isKindOfClass:[NSArray class]] && [dictionary[@"merchant_img"] count] > 0) {
//        NSArray *imgs = dictionary[@"merchant_img"];
//        merchant.imageURL = imgs.firstObject[@"path"];
//    }
//}


@end
