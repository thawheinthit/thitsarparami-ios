//
//  APIClient.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import "Define.h"
#import "Utility.h"

@interface APIClient : NSObject

+ (NSError *)getAFNetworkingErrorMessage:(NSError *)error;
+ (NSError *)getAFNetworkingErrorMessage:(NSError *)error withOperation:(AFHTTPRequestOperation *)operation;
+ (NSNumber *)getNumberFromDictionary:(NSDictionary *)dictionary WithKey:(NSString *)key;
+ (NSString *)getStringFromDictionary:(NSDictionary *)dictionary WithKey:(NSString *)key;

@end
