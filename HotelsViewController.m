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
  static NSString *fontName = @"Copperplate";
  static int fontSize = 15;
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
  
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  Hotel *hotel = self.hotels[indexPath.row];
  NSString *starCount = [NSString stringWithFormat:@"%@", hotel.stars];

  cell.textLabel.font = [UIFont fontWithName:fontName size:fontSize];
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
