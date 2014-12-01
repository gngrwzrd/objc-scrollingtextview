
#import "GWScrollingTextView.h"

@interface GWScrollingTextView ()
@property NSTimer * scroller;
@property NSPoint point;
@property NSPoint wrapPoint;
@property NSSize stringSize;
@property NSTrackingArea * trackingArea;
@property BOOL mouseOver;
@end

@implementation GWScrollingTextView
@synthesize speed = _speed;
@synthesize attributedText = _attributedText;

- (id) initWithCoder:(NSCoder *) coder {
	self = [super initWithCoder:coder];
	[self defaultInit];
	return self;
}

- (id) initWithFrame:(NSRect) frameRect {
	self = [super initWithFrame:frameRect];
	[self defaultInit];
	return self;
}

- (BOOL) isFlipped {
	return TRUE;
}

- (void) setAttributedText:(NSAttributedString *) attributedText {
	_attributedText = attributedText;
	self.stringSize = [self.attributedText boundingRectWithSize:self.bounds.size options:0].size;
	[self setNeedsDisplay:TRUE];
}

- (void) setSpeed:(NSTimeInterval)speed {
	_speed = speed;
	if(self.mouseOver) {
		[self stopScrolling];
		[self startScrolling];
	}
}

- (void) defaultInit {
	self.point = NSZeroPoint;
	self.spaceBetweenWrappedText = 15;
	self.trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingAssumeInside|NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow owner:self userInfo:nil];
	[self addTrackingArea:self.trackingArea];
}

- (void) mouseEntered:(NSEvent *) theEvent {
	if(!self.scrollsOnMouseOver) {
		return;
	}
	self.mouseOver = TRUE;
	[self startScrolling];
}

- (void) mouseExited:(NSEvent *) theEvent {
	if(!self.scrollsOnMouseOver) {
		return;
	}
	self.mouseOver = FALSE;
	[self stopScrolling];
	[self setNeedsDisplay:TRUE];
}

- (void) startScrolling {
	if(self.scroller) {
		[self.scroller invalidate];
	}
	if(self.attributedText && self.speed > 0) {
		self.scroller = [NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(moveText:) userInfo:nil repeats:YES];
	}
}

- (void) stopScrolling {
	if(self.scroller) {
		[self.scroller invalidate];
		self.scroller = nil;
	}
	self.point = NSZeroPoint;
}

- (void) moveText:(NSTimer *) timer {
	self.point = NSMakePoint(self.point.x-1.0,self.point.y);
	[self setNeedsDisplay:YES];
}

- (void) drawRect:(NSRect) dirtyRect {
	if(self.stringSize.width <= self.bounds.size.width || (!self.mouseOver && self.scrollsOnMouseOver)) {
		[self.attributedText drawAtPoint:NSZeroPoint];
		return;
	}
	[self.attributedText drawAtPoint:self.point];
	if(self.stringSize.width > self.bounds.size.width) {
		CGFloat startWrapping = -((self.stringSize.width - self.bounds.size.width) + self.spaceBetweenWrappedText);
		if(self.point.x <= startWrapping) {
			NSPoint otherPoint = self.point;
			otherPoint.x = self.point.x + self.stringSize.width + self.spaceBetweenWrappedText;
			[self.attributedText drawAtPoint:otherPoint];
			if(otherPoint.x < 0) {
				self.point = NSZeroPoint;
			}
		}
	}
}

- (void) dealloc {
	[self.scroller invalidate];
	self.scroller = nil;
}

@end
