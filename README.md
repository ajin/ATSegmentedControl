# ATSegmentedControl

ATSegmentedControl is similar like segmented control from xcode but borderless and has some extra functions. 

<img src=https://raw.githubusercontent.com/ajin/ATSegmentedControl/master/screenshot-1.png height=400 />
<img src=https://raw.githubusercontent.com/ajin/ATSegmentedControl/master/screenshot-2.png height=400 />
<img src=https://raw.githubusercontent.com/ajin/ATSegmentedControl/master/screenshot-3.png height=400 />



## Features

* Automatically hide items and show them in a pop-up menu when resizing.
* Can mark items to always be visible while resizing.
* Can automatically calculate the minumum width for ATSegmentedView.
* Background color and bottom border can be set through interface builder.

## Usage

	#import "ATSegmentedView.h"

	NSImage* icon = [NSImage imageNamed:@"NSHome"];
	NSImage* icon1 = [NSImage imageNamed:@"NSShareTemplate"];

	// add items to segmented view
	[self.segmentedView addButtonWithTitle:@"Home"
	                               tooltip:@"Home sweet home"
	                                  icon:icon
	                         alwaysVisible:YES];

	ATSegmentedButton *buttonSelect = [self.segmentedView addButtonWithTitle:@"Share"
	                                   tooltip:@"Sharing is good"
	                                      icon:icon1
	                             alwaysVisible:YES];
 
	// manual select item
	[self.segmentedView selectItem:buttonSelect];

alternative way to add new item

	#import "ATSegmentedView.h"
	#import "ATSegmentedButton.h"
	#import "ATSegmentedButtonCell.h"

	ATSegmentedButton *button = [[ATSegmentedButton alloc] initWithFrame:NSZeroRect];
	[button setCell:[[ATSegmentedButtonCell alloc] init]];
	[button setTitle: @"Search"];
	[button setToolTip: @"Visit below"];
	[button setEnabled:YES];
	[button setAlwaysVisible:YES];
	
	// remember to set image as template image before adding button
	NSImage* icon3 = [NSImage imageNamed:@"NSRevealFreestandingTemplate"];
	[icon3 setTemplate:YES];
	[self.segmentedView addButton:button icon:icon3];

For a more complete demonstration and usage with delegate, see AppDelegate.m.

## Support

There are various ways to support this project:
* Send me a pull request.
* Review it on your site or blog.
* Make a donation via PayPal :)

If you make any improvements, please submit them as pull requests.

## Building and runnning

To build, simply open ATSegmentedControl.xcodeproj and run. The project contains the core files and a simple demo application.

## License

ATSegmentedControl is available under the MIT license. See the LICENSE file for more info.
