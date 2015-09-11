//
//  HotelService.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/10/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "HotelService.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"

@implementation HotelService

+ (NSArray *) fetchAvailableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startdate <= %@ AND enddate >= %@",startDate,endDate];
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if (finalError) {
    return nil;
  }
  return finalResults;
  
}

+ (void) bookReservationForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
  
  reservation.startdate = startDate;
  reservation.enddate = endDate;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"number == 2"];
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (results.count > 0) {
    Room *room = results.firstObject;
    reservation.room = room;
    NSError *saveError;
    if (![appDelegate.coreDataStack.managedObjectContext save:&saveError]) {
      NSLog(@"%@",saveError.localizedDescription);
    }
    
  }
}



@end
