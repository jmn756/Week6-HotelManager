//
//  ReservationLookupViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ReservationLookupViewController.h"
#import "ReservationResultsViewController.h"
#import "HotelService.h"
#import "Reservation.h"


@interface ReservationLookupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSArray *reservations;

@end

@implementation ReservationLookupViewController

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
  int adjustedX10 = 10;
  int adjustedX30 = 30;
  int adjustedWidth = screenWidth-60;
  int adjustedX50 = quarterWidth + 50;
  int fontSize = 13;
  NSString *fontName = @"Copperplate";
  int navBarHeight = 65;
  int buttonY = frame.size.height - 75;
  int startPic = navBarHeight + 80;
  int startTestField = navBarHeight + 30;
  
  //lastNameTextView creation
  CGRect lnText = CGRectMake(adjustedX30, startTestField, adjustedWidth, labelHeight);
  UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:lnText];
  self.textField = lastNameTextField;
  self.textField.delegate = self;
  lastNameTextField.placeholder = @"Please enter Last Name here.";
  [lastNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameTextField.backgroundColor = customGreen;
  [rootView addSubview:lastNameTextField];
  
  CGRect iv = CGRectMake(0, startPic, screenWidth, viewHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Google-Search.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  //Text on confirm reservation page
  CGRect lnLabel = CGRectMake(adjustedX10, startPic + 100, longLabelValue, longLabelValue);
  UILabel *lastNameLabel = [[UILabel alloc] initWithFrame:lnLabel];
  lastNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
  lastNameLabel.numberOfLines = 0;
  [lastNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameLabel.textAlignment = NSTextAlignmentCenter;
  lastNameLabel.text = @"Please enter the last name of the reservation, then click the Search button below.\n ";
  lastNameLabel.text = [lastNameLabel.text stringByAppendingString:@"Leave text-field blank to retrieve all reservations.\n"];
  lastNameLabel.text = [lastNameLabel.text stringByAppendingString:@"Note: Name fields are case-sensitive. "];
  lastNameLabel.textColor = [UIColor whiteColor];
  lastNameLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [rootView addSubview:lastNameLabel];
  
  //Continue button setup
  CGRect button = CGRectMake(adjustedX50, buttonY, stdWidth, labelHeight);
  UIButton *searchButton = [[UIButton alloc] initWithFrame:button];
  self.searchButton = searchButton;
  [self.searchButton setTitle:@"Search" forState: UIControlStateNormal];
  self.searchButton.backgroundColor = customGreen;
  [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.searchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [rootView addSubview:self.searchButton];
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Reservation Lookup";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchButtonClicked:(UIButton *)sender{
  
  self.reservations = [HotelService fetchReservationsForLastName:self.textField.text];
  ReservationResultsViewController *reserveResultsVC = [[ReservationResultsViewController alloc] init];
  reserveResultsVC.reservations = self.reservations;
  [self.navigationController pushViewController:reserveResultsVC animated:YES];
  
}

#pragma mark: -- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.textField resignFirstResponder];
  return true;
}

@end
