//
//  BNEventEditorController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "BNEventEditorController.h"
#import "DatePickerView.h"
#import "BNAppDelegate.h"
#import "BNEventEntity.h"
#import "EventDataSqlite.h"


@implementation BNEventEditorController
@synthesize delegate,startDatelb,endDatelb;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        dataSqlite=[[EventDataSqlite alloc]init];
       
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
    repeatInt=0;
    repeatTimeInt=0;
    //[self.tableView setFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 104)];
    headView.backgroundColor=[UIColor clearColor];
    
    self.tableView.tableHeaderView=headView;
    
    UIBarButtonItem *doneBt=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [doneBt setTintColor:[UIColor colorWithRed:0.3 green:0.7 blue:0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem=doneBt;
    
    
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 60, 320, 44)] autorelease];
    headerView.backgroundColor = [UIColor grayColor];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self addContentToHeadView:headerView];
    [headView addSubview:headerView];
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320, 44)];
    [self addContentToFooterView:footerView];
    self.tableView.tableFooterView=footerView;

}
-(void)addContentToHeadView:(UIView *)view{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"]];
    CGRect imageFrame = view.frame;
    imageFrame.origin = CGPointZero;
    backgroundView.frame = imageFrame;
    [view addSubview:backgroundView];
    [backgroundView release];
    
    
    
    UILabel *titlelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 20)];
    titlelb.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    titlelb.textAlignment=UITextAlignmentCenter;
    titlelb.text=@"Event";
    titlelb.font=[UIFont boldSystemFontOfSize:22.f];
    [titlelb setBackgroundColor:[UIColor clearColor]];
    titlelb.shadowColor = [UIColor whiteColor];
    titlelb.shadowOffset = CGSizeMake(0.f, 1.f);
    [view addSubview:titlelb];
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 46, 30)];
    [BackButton setAccessibilityLabel:NSLocalizedString(@"", nil)];
    [BackButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    BackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    BackButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [BackButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:BackButton];
}
-(void)addContentToFooterView:(UIView *)view{
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"]];
    CGRect imageFrame = view.frame;
    imageFrame.origin = CGPointZero;
    backgroundView.frame = imageFrame;
    [view addSubview:backgroundView];
    [backgroundView release];

    
    UIButton *Delete = [[UIButton alloc] initWithFrame:CGRectMake(220, 5, 70, 30)];
    [Delete.titleLabel setTextAlignment:UITextAlignmentLeft];
    [Delete.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [Delete setTitle:@"Delete" forState:UIControlStateNormal];
    [Delete setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]] forState:UIControlStateNormal];
    [Delete addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Delete];
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
    [self checkDataInput];
     
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
#pragma mark - Data control

