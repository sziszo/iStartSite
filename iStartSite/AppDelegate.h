//
//  AppDelegate.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Mailbox.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;

+ (AppDelegate *)sharedAppDelegate;


- (UIStoryboard *)storyboard;

- (Mailbox *)getTestAccount;

- (Mailbox *)getTestAccountInContext:(NSManagedObjectContext *)localContext;

@end

