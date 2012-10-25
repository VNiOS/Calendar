//
//  BNEventEditorController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "BNEventEditorController.h"

@implementation BNEventEditorController
@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Edit Event";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    UIBarButtonItem *doneBt=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [self.navigationItem setRightBarButtonItem:doneBt];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)done:(id)sender{
    [self.delegate CloseEditView:self];
}
-(IBAction)closeTextField:(id)sender{
    [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            return 40;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 100;
            break;
        case 3:
            return 40;
            break;
        case 4:
            return 40;
            break;
        case 5:
            return 200;
            break;
            
      
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ], [ indexPath indexAtPosition:1 ]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        switch ([indexPath indexAtPosition:0]) {
            case 0:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 50, 20)];
                label.text=@"Title";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];
                [cell addSubview:label];
                
                title=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, 180, 20)];
                title.backgroundColor=[UIColor clearColor];
                title.textAlignment=UITextAlignmentLeft;
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                title.font=font;
                [title addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell addSubview:title];
                
            }
                break;
            case 1:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 100, 20)];
                label.text=@"Location";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
                location=[[UITextField alloc]initWithFrame:CGRectMake(95, 10, 180, 20)];
                location.backgroundColor=[UIColor clearColor];
                location.textAlignment=UITextAlignmentLeft;
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                location.font=font;
                [location addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell addSubview:location];
            }
                break;
            case 2:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 80, 20)];
                label.text=@"Time";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
            }
                break;
            case 3:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 80, 20)];
                label.text=@"Repeat";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
            }
                break;
            case 4:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Time Repeat";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
            }
                break;
            case 5:
            {
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Description :";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
                label.backgroundColor=[UIColor clearColor];
                
                [cell addSubview:label];
                description=[[UITextView alloc]initWithFrame:CGRectMake(22, 35, 280, 180)];
                description.backgroundColor=[UIColor clearColor];
                description.textAlignment=UITextAlignmentLeft;
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                description.font=font;
                [cell addSubview:description];
                
            }
                break;
            default:
                break;
        }
        
        
        
        
        
    }
    
    // Configure the cell...
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
