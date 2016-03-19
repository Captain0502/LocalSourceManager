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

- (void)dealloc {
    NSLog(@"dealloc %s",__FILE__);
//    _webView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)setFilePath:(NSString *)filePath {
    self->_filePath = filePath;
    
    if (self.webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.autoresizingMask= 0x3f;
//        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    }
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
