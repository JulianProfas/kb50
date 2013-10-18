//
//  WereldTableViewController.m
//  weekopdracht_4
//
//  Created by justin on 10/8/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "WereldTableViewController.h"
#import "LevelTableViewController.h"
@interface WereldTableViewController () <UIAlertViewDelegate>

@end

@implementation WereldTableViewController
@synthesize allWorlds;
@synthesize game;
@synthesize filePath;
@synthesize correctWorlds;

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
    
    allWorlds = nil;
    correctWorlds = nil;
    filePath = @"worlds.plist";
    
    NSString * path = [self givePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
        self.allWorlds = [array objectAtIndex:0];
    }
    if(allWorlds == nil)
    {
        allWorlds = [[NSMutableDictionary alloc] init];
    }
    
    if([self.allWorlds objectForKey:game]){
        correctWorlds = [self.allWorlds objectForKey:game];
    }else{
        correctWorlds = [[NSMutableArray alloc] init];
    }
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@" Edit"  style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = button;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Game"  style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
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
    return [correctWorlds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"gameTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [correctWorlds objectAtIndex:
                           [indexPath row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
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
        [self.navigationItem.leftBarButtonItem setTitle:@"Game"];
        [self.navigationItem.leftBarButtonItem setAction:@selector(goBack)];
        [self save];
    }
    
}

- (IBAction)add
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New World:" message:@"Please enter a name for your new World:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert addButtonWithTitle:@"Enter"];
    [alert show];
    
    
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *name = [alertView textFieldAtIndex:0].text;
        [self.correctWorlds addObject:name];
        [self.tableView reloadData];
    }
    
}

-(void)save
{
    NSMutableArray *save = [[NSMutableArray alloc] init];
    
    [self.allWorlds setObject:correctWorlds forKey:game];
    [save addObject:self.allWorlds];
    
    [save writeToFile:[self givePath] atomically:YES];
}


// In a story board-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"ShowCarDetails"])
//    {
//
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LevelTableViewController *levelView = [LevelTableViewController alloc];
    int selectedRow = indexPath.item;
    NSString *selectedWorld = [self.correctWorlds objectAtIndex:selectedRow];
    levelView.world = selectedWorld;
    
    [self.navigationController pushViewController:levelView animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.correctWorlds removeObjectAtIndex: indexPath.row];
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
