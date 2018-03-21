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
	
	
	_player.frequencyCallback = ^(Float32* freqData,UInt32 size){
		  //let frequencyValuesArray = Array<Float32>(UnsafeBufferPointer(start: UnsafePointer(frequencyData), count: Int(size)))
		
		int length = (int)size;
		NSMutableArray *freqValues = [NSMutableArray new];
		
		for (UInt32 i = 0; i < length; i++) {
			[freqValues addObject:@(freqData[i])];
			//NSLog(@"val:%f",[[freqValues objectAtIndex:i] floatValue]);
		}
		
		//Sanity check for expected 256 length
		if (freqValues.count == 256) {
			_freqView.frequencyValues = freqValues;
		}
		
	};
	

	[_player initBufferProcess];
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
