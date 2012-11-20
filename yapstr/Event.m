/**
 * @file Event.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "Event.h"
@implementation Event
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize eventId;

-(void)setCoordinate:(CLLocationCoordinate2D) c {
    coordinate=c;
    title = [self name];
    subtitle = [NSString stringWithFormat:@"Event id: %i",[eventId intValue]];
}
- (void) createEvent
{
    
}
- (void) requestEvents
{
    
}
- (void) selectEvent
{
    
}
- (void) showEvent
{
    
}
- (void) showEvents
{
    
}

@end
