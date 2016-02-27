//
//  DhammaService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 31/1/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "Monk.h"
#import "Dhamma.h"

@interface DhammaService : APIClient

+ (RACSignal*)getDhammaByMonk:(Monk *)monk;

+ (void)configureDhamma:(Dhamma *)dhammaModel withDictionary:(NSDictionary*)dictionary;


@end
