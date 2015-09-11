//
//  HotelService.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/10/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HotelService : NSObject

+ (NSArray *) fetchAvailableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (void) bookReservationForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
