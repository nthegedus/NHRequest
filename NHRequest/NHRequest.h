//  NHRequest.h
//
//  Created by Nathan Hegedus on 16/04/14.
//  Copyright (c) 2014 Nathan Hegedus. All rights reserved.
//
//  To use 'NHRequest' you will need add to your project 'AFNetworking 2.0 or higher.
//  It's just a simple way to make HTTP requests like POST, PUT, GET and DELETE
//  With 'NHRequest' you can send the parameters in a NSDictonary using value/key, and the same with Headers
//  Enjoy it.
//

#import <Foundation/Foundation.h>

typedef void(^NHRequestSuccess)(id responseObject);
typedef void(^NHRequestFailure)(NSError *error, id responseObject);

@interface NHRequest : NSObject

/*
 *  'showNetworkActivityIndicator' showing network spinning gear in status bar. default is NO
 */
@property (nonatomic, getter = canShowNetworkActivityIndicator) BOOL showNetworkActivityIndicator;


/*
 *  Returns the sharedInstance NHRequest.
 */
+(NHRequest *)sharedInstance;

#pragma mark - POST
/*
 *  Use this method to POST.
 *  @param 'parameters' Sending parameters in NSDictionary (values/keys) if you are using Form-Data, else if you are using Query String it can be nil.
 *  @param 'URLString' The URLString string used to create the request URLString.
 *  @param 'headers' Sending headers in NSDictionary (values/keys). It can be nil.
 *  @param 'success' A block object to be executed when the request operation finishes successfully. This block has no return value and take the response object created by the client response serializer.
 *  @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request response and the error describing the network or parsing error that occurred.
 */
-(void)postWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLStringString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure;

#pragma mark - PUT
/*
 *  Use this method to PUT.
 *  @param 'parameters' Sending parameters in NSDictionary (values/keys) if you are using Form-Data, else if you are using Query String it can be nil.
 *  @param 'URLString' The URLString string used to create the request URLString.
 *  @param 'headers' Sending headers in NSDictionary (values/keys). It can be nil.
 *  @param 'success' A block object to be executed when the request operation finishes successfully. This block has no return value and take the response object created by the client response serializer.
 *  @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request response and the error describing the network or parsing error that occurred.
 */
-(void)putWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLStringString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure;

#pragma mark - GET
/*
 *  Use this method to GET.
 *  @param 'URLString' The URLString string used to create the request URLString.
 *  @param 'headers' Sending headers in NSDictionary (values/keys). It can be nil.
 *  @param 'success' A block object to be executed when the request operation finishes successfully. This block has no return value and take the response object created by the client response serializer.
 *  @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request response and the error describing the network or parsing error that occurred.
 */
-(void)getWithURLString:(NSString *)URLStringString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure;

#pragma mark - DELETE
/*
 *  Use this method to DELETE.
 *  @param 'URLString' The URLString string used to create the request URLString.
 *  @param 'headers' Sending headers in NSDictionary (values/keys). It can be nil.
 *  @param 'success' A block object to be executed when the request operation finishes successfully. This block has no return value and take the response object created by the client response serializer.
 *  @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request response and the error describing the network or parsing error that occurred.
 */
-(void)deleteWithURLString:(NSString *)URLStringString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure;

@end
