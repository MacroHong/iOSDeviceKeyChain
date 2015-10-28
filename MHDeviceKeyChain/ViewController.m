//
//  ViewController.m
//  MHDeviceKeyChain
//
//  Created by Macro on 10/19/15.
//  Copyright © 2015 Macro. All rights reserved.
//

#import "ViewController.h"
#import "DevicesKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *s = [DevicesKeyChain DevicesKeyChain];
    NSLog(@"%@", s);
    //[DevicesKeyChain DeleteDevicesKeyChain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
