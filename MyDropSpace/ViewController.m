//
//  ViewController.m
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithTitle:@"Networks" style:UIBarButtonItemStylePlain
                                               target:self action:@selector(didPressLink)];*/
    UIImage * myImage = [UIImage imageNamed: @"MyDropSpace-Logo.png"];
    [self.myImageView setImage:myImage];

    
    self.title = @"MyDropSpace";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"LoggedIn"]){
//        [[segue NetworkViewController] ]
//    }
//}

- (void)didPressLink {
    NSLog(@"got called");
    if (![[DBSession sharedSession] isLinked]) {
        
        [[DBSession sharedSession] linkFromController:self];
        
    }
    else {
        [self.signInButton setTitle:@"Sign into Dropbox" forState:UIControlStateNormal];
        [[DBSession sharedSession] unlinkAll];
        [[[UIAlertView alloc]
           initWithTitle:@"Dropbox" message:@"You have been logged out of Dropbox!"
           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]

         show];
        //[self updateButtons];
    }
}


@end
