//
//  NSString+JF.h
//  Hattrick
//
//  Created by Denis Jajčević on 12/17/12.
//  Copyright (c) 2012 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (JFDownload)

- (NSURL *)URL;

- (NSString *)escaped;

- (NSString *)unescaped;

- (NSString *)base64;

+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;

- (NSString *)sha1;

- (NSString *)md5;

@end
