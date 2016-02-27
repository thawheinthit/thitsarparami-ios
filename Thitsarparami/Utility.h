//
//  Utility.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"

@interface Utility : NSObject

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (NSString*)getStringFromDate:(NSDate *)date;

+ (NSDate*)getDateFromString:(NSString *)dateString;

+ (id)serializeJSON:(NSString *)jsonString;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+(UIImage*)scaleTheImage:(UIImage*)image;

@end
