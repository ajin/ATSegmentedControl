//
//  ATSegmentedView.h
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ATSegmentedButton.h"

@protocol ATSegmentedDelegate <NSObject>
/**
 *  Tells the delegate that the item was selected.
 */
- (void) didSelectWithItem:(id)sender;

@end

@interface ATSegmentedView : NSView
@property (nonatomic,strong) NSMutableArray* items;
@property (nonatomic,assign) IBInspectable CGFloat itemWidth;
@property (nonatomic,strong) IBInspectable NSColor *backgroundColor;
@property (nonatomic,strong) IBInspectable NSColor *borderColor;
@property (nonatomic,weak) IBOutlet id<ATSegmentedDelegate> delegate;
@property (nonatomic,strong) NSButton *overflowButton;
@property (nonatomic,strong) NSView *constraintView;
@property (nonatomic,assign) NSSize intrinsicContentSize;
@property (nonatomic,assign) BOOL needsUpdateIntrinsicContentSize;


- (ATSegmentedButton *) addButtonWithTitle:(NSString*)title tooltip:(NSString*)tooltip icon:(NSImage*)icon alwaysVisible:(BOOL)visible;
- (void) addButton:(NSButton*) button icon:(NSImage*) icon;
- (void) selectItem:(id)sender;

@end
