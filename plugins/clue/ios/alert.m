#include "clue/alert.h"

#include "clue/ios/ViewController.h"

#import <UIKit/UIKit.h>

void clue_alert(
	const char* title,
	const char* message,
	const char* const buttons[],
	size_t buttons_size,
	clue_alert_button_callback_t button_callback,
	clue_alert_complete_callback_t complete_callback,
	void* user
) {
	ClueViewController* viewController = clue_ios_get_view_controller();

	UIAlertController* alertController = [UIAlertController
		alertControllerWithTitle:[NSString stringWithUTF8String:title]
		message:[NSString stringWithUTF8String:message]
		preferredStyle:UIAlertControllerStyleAlert
	];
	
	const char* default_buttons[] = { "OK" };
	if (!buttons || !buttons_size)
	{
		buttons = default_buttons;
		buttons_size = 1;
	}
	
	for (size_t i = 0; i < buttons_size; ++i)
	{
		UIAlertAction* action = [UIAlertAction
			actionWithTitle:[NSString stringWithUTF8String:buttons[i]]
			style:UIAlertActionStyleDefault
			handler:^(UIAlertAction* action) {
				if (button_callback) button_callback(i, user);
			}
		];

		[alertController addAction:action];
	}
	
	[viewController presentViewController:alertController animated:YES completion:^{
		if (complete_callback) complete_callback(user);
	}];
}
