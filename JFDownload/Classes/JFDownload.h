//
//  JFDownloadManager.h
//  JFUtilNetwork
//
//  Created by Denis Jajčević on 28.2.2013..
//  Copyright (c) 2013. JajcevicFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIImage.h>

@interface JFDownload : NSOperation <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, readonly) NSData *response;
@property (nonatomic, readonly) NSHTTPURLResponse *httpResponse;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) NSInteger *downloadId;
@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL sel;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) BOOL resultOnMainThread;

-(NSString*) getSomeString;

-(void) downloadDataFromURL:(NSURL*) url;
-(void) downloadImageFromURL:(NSURL*) url;
-(void) downloadImageFromURLString:(NSString*) urlString;

+(JFDownload*) performRequest:(NSURLRequest*) request withFinishTarget:(id) target andFinishSelector:(SEL) selector;
-(void) performRequest:(NSURLRequest*) request withFinishTarget:(id) target andFinishSelector:(SEL) selector;

-(id) initWithTarget:(id) target selector:(SEL)sel;

@end
