//
//  PLLoginSignUpViewController.h
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginModalDelegate;

@interface PLLoginSignUpViewController : UIViewController

@property (assign, nonatomic) id <LoginModalDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
- (IBAction)login:(id)sender;
- (IBAction)closeModal:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

@end

@protocol LoginModalDelegate <NSObject>

-(void) dismissModal;
-(void) userLoggedIn;

@end
