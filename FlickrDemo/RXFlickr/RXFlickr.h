//
//  RXFlickr.h
//  spotDock
//
//  Created by Joseph Stein on 12/19/11.
//  Copyright (c) 2011 9mmedia LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RXFlickr;

@protocol RXFlickrDelegate <NSObject>
@optional
- (void)flickrDidAuthorize:(RXFlickr*)flickr;
- (void)flickrDidNotAuthorize:(RXFlickr*)flickr;
@end

@interface RXFlickr : NSObject <UIWebViewDelegate> {
  id<RXFlickrDelegate> delegate;
}

@property(nonatomic,retain) UIWebView* webView;
@property(nonatomic,assign) id<RXFlickrDelegate> delegate;

@property(nonatomic,retain) NSString* token;
@property(nonatomic,retain) NSString* tokenSecret;

- (BOOL)startAuthorization;
- (id)initWithConsumerKey:(NSString*)consumerKey secret:(NSString*)consumerSecret callbackURL:(NSString*)callbackURL;

@end
