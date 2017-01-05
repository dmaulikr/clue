#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "AppDelegate.h"

#include "clue/clue.h"

@interface CustomViewController : UIViewController<GLKViewDelegate>

@property (strong, nonatomic) EAGLContext* glContext;
@property (strong, nonatomic) GLKView* glView;

- (id)init;

@end

@implementation CustomViewController
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
	
	self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	self.glView = [[GLKView alloc] initWithFrame:screenBounds context:self.glContext];
	self.glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
	self.glView.delegate = self;
	[self.view addSubview:self.glView];
	
	CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
	[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	clue_ios_hook_memory_warning();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	CGRect screenBounds = [[UIScreen mainScreen] bounds];

	self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.rootViewController = [[CustomViewController alloc] init];
    [self.window makeKeyAndVisible];
	
	clue_hook_loaded();
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_become_inactive);
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(did_become_inactive);
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_become_active);
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(did_become_active);
}


- (void)applicationWillTerminate:(UIApplication *)application
{
	CLUE_HOOK_INVOKE(will_terminate);
}

@end
