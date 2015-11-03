//
//  ContactEmail.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface ContactEmail : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) Contact *contact;

@end
