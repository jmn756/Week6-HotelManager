//
//  ReservationResultsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "ReservationResultsViewController.h"
#import "Reservation.h"

@interface ReservationResultsViewController () <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ReservationResultsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int thirdHeight = frame.size.height/3;
  int twoThirdsHeight = thirdHeight*2;
  
  CGRect iv = CGRectMake(0, 0, frame.size.width, thirdHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"Hotel.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  CGRect tv = CGRectMake(0, frame.size.height/3, frame.size.width, twoThirdsHeight);
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
    // Do any additional setup after loading the view.
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
  return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellID = @"ReservationCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
//  Room *room = self.sortedArray[indexPath.row];
//  NSString *bedCount = [NSString stringWithFormat:@"%@", room.beds];
//  NSString *rateAmt = [NSString stringWithFormat:@"%@", room.rate];
//  NSString *hotelName = [NSString stringWithFormat:@"%@", room.hotel.name];
//  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
//  
//  cell.textLabel.font = [UIFont fontWithName:@"Copperplate" size:12];
//  cell.textLabel.text = @"Hotel: ";
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:hotelName];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" -- Room: "];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:roomNumber];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" ("];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:bedCount];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" beds, $"];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:rateAmt];
//  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" per night)"];
  
  return cell;
}



@end
