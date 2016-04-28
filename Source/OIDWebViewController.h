/*! @file OIDWebViewController.h
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
# import <Cocoa/Cocoa.h>

@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

/*! @typedef OIDWebViewControllerPresentationCallback
    @brief Represents the type of block used to present the web view controller for authorization.
    @param controllerToPresent The web view controller that the app shall present.
 */
typedef void (^OIDWebViewControllerPresentationCallback)(NSViewController *controllerToPresent);

/*! @typedef OIDWebViewControllerDismissalCallback
    @brief Represents the type of block used to dismiss the web view controller for authorization.
    @param controllerToDismis The web view controller that the app shall dismiss.
    @param completion Callback that must be called once the view controller is dismissed.
 */
typedef void (^OIDWebViewControllerDismissalCallback)(NSViewController *controllerToDismis,
                                                      void (^completion) ());


/*! @class OIDWebViewController
    @brief Provides a simple view controller that encapsulates a web view.
 */
@interface OIDWebViewController : NSViewController

/*! @property webView
    @brief The view controller's web view.
    @discussion The web view is available once the view controller has loaded its view. You may
        change its delegates.
 */
@property(readonly, strong, nullable) WKWebView *webView;

@end

NS_ASSUME_NONNULL_END

#endif
