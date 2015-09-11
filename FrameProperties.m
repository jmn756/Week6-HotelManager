//
//  FrameProperties.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/9/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "FrameProperties.h"

@implementation FrameProperties

+ (CGRect)getScreenFrameSize
{
  CGRect frame = [UIScreen mainScreen].bounds;
  
  return frame;
}


//thirdHeight = frame.size.height/3;
//int quarterWidth = frame.size.width/4;
//int twoThirdsHeight = thirdHeight*2;


@end
