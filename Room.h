//
//  Room.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/8/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSSet *reservation;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationObject:(NSManagedObject *)value;
- (void)removeReservationObject:(NSManagedObject *)value;
- (void)addReservation:(NSSet *)values;
- (void)removeReservation:(NSSet *)values;

@end
