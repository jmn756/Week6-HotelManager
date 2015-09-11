//
//  HoldContraints.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/10/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSDictionary *views = @{@"topView": topView, @"browseHotelLabel": browseHotelLabel, @"bookARoomLabel": bookARoomLabel, @"bottomView": bottomView, @"lookupReservationLabel": lookupReservationLabel};

//topView constraints
//  NSArray *topViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[topView]-|" options:0 metrics:nil views:views];
//  [rootView addConstraints:topViewHorizontalConstraints];
//
//  NSArray *topViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[topView]" options:0 metrics:nil views:views];
//  [rootView addConstraints:topViewVerticalConstraints];
//

//   //browseHotelLabel constraints
//  NSArray *browseHotelLabelVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[browseHotelLabel]" options:0 metrics:nil views:views];
//  [topView addConstraints:browseHotelLabelVerticalConstraints];
//
//  NSArray *greenLabelHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[greenLabel]" options:0 metrics:nil views:views];
//  [rootView addConstraints:greenLabelHorizontalConstraints];
//  NSLayoutConstraint *browseHotelLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:browseHotelLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
//  [topView addConstraint:browseHotelLabelCenterXConstraint];
//  browseHotelLabelCenterXConstraint.active = true;
//