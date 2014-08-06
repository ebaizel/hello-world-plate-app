//
//  PLLoginSignUpViewController.m
//  Plate
//
//  Created by emileleon on 2/25/14.
//  Copyright (c) 2014 Plate SF. All rights reserved.
//

#import "PLLoginSignUpViewController.h"
#import "PLAccountStore.h"
#import "PLAccount.h"
#import "PLPlateStore.h"

@interface PLLoginSignUpViewController ()

@end

@implementation PLLoginSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PLAccount *account = [[PLAccountStore sharedStore] getAccount];
    if (account) {
        _textEmail.text = account.login;
        _textPassword.text = account.password;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    PLAccount *account = [[PLAccount alloc]init];
    account.login = _textEmail.text;
    account.password = _textPassword.text;
    [[PLPlateStore sharedStore] login:account forBlock:^(PLAccount *accountResult, NSError *err) {

        if (!err) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedIn" object:self];
            NSString *path = [self accountArchivePath];
            [NSKeyedArchiver archiveRootObject:accountResult toFile:path];
            [[self delegate] userLoggedIn];            
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (IBAction)logout:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:[self accountArchivePath] error:&error];
    if (success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedOut" object:self];
    }
}


- (NSString *)accountArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"account.archive"];
}


- (IBAction)closeModal:(id)sender {
    [[self delegate] dismissModal];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}
@end
