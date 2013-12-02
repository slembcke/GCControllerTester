//
//  TesterController.m
//  GCControllerTester
//
//  Created by Scott Lembcke on 12/1/13.
//  Copyright (c) 2013 Howling Moon Software. All rights reserved.
//

#import "TesterController.h"

#import <GameController/GameController.h>


@implementation TesterController {
	GCExtendedGamepad *_profile;
	
	IBOutlet UIView *_buttonA;
	IBOutlet UIView *_buttonB;
	IBOutlet UIView *_buttonX;
	IBOutlet UIView *_buttonY;
	IBOutlet UIView *_buttonL1;
	IBOutlet UIView *_buttonL2;
	IBOutlet UIView *_buttonR1;
	IBOutlet UIView *_buttonR2;
	
	IBOutlet UIProgressView *_pressureA;
	IBOutlet UIProgressView *_pressureB;
	IBOutlet UIProgressView *_pressureX;
	IBOutlet UIProgressView *_pressureY;
	IBOutlet UIProgressView *_pressureL1;
	IBOutlet UIProgressView *_pressureL2;
	IBOutlet UIProgressView *_pressureR1;
	IBOutlet UIProgressView *_pressureR2;
	
	IBOutlet UILabel *_leftStick;
	IBOutlet UILabel *_rightStick;
	IBOutlet UILabel *_dpad;
}

- (id)initWithController:(GCController *)controller
{
	if((self = [super initWithNibName:@"Tester" bundle:nil])){
		_profile = controller.extendedGamepad;
		NSAssert(_profile, @"Gamepad must support the extended profile.");
	}
	
	return self;
}

-(void)viewDidAppear:(BOOL)animated
{
	_profile.valueChangedHandler = ^(GCExtendedGamepad *gamepad, GCControllerElement *element){
		[self updateDisplay];
	};
}

-(void)viewDidDisappear:(BOOL)animated
{
	_profile.valueChangedHandler = nil;
}

-(void)updateDisplay
{
	UIColor *light = [UIColor lightGrayColor];
	UIColor *dark = [UIColor blackColor];
	
	_buttonA.backgroundColor = (_profile.buttonA.pressed ? dark : light);
	_buttonB.backgroundColor = (_profile.buttonB.pressed ? dark : light);
	_buttonX.backgroundColor = (_profile.buttonX.pressed ? dark : light);
	_buttonY.backgroundColor = (_profile.buttonY.pressed ? dark : light);
	_buttonL1.backgroundColor = (_profile.leftShoulder.pressed ? dark : light);
	_buttonL2.backgroundColor = (_profile.leftTrigger.pressed ? dark : light);
	_buttonR1.backgroundColor = (_profile.rightShoulder.pressed ? dark : light);
	_buttonR2.backgroundColor = (_profile.rightTrigger.pressed ? dark : light);
	
	_pressureA.progress = _profile.buttonA.value;
	_pressureB.progress = _profile.buttonB.value;
	_pressureX.progress = _profile.buttonX.value;
	_pressureY.progress = _profile.buttonY.value;
	_pressureL1.progress = _profile.leftShoulder.value;
	_pressureL2.progress = _profile.leftTrigger.value;
	_pressureR1.progress = _profile.rightShoulder.value;
	_pressureR2.progress = _profile.rightTrigger.value;
	
	{
		GCControllerDirectionPad *pad = _profile.leftThumbstick;
		
		NSString *text = @"";
		if(pad.left.pressed) text = [text stringByAppendingString:@"L"];
		if(pad.right.pressed) text = [text stringByAppendingString:@"R"];
		if(pad.up.pressed) text = [text stringByAppendingString:@"U"];
		if(pad.down.pressed) text = [text stringByAppendingString:@"D"];
		
		_leftStick.center = CGPointMake(50.0 + pad.xAxis.value*50.0, 50.0 - pad.yAxis.value*50.0);
		_leftStick.text = ([text isEqualToString:@""] ? @"0" : text);
	}{
		GCControllerDirectionPad *pad = _profile.rightThumbstick;
		
		NSString *text = @"";
		if(pad.left.pressed) text = [text stringByAppendingString:@"L"];
		if(pad.right.pressed) text = [text stringByAppendingString:@"R"];
		if(pad.up.pressed) text = [text stringByAppendingString:@"U"];
		if(pad.down.pressed) text = [text stringByAppendingString:@"D"];
		
		_rightStick.center = CGPointMake(50.0 + pad.xAxis.value*50.0, 50.0 - pad.yAxis.value*50.0);
		_rightStick.text = ([text isEqualToString:@""] ? @"0" : text);
	}{
		GCControllerDirectionPad *pad = _profile.dpad;
		
		NSString *text = @"";
		if(pad.left.pressed) text = [text stringByAppendingString:@"L"];
		if(pad.right.pressed) text = [text stringByAppendingString:@"R"];
		if(pad.up.pressed) text = [text stringByAppendingString:@"U"];
		if(pad.down.pressed) text = [text stringByAppendingString:@"D"];
		
		_dpad.center = CGPointMake(50.0 + pad.xAxis.value*50.0, 50.0 - pad.yAxis.value*50.0);
		_dpad.text = ([text isEqualToString:@""] ? @"0" : text);
	}
}

@end
