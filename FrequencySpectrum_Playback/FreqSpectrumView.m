//
//  FreqSpectrumView.m
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/19/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import "FreqSpectrumView.h"
#import "FrequencySpectrumBarView.h"

#define kNumberOfDisplayFrequencies 16//64 is to 10kz//256 is max/full.

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
	[self setupCustomBarViews];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if(_frequencyValues > 0) {
	  [self updateBarFrames];
	  [self updateCustomBar];
	}
}

- (void)setFrequencyValues:(NSArray*)vals{
	_frequencyValues = vals;
		
	[self updateBarFrames];
	[self updateCustomBar];
}

//TODO: use frequencyValues(256), but need to set this before playback
- (void)setupBarViews {
	//Create bar view for each frequency value
	_barViews = [[NSMutableArray alloc] init];
	int i = 0;
	
	//Show only frequencies that have a value
	float barWidth = self.frame.size.width/kNumberOfDisplayFrequencies;
	while (i < kNumberOfDisplayFrequencies) {
		UIView* v = [[UIView alloc] initWithFrame:CGRectZero];
		v.backgroundColor = [UIColor greenColor];
		if(i==3 || i==6 || i==12){
			//frequencies are calculated as
			//sample rate: 44100
			//buckets: 256
			// 44100/256 = 172 (each bar)
			// 1000(<<that's hz)/172 = 5.89(round to 6)
			//1khz?
			UILabel* fLabel = [[UILabel alloc] initWithFrame:CGRectMake(barWidth*i, self.frame.size.height + 15, 100, 15)];
			fLabel.text = [NSString stringWithFormat:@"%dhz",i*172];
			[self addSubview:fLabel];
			//v.backgroundColor = [UIColor redColor];
		}
		[_barViews addObject:v];
		[self addSubview:v];
		i++;
	}
}

//TODO: this is a work in progress, need to work on scaling and centering the frequency views
- (void)updateBarFrames {
	//Layout the bars based on the updated view frame
	int scaling = 7;//to make the bars taller -temp
	float barWidth = self.frame.size.width/_barViews.count;
	
	for(int i = 0;i < _barViews.count; i++){
		UIView* barView = [_barViews objectAtIndex:i];
		float barHeight = 0;
		float viewHeight = self.frame.size.height;
		if (_frequencyValues.count > i) {
			barHeight = viewHeight * [[_frequencyValues objectAtIndex:i] floatValue];
			barHeight = barHeight * scaling;
			if(barHeight>viewHeight)
				barHeight = viewHeight - 5;//max height for bar
		}
			barView.frame = CGRectMake(i * barWidth,viewHeight - barHeight, barWidth, barHeight);
	}
}

#pragma mark use custom bar view
//TODO: use frequencyValues(256), but need to set this before playback
- (void)setupCustomBarViews {
	//Create bar view for each frequency value
	_customBarViews = [[NSMutableArray alloc] init];
	int i = 0;
	
	//Show only frequencies that have a value
	float barWidth = self.frame.size.width/kNumberOfDisplayFrequencies;
	
	while (i < kNumberOfDisplayFrequencies) {
		FrequencySpectrumBarView* v = [[FrequencySpectrumBarView alloc] init];
		v.barHeight = self.frame.size.height;
		v.backgroundColor = [UIColor greenColor];
		
		if(i==3 || i==6 || i==12){
			//frequencies are calculated as
			//sample rate: 44100
			//buckets: 256
			// 44100/256 = 172 (each bar)
			// 1000(<<that's hz)/172 = 5.89(round to 6)
			//1khz?
			UILabel* fLabel = [[UILabel alloc] initWithFrame:CGRectMake(barWidth*i, self.frame.size.height + 15, 100, 15)];
			fLabel.text = [NSString stringWithFormat:@"%dhz",i*172];
			[self addSubview:fLabel];
			//v.backgroundColor = [UIColor redColor];
		}
		
		[_customBarViews addObject:v];
		[self addSubview:v];
		i++;
		
	}
}

- (void)updateCustomBar {
	//Layout the bars based on the updated view frame
	int scaling = 7;//to make the bars taller -temp
	float barWidth = self.frame.size.width/_customBarViews.count;
	
	for(int i = 0;i < _customBarViews.count; i++){
		FrequencySpectrumBarView* barView = [_customBarViews objectAtIndex:i];
		barView.barWidth = barWidth;
		barView.scaling = scaling;
		
		if (_frequencyValues.count > i) {
			barView.barFrequencyValue = [[_frequencyValues objectAtIndex:i] floatValue];
		}
	}
}

@end
