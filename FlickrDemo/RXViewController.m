//
//  RXViewController.m
//  FlickrDemo
//
//  Created by Joseph Stein on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RXViewController.h"

static NSString* kConsumerKey = @"e91d24c65c947c5c0c1ac54e98594dc6";
static NSString* kConsumerSecret = @"d33b149d60c966f6";
static NSString* kCallbackURL = @"http://www.9mmedia.com";

@interface RXViewController () {
  RXFlickr* _flickrAccount;
  IBOutlet UIWebView* _webView;
}
- (IBAction)tappedAuthenticationButton;
@end

@implementation RXViewController

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)dealloc
{
  [_flickrAccount release];
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _flickrAccount = [[RXFlickr alloc] initWithConsumerKey:kConsumerKey secret:kConsumerSecret callbackURL:kCallbackURL];
  [_flickrAccount setDelegate:self];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Action Methods

- (void)tappedAuthenticationButton
{
  [_flickrAccount setWebView:_webView];
  [_flickrAccount startAuthorization];
}

#pragma mark - RXFlickr Delegate

- (void)flickrDidAuthorize:(RXFlickr *)flickr
{
  NSString* message = [NSString stringWithFormat:@"Token = %@\nSecret=%@", [_flickrAccount token], [_flickrAccount tokenSecret]];
  UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
  [alert release];
  
  [_webView loadHTMLString:nil baseURL:nil];
}

- (void)flickrDidNotAuthorize:(RXFlickr *)flickr
{
  UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An authorization error has occured" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
  [alert release];
}

@end
