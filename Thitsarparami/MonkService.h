//
//  MonkService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 30/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "DhammaCategory.h"
#import "Monk.h"


@interface MonkService : APIClient
+ (RACSignal*)getMonkByMonkID:(Monk *)monk;

+ (void)configureMonk:(Monk *)monkModel withDictionary:(NSDictionary*)dictionary;

@end
