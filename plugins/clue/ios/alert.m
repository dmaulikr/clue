#include "clue/alert.h"

#include "clue/ios/ViewController.h"

#import <UIKit/UIKit.h>

void clue_alert(const char* title, const char* message)
{
	
	ClueViewController* viewController = clue_ios_get_view_controller();
	
	void (^completion)(void) = ^{
		// TODO
	};

	UIAlertController* alertController = [UIAlertController
		alertControllerWithTitle:[NSString stringWithUTF8String:title]
		message:[NSString stringWithUTF8String:message]
		preferredStyle:UIAlertControllerStyleAlert
	];

	UIAlertAction* defaultAction = [UIAlertAction
		actionWithTitle:@"OK"
		style:UIAlertActionStyleDefault
		handler:^(UIAlertAction* action) {
			// TODO
		}
	];

	[alertController addAction:defaultAction];
	[viewController presentViewController:alertController animated:YES completion:completion];
}
