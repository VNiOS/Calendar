//
//  BNEventListController.m
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//



#import "BNEventListController.h"
#import "BNEventEditorController.h"
#import "BNCalendarController.h"
#import "EventDataSqlite.h"
#import "BNEventCell.h"
#define max 100000
#define textSize 14



@implementation BNEventListController

- (id)init{
    self = [super init];
    if(self){
        
        dateEvent = [[NSDate dateWithTimeIntervalSinceNow:-9*24*60*60]retain];
        [self updateContentDate:dateEvent];
    }  
    return self;
}

- (void)updateContentDate:(NSDate *)withdate
{
    EventDataSqlite *eventDataSqlite = [[EventDataSqlite alloc] init];
    eventDay = [[NSArray arrayWithArray:[eventDataSqlite EventListIntoDate:withdate]]retain];
    NSLog(@"with date is = %@",withdate);
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
    
    UIBarButtonItem *addEventButton=[[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addEvent:)];
    [self.navigationItem setRightBarButtonItem:addEventButton];
    [self.tableView reloadData];
    
    // add Header View
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,104)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    

    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 44)];
    [self addContentToHeadView:barView];
    [headerView addSubview:barView];
    self.tableView.tableHeaderView = headerView;
    [headerView release];
    [self.navigationController setNavigationBarHidden:YES];
    
    //add Toolbar 
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,300, 320, 40)];
    self.tableView.tableFooterView =  toolBar;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - code

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventDay count];
    
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"BNEventCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[[BNEventCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BNEventEntity *event = [self eventAtIndexPath:indexPath];
    [cell UpdateContentCell:event];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNEventEntity *event = [eventDay objectAtIndex:indexPath.row];
    return [self heightofCell:event];
}



-(CGFloat)heightofCell:(BNEventEntity *)event2
{
    CGSize titleSize = [event2.title sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(270, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize localLabelSize = [event2.local sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize detailLabelSize = [event2.detail sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(240, max) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return (90 + titleSize.height + localLabelSize.height + detailLabelSize.height);
    
}

- (void)bnEventCellDidClickedAtCell:(BNEventCell *)cell1
{
        NSIndexPath *indexPathCell = [self.tableView indexPathForCell:cell1];

        BNEventEntity *event1 = [eventDay objectAtIndex:indexPathCell.row];
       
    
    
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate = self;
    UINavigationController *navirControl=[[UINavigationController alloc]initWithRootViewController:editView];
    
    navirControl.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:navirControl animated:YES];
}



- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath{
    return  [eventDay objectAtIndex:indexPath.row];
    
}



-(void)CloseEditView:(BNEventEditorController *)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}

-(IBAction)addEvent:(id)sender{
    BNEventEditorController *editView=[[BNEventEditorController alloc]initWithNibName:@"BNEventEditorController" bundle:nil];
    editView.delegate=self;
    UINavigationController *navirControl=[[UINavigationController alloc]initWithRootViewController:editView];
    
    navirControl.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:navirControl animated:YES];
}

- (IBAction)BackToCalendar:(id)sender
{
    BNCalendarController *calendar = [[BNCalendarController alloc]initWithNibName:@"BNCalendarController" bundle:nil];
    [self.navigationController popToViewController:calendar animated:YES];
}


-(void)addContentToHeadView:(UIView *)view{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Kal.bundle/kal_grid_background.png"]];
    CGRect imageFrame = view.frame;
    imageFrame.origin = CGPointZero;
    backgroundView.frame = imageFrame;
    [view addSubview:backgroundView];
    [backgroundView release];
    
    
    titlelb = [[UILabel alloc]initWithFrame:CGRectMake(45, 10,120, 20)];
    titlelb.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    titlelb.text= [self conVertDateToStringDate:dateEvent];
    titlelb.font=[UIFont boldSystemFontOfSize:22.f];
    [titlelb setBackgroundColor:[UIColor clearColor]];
    titlelb.shadowColor = [UIColor whiteColor];
    titlelb.shadowOffset = CGSizeMake(0.f, 1.f);
    [view addSubview:titlelb];
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(240,5, 40, 30)];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    dayLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kal.bundle/kal_header_text_fill.png"]];
    [dayLabel setBackgroundColor:[UIColor clearColor]];
    dayLabel.shadowColor = [UIColor whiteColor];
    dayLabel.font=[UIFont boldSystemFontOfSize:22.f];
    [view addSubview:dayLabel];

    
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 46, 30)];
    [BackButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    BackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    BackButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [BackButton addTarget:self action:@selector(done:)  forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:BackButton];
    
    UIButton *PrevButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 46, 30)];
    [PrevButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    PrevButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    PrevButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [PrevButton addTarget:self action:@selector(eventPrevDay:)  forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:PrevButton];
    
    UIButton *NextButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 46, 30)];
    [NextButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_right_arrow.png"] forState:UIControlStateNormal];
    NextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    NextButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [NextButton addTarget:self action:@selector(eventNextDay:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:NextButton];
    
}

-(IBAction)done:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)eventNextDay:(id)sender{
    [eventDay release];
    eventDay = nil;
    NSDate *nextDay = [[NSDate dateWithTimeInterval:24*60*60 sinceDate:dateEvent]retain];
    dateEvent = nextDay;
    titlelb.text = [self conVertDateToStringDate:dateEvent];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    [self updateContentDate:nextDay];
    [self.tableView reloadData];
    NSLog(@"date event is = %@",dateEvent);
    
}

-(IBAction)eventPrevDay:(id)sender
{
    [eventDay release];
    eventDay = nil;
    NSDate *prevDay = [[NSDate dateWithTimeInterval:-24*60*60 sinceDate:dateEvent]retain];
    dateEvent = prevDay;
    titlelb.text = [self conVertDateToStringDate:dateEvent];
    dayLabel.text = [self conVertDateToStringDay:dateEvent];
    [self updateContentDate:prevDay];
    [self.tableView reloadData];
    
}

-(NSString *)conVertDateToStringDate:(NSDate *)date1
{
    NSDateFormatter *df = [[[NSDateFormatter alloc]init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [df stringFromDate:date1];
    return dateString;
}

-(NSString *)conVertDateToStringDay:(NSDate *)date2
{
    NSDateFormatter *dfDay = [[[NSDateFormatter alloc]init]autorelease];
    [dfDay setDateFormat:@"dd"];
    NSString *dayString = [dfDay stringFromDate:date2];
    return dayString;
}




- (void) dealloc{
    [dateEvent release];
    [eventDay release];
    [super dealloc];
    
}


@end



