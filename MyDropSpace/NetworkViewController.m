//
//  NetworkViewController.m
//  MyDropSpace
//
//  Created by Robert Fidler on 1/19/13.
//  Copyright (c) 2013 Robert Fidler. All rights reserved.
//

#import "NetworkViewController.h"
#import "ModalPostViewController.h"

@interface NetworkViewController ()

@end

@implementation NetworkViewController

@synthesize filePaths;

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

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSLog(@"Folder '%@' contains:", metadata.path);
        self.files = [[NSMutableArray alloc] init];
        self.filePaths = [[NSMutableArray alloc] init];
        NSArray* validExtensions = [NSArray arrayWithObjects:@"txt", nil];
        //NSMutableArray* newPostPaths = [NSMutableArray new];
        for (DBMetadata *file in metadata.contents) {
            
                NSString* extension = [[file.path pathExtension] lowercaseString];
                if (!file.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
                    
                    [self.filePaths addObject:file.path];
                }
            //[self.files addObject:file.filename];  //  NSMutableArray.put(file.filename);
            //NSLog(@"\t%@", file.filename);
        }
        
        for (NSString *currPath in self.filePaths){
            [self.restClient loadFile:currPath intoPath:[self photoPath]];
        }
        
        //[self.tableView reloadData];
        NSLog(@"RESTCLIENT FUNC self.files count = %i", [self.filePaths count]);
    }
}

- (NSString*)photoPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"files.txt"];
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString *)destPath {
    //[self.files addObject:[NSString stringwithContentsOfFile]]
    [self.files addObject:[NSString stringWithContentsOfFile:destPath encoding:NSUTF8StringEncoding error: NULL]];
    if([self.files count] == [self.filePaths count]){
        [self.tableView reloadData];
    }
    //story1.text =  ///////////
}


//
//- (void)loadRandomPhoto {
//    if ([photoPaths count] == 0) {
//        
//        NSString *msg = nil;
//        if ([DBSession sharedSession].root == kDBRootDropbox) {
//            msg = @"Put .jpg photos in your Photos folder to use DBRoulette!";
//        } else {
//            msg = @"Put .jpg photos in your app's App folder to use DBRoulette!";
//        }
//        
//        [[[UIAlertView alloc]
//          initWithTitle:@"No Photos!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
//         show];
//        
//
//    } else {
//
//        NSString* photoPath;
//        for(photoPath in photoPaths){
//            [self.restClient loadFile:photoPath intoPath:[self photoPath]];
//        }
//
//    }
//}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[self restClient] loadMetadata:@"/Networks/RI/posts/"];
    
}

- (void)viewDidLoad
{
    if (![[DBSession sharedSession] isLinked]) {
    [[[UIAlertView alloc]
      initWithTitle:@"Alert" message:@"Please sign in to Dropbox to view and add posts."
      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
     
     show];
    }

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) pressedNewPost {
    
    ModalPostViewController *modal = [[ModalPostViewController alloc] initWithNibName:@"ModalPostViewController" bundle:nil];
    
    [self presentViewController:modal animated:YES completion:^{[[self restClient] loadMetadata:@"/Networks/RI/posts/"];}];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"self.files count = %i", [self.filePaths count]);
    return [self.filePaths count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [self.files objectAtIndex:indexPath.row];
    cell.highlighted = NO;
    
    // Configure the cell...
    

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
