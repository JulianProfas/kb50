//
//  VijandTableViewController.m
//  weekopdracht_4
//
//  Created by justin on 10/8/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "VijandTableViewController.h"


@interface VijandTableViewController ()

@end

@implementation VijandTableViewController
@synthesize allEnemies;
@synthesize Level;
@synthesize filePath;
@synthesize correctEnemies;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    
    allEnemies = nil;
    correctEnemies = nil;
    filePath = @"enemies.plist";
    
    NSString * path = [self givePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
        self.allEnemies = [array objectAtIndex:0];
    }
    if(allEnemies == nil)
    {
        allEnemies = [[NSMutableDictionary alloc] init];
    }
    
    if([self.allEnemies objectForKey:Level]){
        correctEnemies = [self.allEnemies objectForKey:Level];
    }else{
        correctEnemies = [[NSMutableArray alloc] init];
    }
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@" Edit"  style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = button;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Level"  style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem.leftBarButtonItem setEnabled:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [correctEnemies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gameTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.correctEnemies objectAtIndex:
                           [indexPath row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(IBAction)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit
{
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if(self.tableView.editing){
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setTitle:@"+"];
        [self.navigationItem.leftBarButtonItem setAction:@selector(add)];
    }else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setTitle:@"Level"];
        [self.navigationItem.leftBarButtonItem setAction:@selector(goBack)];
        [self save];
    }
    
}

- (IBAction)add
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Enemy:" message:@"Please enter a name for your new Enemy:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert addButtonWithTitle:@"Enter"];
    [alert show];
    
    
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *name = [alertView textFieldAtIndex:0].text;
        [self.correctEnemies addObject:name];
        [self.tableView reloadData];
    }
    
}

-(void)save
{
    NSMutableArray *save = [[NSMutableArray alloc] init];
    
    [self.allEnemies setObject:correctEnemies forKey:Level];
    [save addObject:self.allEnemies];
    
    [save writeToFile:[self givePath] atomically:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.correctEnemies removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    [tableView reloadData];
}

-(NSString *)givePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*docDir = [path objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:filePath];
}

@end
