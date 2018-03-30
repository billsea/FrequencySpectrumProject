//
//  FreqSpectrumView.m
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/19/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import "FreqSpectrumView.h"
#import "FrequencySpectrumBarView.h"

#define kNumberOfDisplayFrequencies 18//64 is to 10kz//256 is max/full.

@implementation FreqSpectrumView

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self setupCustomBarViews];
}

- (void)setFrequencyValues:(NSArray*)vals{
	_frequencyValues = vals;
	[self updateCustomBar];
}

#pragma mark use custom segmented bar view
- (void)setupCustomBarViews {
	//Create bar view for each frequency value
	_customBarViews = [[NSMutableArray alloc] init];
	int i = 0;
	
	//Show only frequencies that have a value
	float barWidth = self.frame.size.width/kNumberOfDisplayFrequencies;
	
	while (i < kNumberOfDisplayFrequencies) {
		FrequencySpectrumBarView* v = [[FrequencySpectrumBarView alloc] init];
		v.frame = CGRectMake(i * barWidth, 0, barWidth, self.frame.size.height);
		v.scaling = 7.0f;
		
		if(i==3 || i==6 || i==12){
			//frequencies are calculated as
			//sample rate: 44100
			//buckets: 256
			// 44100/256 = 172 (each bar)
			// 1000(<<that's hz)/172 = 5.89(round to 6)
			//1khz?
			if(_showFrequencyLabels) {
				UILabel* fLabel = [[UILabel alloc] initWithFrame:CGRectMake(barWidth*i, self.frame.size.height + 15, 100, 15)];
				fLabel.text = [NSString stringWithFormat:@"%dhz",i*172];
				[self addSubview:fLabel];
			}
		}
		
		[_customBarViews addObject:v];
		[self addSubview:v];
		i++;
	}
}

- (void)updateCustomBar {
	for(int i = 0;i < _customBarViews.count; i++){
		FrequencySpectrumBarView* barView = [_customBarViews objectAtIndex:i];
		if (_frequencyValues.count > i) {
			barView.isHighlightedBand = NO;//TODO: determine highlighted band from "target" setting
			barView.barFrequencyValue = [[_frequencyValues objectAtIndex:i] floatValue];
		}
	}
}

@end
