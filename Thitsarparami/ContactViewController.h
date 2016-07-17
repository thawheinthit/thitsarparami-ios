//
//  ContactViewController.h
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 27/2/16.
//  Copyright © 2016 Thaw Hein Thit. All rights reserved.
//

#import "ViewController.h"
#import "ContactService.h"
#import "Contact.h"
#import "ContactViewModel.h"

@interface ContactViewController : ViewController
@property (strong, nonatomic) NSArray *contactArray;
@property (strong, nonatomic) ContactViewModel *vm;
@property (weak, nonatomic) IBOutlet UITextView *contactTextView;
@property (strong, nonatomic) Contact *currentContact;


@end
