//
//  RoomsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"
#import "AppDelegate.h"


@interface RoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomsViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  CGRect frame = [UIScreen mainScreen].bounds;
  int thirdHeight = frame.size.height/3;
  int twoThirdsHeight = thirdHeight*2;
  
  CGRect iv = CGRectMake(0, 0, frame.size.width, thirdHeight);
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:iv];
  imageView.image = [UIImage imageNamed: @"hotelroom.jpg"];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:imageView];
  
  CGRect tv = CGRectMake(0, frame.size.height/3, frame.size.width, twoThirdsHeight);
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
  self.navigationItem.title = self.hotel.name;
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
  return self.hotel.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellID = @"RoomCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  NSArray *array = [self.hotel.rooms allObjects];
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
  NSArray *sortedArray=[array sortedArrayUsingDescriptors:@[sort]];
  
  Room *room = sortedArray[indexPath.row];
  NSString *bedCount = [NSString stringWithFormat:@"%@", room.beds];
  NSString *rateAmt = [NSString stringWithFormat:@"%@", room.rate];
  NSString *roomNumber = [NSString stringWithFormat:@"%@", room.number];
  
  cell.textLabel.font = [UIFont fontWithName:@"Copperplate" size:15];
  cell.textLabel.text = @"Room: ";
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:roomNumber];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" ("];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:bedCount];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" beds, $"];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:rateAmt];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" per night)"];
  cell.userInteractionEnabled = NO;
  return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
