//
//  BNEventListController.h
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEditorController.h"
@interface BNEventListController : UIViewController<EditEventDelegate>{
    
}
-(void)addOrUpdateEvent:(BNEventEntity *)event;
@end
