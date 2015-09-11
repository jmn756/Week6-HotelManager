//
//  AppDelegate.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
@class CoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CoreDataStack *coreDataStack;


@end

