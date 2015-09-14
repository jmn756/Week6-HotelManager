//
//  ReservationResultsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ReservationResultsViewController.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "Guest.h"


@interface ReservationResultsViewController () <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ReservationResultsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  //variables
  CGRect frame = [UIScreen mainScreen].bounds;
  int screenWidth = frame.size.width;
  int screenHeight = frame.size.height;
  int viewHeight = screenHeight/3;
  int twiceViewHeight = viewHeight*2;

  //imageView creation
  CGRect iv = CGRectMake(0, 0, screenWidth, viewHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Hotel.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  //tableView creation
  CGRect tv = CGRectMake(0, viewHeight, screenWidth, twiceViewHeight);
  UITableView *tableView = [[UITableView alloc] initWithFrame:tv style:UITableViewStylePlain];
  self.tableView = tableView;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ReservationCell"];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Reservation Search Results";
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.reservations.count > 0){
     return self.reservations.count;
  } else {
    return 1;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellID = @"ReservationCell";
  static NSString *fontName = @"Copperplate";
  static int fontSize = 10;
  
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
  cell.textLabel.numberOfLines = 0;
  
  if (self.reservations.count == 0) {
    cell.textLabel.text = @"No reservations found";
  } else {
    Reservation *reservation = self.reservations[indexPath.row];
    NSString *guestName = [NSString stringWithFormat:@"%@", reservation.guest.lastname];
    NSString *hotelName = [NSString stringWithFormat:@"%@", reservation.room.hotel.name];
    NSString *roomNumber = [NSString stringWithFormat:@"%@", reservation.room.number];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *startDateString = [formatter stringFromDate:reservation.startdate];
    NSString *endDateString = [formatter stringFromDate:reservation.enddate];
    NSString *startdate = [NSString stringWithFormat:@"%@", startDateString];
    NSString *enddate = [NSString stringWithFormat:@"%@", endDateString];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:fontSize];
    cell.textLabel.text = @"Guest: ";
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:guestName];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" -- Hotel: "];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:hotelName];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" -- Room: "];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:roomNumber];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@"\n ("];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:startdate];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" -- "];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:enddate];
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@")"];
  }
  return cell;
}



@end
