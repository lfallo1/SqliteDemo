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

@interface ViewController ()
{
    NSMutableArray *personList;
    UIBarButtonItem *addItem;
    PersonDal *dal;
}

@property (weak, nonatomic) IBOutlet UITableView *PersonTableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize view
    addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson:)];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = addItem;
    
    //initialize data array
    dal = [[PersonDal alloc]init];
    personList = [[NSMutableArray alloc] initWithArray:[dal allPerson]];
    [self _reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_reloadData{
    [self.PersonTableView reloadData];
}

#pragma mark - Table view data source

-(void)addPerson:sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Person" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[alertView title] isEqualToString:@"Add Person"] && buttonIndex == 1){
        Person *p = [[Person alloc]initWithPerson:nil name:[[alertView textFieldAtIndex:0]text]];
        NSNumber *newId = [dal insertPerson:p];
        [p setPersonId:newId];
        [personList insertObject:p atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.PersonTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.PersonTableView setEditing:editing animated:YES];
    if(editing){
        addItem.enabled = NO;
    }
    else{
        addItem.enabled = YES;
    }
}

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
