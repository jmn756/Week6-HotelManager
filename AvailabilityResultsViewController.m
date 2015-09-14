//
//  AvailabilityResultsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//


#import "AvailabilityResultsViewController.h"
#import "HotelService.h"
#import "Room.h"
#import "Hotel.h"
#import "ConfirmReservationViewController.h"

@interface AvailabilityResultsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;
@property (strong, nonatomic) NSMutableArray *section0rooms;
@property (strong, nonatomic) NSArray *sortedArray;


@end

@implementation AvailabilityResultsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  //variables
  UIColor *customGreen = [UIColor colorWithRed:77.0f/255.0f
                                         green:169.0f/255.0f
                                          blue:135.0f/255.0f
                                         alpha:1.0f];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int screenWidth = frame.size.width;
  int screenHeight = frame.size.height;
  int viewHeight = screenHeight/3;
  int twiceViewHeight = viewHeight*2;
  int quarterWidth = screenWidth/4;
  int labelHeight = 30;
  int longLabelWidth = 250;
  int navBarHeight = 65;
  int textStripHeight = 50;
  int quarterStripHeight = textStripHeight/4;
  int adjustedX30 = quarterWidth - 30;
  NSString *fontName = @"Copperplate";
  int fontSize = 20;
  int startPic = navBarHeight + textStripHeight;
  int startTV = startPic + viewHeight;
  
  //topText strip creation
  CGRect top = CGRectMake(0, navBarHeight, screenWidth, textStripHeight);
  UIView *topView = [[UIView alloc] initWithFrame:top];
  [topView setTranslatesAutoresizingMaskIntoConstraints:false];
  topView.backgroundColor = customGreen;
  [rootView addSubview:topView];
  
  //Text on topView
  CGRect dLabel = CGRectMake(adjustedX30, quarterStripHeight, longLabelWidth, labelHeight);
  UILabel *datesLabel = [[UILabel alloc] initWithFrame:dLabel];
  [datesLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy"];
  NSString *startDateString = [formatter stringFromDate:self.startdate];
  datesLabel.text = startDateString;
  datesLabel.text = [datesLabel.text stringByAppendingString:@" -- "];
  NSString *endDateString = [formatter stringFromDate:self.enddate];
  datesLabel.text = [datesLabel.text stringByAppendingString:endDateString];
  datesLabel.textColor = [UIColor blackColor];
  datesLabel.font = [UIFont fontWithName:fontName size:fontSize];
  [topView addSubview:datesLabel];
  
  CGRect iv = CGRectMake(0, startPic , screenWidth, viewHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Yangtze-Gold-2-Front-Desk.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  CGRect tv = CGRectMake(0, startTV, screenWidth, twiceViewHeight);
  UITableView *tableView = [[UITableView alloc] initWithFrame:tv style:UITableViewStylePlain];
  self.tableView = tableView;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];
  
  self.view = rootView;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Available Rooms";
  
  self.rooms = [HotelService fetchAvailableRoomsForStartDate:self.startdate endDate:self.enddate];
  //sort result set
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
  self.sortedArray=[self.rooms sortedArrayUsingDescriptors:@[sort]];
  
  [self.tableView reloadData];

}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellID = @"RoomCell";
  static NSString *fontName = @"Copperplate";
  static int fontSize = 12;
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  Room *room = self.sortedArray[indexPath.row];
  NSString *bedCount = [NSString stringWithFormat:@"%@", room.beds];
  NSString *rateAmt = [NSString stringWithFormat:@"%@", room.rate];
  NSString *hotelName = [NSString stringWithFormat:@"%@", room.hotel.name];
  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
  
  cell.textLabel.font = [UIFont fontWithName:fontName size:fontSize];
  cell.textLabel.text = @"Hotel: ";
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:hotelName];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" -- Room: "];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:roomNumber];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" ("];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:bedCount];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" beds, $"];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:rateAmt];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" per night)"];
  
  return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ConfirmReservationViewController *confirmVC = [[ConfirmReservationViewController alloc] init];
  confirmVC.selectedRoom = self.sortedArray[indexPath.row];
  confirmVC.startdate = self.startdate;
  confirmVC.enddate = self.enddate;
  [self.navigationController pushViewController:confirmVC animated:YES];
  
}

@end
