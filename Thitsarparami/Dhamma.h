//
//  Dhamma.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//

#import "Model.h"
#import <AUMediaPlayer/AUMediaPlayer.h>

@interface Dhamma : Model <AUMediaItem>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *remotePath;

@property (nonatomic, strong) NSString *fileTypeExtension;



@property (nonatomic, strong) NSString *dhammaTitle;
@property (nonatomic, strong) NSString *filePath;

@end



@interface DhammaItem : Dhamma
@end

@interface ExampleMediaCollection :NSObject <AUMediaItemCollection>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *mediaItems;

@end

