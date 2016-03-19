//
//  ShowHtmlTableViewController.h
//  LocalSourceManager
//
//  Created by Captain on 16/3/18.
//  Copyright © 2016年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowHtmlTableViewController : UITableViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *filePath;

@end
