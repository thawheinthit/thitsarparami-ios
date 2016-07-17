//
//  NewsService.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 12/3/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "APIClient.h"
#import "News.h"

@interface NewsService : APIClient

+ (RACSignal*)getAllNews;
+ (void)configureNews:(News *)newsModel withDictionary:(NSDictionary*)dictionary;

@end
