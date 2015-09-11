//
//  ConfirmReservationViewController.h
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/11/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ConfirmReservationViewController : UIViewController

@property (strong, nonatomic) Room *selectedRoom;
@property (strong, nonatomic) NSDate *startdate;
@property (strong, nonatomic) NSDate *enddate;

@end
