NHRequest
=========

It's an interface with AFNetworking to make HTTP requests like POST, PUT, GET and DELETE


##Setup

### Installation with CocoaPods

I recommend you to take a look at [CocoaPods](http://cocoapods.org) and use it for dependency management in your iOS projects.

To add NHRequest to your project it is necessary that the following lines are in your Podfile:

```ruby
platform :ios, '7.0'
pod "NHRequest", "~> 1.0.1"
```

### Installation without CocoaPods

  1. Add the AFNetwork into your project
  2. Import "NHRequest.h", `#import "NHRequest.h"`
  
##How to use?

  `GET`:
```objective-c
    [[NHRequest sharedInstance] getWithURLString:@"yourURL" andHeaders:nil withBlockSuccess:^(id responseObject) {
       NSLog(@"responseObject: %@",responseObject);
    } orFailure:^(NSError *error, id responseObject) {
        NSLog(@"error: %@",error);
        NSLog(@"responseObject: %@",responseObject);
    }];
```
    
    
  `POST`:
```objective-c
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"My name"] forKeys:[NSArray arrayWithObject:@"nameKey"]];
    
    [[NHRequest sharedInstance] postWithParametersAndValuesDict:parameters URLString:@"http://SomeURL.com.br" andHeaders:nil withBlockSuccess:^(id responseObject) {
        NSLog(@"responseObject: %@",responseObject);
    } orFailure:^(NSError *error, id responseObject) {
        NSLog(@"error: %@",error);
        NSLog(@"responseObject: %@",responseObject);
    }];
```
    
    
  `PUT`
```objective-c
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"My name"] forKeys:[NSArray arrayWithObject:@"nameKey"]];
    
    [[NHRequest sharedInstance] putWithParametersAndValuesDict:parameters URLString:@"http://SomeURL.com" andHeaders:nil withBlockSuccess:^(id responseObject) {
        NSLog(@"responseObject: %@",responseObject);
     } orFailure:^(NSError *error, id responseObject) {
        NSLog(@"error: %@",error);
      NSLog(@"responseObject: %@",responseObject);
    }];
```


  `DELETE`
```objective-c
    [[NHRequest sharedInstance] deleteWithURLString:@"yourURL" andHeaders:nil withBlockSuccess:^(id responseObject) {
        NSLog(@"responseObject: %@",responseObject);
    } orFailure:^(NSError *error, id responseObject) {
        NSLog(@"error: %@",error);
        NSLog(@"responseObject: %@",responseObject);
    }];
```
