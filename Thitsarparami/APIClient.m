//
//  APIClient.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient
+ (NSError *)getAFNetworkingErrorMessage:(NSError *)error withOperation:(AFHTTPRequestOperation *)operation {
    if (error.code == kCFURLErrorNotConnectedToInternet) {
        return error;
    }
    
    if (operation.response.statusCode == 404) {
        NSDictionary *info = @{NSLocalizedDescriptionKey : @"Not Found"};
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:404 userInfo:info];
        return underlyingError;
    }
    NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    NSData *data = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    if (parseError) {
        NSDictionary *info = @{NSLocalizedDescriptionKey : @"Cannot serialize data from body"};
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:500 userInfo:info];
        return underlyingError;
    }
    else if (json && [json isKindOfClass:[NSDictionary class]]) {
        if (json[@"error"] && [json[@"error"] isKindOfClass:[NSDictionary class]]) {
            if (json[@"error"][@"message"] && [json[@"error"][@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *info = @{NSLocalizedDescriptionKey : json[@"error"][@"message"]};
                NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                                      code:500 userInfo:info];
                return underlyingError;
            }
        }
    }
    if (json) {
        NSLog(@"json %@", json);
        int statusCode= 500;
        if (json[@"error"] && [json[@"error"] isKindOfClass:[NSDictionary class]]) {
            if (json[@"error"][@"status_code"] && [json[@"error"][@"status_code"] isKindOfClass:[NSNumber class]]) {
                statusCode = [json[@"error"][@"status_code"] intValue];
            }
        }
        if (statusCode == 422) {
            
            NSString *message;
            for (NSString *key in json[@"error"][@"message"]) {
                message =  json[@"error"][@"message"][key][0];
            }
            NSDictionary *info = @{NSLocalizedDescriptionKey : message};
            NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                                  code:statusCode userInfo:info];
            return underlyingError;
        }
        NSDictionary *info = @{NSLocalizedDescriptionKey : @"Something went wrong"};
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:statusCode userInfo:info];
        return underlyingError;
    }
    return error;
    
}

+ (NSError *)getAFNetworkingErrorMessage:(NSError *)error{
    NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    NSData *data = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    if (parseError) {
        NSDictionary *info = @{NSLocalizedDescriptionKey : @"Cannot serialize data from body"};
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:500 userInfo:info];
        return underlyingError;
    }
    else if (json && [json isKindOfClass:[NSDictionary class]]) {
        if (json[@"error"] && [json[@"error"] isKindOfClass:[NSDictionary class]]) {
            if (json[@"error"][@"message"] && [json[@"error"][@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *info = @{NSLocalizedDescriptionKey : json[@"error"][@"message"]};
                NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                                      code:500 userInfo:info];
                return underlyingError;
            }
        }
    }
    if (json) {
        NSLog(@"json %@", json);
        NSDictionary *info = @{NSLocalizedDescriptionKey : @"Something went wrong"};
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:500 userInfo:info];
        return underlyingError;
    }
    return error;

}
+ (NSNumber *)getNumberFromDictionary:(NSDictionary *)dictionary WithKey:(NSString *)key{
    id result = dictionary[key];
    if (result == [NSNull null]) {
        return @(0);
    }
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    if ([result isKindOfClass:[NSString class]]) {
        return [f numberFromString:result];
    }
    return result;

}
+ (NSString *)getStringFromDictionary:(NSDictionary *)dictionary WithKey:(NSString *)key{
    if (dictionary[key] == [NSNull null] || !dictionary[key]) {
        return nil;
    }
    return dictionary[key];
}

@end
