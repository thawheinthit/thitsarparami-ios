//
//  Dhamma.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "Dhamma.h"

@implementation Dhamma

- (NSString *)fileTypeExtension {
    return @".dat";
}

- (AUMediaType)itemType {
    return AUMediaTypeAudio;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_author forKey:@"author"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_remotePath forKey:@"remotePath"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_fileTypeExtension forKey:@"fileTypeExtension"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [[Dhamma alloc] init];
    if (self) {
        _author = [aDecoder decodeObjectForKey:@"author"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _remotePath = [aDecoder decodeObjectForKey:@"remotePath"];
        _fileTypeExtension = [aDecoder decodeObjectForKey:@"fileTypeExtension"];
    }
    return self;
}


//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_dhammaTitle forKey:@"dhammaTitle"];
//    [aCoder encodeObject:_filePath forKey:@"filePath"];
//    [aCoder encodeObject:_uid forKey:@"uid"];
//    [aCoder encodeObject:_fileTypeExtension forKey:@"fileTypeExtension"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [[Dhamma alloc] init];
//    if (self) {
//        _dhammaTitle = [aDecoder decodeObjectForKey:@"dhammaTitle"];
//        _filePath = [aDecoder decodeObjectForKey:@"filePath"];
//        _uid = [aDecoder decodeObjectForKey:@"uid"];
//        _fileTypeExtension = [aDecoder decodeObjectForKey:@"fileTypeExtension"];
//    }
//    return self;
//}

@end

@implementation DhammaItem

- (NSString *)fileTypeExtension {
    return @".mp3";
}

@end




@implementation ExampleMediaCollection

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_author forKey:@"author"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_mediaItems forKey:@"mediaItems"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [[ExampleMediaCollection alloc] init];
    if (self) {
        _author = [aDecoder decodeObjectForKey:@"author"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _mediaItems = [aDecoder decodeObjectForKey:@"mediaItems"];
    }
    return self;
}

- (BOOL)containsMediaType:(AUMediaType)type {
    if (type == AUMediaTypeAudio) {
        return YES;
    } else {
        return NO;
    }
}
@end
