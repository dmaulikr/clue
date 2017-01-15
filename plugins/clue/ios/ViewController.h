#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ClueViewController: UIViewController<GLKViewDelegate>

@property (strong, nonatomic) EAGLContext* glContext;
@property (strong, nonatomic) GLKView* glView;
@property (assign, nonatomic) int glFramebuffer;

@property (strong, nonatomic) NSMutableArray* touches;

- (id)init;
- (void)applyContext;

@end

ClueViewController* clue_ios_get_view_controller(void);
