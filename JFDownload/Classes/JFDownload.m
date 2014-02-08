//
//  JFDownloadManager.m
//  JFUtilNetwork
//
//  Created by Denis Jajčević on 28.2.2013..
//  Copyright (c) 2013. JajcevicFramework. All rights reserved.
//

#import "JFDownload.h"

typedef enum {
    JFMediaTypeData,
    JFMediaTypeString,
    JFMediaTypeImage,
    JFMediaTypePList
} JFMediaType;

@interface JFDownload ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *p_data;
@property (nonatomic, retain) NSURLResponse *p_response;
@property (nonatomic, retain) NSError *p_error;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, assign) JFMediaType mediaType;

@end

@implementation JFDownload

-(id) initWithTarget:(id) target selector:(SEL)sel
{
    self = [super init];
    if (self) {
        self.target = target;
        self.sel = sel;
        self.p_data = [NSMutableData data];
    }
    return self;
}

-(NSString*) getSomeString
{
    return @"bla";
}

-(void)downloadDataFromURL:(NSURL *)url
{
    _mediaType = JFMediaTypeData;
    self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self startImmediately:NO];
}

-(void)downloadImageFromURL:(NSURL *)url
{
    _mediaType = JFMediaTypeImage;
    self.request = [NSURLRequest requestWithURL:url];
    self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self startImmediately:NO];
}

+(JFDownload *)performRequest:(NSURLRequest *)request withFinishTarget:(id)target andFinishSelector:(SEL)selector
{
    JFDownload *download = [[JFDownload alloc] initWithTarget:target selector:selector];
    
    [download performRequest:request withFinishTarget:target andFinishSelector:selector];
    
    return download;
}

-(void)performRequest:(NSURLRequest *)request withFinishTarget:(id)target andFinishSelector:(SEL)selector
{
    self.request = request;
    self.connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:YES];
}

-(NSData *)response
{
    return _p_data;
}

-(void)main
{
    [self.connection performSelector:@selector(start) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    
    while(!_finished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

-(void)cancel
{
    [self.connection cancel];
    [super cancel];
}

-(void)downloadImageFromURLString:(NSString *)urlString
{
    [self downloadImageFromURL:[NSURL URLWithString:urlString]];
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    _p_data.length = 0;
    return request;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.p_response = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_p_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_mediaType == JFMediaTypeImage) {
        NSLog(@"Image: %@", [UIImage imageWithData:_p_data]);
    }
    else if(_mediaType == JFMediaTypeString) {
        NSLog(@"String: %@", [[NSString alloc] initWithData:_p_data encoding:NSUTF8StringEncoding]);
    }
    
    if (_target && _sel) {
        if (_resultOnMainThread)
            [_target performSelectorOnMainThread:_sel withObject:self waitUntilDone:NO];
        else
            [_target performSelectorInBackground:_sel withObject:self];
    }
    _target = nil;
    _sel = nil;
    self.finished = YES;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Response error %@", error);
    self.p_error = error;
    
}

-(NSHTTPURLResponse *)httpResponse
{
    return (NSHTTPURLResponse*)_p_response;
}

@end
