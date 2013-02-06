//
//  ViewController.h
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface ViewController : UIViewController {
    DBRestClient *restClient;
    
}
@property (retain) IBOutlet UIImageView *myImageView;

@property (retain) IBOutlet UIButton* signInButton;

-(IBAction) didPressLink;




@end
