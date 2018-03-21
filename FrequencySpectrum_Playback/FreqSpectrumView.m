//
//  FreqSpectrumView.m
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/19/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import "FreqSpectrumView.h"


@implementation FreqSpectrumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)aRect
{
	if ((self = [super initWithFrame:aRect])) {
		[self commonInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	if ((self = [super initWithCoder:coder])) {
		[self commonInit];
	}
	return self;
}

-(void)commonInit {
	[self setupBarViews];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	//self.labelView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: 20.0)
	if(_frequencyValues > 0)
	  [self updateBarFrames];
}

- (void)setFrequencyValues:(NSArray*)vals{
	_frequencyValues = vals;
		
	[self updateBarFrames];
}

//TODO: use frequencyValues(256), but need to set this before playback
- (void)setupBarViews {
	//Create bar view for each frequency value
	_barViews = [[NSMutableArray alloc] init];
	//for(NSObject* fv in _frequencyValues){
	int i = 0;
	while (i < 256) {
		UIView* v = [[UIView alloc] initWithFrame:CGRectZero];
		v.backgroundColor = self.tintColor;
		[_barViews addObject:v];
		[self addSubview:v];
		i++;
	}

}

//TODO: this is a work in progress, need to work on scaling and centering the frequency views
- (void)updateBarFrames {
	//Layout the bars based on the updated view frame
	int tempScaleWidth = 140;//Until we get better centering etc..
	int scaling = 8;//to make the bars bigger -temp
	float barWidth = self.frame.size.width / (_barViews.count - tempScaleWidth);
	
	for(int i = 0;i < _barViews.count; i++){
		UIView* barView = [_barViews objectAtIndex:i];
		float barHeight = 0;
		float viewHeight = self.frame.size.height;
		if (_frequencyValues.count > i) {
			barHeight = viewHeight * [[_frequencyValues objectAtIndex:i] floatValue];
		}
			barView.frame = CGRectMake(i * barWidth,viewHeight - (barHeight  * scaling), barWidth, barHeight * scaling);
	}
	
	
}

@end
