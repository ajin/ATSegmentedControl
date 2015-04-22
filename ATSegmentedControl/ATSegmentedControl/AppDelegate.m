//
//  AppDelegate.m
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//

#import "AppDelegate.h"
#import "ATSegmentedButton.h"
#import "ATSegmentedButtonCell.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // Do not forget to set the delegate from the Interface Builder
    
    // optional: define your own overflow icon
    NSImage* iconOverflow = [NSImage imageNamed:@"NSRightFacingTriangleTemplate"];
    [[self.segmentedView overflowButton] setImage:iconOverflow];
    
    // initialize icons
    NSImage* icon = [NSImage imageNamed:@"NSHome"];
    NSImage* icon1 = [NSImage imageNamed:@"NSBookmarksTemplate"];
    NSImage* icon2 = [NSImage imageNamed:@"NSShareTemplate"];
    NSImage* icon3 = [NSImage imageNamed:@"NSListViewTemplate"];
    NSImage* icon4 = [NSImage imageNamed:@"NSIconViewTemplate"];
    NSImage* icon5 = [NSImage imageNamed:@"NSQuickLook"];
    NSImage* icon6 = [NSImage imageNamed:@"NSRevealFreestandingTemplate"];
    
    // add items to segmented view
    [self.segmentedView addButtonWithTitle:@"Home"
                                   tooltip:@"Home sweet home"
                                      icon:icon
                             alwaysVisible:YES];
    
    [self.segmentedView addButtonWithTitle:@"Bookmarks"
                                   tooltip:@"Where is it?"
                                      icon:icon1
                             alwaysVisible:NO];
    
    ATSegmentedButton *buttonSelect = [self.segmentedView addButtonWithTitle:@"Share"
                                   tooltip:@"Sharing is good"
                                      icon:icon2
                             alwaysVisible:YES];
    
    [self.segmentedView addButtonWithTitle:@"List view"
                                   tooltip:@"Super list"
                                      icon:icon3
                             alwaysVisible:NO];
    
    [self.segmentedView addButtonWithTitle:@"Icon view"
                                   tooltip:@"Amazing view"
                                      icon:icon4
                             alwaysVisible:NO];
    
    [self.segmentedView addButtonWithTitle:@"QuickLook"
                                   tooltip:@"Awesome look"
                                      icon:icon5
                             alwaysVisible:YES];
    
    // manual select item
    [self.segmentedView selectItem:buttonSelect];

    // alternative way to add item
    ATSegmentedButton *button = [[ATSegmentedButton alloc] initWithFrame:NSZeroRect];
    [button setCell:[[ATSegmentedButtonCell alloc] init]];
    [button setTitle: @"Search"];
    [button setToolTip: @"Visit below"];
    [button setEnabled:YES];
    [button setAlwaysVisible:YES];
    // remember to set image as template image before adding button
    [icon6 setTemplate:YES];
    [self.segmentedView addButton:button icon:icon6];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) didSelectWithItem:(id)sender {
    NSButton *button = sender;
    [self.textField setStringValue:[button title]];
    [self.tooltipField setStringValue:[button toolTip]];
    
    NSLog(@"selected item: %@",[button title]);
}

@end
