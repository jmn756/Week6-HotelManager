//
//  Reservation.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/8/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * startdate;
@property (nonatomic, retain) NSDate * enddate;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Guest *guest;

@end
