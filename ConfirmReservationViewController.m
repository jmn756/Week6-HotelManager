//
//  ConfirmReservationViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/11/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ConfirmReservationViewController.h"
#import "Room.h"
#import "Hotel.h"


@interface ConfirmReservationViewController ()

@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation ConfirmReservationViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int quarterWidth = frame.size.width/4;
  int thirdHeight = frame.size.height/3;
  int twoThirdsHeight = thirdHeight*2;
  int navBarHeight = 65;
  int textStripHeight = 50;
  int startPic = navBarHeight + 70;
  NSString *fontName = @"Copperplate";
  
  //firstNameTextField creation
  CGRect top = CGRectMake(30, navBarHeight, frame.size.width-60, 30);
  UITextField *firstNameTextField = [[UITextField alloc] initWithFrame:top];
  firstNameTextField.placeholder = @"Please enter First Name here.";
  [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  firstNameTextField.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                            green:169.0f/255.0f
                                             blue:135.0f/255.0f
                                            alpha:1.0f];
  [rootView addSubview:firstNameTextField];
  
  //lastNameTextView creation
  CGRect bottom = CGRectMake(30, navBarHeight + 35, frame.size.width-60, 30);
  UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:bottom];
  lastNameTextField.placeholder = @"Please enter Last Name here.";
  [lastNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameTextField.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                                      green:169.0f/255.0f
                                                       blue:135.0f/255.0f
                                                      alpha:1.0f];
  [rootView addSubview:lastNameTextField];
  
  CGRect iv = CGRectMake(0, startPic , frame.size.width, thirdHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"hotelroom.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  //Text on confirm reservation page
  UILabel *datesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, startPic + 100, 350, 350)];
  datesLabel.lineBreakMode = NSLineBreakByWordWrapping;
  datesLabel.numberOfLines = 0;
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy"];
  NSString *startDateString = [formatter stringFromDate:self.startdate];
  NSString *endDateString = [formatter stringFromDate:self.enddate];
  
   NSString *hotelStars = [NSString stringWithFormat:@"%@", self.selectedRoom.hotel.stars];
   NSString *roomNumber = [NSString stringWithFormat:@"%@", self.selectedRoom.number];
  
  [datesLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  datesLabel.textAlignment = NSTextAlignmentCenter;
  datesLabel.text = @"Reservation at the lovely ";
  datesLabel.text = [datesLabel.text stringByAppendingString:hotelStars];
  datesLabel.text = [datesLabel.text stringByAppendingString:@"-star "];
  datesLabel.text = [datesLabel.text stringByAppendingString:self.selectedRoom.hotel.name];
  datesLabel.text = [datesLabel.text stringByAppendingString:@"\nin "];
  datesLabel.text = [datesLabel.text stringByAppendingString:self.selectedRoom.hotel.location];
  datesLabel.text = [datesLabel.text stringByAppendingString:@": Room "];
  datesLabel.text = [datesLabel.text stringByAppendingString:roomNumber];
  datesLabel.text = [datesLabel.text stringByAppendingString:@"\nfrom "];
  datesLabel.text = [datesLabel.text stringByAppendingString:startDateString];
  datesLabel.text = [datesLabel.text stringByAppendingString:@" thru "];
  datesLabel.text = [datesLabel.text stringByAppendingString:endDateString];
  
  datesLabel.textColor = [UIColor whiteColor];
  datesLabel.font = [UIFont fontWithName:fontName size:13];
  [rootView addSubview:datesLabel];
  
  //Continue button setup
  CGRect button = CGRectMake(quarterWidth + 50, frame.size.height - 75, 100, 25);
  UIButton *submitButton = [[UIButton alloc] initWithFrame:(button)];
  self.submitButton = submitButton;
  [self.submitButton setTitle:@"Submit" forState: UIControlStateNormal];
  self.submitButton.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                                        green:169.0f/255.0f
                                                         blue:135.0f/255.0f
                                                        alpha:1.0f];
  [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [rootView addSubview:self.submitButton];


  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Confirm Reservation";
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitButtonClicked:(UIButton *)sender{
  NSLog(@"user pressed submit button");
  
}



@end
