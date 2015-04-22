//
//  ATSegmentedView.m
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//  Licensed under MIT License

#import "ATSegmentedView.h"
#import "ATSegmentedButton.h"
#import "ATSegmentedButtonCell.h"

@implementation ATSegmentedView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self initialize];
    }
    return self;
}

/**
 *  Initialize Segmented View
 *
 *  @param aDecoder An unarchiver object
 *  @return initialized using the data in decoder
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self != nil) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    self.items = [[NSMutableArray alloc] init];
    self.itemWidth = 32.0f;
    
    self.overflowButton = [[NSButton alloc] initWithFrame:NSZeroRect];
    [self.overflowButton setCell:[[ATSegmentedButtonCell alloc] init]];
    NSImage* icon = [NSImage imageNamed:@"NSRightFacingTriangleTemplate"];
    [self.overflowButton setImage:icon];
    [self.overflowButton setTarget:self];
    [self.overflowButton setAction:@selector(overflowContexMenu:)];
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    [self.overflowButton setMenu:theMenu];
}

- (void)awakeFromNib {
    
}

/**
 *  Adds a button to the receiver with the given title, tooltip and icon.
 *
 *  @param title   The title of the new button.
 *  @param tooltip The tooltip of the new button.
 *  @param icon    The icon of the new button.
 *
 *  @return Returns a new instance of ATSegmentedButton.
 */
- (ATSegmentedButton*) addButtonWithTitle:(NSString*)title tooltip:(NSString*)tooltip icon:(NSImage*)icon alwaysVisible:(BOOL)visible {
    [icon setTemplate:YES];
    
    ATSegmentedButton *button = [[ATSegmentedButton alloc] initWithFrame:NSZeroRect];
    [button setCell:[[ATSegmentedButtonCell alloc] init]];
    [button setTitle: title];
    [button setToolTip: tooltip];
    [button setEnabled:YES];
    [button setAlwaysVisible:visible];
    
    [self addButton:button icon:icon];
    return button;
}

/**
 *  Adds a button to the receiver with icon
 *
 *  @param button The button object of the new button
 *  @param icon   The icon of the new button
 */
- (void) addButton:(NSButton*) button icon:(NSImage*) icon {
    [button setFrame:NSMakeRect(0.0f, 0.0f, self.itemWidth, NSHeight(self.bounds))];
    
    if (![button target]){
        [button setTarget:self];
        [button setAction:@selector(selectItem:)];
    }
    
    [button setImage:icon];
    [button setButtonType:NSToggleButton];
    [button sendActionOn:NSLeftMouseDownMask];
    [self.items addObject:button];
    [self layoutSubviews];
}

/**
 *  The natural size for the receiving view, considering only properties of the view itself. (read-only)
 *  @return <#return value description#>
 */
- (NSSize)intrinsicContentSize {
    [self updateIntrinsicContentSizeIfNeeded];
    return _intrinsicContentSize;
}

/**
 *  setNeedsUpdateIntrinsicContentSize
 */
- (void)setNeedsUpdateIntrinsicContentSize {
    self.needsUpdateIntrinsicContentSize = YES;
    [self invalidateIntrinsicContentSize];
}

/**
 *  Update the minimum width size for the receiving view if needed
 */
- (void)updateIntrinsicContentSizeIfNeeded {
    if (self.needsUpdateIntrinsicContentSize) {
        [self updateIntrinsicContentSize];
    }
}

/**
 *  Update the minimum width size for the receiving view
 */
- (void)updateIntrinsicContentSize {
    NSUInteger currentWidth = [[self subviews] count] * self.itemWidth;
    _intrinsicContentSize = NSMakeSize(currentWidth - self.itemWidth + 15, 0);
    self.needsUpdateIntrinsicContentSize = YES;
}

/**
 *  Use iconbar view in flipped coordinate system
 *  @return YES
 */
- (BOOL) isFlipped {
    return YES;
}

/**
 *  handler for selected  item
 *  @param sender NSButton
 */
- (void)selectItem:(id)sender {
    for (NSButton *item in self.items){
        [item setState: NSOffState];
    }
    for (NSMenuItem *item in [[self.overflowButton menu] itemArray]) {
        [item setState:NSOffState];
    }
    ATSegmentedButton *button = nil;
    
    if([sender isKindOfClass:[NSMenuItem class]]){
        NSMenuItem *menuItem = sender;
        button = [menuItem representedObject];
        [button setState:([button state] == NSOnState ? NSOffState : NSOnState)];
        [menuItem setState:[button state]];
    } else {
        button = sender;
        [button setState:([button state] == NSOnState ? NSOffState : NSOnState)];
    }
    
    if(self.delegate){
        [self.delegate didSelectWithItem:button];
    }
    
}

