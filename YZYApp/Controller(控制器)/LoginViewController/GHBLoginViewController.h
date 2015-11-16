//
//  GHBLoginViewController.h
//  YZYApp
//
//  Created by 123 on 15/10/9.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHBLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *accountTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (assign, nonatomic)BOOL editable;

@end
