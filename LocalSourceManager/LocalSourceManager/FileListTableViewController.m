//
//  FileListTableViewController.m
//  LocalSourceManager
//
//  Created by Captain on 16/3/18.
//  Copyright © 2016年 Captain. All rights reserved.
//

#import "FileListTableViewController.h"

#import "ShowHtmlTableViewController.h"

@interface FileListTableViewController ()
{
    NSFileManager *_defaultManager;
    NSString *_currentPath;
    NSString *_topDirectPath;
}

@property (nonatomic, strong) NSArray *fileListArray;

@end

@implementation FileListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFileList)];
     self.navigationItem.rightBarButtonItem = refreshItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(backStep)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self intializedProperties];
}

- (void)refreshFileList {
    _currentPath = [_defaultManager currentDirectoryPath];
    _fileListArray = [_defaultManager contentsOfDirectoryAtPath:_currentPath error:nil];
    [self.tableView reloadData];
}

- (void)backStep {
    if ([_topDirectPath isEqualToString:_currentPath]) {
        return;
    }
    
    [_defaultManager changeCurrentDirectoryPath:@".."];
    [self refreshFileList];
}

- (void)intializedProperties {
    _defaultManager = [NSFileManager defaultManager];
    
    NSArray *userDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _currentPath = userDir.firstObject;
    [_defaultManager changeCurrentDirectoryPath:_currentPath];
    _currentPath = [_defaultManager currentDirectoryPath];
    _topDirectPath = _currentPath;
    
    _fileListArray = [_defaultManager contentsOfDirectoryAtPath:_currentPath error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fileListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentity = @"CellIdentity";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentity];
    }
    
    NSString *fileName = [_fileListArray objectAtIndex:indexPath.row];
    BOOL isDirectory;
    [_defaultManager fileExistsAtPath:fileName isDirectory:&isDirectory];
//    if (isDirectory == YES) {
//        cell.textLabel.textColor = [UIColor blueColor];
//    }else {
//    }
    cell.textLabel.textColor = isDirectory ? [UIColor blueColor] : [UIColor blackColor];
   
    
    cell.textLabel.text = fileName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fileName = [_fileListArray objectAtIndex:indexPath.row];
    BOOL isDirectory;
    [_defaultManager fileExistsAtPath:fileName isDirectory:&isDirectory];
    
    if (isDirectory == YES) {
        [_defaultManager changeCurrentDirectoryPath:fileName];
        _currentPath = [_defaultManager currentDirectoryPath];
        [self refreshFileList];
    } else /*if ([fileName hasSuffix:@".html"]) */{
        NSLog(@"is file");
        [self push2HtmlShowPageWithFile:fileName];
    }
}

- (void)push2HtmlShowPageWithFile:(NSString *)fileName {
    ShowHtmlTableViewController *htmlPage = [[ShowHtmlTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    htmlPage.filePath = [_currentPath stringByAppendingPathComponent:fileName];
    [self.navigationController pushViewController:htmlPage animated:YES];
}

@end
