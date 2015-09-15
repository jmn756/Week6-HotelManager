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
#import "Guest.h"
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

+ (BOOL) bookReservationForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)selectedRoom guestFirst:(NSString *)guestFirst guestLast:(NSString *)guestLast {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
  
  reservation.startdate = startDate;
  reservation.enddate = endDate;
  reservation.room = selectedRoom;
  selectedRoom.reservation = [selectedRoom.reservation setByAddingObject:reservation];
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"lastname like %@ AND firstname like %@", guestLast, guestFirst];
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (results.count > 0) {
    Guest *guest = results.firstObject;
    reservation.guest = guest;
    guest.reservation = [guest.reservation setByAddingObject:reservation];
  } else {
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
    guest.firstname = guestFirst;
    guest.lastname = guestLast;
    guest.reservation = [guest.reservation setByAddingObject:reservation];
    reservation.guest = guest;
  }
  
  NSError *saveError;
  if (![appDelegate.coreDataStack.managedObjectContext save:&saveError]) {
      NSLog(@"%@",saveError.localizedDescription);
    return false;
  } else {
    return true;
  }
    
}

+ (NSArray *)fetchReservationsForLastName:(NSString *)lastName {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
 
  //if lastname is not empty, set the predicate
  if (![lastName isEqual:@""]) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guest.lastname = %@",lastName];
    request.predicate = predicate;
  }
  
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  if (fetchError) {
    return nil;
  }
  return results;
 }

@end
