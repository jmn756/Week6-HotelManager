//
//  HotelsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "HotelsViewController.h"
#import "Hotel.h"
#import "AppDelegate.h"
#import "RoomsViewController.h"
#import "CoreDataStack.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;

@end

@implementation HotelsViewController


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
  self.tableView.delegate = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];

  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Hotels";
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  self.hotels = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
  }
  
  [self.tableView reloadData];
  
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellID = @"HotelCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  Hotel *hotel = self.hotels[indexPath.row];
  NSString *starCount = [NSString stringWithFormat:@"%@", hotel.stars];

  cell.textLabel.font = [UIFont fontWithName:@"Copperplate" size:15];
  cell.textLabel.text = hotel.name;
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" - "];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:hotel.location];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@" ("];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:starCount];
  cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@"-star hotel)"];
  return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  RoomsViewController *roomsVC = [[RoomsViewController alloc] init];
  roomsVC.hotel = self.hotels[indexPath.row];
  [self.navigationController pushViewController:roomsVC animated:YES];

}


@end
