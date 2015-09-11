//
//  ReservationLookupViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ReservationLookupViewController.h"
#import "ReservationResultsViewController.h"

@interface ReservationLookupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation ReservationLookupViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor blackColor];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int quarterWidth = frame.size.width/4;
  int thirdHeight = frame.size.height/3;
  int twoThirdsHeight = thirdHeight*2;
  int navBarHeight = 65;
  int textStripHeight = 50;
  int startPic = navBarHeight + 80;
  NSString *fontName = @"Copperplate";
  
  //lastNameTextView creation
  CGRect bottom = CGRectMake(30, navBarHeight + 30, frame.size.width-60, 30);
  UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:bottom];
  self.textField = lastNameTextField;
  self.textField.delegate = self;
  lastNameTextField.placeholder = @"Please enter Last Name here.";
  [lastNameTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameTextField.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                                      green:169.0f/255.0f
                                                       blue:135.0f/255.0f
                                                      alpha:1.0f];
  [rootView addSubview:lastNameTextField];
  
  CGRect iv = CGRectMake(0, startPic , frame.size.width, thirdHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Google-Search.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  
  //Text on confirm reservation page
  UILabel *lastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, startPic + 100, 350, 350)];
  lastNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
  lastNameLabel.numberOfLines = 0;
  
  [lastNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  lastNameLabel.textAlignment = NSTextAlignmentCenter;
  lastNameLabel.text = @"Please enter the last name of the reservation, then click the Search button below.\n ";
  lastNameLabel.text = [lastNameLabel.text stringByAppendingString:@"Leave text-field blank to retrieve all reservations.\n"];

  lastNameLabel.text = [lastNameLabel.text stringByAppendingString:@"Note: Name fields are case-sensitive. "];
  
  lastNameLabel.textColor = [UIColor whiteColor];
  lastNameLabel.font = [UIFont fontWithName:fontName size:13];
  [rootView addSubview:lastNameLabel];
  
  //Continue button setup
  CGRect button = CGRectMake(quarterWidth + 50, frame.size.height - 75, 100, 25);
  UIButton *searchButton = [[UIButton alloc] initWithFrame:(button)];
  self.searchButton = searchButton;
  [self.searchButton setTitle:@"Search" forState: UIControlStateNormal];
  self.searchButton.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                                      green:169.0f/255.0f
                                                       blue:135.0f/255.0f
                                                      alpha:1.0f];
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
  NSLog(@"user pressed search button");
  
  ReservationResultsViewController *reserveResultsVC = [[ReservationResultsViewController alloc] init];
  //reserveResultsVC.results = self.results;
  [self.navigationController pushViewController:reserveResultsVC animated:YES];
  
}

#pragma mark: -- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.textField resignFirstResponder];
  return true;
}

@end
