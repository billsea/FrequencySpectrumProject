//
//  ViewController.h
//  FrequencySpectrum_Playback
//
//  Created by Loud on 3/9/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "audioPlayback.h"
#import "FreqSpectrumView.h"

@interface ViewController : UIViewController
@property(nonatomic) audioPlayback* player;
@property (weak, nonatomic) IBOutlet FreqSpectrumView *freqView;


- (IBAction)playButton:(id)sender;



@end

