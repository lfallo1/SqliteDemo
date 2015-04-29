//
//  ViewController.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "ViewController.h"
#import "PhoneDetailsTableViewController.h"
#import "PersonDal.h"
#import "PhoneDal.h"
#import "FavoriteService.h"

@interface ViewController ()
{
    NSArray *personList;
}

@property (weak, nonatomic) IBOutlet UITableView *PersonTableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonDal *dal = [[PersonDal alloc]init];
    personList = [[NSArray alloc] initWithArray:[dal allPerson]];
    [self.PersonTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [personList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    cell.textLabel.text = [[personList objectAtIndex:indexPath.row] name];
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [FavoriteService addToFavorites:[personList objectAtIndex:indexPath.row] filename:@"Person.data" callback:^(NSString *msg){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Favorites" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (IBAction)showFavoritesClicked:(id)sender{
    NSMutableArray *favs = [FavoriteService getFavorites:@"Person.data"];
    NSString *msg = [[NSString alloc]init];
    if(favs != nil){
        for(int i = 0; i < [favs count]; i++){
            NSNumber *personId = [[favs objectAtIndex:i]personId];
            NSString *name = [[favs objectAtIndex:i]name];
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%@ - %@\n",name, personId]];
        }
    }
    else{
        msg = @"No contacts are currently in favorites";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Favorites" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.PersonTableView indexPathForCell:sender];
    PhoneDetailsTableViewController *ctrl = [segue destinationViewController];
    
    Person *p = [personList objectAtIndex:indexPath.row];
    NSArray *phoneList = [[[PhoneDal alloc]init]getByPerson:[p personId]];
    [ctrl updatePhoneList:phoneList];
}

@end
