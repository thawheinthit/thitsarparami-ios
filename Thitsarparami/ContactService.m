//
//  ContactService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 19/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ContactService.h"

@implementation ContactService
+ (RACSignal *)getContact {
    
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *request = [NSString stringWithFormat:@"%@%@", APIPath, APIContact];
    
    
    [manager GET:request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//                NSLog(@"JSON: %@", responseObject[@"data"]);
        
        
        [subject sendNext:[[[responseObject[@"data"][@"contacts"] rac_sequence] map:^id(NSDictionary* contactDictionary) {
            
            Contact *contact = [Contact new];
            [self configureContact:contact withDictionary:contactDictionary];
            return contact;
            
        }] array]];
        [subject sendCompleted];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:[self getAFNetworkingErrorMessage:error]];
    }];
    return subject;
}

+ (void)configureContact:(Contact *)contactModel withDictionary:(NSDictionary*)dictionary{
    contactModel.objectId = dictionary[@"id"];
    contactModel.contactInfo = dictionary[@"contactInfo"];
}



@end
