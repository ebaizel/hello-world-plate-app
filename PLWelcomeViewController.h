//
//  PLWelcomeViewController.h
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLLoginSignUpViewController.h"

@protocol WelcomeViewDelegate <NSObject>
- (void)skipWelcomeScreen;
@end

@interface PLWelcomeViewController : UIViewController <LoginModalDelegate>

@property (strong, nonatomic) PLLoginSignUpViewController *pllsvc;
@property (weak, nonatomic) id<WelcomeViewDelegate> delegate;

- (IBAction)login:(id)sender;
- (IBAction)skipWelcome:(id)sender;

@end
