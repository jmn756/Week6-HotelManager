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
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int thirdHeight = frame.size.height/3;
  int quarterWidth = frame.size.width/4;
  int twoThirdsHeight = thirdHeight*2;
  NSString *fontName = @"Copperplate";
  
  //topView creation
  CGRect top = CGRectMake(0, 0, frame.size.width, thirdHeight);
  UIView *topView = [[UIView alloc] initWithFrame:top];
  self.topRect = top;
  [topView setTranslatesAutoresizingMaskIntoConstraints:false];
  topView.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                                 green:169.0f/255.0f
                                                  blue:135.0f/255.0f
                                                 alpha:1.0f];
  [rootView addSubview:topView];
  
  //Text on topView
  UILabel *browseHotelLabel = [[UILabel alloc] initWithFrame:CGRectMake(quarterWidth, thirdHeight/2, 200, 30)];
  [browseHotelLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  browseHotelLabel.text = @"Browse Hotels";
  browseHotelLabel.textColor = [UIColor blackColor];
  browseHotelLabel.font = [UIFont fontWithName:fontName size:24];
  [topView addSubview:browseHotelLabel];
  
  //middleWhiteView creation
  CGRect middle = CGRectMake(0, thirdHeight + 1, frame.size.width, thirdHeight);
  UIView *midView = [[UIView alloc] initWithFrame:middle];
  self.middleRect = middle;
  [midView setTranslatesAutoresizingMaskIntoConstraints:false];
  midView.backgroundColor = [UIColor whiteColor];
  [rootView addSubview:midView];

  //Text on middleWhiteView
  UILabel *bookARoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(quarterWidth + 10, 75, 200, 30)];
  [bookARoomLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  bookARoomLabel.text = @"Book A Room";
  bookARoomLabel.textColor = [UIColor blackColor];
  bookARoomLabel.font = [UIFont fontWithName:fontName size:24];
  [midView addSubview:bookARoomLabel];
  
  //bottomView creation
  CGRect bottom = CGRectMake(0, twoThirdsHeight, frame.size.width, thirdHeight);
  UIView *bottomView = [[UIView alloc] initWithFrame:bottom];
  self.bottomRect = bottom;
  [bottomView setTranslatesAutoresizingMaskIntoConstraints:false];
  bottomView.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                            green:169.0f/255.0f
                                             blue:135.0f/255.0f
                                            alpha:1.0f];
  [rootView addSubview:bottomView];
  
  //Text on bottomView
  UILabel *lookupReservationLabel = [[UILabel alloc] initWithFrame:CGRectMake(quarterWidth - 20, 75, 250, 30)];
  [lookupReservationLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  lookupReservationLabel.text = @"Lookup Reservation";
  lookupReservationLabel.textColor = [UIColor blackColor];
  lookupReservationLabel.font = [UIFont fontWithName:fontName size:24];
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
