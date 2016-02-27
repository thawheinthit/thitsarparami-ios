//
//  MonkService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 30/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "MonkService.h"

@implementation MonkService

+ (RACSignal*)getMonkByMonkID:(Monk *)monk{
    
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [self getAllRequestByMonk:monk];
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"data %@", responseObject);
        
        [subject sendNext:[[[responseObject[@"data"] rac_sequence] map:^id(NSDictionary *monkData) {
            Monk *tmpMonk = [Monk new];
            [self configureMonk:monk withDictionary:monkData];
            return tmpMonk;
        }] array]];
        
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:[self getAFNetworkingErrorMessage:error]];
    }];
    return subject;
}


+ (NSString *)getAllRequestByMonk:(Monk*)monk {
    NSString *subPath = [NSString stringWithFormat:APIMonkByID, monk.objectId];
    return [NSString stringWithFormat:@"%@%@", APIPath, subPath];
}

+ (void)configureMonk:(Monk *)monkModel withDictionary:(NSDictionary*)dictionary{
    monkModel.objectId = dictionary[@"id"];
    monkModel.monkName = dictionary[@"name"];
    monkModel.monkImage = dictionary[@"image"];
    monkModel.dhammaCount = dictionary[@"count"];
}

@end
