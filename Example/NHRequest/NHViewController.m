//
//  NHViewController.m
//  NHRequest
//
//  Created by Nathan Hegedus - Mac Mini on 16/04/14.
//  Copyright (c) 2014 Nathan Hegedus. All rights reserved.
//

#import "NHViewController.h"
#import "NHRequest.h"

@interface NHViewController ()

@property (weak, nonatomic) IBOutlet UITextView *responsseTextView;

@end

@implementation NHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)getSomething:(id)sender {
    
    [_responsseTextView setText:@""];
    
    [[NHRequest sharedInstance] setShowNetworkActivityIndicator:YES];
    
    [[NHRequest sharedInstance] getWithURLString:@"https://itunes.apple.com/lookup?id=909253&entity=album" andHeaders:nil withBlockSuccess:^(id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"responseObject:\n%@", responseObject]];
    } orFailure:^(NSError *error, id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"error:\n%@n\nresponseObject:\n%@", error, responseObject]];
    }];
    
}

- (IBAction)getSomethingWithError:(id)sender {

    [_responsseTextView setText:@""];

    [[NHRequest sharedInstance] setShowNetworkActivityIndicator:YES];
    
    [[NHRequest sharedInstance] getWithURLString:@"https://itunes.apple.com/lookup?id=909253&entity=ERROR" andHeaders:nil withBlockSuccess:^(id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"responseObject:\n%@", responseObject]];
    } orFailure:^(NSError *error, id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"error:\n%@\n\n\n\nresponseObject:\n%@", error, responseObject]];
    }];
    
}

- (IBAction)postSomething:(id)sender {

    NSLog(@"It will not work because need a valid URL and parameters");
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"My name"] forKeys:[NSArray arrayWithObject:@"nameKey"]];
    
    [[NHRequest sharedInstance] postWithParametersAndValuesDict:parameters URLString:@"http://SomeURL.com.br" andHeaders:nil withBlockSuccess:^(id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"responseObject:\n%@", responseObject]];
    } orFailure:^(NSError *error, id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"error:\n%@\n\n\n\nresponseObject:\n%@", error, responseObject]];
    }];

}

- (IBAction)putSomething:(id)sender {
    
    NSLog(@"It will not work because need a valid URL and parameters");

    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"My name"] forKeys:[NSArray arrayWithObject:@"nameKey"]];
    
    [[NHRequest sharedInstance] putWithParametersAndValuesDict:parameters URLString:@"http://SomeURL.com" andHeaders:nil withBlockSuccess:^(id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"responseObject:\n%@", responseObject]];
    } orFailure:^(NSError *error, id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"error:\n%@\n\n\n\nresponseObject:\n%@", error, responseObject]];
    }];

}

- (IBAction)deleteSomething:(id)sender {
    
    NSLog(@"It will not work because need a valid URL and parameters");

    NSDictionary *header = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"SomValueOnHeader"] forKeys:[NSArray arrayWithObject:@"nameKey"]];
    
    [[NHRequest sharedInstance] deleteWithURLString:@"http://SomeURL.com" andHeaders:header withBlockSuccess:^(id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"responseObject:\n%@", responseObject]];
    } orFailure:^(NSError *error, id responseObject) {
        [_responsseTextView setText:[NSString stringWithFormat:@"error:\n%@\n\n\n\nresponseObject:\n%@", error, responseObject]];
    }];
    
}

@end
