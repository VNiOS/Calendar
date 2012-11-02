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
@synthesize delegate,startDatelb,endDatelb,tableView1,eventEdited,dateStart;


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
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0, 320, 44)] autorelease];
    headerView.backgroundColor = [UIColor grayColor];
    [self.tableView1 setBackgroundColor:[UIColor clearColor]];
    [self addContentToHeadView:headerView];
    [self.view addSubview:headerView];
    
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 356,320, 44)];
    [self addContentToFooterView:footerView];
    [self.view addSubview:footerView];

    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headView.backgroundColor=[UIColor clearColor];
    self.tableView1.tableHeaderView=headView;
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    footer.backgroundColor=[UIColor clearColor];
    self.tableView1.tableFooterView=footer;
    
        
    
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
-(void)dealloc{
    [titletf release];
    [startDatelb release];
    [endDatelb release];
    [description release];
    [repeat release];
    [repeatTime release];
    [location release];
}
#pragma mark -Action
-(IBAction)done:(id)sender{
    [self checkDataInput];
    
}
-(IBAction)back:(id)sender{
    NSLog(@"Back");
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Quit without save " message:@"Are you sure ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag=5;
    [alert show];
    
}
-(IBAction)closeTextField:(id)sender{
    eventEdited.title=titletf.text;
    eventEdited.local=location.text;
    [sender resignFirstResponder];
    [self.tableView1 reloadData];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
         [textView resignFirstResponder];
        eventEdited.detail=textView.text;
          return NO;
    }
    return YES;
}


#pragma mark - Data IO
-(void)getDateStart:(NSDate *)date{
    dateStart=date;
}
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
        
        NSLog(@"EditType : update");
        
        NSLog(@" ___title %@",eventEdited.title);
        NSLog(@" ___location %@",eventEdited.local);
        NSLog(@" ___startDate %@",eventEdited.timeStart);
        NSLog(@" ___endDate %@",eventEdited.timeEnd);
        NSLog(@" ___repeat %d",eventEdited.repeat);
        NSLog(@" ___time repeat %@",eventEdited.timeRepeat);
        NSLog(@" ___description %@",eventEdited.detail);
        
        
        
//         [titletf setText:event.title];
//        [location setText:event.local];
//        [startDatelb setText: event.timeStart];
//        [endDatelb setText: event.timeEnd];
//        [repeat setText:[NSString stringWithFormat:@"%d",event.repeat]];
//        [repeatTime setText:event.timeRepeat];
//        [description setText:event.detail];
//        [self.tableView1 reloadData];
      
    }
}
-(int)strimTextLength:(NSString *)string{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return trimmedString.length;
}
-(void)checkDataInput{
    CGRect end=self.tableView1.tableFooterView.bounds;
    [self.tableView1 scrollRectToVisible:end animated:YES];  
    
    
    if ([self strimTextLength:titletf.text]==0) {
        
        
        
        [self showAlerView:@"Title" andSucces:NO];
    }
    else{

            if ([self strimTextLength:startDatelb.text]==0||[self strimTextLength:endDatelb.text]==0) {
                [self showAlerView:@"Date" andSucces:NO];
            }
            else{
                [self saveData:EditType];
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
    
    
    
     BOOL succes;
    NSString *action=[NSString stringWithFormat:@"Update "];
    
        NSLog(@"Save data");
       
        if (eventEdited.event_id==defaultEventID) {
            NSLog(@"insert event");
            succes=[dataSqlite insertDatabase:eventEdited]; 
        }
        else{
            
            NSLog(@"update event with id %d",eventEdited.event_id);
            succes=[dataSqlite updateDatabase:eventEdited];
        }
    //show Alert
         
    [self showAlerView:action andSucces:succes];
}

-(IBAction)deleteEvent:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Delete Event " message:@"Are you sure ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag=6;
    [alert show];
     

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
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 60, 20)];
                label.text=@"Title";
                label.font=[UIFont boldSystemFontOfSize:16];
                label.backgroundColor=[UIColor clearColor];
                [cell addSubview:label];
                
                
                titletf=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 180, 20)];
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
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25, 10, 60, 20)];
                label.text=@"Local";
                label.font=[UIFont boldSystemFontOfSize:16];
                label.backgroundColor=[UIColor clearColor];
                [cell addSubview:label];

              
                location=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 180, 20)];
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
                switch (eventEdited.repeat) {
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
                    default:
                        repeat.text=@"No repeat";
                        break;
                }
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
                NSLog(@"set event detail %@ is %@",description.text,eventEdited.detail);
                description.delegate=self;
                [cell addSubview:description];
                
            }
                break;
            default:
                break;
        }
    }
    return cell;
}


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
    [self.tableView1 reloadData]; 
}
#pragma mark - UIAlertView
-(void)showAlerView:(NSString *)title andSucces :(BOOL)succes{
    
    if (succes) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Succes" message:[NSString stringWithFormat:@"%@ succes",title] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
    }
    else{
        NSString *msg=[NSString stringWithFormat:@"%@ is not acceptable , please recheck",title];
       
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not succes" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=3;
        [alert show];
        
        
        
    }
 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2) {
        [self.delegate reloadDatainView];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(alertView.tag==5){
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            
        }
    }
    else if(alertView.tag==6){
        if (buttonIndex==0) {
            bool succes;
            NSString *action=[NSString stringWithFormat:@"Delete Event "];
            succes=[dataSqlite deleteDatabase:eventEdited];
            [self showAlerView:action andSucces:succes];
        }
        else{
            
        }
    }
}
@end
