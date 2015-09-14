//
//  HotelService.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/10/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Reservation.h"


@interface HotelService : NSObject

+ (NSArray *) fetchAvailableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (BOOL) bookReservationForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)selectedRoom guestFirst:(NSString *)guestFirst guestLast:(NSString *)guestLast;
+ (NSArray *)fetchReservationsForLastName:(NSString *)lastName;
@end
