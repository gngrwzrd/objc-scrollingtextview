
#import "AppDelegate.h"

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *) aNotification {
	NSDictionary * attrs = @{NSFontAttributeName:[NSFont systemFontOfSize:[NSFont systemFontSize]]};
	NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:@"This is some really long text and it's so long it won't fit in the view" attributes:attrs];
	self.scrollingText.attributedText = text;
	self.scrollingText.speed = .03;
	[self.scrollingText startScrolling];
	
	self.scrollingText2.attributedText = text;
	self.scrollingText2.speed = .04;
	self.scrollingText2.scrollsOnMouseOver = TRUE;
}

@end