-(void)checkDataInput{
    
    [self saveData:1];
    
//    if (!titletf.text.length) {
//        [self showAlerView:@"Title"];
//    }
//    else{
//        if (!description.text.length) {
//            [self showAlerView:@"Description"];
//        }
//        else{
//            
//            if ([startDatelb.text isEqualToString:endDatelb.text]) {
//                [self showAlerView:@"Date"];
//            }
//            else{
//                
//                
//                [self saveData:1];
//            }
//
//        }
//        
//        
//        
//    }
    
    
}
-(void)saveData:(int)type{
    NSDictionary *data=[[NSDictionary alloc]initWithObjectsAndKeys:
                        @"24",                    @"event_id",
                        @"abdcde",                @"title",
                        @"2012-10-29 14:00:00",   @"timeStart",
                        @"2012-10-29 17:00:00",   @"timeEnd",
                        @"1",                     @"repeat",
                        @"2012-10-29 18:00:00",   @"timeRepeat",
                        @"abecdfdsaf",            @"local",
                        @"fafafafafa",            @"detail",
                        
                        nil];

    eventEdited=[[BNEventEntity alloc]initWithDictionary:data];
    BOOL succes;
    
    if (type==1) {
        succes=[dataSqlite insertDatabase:eventEdited]; 
        
    }
    else if(type==2){
        
        
        
    }
    else if(type==3){
        
        
        
    }
    if (succes) {
        [self showAlerView:@"ok"];
    }
    else{
        [self showAlerView:@"Insert"];
    }
    
   
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
            
        default:
            return 40;
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
                titletf=[[UITextField alloc]initWithFrame:CGRectMake(25, 10, 180, 20)];
                titletf.backgroundColor=[UIColor clearColor];
                titletf.textAlignment=UITextAlignmentLeft;
                titletf.placeholder=@"Title";
                UIFont *font=[UIFont fontWithName:@"Arial" size:16];
                titletf.font=font;
                [titletf addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell addSubview:titletf];
                
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
                
                    
                        UILabel *labelStart=[[UILabel alloc]initWithFrame:CGRectMake(25, 15, 80, 20)];
                        labelStart.text=@"Time Start";
                        labelStart.font=[UIFont boldSystemFontOfSize:16];
                        labelStart.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:labelStart];
                        
                        startDatelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 15, 200, 20)];
                        startDatelb.text=@"";
                        
                        startDatelb.backgroundColor=[UIColor clearColor];
                        startDatelb.textColor=[UIColor blueColor];
                        [cell addSubview:startDatelb];
                        
                        
                        UILabel *labelEnd=[[UILabel alloc]initWithFrame:CGRectMake(25, 60, 80, 20)];
                        labelEnd.text=@"Time End";
                        labelEnd.font=[UIFont fontWithName:@"Arial-BoldMT" size:16];
                        labelEnd.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:labelEnd];
                        
                        
                        endDatelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 200, 20)];
                        endDatelb.text=@"";
                        endDatelb.textColor=[UIColor blueColor];
                        endDatelb.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:endDatelb];
                                   
            }
                break;
            case 3:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 80, 20)];
                label.text=@"Repeat";
                label.font=[UIFont boldSystemFontOfSize:16];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
                
                
                
                repeat=[[UILabel alloc]initWithFrame:CGRectMake(150, 10, 200, 20)];
                repeat.textColor=[UIColor blueColor];
                repeat.backgroundColor=[UIColor clearColor];
                [cell addSubview:repeat];
            }
                break;
            case 4:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Time Repeat";
                label.font=[UIFont boldSystemFontOfSize:16];
                label.backgroundColor=[UIColor clearColor];

                [cell addSubview:label];
                
                repeatTime=[[UILabel alloc]initWithFrame:CGRectMake(150, 10, 200, 20)];
                repeatTime.textColor=[UIColor blueColor];
                repeatTime.backgroundColor=[UIColor clearColor];
                [cell addSubview:repeatTime];
            }
                break;
            case 5:
            {
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 120, 20)];
                label.text=@"Description";
                label.font=[UIFont boldSystemFontOfSize:16];
                label.backgroundColor=[UIColor clearColor];
                
                [cell addSubview:label];
                description=[[UITextView alloc]initWithFrame:CGRectMake(22, 25, 280, 180)];
                description.backgroundColor=[UIColor clearColor];
                description.textAlignment=UITextAlignmentLeft;
  
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
 
        DatePickerView *pickerView=[[DatePickerView alloc]initWithNibName:@"DatePickerView" bundle:nil];
        pickerView.delegate=self;
        [self.navigationController pushViewController:pickerView animated:YES];
        
    }
    else if(indexPath.section==3){
        [self showOption:1];
    }
    else if(indexPath.section==4){
        [self showOption:2];
    }
}
#pragma mark - UIActionSheet
-(void)showOption:(int)type{
    if (type==1) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Repeat" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"No repeat" otherButtonTitles:@"Every day",@"Every week",@"Every month", nil];
        actionSheet.tag=1;
        [actionSheet showInView:self.view];
    }
    else if(type==2){
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Time Repeat" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"No time repeat" otherButtonTitles:@"5 min",@"10 min",@"15 min",@"20 min", nil];
        actionSheet.tag=2;
        [actionSheet showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1) {
        //NSLog(@" select repeat at index %d",buttonIndex);
        repeatInt=buttonIndex;
        switch (buttonIndex) {
            case 0:
                repeat.text=@"No repeat";
                
                break;
            case 1:
                repeat.text=@"Every day";
                break;
                
            case 2:
                repeat.text=@"Every week";
                break;
            case 3:
                repeat.text=@"Every month";
                break;

        }
    }
    else if(actionSheet.tag==2){
        //NSLog(@" select repeat time at index %d",buttonIndex);
        repeatTimeInt=buttonIndex;
        switch (buttonIndex) {
            case 0:
                repeatTime.text=@"No time repeat";
                break;
            case 1:
                repeatTime.text=@"5 min";
                break;
                
            case 2:
                repeatTime.text=@"10 min";
                break;
            case 3:
                repeatTime.text=@"15 min";
                break;
            case 4:
                repeatTime.text=@"20 min";
                break;
                
        }
    }
}
#pragma mark - UIAlertView
-(void)showAlerView:(NSString *)title{
    if ([title isEqualToString:@"ok"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Succes" message:@"Update database complete" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@ error",title] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2) {
        [self.delegate CloseEditView:self];
    }
}
@end
