//
//  BNEventEditorController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "BNEventEditorController.h"
#import "DatePickerView.h"
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
    self.title=@" Event";
    UIBarButtonItem *doneBt=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [doneBt setTintColor:[UIColor colorWithRed:0.3 green:0.7 blue:0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem=doneBt;
    
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
            return 40;

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
    if (section==2) {
        return 2;
    }
    else{
        return 1;
    }
    
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
                title=[[UITextField alloc]initWithFrame:CGRectMake(25, 10, 180, 20)];
                title.backgroundColor=[UIColor clearColor];
                title.textAlignment=UITextAlignmentLeft;
                title.placeholder=@"Title";
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                title.font=font;
                [title addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell addSubview:title];
                
            }
                break;
            case 1:
            {
                

              
                location=[[UITextField alloc]initWithFrame:CGRectMake(25, 10, 180, 20)];
                location.backgroundColor=[UIColor clearColor];
                location.textAlignment=UITextAlignmentLeft;
                location.placeholder=@"Location";
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                location.font=font;
                [location addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell addSubview:location];
            }
                break;
            case 2:
            {
                switch ([indexPath indexAtPosition:1]) {
                    case 0:
                    {
                        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 80, 20)];
                        label.text=@"Time Start";
                        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                        label.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:label];
                        
                        startDatelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 120, 20)];
                        startDatelb.text=@"";
                        startDatelb.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                        startDatelb.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:startDatelb];
                    }
                        break;
                    case 1:
                    {
                        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 80, 20)];
                        label.text=@"Time End";
                        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                        label.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:label];
                        
                        
                        endDatelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 120, 20)];
                        endDatelb.text=@"";
                        endDatelb.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                        endDatelb.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:endDatelb];
                    }
                        break;
                   
                    default:
                        break;
                }
               
            }
                break;
            case 3:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 80, 20)];
                label.text=@"Repeat";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
            }
                break;
            case 4:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Time Repeat";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
            }
                break;
            case 5:
            {
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Description";
                label.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                label.backgroundColor=[UIColor clearColor];
                
                [cell addSubview:label];
                description=[[UITextView alloc]initWithFrame:CGRectMake(22, 25, 280, 180)];
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
    if (indexPath.section==2) {
        bool type;
        if (indexPath.row==0) {
            type=1;
        }
        else{
            type=0;
        }
        DatePickerView *pickerView=[[DatePickerView alloc]initWithNibName:@"DatePickerView" bundle:nil];
        [pickerView setDateType:type];
        [self.navigationController pushViewController:pickerView animated:YES];
        
    }
    else if(indexPath.section==3){
        
    }
    else if(indexPath.section==4){
        
    }
}

@end
