#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface CustomViewController : UIViewController<GLKViewDelegate>

@property (strong, nonatomic) EAGLContext* glContext;
@property (strong, nonatomic) GLKView* glView;

@property (strong, nonatomic) NSMutableArray* touches;

- (id)init;
- (void)applyContext;

@end