/**
 *  Displays a contextual menu
 *  @param sender <#sender description#>
 */
- (void) overflowContexMenu:(id)sender {
    [NSMenu popUpContextMenu:[((NSButton*) sender) menu]
                   withEvent:[NSApp currentEvent]
                     forView:sender];
}

/**
 *  Occurs when parent view is resized
 *  @param oldSize The previous size of the superview's bounds rectangle.
 */
- (void) resizeWithOldSuperviewSize:(NSSize)oldSize{
    [super resizeWithOldSuperviewSize:oldSize];
    [self layoutSubviews];
    [self setNeedsUpdateIntrinsicContentSize];

}

/**
 *  Private function to create menu item from given button
 *  @param button NSButton
 *  @return Menu Item
 */
- (NSMenuItem*) makeMenuItemFromButton: (NSButton*) button{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    [menuItem setTitle:[button title]];
    //[menuItem setTitle:@"asdfasdfsad"];
    [menuItem setAction:[button action]];
    [menuItem setTarget:[button target]];
    [menuItem setImage:[button image]];
    [menuItem setState:[button state]];
    [menuItem setRepresentedObject:button];
    return menuItem;
}

/**
 *  Rearrange icon items
 */
- (void) layoutSubviews {
    NSUInteger countItems = [self.items count];
    if(countItems > 0){
        CGFloat offset_x = 2;
        CGFloat stretchWidth = self.itemWidth;
        NSMutableArray* visibleItems = nil;
        NSMenu *theMenu = [self.overflowButton menu];
        [theMenu removeAllItems];
        
        NSUInteger currentWidth = 0;
        NSUInteger alwaysVisibleWidth = 0;
        CGFloat availableWidth = [self frame].size.width;
        
        // create set of visible items and create menuitem for remaining items
        if (self.itemWidth * countItems > availableWidth){
            visibleItems = [NSMutableArray arrayWithCapacity:countItems];
            for(NSUInteger i = 0; i < countItems; i++) {
                currentWidth += self.itemWidth;
                ATSegmentedButton *button = [self.items objectAtIndex:i];
                
                if([button alwaysVisible]){
                    alwaysVisibleWidth += self.itemWidth;
                }
                
                if(currentWidth < (availableWidth - self.itemWidth) || [button alwaysVisible]){
                    [visibleItems addObject:button];
                } else {
                    NSMenuItem *menuItem = [self makeMenuItemFromButton:button];
                    [theMenu addItem:menuItem];
                }
            }
            
            currentWidth = alwaysVisibleWidth;
            NSArray *tempArray = [visibleItems copy];
            
            // remove none always-visible items
            for(ATSegmentedButton *button in tempArray){
                
                if(![button alwaysVisible]){
                    currentWidth += self.itemWidth;
                    if(currentWidth > (availableWidth - self.itemWidth)){
                        [visibleItems removeObject:button];
                        NSMenuItem *menuItem = [self makeMenuItemFromButton:button];
                        [theMenu addItem:menuItem];
                    }
                }
            }
            
        } else {
            visibleItems = self.items;
            offset_x = floorf((NSWidth(self.bounds)-(countItems * self.itemWidth))/2.0f);
        }
        
        // remove all the items from the view
        while([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        
        // add overflow button when needed
        if([visibleItems count] != [self.items count]){
            [self.overflowButton setMenu:theMenu];
            [visibleItems addObject:self.overflowButton];
            stretchWidth = floorf(NSWidth(self.bounds)/[visibleItems count]);
        }
        
        [self setNeedsUpdateIntrinsicContentSize];
        
        // display visible items
        for (NSButton *item in visibleItems){
            item.frame = NSMakeRect(offset_x, NSMinY(self.bounds), stretchWidth, NSHeight(self.bounds));
            offset_x += stretchWidth;
            [self addSubview:item];
        }
        
    }
}

/**
 *  Custom draw background and border
 *  @param dirtyRect <#dirtyRect description#>
 */
- (void)drawRect:(NSRect)dirtyRect {
    //[super drawRect:dirtyRect];    
    // Drawing code here.
    // draw background color
    if (self.backgroundColor) {
        [super drawRect:dirtyRect];
        [self.backgroundColor setFill];
        NSRectFill(dirtyRect);
    }
    
    // draw bottom border
    if (self.borderColor) {
        [self.borderColor setStroke];
        [NSBezierPath setDefaultLineWidth:0.0f];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(NSMinX(self.bounds), NSMaxY(self.bounds))
                                  toPoint:NSMakePoint(NSMaxX(self.bounds), NSMaxY(self.bounds))];
    }
}



@end
