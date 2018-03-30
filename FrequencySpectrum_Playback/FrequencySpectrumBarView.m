//
//  FrequencySpectrumBarView.m
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/29/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import "FrequencySpectrumBarView.h"

@implementation FrequencySpectrumBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (id)initWithFrame:(CGRect)aRect
//{
//	if ((self = [super initWithFrame:aRect])) {
//		[self commonInit];
//	}
//	return self;
//}
//
//- (id)initWithCoder:(NSCoder*)coder
//{
//	if ((self = [super initWithCoder:coder])) {
//		[self commonInit];
//	}
//	return self;
//}
//
//- (void) commonInit {
//
//}

- (void)setBarFrequencyValue:(float)value {
	_barFrequencyValue = value;
	[self updateSubviews];
}

- (void)updateSubviews {
	NSLog(@"freq updated:%f",_barFrequencyValue);
	//TODO: Add segmented subviews for frequency value. 
}



@end
