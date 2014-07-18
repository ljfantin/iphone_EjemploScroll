//
//  ViewController.m
//  EjemploScroll
//
//  Created by Leandro Fantin on 17/07/14.
//  Copyright (c) 2014 mercadolibre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //seteo el content size
    [[self scroll] setContentSize:[[self view] frame].size];
   
    //Me atacho a los eventos del teclado
    [self registerForKeyboardNotifications];
    
    //Creo identificador de gestos.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPulsado)];
    [tapRecognizer setCancelsTouchesInView:NO];
    //agrego al scroll view el identificador de gestos
    [[self scroll] addGestureRecognizer:tapRecognizer];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //[[self scroll] setContentSize:[[self view] frame].size];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)unregisterForKeyboardNotifications
{
    //me desatacho los eventos del teclado
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

#pragma mark - Notificaciones del teclado
- (void) keyboardWasShown:(NSNotification *)notificacion
{
    //Nota: El ScrollView no tiene que estar en autolayout para que funcione
    NSDictionary* info = [notificacion userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height = kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGRect rect = self.activeField.frame;
        [self.scroll scrollRectToVisible:rect animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notificacion
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
}

#pragma mark Delegate textfield
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (void) scrollViewPulsado
{
    [[self view] endEditing:YES];
}

@end
