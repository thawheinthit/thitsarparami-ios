//
//  RegisterService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 12/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "Setting.h"
@interface RegisterService : APIClient

+ (RACSignal *)addNewDevice:(Setting *)setting;

@end
