//
//  ModalPostViewController.m
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import "ModalPostViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface ModalPostViewController ()

@end

@implementation ModalPostViewController
@synthesize inputField;

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
    //    [restClient ]
}

//file uploading - success
- (void)restClient:(DBRestClient*)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File successfully uploaded to: %@", metadata.path);
}

//file uploading - failure
- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed. Error: %@", error);
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelModalViewClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"cancelled new post!");
    }];
}

- (IBAction)closeModalViewClicked:(id)sender {
    
    
    /*
     NSString *localPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
     NSString *filename = @"Info.plist";
     NSString *destDir = @"/";
     [[self restClient] uploadFile:filename toPath:destDir
     withParentRev:nil fromPath:localPath]; 
    */
    
    // String to write
    NSString *content = [inputField text];
    
    // For error information
    NSError *error;
    
    // Create file manager
    NSFileManager *fileMgr = [NSFileManager defaultManager];

    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"]; 

    
    NSString *nameOfFile = @"2013-01-20-.txt";
    
    // File we want to create in the documents directory
    // Result is: /Documents/file1.txt
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:nameOfFile];
    
    // Write the file
    [content writeToFile:filePath atomically:YES
            encoding:NSUTF8StringEncoding error:&error];
    
    // Show contents of Documents directory
    NSLog(@"Documents directory: %@",
          [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);

    
    
//    [[NSFileManager alloc] createFileAtPath];
    //write to file, upload file to dropbox
    //NSString *path = [self tempPath];
//    NSString *localPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"txt"];
//    bool ok = [content writeToFile:localPath atomically:YES encoding:NSUnicodeStringEncoding error:NULL];
//    if (!ok) {
//        NSLog(@"Error writing file at %@",localPath);
//        
//    }
//    //generate time somehow? txt
//    NSString *filename = @"info.txt";
    NSString *destDir = @"/Networks/RI/posts/";
//    NSLog(@"localpath = %@", localPath);
//    NSLog(@"filename = %@", filename);
    NSLog(@"destDir = %@", destDir);
    
    [[self restClient] uploadFile:nameOfFile toPath:destDir
                    withParentRev:nil fromPath:filePath];
    
    //
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Closing value in box was: %@", content);
    }];
}

- (NSString*)tempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"files.txt"];
}



@end
