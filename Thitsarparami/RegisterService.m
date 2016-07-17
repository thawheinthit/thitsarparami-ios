//
//  RegisterService.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 12/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "RegisterService.h"

@implementation RegisterService

+ (RACSignal *)addNewDevice:(Setting *)setting{
    RACReplaySubject *subject = [RACReplaySubject subject];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer new];
    NSString *request = [self getAllRequest];
    NSDictionary *params = [self getRegisterDevice:setting];
    
    [manager POST:request parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        [subject sendNext:setting];
        [subject sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subject sendError:[self getAFNetworkingErrorMessage:error withOperation:operation]];
    }];
    return subject;
}

+ (NSString*)getAllRequest {
    return [NSString stringWithFormat:@"%@%@", APIPath, APIRegister];
}

//
//+ (RACSignal *)changeCurrentPassword:(NSString *)currentPassword toNewPassword:(NSString *)newPassword andRetype:(NSString *)retypePassword {
//    RACReplaySubject *subject = [RACReplaySubject subject];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer new];
//    NSString *request = [self getRequestChangePasswordForConsumer: [QBConsumer loginUser]];
//    
//    NSLog(@"pass %@", request);
//    NSDictionary *params = @{
//                             @"current_pass" : currentPassword,
//                             @"new_pass" : newPassword
//                             };
//    [manager POST:request parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        [subject sendNext:responseObject];
//        [subject sendCompleted];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [subject sendError:[self getAFNetworkingErrorMessage:error withOperation:operation]];
//    }];
//    return subject;
//}
+ (NSDictionary*)getRegisterDevice:(Setting*)setting {
    return @{ @"device_id" : setting.deviceToken, @"notification" : setting.notiStatus, @"device_name": setting.deviceName };
}
@end
