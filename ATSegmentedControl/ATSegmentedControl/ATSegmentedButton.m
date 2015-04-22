//
//  ATSegmentedButton.m
//  ATSegmentedControl
//
//  Created by Ajin Man Tuladhar on 22/04/15.
//  Copyright (c) 2015 Ajin Man Tuladhar. All rights reserved.
//  Licensed under MIT License

#import "ATSegmentedButton.h"

@implementation ATSegmentedButton

- (id)init {
    if (self = [super init]) {
        [self setAlwaysVisible:NO];
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

@end
