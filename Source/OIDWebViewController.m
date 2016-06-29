/*! @file OIDWebViewController.m
    @brief AppAuth iOS SDK
    @copyright
        Copyright 2016 equinux AG. All Rights Reserved.
    @copydetails
        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.
 */

#import <TargetConditionals.h>
#if !TARGET_OS_IPHONE
# import "OIDWebViewController.h"
# import <WebKit/WebKit.h>

@interface OIDWebViewController ()
// Make property writeable.
@property(strong, nullable) WKWebView *webView;
@end

@implementation OIDWebViewController


- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration
{
  self = [super initWithNibName:nil bundle:nil];
  if (!self) return nil;
	
  // Do not reference the view here, it would cause a race condition (`viewDidLoad` gets called
  // before we have a web view).
  self.webView = [[WKWebView alloc] initWithFrame:NSZeroRect configuration:configuration];
	
  return self;
}

- (void)loadView
{
  self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 600, 600)];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.webView.frame = self.view.bounds;
  self.webView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
  [self.view addSubview:self.webView];
}

@end

#endif
