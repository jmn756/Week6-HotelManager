//
//  BookRoomViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "BookRoomViewController.h"
#import "AvailabilityResultsViewController.h"

@interface BookRoomViewController ()

@property (strong, nonatomic) UIButton *continueButton;
@property (strong, nonatomic) UIDatePicker *datePickerStart;
@property (strong, nonatomic) UIDatePicker *datePickerEnd;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *startDateSelected;
@property (strong, nonatomic) NSDate *endDateSelected;

@end

@implementation BookRoomViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  //variables
  UIColor *customGreen = [UIColor colorWithRed:77.0f/255.0f
                                         green:169.0f/255.0f
                                          blue:135.0f/255.0f
                                         alpha:1.0f];
  
  UIColor *customPickerGreen = [UIColor colorWithRed:156.0f/255.0f
                                               green:204.0f/255.0f
                                                blue:204.0f/255.0f
                                               alpha:1.0f];
  CGRect frame = [UIScreen mainScreen].bounds;
  int screenWidth = frame.size.width;
  int screenHeight = frame.size.height;
  int halfHeight = screenHeight/2;
  int quarterHeight = screenHeight/4;
  int quarterWidth = screenWidth/4;
  int labelHeight = 30;
  int stdWidth = 100;
  int longLabelWidth = 250;
  int adjustedX15 = quarterWidth - 15;
  int adjustedX50 = quarterWidth + 50;
  int navBarHeight = 65;
  int textStripHeight = 50;
  int startPickerY = navBarHeight + textStripHeight;
  int endPickerY = halfHeight + textStripHeight + 1;
  int buttonY = frame.size.height - 75;
  int quarterStripHeight = textStripHeight/4;
  int fontSize = 20;
  NSString *fontName = @"Copperplate";
  NSString *selectArrivalDate = @"Select Arrival Date";
  NSString *selectDepartureDate = @"Select Departure Date";

  rootView.backgroundColor = customPickerGreen;

  //topText strip creation
  CGRect top = CGRectMake(0, navBarHeight, screenWidth, textStripHeight);
  UIView *topView = [[UIView alloc] initWithFrame:top];
  [topView setTranslatesAutoresizingMaskIntoConstraints:false];
  topView.backgroundColor = customGreen;
  [rootView addSubview:topView];
  
  //Text on topView
  CGRect sSDLabel = CGRectMake(quarterWidth, quarterStripHeight, longLabelWidth, labelHeight);
  UILabel *selectStartDateLabel = [[UILabel alloc] initWithFrame:sSDLabel];
  [selectStartDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  selectStartDateLabel.text = selectArrivalDate;
  selectStartDateLabel.textColor = [UIColor blackColor];
  selectStartDateLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [topView addSubview:selectStartDateLabel];

  //set up date picker
  CGRect brStart = CGRectMake(0, startPickerY, screenWidth, quarterHeight);
  UIDatePicker *datePickerStart = [[UIDatePicker alloc] initWithFrame:(brStart)];
  self.datePickerStart = datePickerStart;
  self.datePickerStart.datePickerMode = UIDatePickerModeDate;
  self.datePickerStart.tag = 1;
  self.startDateSelected = [self.datePickerStart date];
  [self.datePickerStart addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  [rootView addSubview:self.datePickerStart];
  
  //bottomText strip creation
  CGRect bottom = CGRectMake(0, halfHeight, screenWidth, textStripHeight);
  UIView *bottomView = [[UIView alloc] initWithFrame:bottom];
  [bottomView setTranslatesAutoresizingMaskIntoConstraints:false];
  bottomView.backgroundColor = customGreen;
  
  [rootView addSubview:bottomView];
  
  //Text on topView
  CGRect sEDLabel = CGRectMake(adjustedX15, quarterStripHeight, longLabelWidth, labelHeight);
  UILabel *selectEndDateLabel = [[UILabel alloc] initWithFrame:sEDLabel];
  [selectEndDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  selectEndDateLabel.text = selectDepartureDate;
  selectEndDateLabel.textColor = [UIColor blackColor];
  selectEndDateLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [bottomView addSubview:selectEndDateLabel];
  
  //set up date picker
  CGRect brEnd = CGRectMake(0, endPickerY, screenWidth, quarterHeight);
  UIDatePicker *datePickerEnd = [[UIDatePicker alloc] initWithFrame:(brEnd)];
  self.datePickerEnd = datePickerEnd;
  self.datePickerEnd.datePickerMode = UIDatePickerModeDate;
  self.datePickerEnd.tag = 2;
  self.endDateSelected = [self.datePickerEnd date];
  [self.datePickerEnd addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  [rootView addSubview:self.datePickerEnd];
  
  //Continue button setup
  CGRect button = CGRectMake(adjustedX50, buttonY, stdWidth, labelHeight);
  UIButton *continueButton = [[UIButton alloc] initWithFrame:(button)];
  self.continueButton = continueButton;
  [self.continueButton setTitle:@"Continue" forState: UIControlStateNormal];
  self.continueButton.backgroundColor = customGreen;
  [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.continueButton addTarget:self action:@selector(continueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [rootView addSubview:self.continueButton];

  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Date Selection";
}

-(void)datePickerValueChanged:(UIDatePicker *)sender {
  
  self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
  if (sender.tag == 1) {
    self.startDateSelected = [sender date];
  } else {
    self.endDateSelected = [sender date];
  }
}

-(void)continueButtonClicked:(UIButton *)sender{
  NSDate *startSelected = [self getDateComponents:self.startDateSelected];
  NSDate *endSelected = [self getDateComponents:self.endDateSelected];
  
  if (endSelected > startSelected) {
      //push available rooms vc for selected dates
    AvailabilityResultsViewController *availabilityResultsVC = [[AvailabilityResultsViewController alloc] init];
    availabilityResultsVC.startdate = startSelected;
    availabilityResultsVC.enddate = endSelected;
    [self.navigationController pushViewController:availabilityResultsVC animated:YES];
  } else {
    //present an alert telling user to select appropriate dates
    [self presentDateSelectionAlert];
  }

}

- (void)presentDateSelectionAlert
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inappropriate Dates Selected" message:@"Please select an ARRIVAL DATE that is earlier than the DEPARTURE DATE!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [alert show];
}

-(NSDate *)getDateComponents:(NSDate *)date
{
  NSCalendar *userCalendar = [NSCalendar currentCalendar];
  
  NSDateComponents *requestedComponents = [userCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
  
  NSDate *newDate = [userCalendar dateFromComponents:requestedComponents];
  
  return newDate;
}


@end
