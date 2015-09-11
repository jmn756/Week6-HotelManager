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
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int quarterWidth = frame.size.width/4;
  int thirdHeight = frame.size.height/3;
  int twoThirdsHeight = thirdHeight*2;
  int navBarHeight = 65;
  int textStripHeight = 50;
  int startPic = navBarHeight + textStripHeight;
  NSString *fontName = @"Copperplate";
  
  //topText strip creation
  CGRect top = CGRectMake(0, navBarHeight, frame.size.width, textStripHeight);
  UIView *topView = [[UIView alloc] initWithFrame:top];
  [topView setTranslatesAutoresizingMaskIntoConstraints:false];
  topView.backgroundColor = [UIColor colorWithRed:77.0f/255.0f
                                            green:169.0f/255.0f
                                             blue:135.0f/255.0f
                                            alpha:1.0f];
  [rootView addSubview:topView];
  
  //Text on topView
  UILabel *datesLabel = [[UILabel alloc] initWithFrame:CGRectMake(quarterWidth - 30, textStripHeight/4, 250, 30)];
  [datesLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy"];
  NSString *startDateString = [formatter stringFromDate:self.startdate];
  datesLabel.text = startDateString;
  datesLabel.text = [datesLabel.text stringByAppendingString:@" -- "];
  NSString *endDateString = [formatter stringFromDate:self.enddate];
  datesLabel.text = [datesLabel.text stringByAppendingString:endDateString];
  datesLabel.textColor = [UIColor blackColor];
  datesLabel.font = [UIFont fontWithName:fontName size:20];
  [topView addSubview:datesLabel];
  
  CGRect iv = CGRectMake(0, startPic , frame.size.width, thirdHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Yangtze-Gold-2-Front-Desk.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  CGRect tv = CGRectMake(0, (frame.size.height/3) + 60, frame.size.width, twoThirdsHeight);
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
  
  cell.textLabel.font = [UIFont fontWithName:@"Copperplate" size:12];
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
