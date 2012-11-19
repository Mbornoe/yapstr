/**
 * @file NetworkDriver.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "NetworkDriver.h"

@implementation NetworkDriver


- (void) uploadPhoto
{
    
}


+ (void) uploadEvent:(NSData*)eventData;
{
    NSString *eventJSON = [self parseToJSON:eventData];
    NSLog(@"%@", eventJSON);
    
    NSLog(@"CHOOSED EVENT");
    NSString *eventJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/EventController/storeEvent/?data=%@",eventJSON];
    NSLog(@"%@",eventJSONUrlString);
    
    NSLog(@" ER HHER");
    NSURL *eventJSONUrl = [NSURL URLWithString:eventJSONUrlString];
    NSLog(@" ER HHER2");
    NSLog(@"%@",eventJSONUrl);
    NSData *jsonData = [NSData dataWithContentsOfURL:eventJSONUrl];
    NSLog(@" ER HHER3");
    NSLog(@"%@",eventJSONUrl);
    NSLog(@"%@", jsonData);
    NSDictionary *serverOutput = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSLog(@" ER HHER4");
    NSLog(@"%@", serverOutput);
    
    
}


+(NSString*) parseToJSON: (NSData*)dataToParse{
    
    NSString *eventJSONString = [[NSString alloc] initWithData:dataToParse encoding:NSUTF8StringEncoding];
    NSString *encodedJSONString = [eventJSONString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return encodedJSONString;
    
}

@end
