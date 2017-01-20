#include "clue/share.h"
#include "clue/hook.h"

#include "clue/ios/ViewController.h"

#import <UIKit/UIKit.h>

void clue_share(const char* text, const char* url, float x, float y)
{
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	if (text)
	{
		[items addObject:[NSString stringWithUTF8String:text]];
	}
	
	if (url)
	{
		[items addObject:[NSURL URLWithString:[NSString stringWithUTF8String:url]]];
	}
	
	//NSArray* immutableItems = [items copy];
	
	ClueViewController* viewController = clue_ios_get_view_controller();
	
	UIActivityViewController* activityViewController =
		[[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
	
	activityViewController.excludedActivityTypes = @[];
	
	// iPads need to configure the popoverPresentationController.
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		activityViewController.popoverPresentationController.sourceView = viewController.view;
		activityViewController.popoverPresentationController.sourceRect = CGRectMake(
			// Point the popover to this point.
			x * viewController.view.bounds.size.width,
			y * viewController.view.bounds.size.height,
			
			// Automatically size the popover.
			0,
			0
		);
	}
	
	void (^completion)(void) = ^{
		CLUE_HOOK_INVOKE(share_complete);
	};
	
	[viewController presentViewController:activityViewController animated:true completion:completion];
}
