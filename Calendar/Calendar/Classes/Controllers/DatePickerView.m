//
//  DatePickerView.m
//  Calendar
//
//  Created by Applehouse on 10/26/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
@synthesize datelb,datePicker,dateSelected,dateTypelb,delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setDateType:(bool)datetype{
    if (datetype) {
        dateTypelb.text=@"Start time :";
    }
    else{
        dateTypelb.text=@"End time :";
    }
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
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)setDate:(id)sender{
    NSLocale *usLocale = [[[NSLocale alloc]
                           initWithLocaleIdentifier:@"en_US"] autorelease];
    
    NSDate *pickerDate = [self.datePicker date];
    NSString *selectionString = [[NSString alloc] initWithFormat:@"%@",
                                 [pickerDate descriptionWithLocale:usLocale]];
    datelb.text= selectionString;
    
    [selectionString release];
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

@end
