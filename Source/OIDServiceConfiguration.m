/*! @file OIDServiceConfiguration.m
    @brief AppAuth iOS SDK
    @copyright
        Copyright 2015 Google Inc. All Rights Reserved.
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

#import "OIDServiceConfiguration.h"

#import "OIDDefines.h"
#import "OIDErrorUtilities.h"
#import "OIDServiceDiscovery.h"

/*! @var kAuthorizationEndpointKey
    @brief The key for the @c authorizationEndpoint property.
 */
static NSString *const kAuthorizationEndpointKey = @"authorizationEndpoint";

/*! @var kTokenEndpointKey
    @brief The key for the @c tokenEndpoint property.
 */
static NSString *const kTokenEndpointKey = @"tokenEndpoint";

/*! @var kDiscoveryDocumentKey
    @brief The key for the @c discoveryDocument property.
 */
static NSString *const kDiscoveryDocumentKey = @"discoveryDocument";

NS_ASSUME_NONNULL_BEGIN

@interface OIDServiceConfiguration ()

- (nullable instancetype)initWithAuthorizationEndpoint:(NSURL *)authorizationEndpoint
        tokenEndpoint:(NSURL *)tokenEndpoint
    discoveryDocument:(nullable OIDServiceDiscovery *)discoveryDocument
    NS_DESIGNATED_INITIALIZER;

@end

@implementation OIDServiceConfiguration

- (nullable instancetype)init
    OID_UNAVAILABLE_USE_INITIALIZER(@selector(initWithAuthorizationEndpoint:tokenEndpoint:));

- (nullable instancetype)initWithAuthorizationEndpoint:(NSURL *)authorizationEndpoint
        tokenEndpoint:(NSURL *)tokenEndpoint
    discoveryDocument:(nullable OIDServiceDiscovery *)discoveryDocument {

  self = [super init];
  if (self) {
    _authorizationEndpoint = [authorizationEndpoint copy];
    _tokenEndpoint = [tokenEndpoint copy];
    _discoveryDocument = [discoveryDocument copy];
  }
  return self;
}

- (nullable instancetype)initWithAuthorizationEndpoint:(NSURL *)authorizationEndpoint
                                         tokenEndpoint:(NSURL *)tokenEndpoint {
  return [self initWithAuthorizationEndpoint:authorizationEndpoint
                               tokenEndpoint:tokenEndpoint
                           discoveryDocument:nil];
}

- (nullable instancetype)initWithDiscoveryDocument:(OIDServiceDiscovery *) discoveryDocument {
  return [self initWithAuthorizationEndpoint:discoveryDocument.authorizationEndpoint
                               tokenEndpoint:discoveryDocument.tokenEndpoint
                           discoveryDocument:discoveryDocument];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(nullable NSZone *)zone {
  // The documentation for NSCopying specifically advises us to return a reference to the original
  // instance in the case where instances are immutable (as ours is):
  // "Implement NSCopying by retaining the original instead of creating a new copy when the class
  // and its contents are immutable."
  return self;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
  return YES;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  NSURL *authorizationEndpoint = [aDecoder decodeObjectOfClass:[NSURL class]
                                                        forKey:kAuthorizationEndpointKey];
  NSURL *tokenEndpoint = [aDecoder decodeObjectOfClass:[NSURL class]
                                                forKey:kTokenEndpointKey];
  // We don't accept nil authorizationEndpoints or tokenEndpoints.
  if (!authorizationEndpoint || !tokenEndpoint) {
    return nil;
  }

  OIDServiceDiscovery *discoveryDocument = [aDecoder decodeObjectOfClass:[OIDServiceDiscovery class]
                                                                  forKey:kDiscoveryDocumentKey];

  return [self initWithAuthorizationEndpoint:authorizationEndpoint
                               tokenEndpoint:tokenEndpoint
                           discoveryDocument:discoveryDocument];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_authorizationEndpoint forKey:kAuthorizationEndpointKey];
  [aCoder encodeObject:_tokenEndpoint forKey:kTokenEndpointKey];
  [aCoder encodeObject:_discoveryDocument forKey:kDiscoveryDocumentKey];
}

#pragma mark - description

- (NSString *)description {
  return [NSString stringWithFormat:
      @"OIDServiceConfiguration authorizationEndpoint: %@, tokenEndpoint: %@, "
          "discoveryDocument: [%@]",
      _authorizationEndpoint,
      _tokenEndpoint,
      _discoveryDocument];
}

@end

NS_ASSUME_NONNULL_END
