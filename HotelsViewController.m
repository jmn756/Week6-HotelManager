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

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;

@end

@implementation HotelsViewController


- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:rootView.frame style:UITableViewStylePlain];
  self.tableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView];

  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Hotels";
  
   self.tableView.dataSource = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];

//  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
//  
//  //  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name MATCHES %@",@"Four Seasons"];
//  
//  fetchRequest.predicate  = [NSPredicate predicateWithFormat:@"stars < 3"];
//  
//  NSError *fetchError;
//  self.hotels = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
//  
//  if (fetchError) {
//    NSLog(@"%@",fetchError.localizedDescription);
//  }
//  
  [self.tableView reloadData];

  
  
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
  
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  
  return cell;
}


@end
