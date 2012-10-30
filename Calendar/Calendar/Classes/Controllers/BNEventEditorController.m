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


#define EventNew 1
#define EventUpdate 2



#define defaultEventID 999999999

@implementation BNEventEditorController
@synthesize delegate,startDatelb,endDatelb,tableView,eventEdited;


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
    dataSqlite=[[EventDataSqlite alloc]init];
    self.title=@" Event";
    repeatInt=0;
    repeatTimeInt=0;
   
    
    
    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 104)];
    headView.backgroundColor=[UIColor clearColor];
    
    self.tableView.tableHeaderView=headView;
    
    UIBarButtonItem *doneBt=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [doneBt setTintColor:[UIColor colorWithRed:0.3 green:0.7 blue:0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem=doneBt;
    
    
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0, 320, 44)] autorelease];
    headerView.backgroundColor = [UIColor grayColor];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self addContentToHeadView:headerView];
    [self.view addSubview:headerView];
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 330,320, 44)];
    [self addContentToFooterView:footerView];
    [self.view addSubview:footerView];

    
    NSDictionary *data2=[[NSDictionary alloc]initWithObjectsAndKeys:
                         @"5",@"event_id",
                         @"test update event 3",         @"title",
                         @"2012-10-31 11:00:00",         @"timeStart",
                         @"2012-10-31 11:30:00",         @"timeEnd",
                         @"0",        @"repeat",
                         @"0",        @"timeRepeat",
                         @"afd",         @"local",
                         @"dfdf",         @"detail",
                         
                         nil];
    BNEventEntity *testUpdate=[[BNEventEntity alloc ]initWithDictionary:data2];
    [self getEventInput:testUpdate];
    
    
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
    [BackButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
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
    [Delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Delete];
    
    if (EditType==EventNew) {
        [Delete setHidden:YES];
    }
    
    UIButton *Insert = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 70, 30)];
    [Insert.titleLabel setTextAlignment:UITextAlignmentLeft];
    [Insert.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [Insert setTitle:@"Accept" forState:UIControlStateNormal];
    [Insert setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]] forState:UIControlStateNormal];
    [Insert addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Insert];
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
  
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
#pragma mark -Action
-(IBAction)done:(id)sender{
    [self checkDataInput];
    
}
-(IBAction)back:(id)sender{
    NSLog(@"Back");
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)closeTextField:(id)sender{
    [sender resignFirstResponder];
    [self.tableView reloadData];
}



