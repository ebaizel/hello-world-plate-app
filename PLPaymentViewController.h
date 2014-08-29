//
//  PLPaymentViewController.h
//  Plate
//
//  Created by Emile Baizel on 8/28/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPaymentModalDelegate;

@interface PLPaymentViewController : UIViewController

@property (assign, nonatomic) id <AddPaymentModalDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCardType;
@property (weak, nonatomic) IBOutlet UITextField *textCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *textExpiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *textExpiryYear;
@property (weak, nonatomic) IBOutlet UISwitch *switchSaveToAccount;
@property (weak, nonatomic) IBOutlet UILabel *labelSaveToAccount;
@property (assign, nonatomic) BOOL displaySaveToAccount;

- (IBAction)save:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)closeModal:(id)sender;
@end


@protocol AddPaymentModalDelegate <NSObject>

-(void) dismissModal;
-(void) paymentAdded;

@end
