//
//  ShowHtmlTableViewController.m
//  LocalSourceManager
//
//  Created by Captain on 16/3/18.
//  Copyright © 2016年 Captain. All rights reserved.
//

#import "ShowHtmlTableViewController.h"

@interface ShowHtmlTableViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ShowHtmlTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setFilePath:(NSString *)filePath {
    self->_filePath = filePath;
    
    if (self.webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.delegate = self;
//        self.view.autoresizingMask = 0x3f;
        self.webView.autoresizingMask= 0x3f;
        [self.view addSubview:self.webView];
    }
    
//    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:filePath];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
