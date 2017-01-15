#include "clue/hook.h"
#include "clue/touch.h"

#import "clue/ios/AppDelegate.h"
#import "clue/ios/ViewController.h"

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

void clue_ios_init_touch(clue_touch_t* dest, NSUInteger index, UITouch* touch, CGSize screenSize)
{
	CGPoint point = [touch locationInView:nil];
		
	dest->index = index;
	dest->x = point.x;
	dest->y = point.y;
	dest->nx = point.x / screenSize.width;
	dest->ny = point.y / screenSize.height;
	dest->force = touch.force;
	dest->maximumPossibleForce = touch.maximumPossibleForce;
}

@implementation ClueViewController
{
	double lastTimestamp;
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
		lastTimestamp = -1.0;
	}
	
	return self;
}

- (void)applyContext
{
	[EAGLContext setCurrentContext:self.glContext];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	clue_hook_render();
}

- (void)update:(CADisplayLink*)displayLink
{
	double timestamp = (double)displayLink.timestamp;
	
	double dt = 1.0 / 60.0;
	
	if (lastTimestamp >= 0.0)
	{
		dt = timestamp - lastTimestamp;
	}
	
	lastTimestamp = timestamp;
	
	clue_hook_update(dt);
	
	[self.glView display];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Set up GLES context.
	self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	
	// Set up GLES view.
	self.glView = [[GLKView alloc] initWithFrame:UIScreen.mainScreen.bounds context:self.glContext];
	self.glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
	self.glView.multipleTouchEnabled = YES;
	self.glView.delegate = self;
	[self.view addSubview:self.glView];
	
	[self applyContext];
	glGetIntegerv(GL_FRAMEBUFFER_BINDING, &_glFramebuffer);
	
	// Set up game loop.
	CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
	[displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	CLUE_HOOK_INVOKE(ios_memory_warning);
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
	if (!self.touches) self.touches = [[NSMutableArray alloc] init];
	
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	
	clue_touch_t ourTouch;
	
	for (UITouch* touch in touches)
	{
		// Get persistent index of this particular touch.
		NSUInteger index = [self.touches indexOfObject:touch];
		
		if (index == NSNotFound)
		{
			// If the touch wasn't previously recorded, find a new persistent index for it.
			for (index = 0; index < self.touches.count; ++index)
			{
				if (self.touches[index] == NSNull.null) break;
			}
			
			if (index == self.touches.count)
			{
				[self.touches addObject:touch];
			}
			else
			{
				[self.touches setObject:touch atIndexedSubscript:index];
			}
		}
		
		clue_ios_init_touch(&ourTouch, index, touch, screenBounds.size);
		clue_hook_touch_down(&ourTouch);
	}
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
	if (!self.touches) return;
	
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	
	clue_touch_t ourTouch;
	
	for (NSUInteger i = 0; i < self.touches.count; ++i)
	{
		// Skip empty slots.
		if (self.touches[i] == NSNull.null) continue;
		
		// Skip touches that aren't part of this event.
		if (![touches containsObject:self.touches[i]]) continue;
		
		clue_ios_init_touch(&ourTouch, i, self.touches[i], screenBounds.size);
		clue_hook_touch_move(&ourTouch);
	}
}

- (void)touchesEnded:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
	if (!self.touches) return;
	
	CGRect screenBounds = UIScreen.mainScreen.bounds;
	
	clue_touch_t ourTouch;
	
	for (NSUInteger i = 0; i < self.touches.count; ++i)
	{
		// Skip empty slots.
		if (self.touches[i] == NSNull.null) continue;
		
		// Skip touches that aren't part of this event.
		if (![touches containsObject:self.touches[i]]) continue;
		
		clue_ios_init_touch(&ourTouch, i, self.touches[i], screenBounds.size);
		clue_hook_touch_up(&ourTouch);
		
		// Now that this touch is done, remove it from our list.
		self.touches[i] = NSNull.null;
	}
}

- (void)touchesCancelled:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
	[self touchesEnded:touches withEvent:event];
}

ClueViewController* clue_ios_get_view_controller(void)
{
	return (ClueViewController*)clue_ios_get_app_delegate().window.rootViewController;
}

@end
