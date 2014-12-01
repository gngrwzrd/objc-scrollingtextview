
#import <Cocoa/Cocoa.h>
#import "GWScrollingTextView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSWindow * window;
@property (weak) IBOutlet GWScrollingTextView * scrollingText;
@property (weak) IBOutlet GWScrollingTextView * scrollingText2;
@end
