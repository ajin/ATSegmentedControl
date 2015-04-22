//
//  ATSegmentedButtonCell.m
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//  Licensed under MIT License

#import "ATSegmentedButtonCell.h"

@implementation ATSegmentedButtonCell
- (id)init {
    self = [super init];
    if (self) {
        self.bezelStyle = NSTexturedRoundedBezelStyle;
    }
    return self;
}

- (NSInteger) nextState {
    return self.state;
}


- (void) drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    if (self.state == NSOnState) {
        
    }
}
@end
