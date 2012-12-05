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


+ (void)uploadPhoto:(UIImage*)image withEvent:(Event*)event
{
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    NSDictionary *jsonDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: event.eventId, @"eventId", nil];
    NSString *urlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/PhotoController/storePhoto?data=%@", [self parseToJSONjonas:jsonDictionary]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	NSString *boundary = @"---------------------------Boundary Line---------------------------";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"uploadedFile.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:body];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"%@", returnString);
}

+(NSArray*)regEvents:(Event*)locationEvent
{
    NSDictionary *typeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%f",locationEvent.location.longitude], @"longitude",
                              [NSString stringWithFormat:@"%f",locationEvent.location.latitude], @"latitude",
                              //locationEvent.name, @"name",
                              //locationEvent.date, @"date",
                                    nil];
    NSData *typeData =[NSJSONSerialization dataWithJSONObject:typeDict options:kNilOptions error:nil];
    NSString *typeJSON = [self parseToJSON:typeData];
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSString *typeJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/EventController/getEvents/?data=%@",typeJSON];
    NSURL *typeJSONUrl = [NSURL URLWithString:typeJSONUrlString];
    NSData *jsonData = [NSData dataWithContentsOfURL:typeJSONUrl];
    NSLog(@"%@",typeJSONUrl);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *events = [json objectForKey:@"EventsList"];
    for(NSDictionary *event in events) {
        Event *eventObj = [[Event alloc] init];
        eventObj.name = [event objectForKey:@"name"];
        eventObj.eventId = [NSNumber numberWithInt:[[event objectForKey:@"eventId"] integerValue]];
        NSDictionary *location = [event objectForKey:@"location"];
        eventObj.description = [event objectForKey:@"description"];
        eventObj.location = [[Location alloc] initWithLatitude:[[location objectForKey:@"latitude"] doubleValue] andLongitude:[[location objectForKey:@"longitude"] doubleValue]];
        [returnArray addObject:eventObj];
    }
    return returnArray;
}
+(NSArray*)regEvents {
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSURL *jsonUrl = [NSURL URLWithString:@"http://12gr550.lab.es.aau.dk/EventController/getEvents"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *events = [json objectForKey:@"EventsList"];
    for(NSDictionary *event in events) {
        Event *eventObj = [[Event alloc] init];
        eventObj.name = [event objectForKey:@"name"];
        eventObj.eventId = [NSNumber numberWithInt:[[event objectForKey:@"eventId"] integerValue]];
        NSDictionary *location = [event objectForKey:@"Location"];
        eventObj.description = [event objectForKey:@"description"];
        eventObj.location = [[Location alloc] initWithLatitude:[[location objectForKey:@"latitude"] doubleValue] andLongitude:[[location objectForKey:@"longitude"] doubleValue]];
        [returnArray addObject:eventObj];
    }
    return returnArray;
}

+(NSArray*)reqPhotos {
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSError* error = nil;
    NSURL *jsonUrl = [NSURL URLWithString:@"http://12gr550.lab.es.aau.dk/PhotoController/getPhotos"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        // Back to the main thread for UI updates, etc.
    });
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSArray *photoList = [json objectForKey:@"photoList"];
    for(NSDictionary *photo in photoList) {
        Photo *photoObj = [[Photo alloc] init];
        photoObj.photoPath = [photo objectForKey:@"photoPath"];
        photoObj.thumpnailPath = [photo objectForKey:@"thumpnailPath"];
        photoObj.userID = [NSNumber numberWithInt:[[photo objectForKey:@"userID"] integerValue]];
        NSDictionary *location = [photo objectForKey:@"location"];
        photoObj.location = [[Location alloc] initWithLatitude:[[location objectForKey:@"longitude"] doubleValue] andLongitude:[[location objectForKey:@"longitude"] doubleValue]];
        photoObj.eventID = [NSNumber numberWithInt:[[photo objectForKey:@"eventID"] integerValue]];
        photoObj.photoID = [NSNumber numberWithInt:[[photo objectForKey:@"photoID"] integerValue]];
        [returnArray addObject:photoObj];
    }
    return returnArray;
}
+(NSArray*)reqPhotosWithEvent:(Event*)event {
    NSDictionary *jsonLimitDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"0", @"startNumber", @"100", @"endNumber", nil];
    NSDictionary *jsonTypeDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%i", [[event eventId] integerValue]], @"eventId", nil];
    NSDictionary *jsonSendDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:jsonTypeDictionary,@"Type", jsonLimitDictionary, @"Limit", nil];
    NSString *url = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/PhotoController/getPhotos?data=%@", [self parseToJSONjonas:jsonTypeDictionary]];
    NSLog(@"%@",url);
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *photoList = [json objectForKey:@"photoList"];
    for(NSDictionary *photo in photoList) {
        Photo *photoObj = [[Photo alloc] init];
        photoObj.photoPath = [photo objectForKey:@"path"];
        photoObj.thumpnailPath = [photo objectForKey:@"thumbPath"];
        photoObj.userID = [NSNumber numberWithInt:[[photo objectForKey:@"userId"] integerValue]];
        NSDictionary *location = [photo objectForKey:@"location"];
        photoObj.location = [[Location alloc] initWithLatitude:[[location objectForKey:@"longitude"] doubleValue] andLongitude:[[location objectForKey:@"longitude"] doubleValue]];
        photoObj.eventID = [NSNumber numberWithInt:[[photo objectForKey:@"eventId"] integerValue]];
        photoObj.photoID = [NSNumber numberWithInt:[[photo objectForKey:@"photoId"] integerValue]];
        [returnArray addObject:photoObj];
    }
    return returnArray;
    
}


+ (Event*)uploadEvent:(Event*)eventIn;
{
    NSDictionary *eventDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               eventIn.name, @"name",
                               eventIn.privateOn, @"privateOn",
                               eventIn.date, @"date",
                               eventIn.description, @"description",
                               eventIn.password, @"password",
                               [NSString stringWithFormat:@"%f",eventIn.location.longitude], @"longitude",
                               [NSString stringWithFormat:@"%f",eventIn.location.latitude], @"latitude",
                               nil];
    NSData *eventData =[NSJSONSerialization dataWithJSONObject:eventDict options:kNilOptions error:nil];
    NSString *eventJSON = [self parseToJSON:eventData];
    
    NSString *eventJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/EventController/storeEvent/?data=%@",eventJSON];
    NSURL *eventJSONUrl = [NSURL URLWithString:eventJSONUrlString];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventJSONUrl];
    NSDictionary *serverOutput = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    Event *outEvent =  eventIn;
    outEvent.eventId = [NSNumber numberWithInt:[[serverOutput objectForKey:@"message"] integerValue]];
    NSLog(@"New event has been assigned id: %@", outEvent.eventId);
    return outEvent;
}

+(NSString*) parseToJSONjonas: (NSDictionary*)dataToParse{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataToParse options:kNilOptions error:nil];
    NSString *eventJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *encodedJSONString = [eventJSONString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return encodedJSONString;
    
}

+(NSString*) parseToJSON: (NSData*)dataToParse{
    
    NSString *eventJSONString = [[NSString alloc] initWithData:dataToParse encoding:NSUTF8StringEncoding];
    NSString *encodedJSONString = [eventJSONString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return encodedJSONString;
    
}

@end
