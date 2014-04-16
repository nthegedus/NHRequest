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

#import "NHRequest.h"
#import "AFNetworking.h"

#define kMessageWithoutInternet @"Please check your internet connection and try again later"

typedef NS_ENUM(NSInteger, RequestType) {
    
    POST,
    PUT,
    GET,
    DELETE
    
};

@implementation NHRequest

#pragma mark - Singleton
//Create a singleton
+(NHRequest *)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
    
}

#pragma mark - POST

-(void)postWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure{
    
    [self requestWithType:POST URLString:URLString parameters:parameters header:headers withBlockSuccess:^(id responseObject) {
        
        success(responseObject);
        
    } orFailure:^(NSError *error, id responseObject) {
        
        failure(error, responseObject);
        
    }];
    
}

#pragma mark - PUT

-(void)putWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure{
    
    [self requestWithType:PUT URLString:URLString parameters:parameters header:headers withBlockSuccess:^(id responseObject) {
        
        success(responseObject);
        
    } orFailure:^(NSError *error, id responseObject) {
        
        failure(error, responseObject);
        
    }];
    
    
}


#pragma mark - GET

-(void)getWithURLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure{
    
    [self requestWithType:GET URLString:URLString parameters:nil header:headers withBlockSuccess:^(id responseObject) {
        
        success(responseObject);
        
    } orFailure:^(NSError *error, id responseObject) {
        
        failure(error, responseObject);
        
    }];
    
}


#pragma mark - DELETE

-(void)deleteWithURLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure{
        
    [self requestWithType:DELETE URLString:URLString parameters:nil header:headers withBlockSuccess:^(id responseObject) {

        success(responseObject);

    } orFailure:^(NSError *error, id responseObject) {

        failure(error, responseObject);
        
    }];
    
}

#pragma mark - Request By Type

-(void)requestWithType:(RequestType)requestType URLString:(NSString *)URLString parameters:(NSDictionary *)parameters header:(NSDictionary *)headers withBlockSuccess:(NHRequestSuccess)success orFailure:(NHRequestFailure)failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:self.canShowNetworkActivityIndicator];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            manager = [self setHeaders:headers onOperationManager:manager];
            
            
            if (requestType == POST) {
                
                [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error, operation.responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }];
                
                return;
                
            }
            
            if (requestType == PUT) {
                
                [manager PUT:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error, operation.responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }];
                
                return;
            }
            
            if (requestType == GET) {
                
                [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error, operation.responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }];
                
                return;
            }
            
            if (requestType == DELETE) {
                
                [manager DELETE:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error, operation.responseObject);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }];
                
                return;
                
            }

        }else{
            
            [self showAlertConnection];
            failure(Nil, nil);

        }

        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
    }];
    
}


#pragma mark - Header

-(AFHTTPRequestOperationManager *)setHeaders:(NSDictionary *)headers onOperationManager:(AFHTTPRequestOperationManager *)operationManager{

    if ([[headers allKeys] count] > 0) {
        
        for (int i = 0; i < [[headers allKeys] count]; i++) {
            NSString *currentKey = [[headers allKeys] objectAtIndex:i];
            NSString *valueForKey = [headers valueForKey:currentKey];
            [operationManager.requestSerializer setValue:valueForKey forHTTPHeaderField:currentKey];
        }
        
    }
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return operationManager;

    
}

#pragma mark - Other Stuff

-(void)showAlertConnection{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:kMessageWithoutInternet delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    
}

@end
