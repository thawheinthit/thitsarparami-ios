//
//  Utility.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static NSDateFormatter *dateFormatter;

+ (UIColor *)colorFromHexString:(NSString *)hexString{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


+ (void)initDateFormatter {
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:tDateTimeFormat];
    }
}

+ (NSString*)getStringFromDate:(NSDate *)date{
    [self initDateFormatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate*)getDateFromString:(NSString *)dateString{
    [self initDateFormatter];
    return [dateFormatter dateFromString:dateString];
}

+ (id)serializeJSON:(NSString *)jsonString{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return json;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)scaleTheImage:(UIImage*)image
{
    CGSize size = CGSizeMake(32, 32);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+(void)fetchImage:(NSString *)urlStringOfImage
{
//    dispatch_queue_t imageQueue= dispatch_queue_create("imageQueue", nil);
//    dispatch_async(imageQueue, ^{
//        NSURL *imageURL = [NSURL URLWithString:urlStringOfImage];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        return image;
//        
////        dispatch_async(dispatch_get_main_queue(), ^{
////            
////        });
//    });
    
    
}


@end
