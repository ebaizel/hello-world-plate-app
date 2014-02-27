//
//  PLOrderNavigationController.h
//  Plate
//
//  Created by emileleon on 12/5/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLWelcomeViewController.h"
@class PLStartOrderViewController;

@interface PLOrderNavigationController : UINavigationController <WelcomeViewDelegate>
{
    BOOL skipWelcome;
    PLStartOrderViewController *plsovc;
}

@property (nonatomic, strong) PLWelcomeViewController *plwvc;
@end
