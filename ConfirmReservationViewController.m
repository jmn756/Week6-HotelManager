//
//  ConfirmReservationViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/11/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ConfirmReservationViewController.h"
#import "HotelService.h"
#import "Room.h"
#import "Hotel.h"
#import "MainMenuViewController.h"


@interface ConfirmReservationViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UITextField *firstTextField;
@property (strong, nonatomic) UITextField *lastTextField;

@end

@implementation ConfirmReservationViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor blackColor];
  
  //variables
  UIColor *customGreen = [UIColor colorWithRed:77.0f/255.0f
                                         green:169.0f/255.0f
                                          blue:135.0f/255.0f
                                         alpha:1.0f];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int screenWidth = frame.size.width;
  int screenHeight = frame.size.height;
  int viewHeight = screenHeight/3;
  int quarterWidth = screenWidth/4;
  int labelHeight = 30;
  int stdWidth = 100;
  int longLabelValue = 350;
  int adjustedWidth = screenWidth-60;
  int adjustedX30 = 30;
  int adjustedX10 = 10;
  int adjustedX50 = quarterWidth + 50;
  int fontSize = 13;
  NSString *fontName = @"Copperplate";
  int buttonY = frame.size.height - 75;
  int navBarHeight = 65;
  int startPic = navBarHeight + 70;
  
  //firstNameTextField creation
  CGRect top = CGRectMake(adjustedX30, navBarHeight, adjustedWidth, labelHeight);
  UITextField *firstNameTextField = [[UITextField alloc] initWithFrame:top];
  self.firstTextField = firstNameTextField;
  self.firstTextField.delegate = self;
  firstNameTextField.placeholder = @"Please enter First Name here.";
  [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  firstNameTextField.backgroundColor = customGreen;
  [rootView addSubview:firstNameTextField];
  
  //lastNameTextView creation
  CGRect bottom = CGRectMake(adjustedX30, navBarHeight + 35, adjustedWidth, labelHeight);
  UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:bottom];
  self.lastTextField = lastNameTextField;
  self.lastTextField.delegate = self;
  lastNameTextField.placeholder = @"Please enter Last Name here.";
  [lastNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameTextField.backgroundColor = customGreen;
  [rootView addSubview:lastNameTextField];
  
  CGRect iv = CGRectMake(0, startPic , screenWidth, viewHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"hotelroom.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  //Text on confirm reservation page
  CGRect dLabel = CGRectMake(adjustedX10, startPic + 100, longLabelValue, longLabelValue);
  UILabel *datesLabel = [[UILabel alloc] initWithFrame:dLabel];
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
  datesLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [rootView addSubview:datesLabel];
  
  //Continue button setup
  CGRect button = CGRectMake(adjustedX50, buttonY, stdWidth, labelHeight);
  UIButton *submitButton = [[UIButton alloc] initWithFrame:(button)];
  self.submitButton = submitButton;
  [self.submitButton setTitle:@"Submit" forState: UIControlStateNormal];
  self.submitButton.backgroundColor = customGreen;
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


-(void)submitButtonClicked:(UIButton *)sender{
  
  if ([self.lastTextField.text isEqual:@""] || [self.firstTextField.text isEqual:@""]) {
       [self presentEmptyNameFieldAlert];
  } else {
    BOOL result = [HotelService bookReservationForStartDate:self.startdate endDate:self.enddate room:self.selectedRoom guestFirst:self.firstTextField.text guestLast:self.lastTextField.text];
    if (result)
    {
      [self presentSuccessfulBookingAlert];
      [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
      [self presentUnSuccessfulBookingAlert];
    }
  }
}

- (void)presentEmptyNameFieldAlert
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name Fields Are Required" message:@"Please make an entry in BOTH name fields." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [alert show];
}

- (void)presentSuccessfulBookingAlert
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Booking Confirmed" message:@"Your reservation has been successfully booked" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [alert show];
}

- (void)presentUnSuccessfulBookingAlert
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Booking Not Confirmed" message:@"Your reservation has NOT been successfully booked" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [alert show];
}



#pragma mark: -- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.firstTextField resignFirstResponder];
  [self.lastTextField resignFirstResponder];
  return true;
}


@end