#pragma mark - Data IO
-(void)getEventInput:(BNEventEntity *)event{
    if (!event) {
        EditType=EventNew;
        NSLog(@"Create new event");
        NSString *IdDefault=[NSString stringWithFormat:@"%d",defaultEventID];
        NSDictionary *data=[[NSDictionary alloc]initWithObjectsAndKeys:
                            IdDefault,@"event_id",
                            @"",         @"title",
                            @"",         @"timeStart",
                            @"",         @"timeEnd",
                            @"0",        @"repeat",
                            @"0",        @"timeRepeat",
                            @"",         @"local",
                            @"",         @"detail",
                            
                            nil];
        
        eventEdited=[[BNEventEntity alloc]initWithDictionary:data];
    }
    else{
        EditType=EventUpdate;
        
        
        eventEdited=event;
        NSLog(@"editType : update");
//        [titletf setText:event.title];
//        [location setText:event.local];
//        [startDatelb setText: event.timeStart];
//        [endDatelb setText: event.timeEnd];
//        [repeat setText:[NSString stringWithFormat:@"%d",event.repeat]];
//        [repeatTime setText:event.timeRepeat];
//        [description setText:event.detail];
        //[self.tableView reloadData];
        //NSLog(@"Update event");
    }
}
-(void)checkDataInput{
    
    
    
    if (titletf.text.length==0) {
        [self showAlerView:@"Title" andSucces:NO];
    }
    else{
        if (description.text.length==0) {
            [self showAlerView:@"Description" andSucces:NO];
        }
        else{
            
            if ([startDatelb.text isEqualToString:endDatelb.text]) {
                [self showAlerView:@"Date" andSucces:NO];
            }
            else{
                
                
                [self saveData:EditType];
            }

        }
        
        
        
    }
    
    
}
-(void)saveData:(int)type{
//    eventEdited.title=titletf.text;
//    eventEdited.local=location.text;
//    eventEdited.timeStart=startDatelb.text;
//    eventEdited.timeEnd=endDatelb.text;
//    eventEdited.repeat=repeatInt;
//    eventEdited.timeRepeat=repeatTime.text;
//    eventEdited.detail=description.text;
    
     BOOL succes;
    NSString *action=[NSString stringWithFormat:@"Update "];
    
        NSLog(@"Save data");
       
        if (eventEdited.event_id==defaultEventID) {
            NSLog(@"insert event");
            succes=[dataSqlite insertDatabase:eventEdited]; 
        }
        else{
            
            NSLog(@"update event");
            succes=[dataSqlite updateDatabase:eventEdited];
        }
    //show Alert
         [self showAlerView:action andSucces:succes];
    
 
    
   
}
-(IBAction)deleteEvent:(id)sender{
    
    bool succes;
        NSString *action=[NSString stringWithFormat:@"Delete Event "];
        succes=[dataSqlite deleteDatabase:eventEdited];
    [self showAlerView:action andSucces:succes];    

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
                titletf.text=eventEdited.title;
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
                location.text=eventEdited.local;
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
                        startDatelb.text=eventEdited.timeStart;
                        
                        startDatelb.backgroundColor=[UIColor clearColor];
                        startDatelb.textColor=[UIColor blueColor];
                        [cell addSubview:startDatelb];
                        
                        
                        UILabel *labelEnd=[[UILabel alloc]initWithFrame:CGRectMake(25, 60, 80, 20)];
                        labelEnd.text=@"Time End";
                        labelEnd.font=[UIFont boldSystemFontOfSize:16];
                        labelEnd.backgroundColor=[UIColor clearColor];
                        
                        [cell addSubview:labelEnd];
                        
                        
                        endDatelb=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 200, 20)];
                        endDatelb.text=eventEdited.timeEnd;
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
                repeat.text=[NSString stringWithFormat:@"%d",eventEdited.repeat];
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
                repeatTime.text=eventEdited.timeRepeat;
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
                description.text=eventEdited.detail;
                
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
        eventEdited.repeat= buttonIndex;
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
        
        repeatTimeInt=buttonIndex;
        switch (buttonIndex) {
            case 0:
                eventEdited.timeRepeat=@"No time repeat";
                repeatTime.text=eventEdited.timeRepeat;
                break;
            case 1:
                 eventEdited.timeRepeat=@"5 min";
                repeatTime.text=eventEdited.timeRepeat;
                break;
                
            case 2:
                 eventEdited.timeRepeat=@"10 min";
                repeatTime.text=eventEdited.timeRepeat;
                break;
            case 3:
                eventEdited.timeRepeat=@"15 min";
                repeatTime.text=eventEdited.timeRepeat;
                break;
            case 4:
                 eventEdited.timeRepeat=@"20 min";
                repeatTime.text=eventEdited.timeRepeat;
                break;
                
                
        }
       NSLog(@"select timeRepeat : %@",eventEdited.timeRepeat);
    }
    [self.tableView reloadData]; 
}
#pragma mark - UIAlertView
-(void)showAlerView:(NSString *)title andSucces :(BOOL)succes{
    NSLog(@" %@ is error",title);
    if (succes) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Succes" message:[NSString stringWithFormat:@"%@ succes",title] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
    }
    else{
        NSString *msg=[NSString stringWithFormat:@"%@ is error",title];
       
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not succes" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=3;
        [alert show];
        
        
        
    }
 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
