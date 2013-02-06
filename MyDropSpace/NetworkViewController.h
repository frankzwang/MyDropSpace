//
//  NetworkViewController.h
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface NetworkViewController : UITableViewController {
    DBRestClient *restClient;
}

@property (nonatomic, strong) NSMutableArray *filePaths;
@property (nonatomic, strong) NSMutableArray *files;

-(IBAction) pressedNewPost;

@end
