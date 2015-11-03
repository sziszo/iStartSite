//
//  AppDelegate.m
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//


#import "AppDelegate.h"

#import <MailCore/MailCore.h>
#import <MailCore/MCOIMAPFetchMessagesOperation.h>

#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"application did finish launching");
    
//    MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
//    session.hostname = @"imap.gmail.com";
//    session.port = 993;
//    session.username = @"matt@gmail.com";
//    session.password = @"password";
//    session.connectionType = MCOConnectionTypeTLS;
//    
//    MCOIndexSet *uidSet = [MCOIndexSet indexSetWithRange:MCORangeMake(1,UINT64_MAX)];
//    MCOIMAPFetchMessagesOperation *fetchOp =
//    [session fetchMessagesByUIDOperationWithFolder:@"INBOX"
//                                       requestKind:MCOIMAPMessagesRequestKindHeaders
//                                              uids:uidSet];
//    
//    [fetchOp start:^(NSError *err, NSArray *msgs, MCOIndexSet *vanished) {
//        NSLog(@"Fetched all the message headers!.");
//    }];
    
    // Override point for customization after application launch.
    
    //loggers
    [self setupLoggers];
    
    //core data
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"iStartSite.sqlite"];
    
    //load test account
    [self initTestData];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}


#pragma mark - DDLog loggers

- (void)setupLoggers {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
}

#pragma mark - setup

- (void)initTestData {
    
    NSArray* accounts = [Mailbox MR_findAll];
    NSLog(@"accounts number = %lu", (unsigned long)[accounts count]);
    
    Mailbox* account = [self getTestAccount];
    if(account) {
        NSLog(@"Account has already been stored");
        if (![account.loginName isEqualToString:@"***ACCOUNT***"]) {
            NSLog(@"Modifying loginName! The loginname was %@", account.loginName);
            
            account.loginName = @"***ACCOUNT***";
            
            NSError* error = nil;
            [[NSManagedObjectContext MR_contextForCurrentThread] save:&error];
            if (error) {
                NSLog(@"An error occured: %@", error);
            }
        }
        
    } else {
        NSLog(@"saving test account ...");
        
        Mailbox* account = [Mailbox MR_createEntity];
        
        account.accountName = @"***ACCOUNT***@gmail.com";
        account.server = @"imap.gmail.com";
        account.port = [NSNumber numberWithInt:993];
        account.loginName = @"***ACCOUNT***";
        account.password = @"***PASSWORD***";
        
        NSError *error = nil;
        [[NSManagedObjectContext MR_defaultContext] save:&error];
        if (error) {
            NSLog(@"An error occured while saving test account: %@", error);
        }
    }
    
}


- (Mailbox *)getTestAccount  {
    return [self getTestAccountInContext:[NSManagedObjectContext MR_defaultContext]];
}

- (Mailbox *)getTestAccountInContext:(NSManagedObjectContext *)localContext  {
    return [Mailbox MR_findFirstByAttribute:@"accountName" withValue:@"***ACCOUNT***@gmail.com" inContext:localContext];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - AppDelegate methods

+ (AppDelegate *)sharedAppDelegate {
    return [[UIApplication sharedApplication] delegate];
}

- (UIStoryboard *)storyboard {
    return self.window.rootViewController.storyboard;
}

@end
