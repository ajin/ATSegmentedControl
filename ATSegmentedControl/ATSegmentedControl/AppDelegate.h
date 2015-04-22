//
//  AppDelegate.h
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATSegmentedView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, ATSegmentedDelegate>

@property (weak) IBOutlet ATSegmentedView *segmentedView;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSTextField *tooltipField;

@end

