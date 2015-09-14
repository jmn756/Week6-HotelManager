//
//  MainMenuViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HotelsViewController.h"
#import "BookRoomViewController.h"
#import "ReservationLookupViewController.h"

@interface MainMenuViewController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic) CGRect topRect;
@property (nonatomic) CGRect middleRect;
@property (nonatomic) CGRect bottomRect;

@end

@implementation MainMenuViewController


- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  [self setupTapRecognizer:rootView];
  
  //variables
  UIColor *customGreen = [UIColor colorWithRed:77.0f/255.0f
                                        green:169.0f/255.0f
                                         blue:135.0f/255.0f
                                        alpha:1.0f];

  CGRect frame = [UIScreen mainScreen].bounds;
  int screenWidth = frame.size.width;
  int screenHeight = frame.size.height;
  int viewHeight = screenHeight/3;
  int halfViewHeight = viewHeight/2;
  int quarterWidth = screenWidth/4;
  int twiceViewHeight = viewHeight*2;
  int labelHeight = 30;
  int stdLabelWidth = 200;
  int longLabelWidth = 250;
  int adjustedX10 = quarterWidth + 10;
  int adjustedX20 = quarterWidth - 20;
  int fontSize = 24;
  NSString *fontName = @"Copperplate";
  NSString *browseHotels = @"Browse Hotels";
  NSString *bookARoom = @"Book A Room";
  NSString *lookupReservation = @"Lookup Reservation";
  
  
  //topView creation
  CGRect top = CGRectMake(0, 0, screenWidth, viewHeight);
  UIView *topView = [[UIView alloc] initWithFrame:top];
  self.topRect = top;
  [topView setTranslatesAutoresizingMaskIntoConstraints:false];
  topView.backgroundColor = customGreen;
  [rootView addSubview:topView];
  
  //Text on topView
  CGRect bHLabel = CGRectMake(quarterWidth, halfViewHeight, stdLabelWidth, labelHeight);
  UILabel *browseHotelLabel = [[UILabel alloc] initWithFrame:bHLabel];
  [browseHotelLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  browseHotelLabel.text = browseHotels;
  browseHotelLabel.textColor = [UIColor blackColor];
  browseHotelLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [topView addSubview:browseHotelLabel];
  
  //middleWhiteView creation
  CGRect middle = CGRectMake(0, viewHeight, screenWidth, viewHeight);
  UIView *midView = [[UIView alloc] initWithFrame:middle];
  self.middleRect = middle;
  [midView setTranslatesAutoresizingMaskIntoConstraints:false];
  midView.backgroundColor = [UIColor whiteColor];
  [rootView addSubview:midView];

  //Text on middleWhiteView
  CGRect barLabel = CGRectMake(adjustedX10, halfViewHeight, stdLabelWidth, labelHeight);
  UILabel *bookARoomLabel = [[UILabel alloc] initWithFrame:barLabel];
  [bookARoomLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  bookARoomLabel.text = bookARoom;
  bookARoomLabel.textColor = [UIColor blackColor];
  bookARoomLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [midView addSubview:bookARoomLabel];
  
  //bottomView creation
  CGRect bottom = CGRectMake(0, twiceViewHeight, screenWidth, viewHeight);
  UIView *bottomView = [[UIView alloc] initWithFrame:bottom];
  self.bottomRect = bottom;
  [bottomView setTranslatesAutoresizingMaskIntoConstraints:false];
  bottomView.backgroundColor = customGreen;
  [rootView addSubview:bottomView];
  
  //Text on bottomView
  CGRect lrLabel = CGRectMake(adjustedX20, halfViewHeight, longLabelWidth, labelHeight);
  UILabel *lookupReservationLabel = [[UILabel alloc] initWithFrame:lrLabel];
  [lookupReservationLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  lookupReservationLabel.text = lookupReservation;
  lookupReservationLabel.textColor = [UIColor blackColor];
  lookupReservationLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [bottomView addSubview:lookupReservationLabel];
  
  self.view = rootView;
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Main Menu";
  
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(void)setupTapRecognizer:(UIView *)viewRect {
  
  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
  tapRecognizer.delegate = self;
  tapRecognizer.numberOfTapsRequired = 1;
  [viewRect addGestureRecognizer:tapRecognizer];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
  CGPoint p = [touch locationInView:gestureRecognizer.view];
  NSLog(@" %f %f", p.x, p.y);
  
  if (CGRectContainsPoint(_topRect, p)) {
    //transfer to Hotels VC
    HotelsViewController *hotelVC = [[HotelsViewController alloc] init];
    [self.navigationController pushViewController:hotelVC animated:YES];
  } else {
    if (CGRectContainsPoint(_middleRect, p)) {
      //transfer to Book A Room VC
      BookRoomViewController *bookRoomVC = [[BookRoomViewController alloc] init];
      [self.navigationController pushViewController:bookRoomVC animated:YES];
    } else {
      if (CGRectContainsPoint(_bottomRect, p)) {
        //transfer to Reservation Lookup VC
        ReservationLookupViewController *reserveLookupVC = [[ReservationLookupViewController alloc] init];
        [self.navigationController pushViewController:reserveLookupVC animated:YES];
      }
      
    }
  }
  
  return true;
}


@end
