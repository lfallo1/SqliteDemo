//
//  PhoneDetailsTableViewController.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "PhoneDetailsTableViewController.h"

@interface PhoneDetailsTableViewController()
{
    IBOutlet UITableView *PhoneDetailsTableView;
}
@property (nonatomic, strong) NSArray *phoneList;
@end

@implementation PhoneDetailsTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.phoneList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneDetailsCell" forIndexPath:indexPath];
    cell.textLabel.text = [[[self.phoneList objectAtIndex:indexPath.row] person] name];
    cell.detailTextLabel.text = [[self.phoneList objectAtIndex:indexPath.row] number];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    [PhoneDetailsTableView reloadData];
}

-(void)updatePhoneList:(NSArray *)pList{
    if(self.phoneList == nil){
        self.phoneList = [[NSArray alloc]init];
    }
    self.phoneList = pList;
}

@end
