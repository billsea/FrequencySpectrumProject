//
//  ViewController.m
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/9/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// allocate the audio player
	_player = [[audioPlayback alloc] init];
	[_player initializeAudio];
	
	//Callback for frequency display refresh
ViewController __weak *weakSelf = self;
	_player.frequencyCallback = ^(Float32* freqData,UInt32 size){
		int length = (int)size;
		NSMutableArray *freqValues = [NSMutableArray new];
		
		for (UInt32 i = 0; i < length; i++) {
			[freqValues addObject:@(freqData[i])];
		}
		
		//Validate 256 length
		if (freqValues.count == 256) {
			weakSelf.freqView.frequencyValues = freqValues;//TODO:fix warning
		}
	};
	
	[weakSelf.player initBufferProcess];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)playButton:(id)sender {
	[_player start];
	[_player setBypass:NO];////////////// processing OFF
}
@end
