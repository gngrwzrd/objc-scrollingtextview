
#import <Cocoa/Cocoa.h>

@interface GWScrollingTextView : NSView
@property (nonatomic) NSAttributedString * attributedText;
@property (nonatomic) NSUInteger spaceBetweenWrappedText;
@property (nonatomic) NSTimeInterval speed;
@property BOOL scrollsOnMouseOver;
- (void) startScrolling;
- (void) stopScrolling;
@end
