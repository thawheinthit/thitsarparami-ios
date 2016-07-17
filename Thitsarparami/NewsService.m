//
//  NewsService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 12/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "NewsService.h"

@implementation NewsService

+ (RACSignal *)getAllNews {

    RACReplaySubject *subject = [RACReplaySubject subject];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [NSString stringWithFormat:@"%@%@", APIPath, APINews];
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [subject sendNext:[[[responseObject[@"data"] rac_sequence] map:^id(NSDictionary* newsDictionary) {
            
            News *news = [News new];
            [self configureNews:news withDictionary:newsDictionary];
            return news;
            
        }] array]];
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:[self getAFNetworkingErrorMessage:error]];
    }];
    return subject;
}

+ (NSString*)getAllRequest {
    return [NSString stringWithFormat:@"%@%@", APIPath, APINews];
}

+ (void)configureNews:(News *)newsModel withDictionary:(NSDictionary*)dictionary{
    newsModel.objectId = dictionary[@"id"];
    newsModel.newsTitle = dictionary[@"title"];
    newsModel.newsDescription = dictionary[@"content"];
}
@end
