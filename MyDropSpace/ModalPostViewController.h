//
//  ModalPostViewController.h
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface ModalPostViewController : UIViewController {
    DBRestClient *restClient;
}

@property (assign) IBOutlet UITextView  *inputField;


- (IBAction)cancelModalViewClicked:(id)sender;
- (IBAction)closeModalViewClicked:(id)sender;

@end
