//
//  ContactService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 19/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "Contact.h"

@interface ContactService : APIClient

+ (RACSignal*)getContact;
+ (void)configureContact:(Contact *)contactModel withDictionary:(NSDictionary*)dictionary;
@end
