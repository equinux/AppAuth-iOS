//
//  OIDWebViewController.m
//  AppAuth
//
//  Created by Marc Haisenko on 28.04.16.
//  Copyright © 2016 Google Inc. All rights reserved.
//

#import <TargetConditionals.h>
#if !TARGET_OS_IPHONE
# import "OIDWebViewController.h"
# import <WebKit/WebKit.h>

@interface OIDWebViewController ()
// Make property writeable.
@property(strong, nullable) WKWebView *webView;
@end

@implementation OIDWebViewController

- (void)loadView
{
  self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 600, 600)];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.webView];
}

@end

#endif