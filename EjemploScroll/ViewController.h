//
//  ViewController.h
//  EjemploScroll
//
//  Created by Leandro Fantin on 17/07/14.
//  Copyright (c) 2014 mercadolibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) UITextField * activeField;

@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet UITextField *textfield4;


@end
