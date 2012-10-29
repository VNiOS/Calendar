//
//  DatePickerView.m
//  Calendar
//
//  Created by Applehouse on 10/26/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
@synthesize datePicker,delegate,dateStartlb,dateEndlb,tableView1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSDate *today1=[NSDate date];
        NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateInput=[[df stringFromDate:today1]retain];
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
    dateType=YES;
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 60, 320, 44)] autorelease];
    headerView.backgroundColor = [UIColor grayColor];
    [self.tableView1 setBackgroundColor:[UIColor clearColor]];
    [self addContentToHeadView:headerView];
    [self.view addSubview:headerView];

   
    // Do any additional setup after loading the view from its nib.
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
    titlelb.text=@"Set time";
    titlelb.font=[UIFont boldSystemFontOfSize:22.f];
    [titlelb setBackgroundColor:[UIColor clearColor]];
    titlelb.shadowColor = [UIColor whiteColor];
    titlelb.shadowOffset = CGSizeMake(0.f, 1.f);
    [view addSubview:titlelb];
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 46, 30)];
    [BackButton setAccessibilityLabel:NSLocalizedString(@"Previous month", nil)];
    [BackButton setImage:[UIImage imageNamed:@"Kal.bundle/kal_left_arrow.png"] forState:UIControlStateNormal];
    BackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    BackButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [BackButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:BackButton];
}
-(IBAction)done:(id)sender{
    delegate.startDatelb.text=dateStartlb.text;
    delegate.endDatelb.text=dateEndlb.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)setDate:(id)sender{
    
    
    NSDate *pickerDate = [self.datePicker date];
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[df stringFromDate:pickerDate];
    NSLog(@"select : %@",dateString);
    if (dateType) {
        self.dateStartlb.text=dateString;
    }
    else{
        self.dateEndlb.text=dateString;
    }
    
    //[dateString release];
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
#pragma mark tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ], [ indexPath indexAtPosition:1 ]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 90, 20)];
                label.text=@"Start time";
                [label setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:label];
                
                self.dateStartlb=[[UILabel alloc]initWithFrame:CGRectMake(120, 15, 180, 20)];
                self.dateStartlb.text=dateInput;
                
                [self.dateStartlb setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:self.dateStartlb];
                
                
            }
                break;
            case 1:
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 90, 20)];
                label.text=@"End time";
                [label setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:label];
                
                
                
                self.dateEndlb=[[UILabel alloc]initWithFrame:CGRectMake(120, 15, 180, 20)];
                self.dateEndlb.text=dateInput;
                [self.dateEndlb setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:self.dateEndlb];
                
            }
                break;
          
            
        }
                
        
        
    }
    
    
    
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        dateType=YES;
    }
    else{
        dateType=NO;
    }

}

@end
