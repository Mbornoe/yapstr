/**
 * @file NetworkDriver.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The NetworkDriver is used for communicating data between the view controlleres in the Mobile Client subsystem and the views and controllers in the Server subsystem.
 */

#import "NetworkDriver.h"

@implementation NetworkDriver

/** Method inform the Server that a certain photo has been flaged for deletion. Takes the said photo object as input parameter. */
+ (void)reqSetDeleteFlag:(Photo*)photo{
    NSDictionary *photoDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: photo.photoID, @"photoId", nil];
    NSString *json = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/PhotoController/setDeleteFlag?data=%@", [self parseToJSON:photoDictionary]];
    NSURL *jsonURL = [NSURL URLWithString:json];    
    [NSData dataWithContentsOfURL:jsonURL];
}

/** Method allowing upload of photo. Takes an image and an event object as input parameters. */
+ (void)uploadPhoto:(UIImage*)image withEvent:(Event*)event
{
    /** Converting UIImage into JPEG incoded image data, with highest quality. */
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    NSDictionary *jsonDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: event.eventId, @"eventId", nil];
    NSString *urlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/PhotoController/storePhoto?data=%@", [self parseToJSON:jsonDictionary]];
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
    
    /** Response from server, was the transmission successful. */
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"%@", returnString);
}

/** Method for requesting all events from the Server. */
+ (NSArray*)regEvents {
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSURL *jsonUrl = [NSURL URLWithString:@"http://12gr550.lab.es.aau.dk/EventController/getEvents"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *events = [json objectForKey:@"EventsList"];
    for(NSDictionary *event in events)
    {
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

/** Method for requesting the events in the in the vicinity of the users location. Takes an event object holding the users current location as input parameter. */
+ (NSArray*)regEvents:(Location*)location
{
    NSDictionary *coordinateDict =  [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%f",location.longitude], @"longitude",
                                    [NSString stringWithFormat:@"%f",location.latitude], @"latitude",
                                     nil];
    NSDictionary *locationDict = [[NSDictionary alloc] initWithObjectsAndKeys: coordinateDict, @"location", nil];
    NSString *locationJSON = [self parseToJSON:locationDict];
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];    
    NSString *typeJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/EventController/getEvents?data=%@",locationJSON];
    NSURL *typeJSONUrl = [NSURL URLWithString:typeJSONUrlString];
    NSData *jsonData = [NSData dataWithContentsOfURL:typeJSONUrl];
    NSString *test = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", test);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *events = [json objectForKey:@"EventsList"];
    for(NSDictionary *event in events)
    {
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

/** Method for requesting the photos associated with a certain event. Takes the event object that the photos are associated with as input parameter. */
+ (NSArray*)reqPhotosFromServer:(Event*)event
{     
    NSDictionary *jsonTypeDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%i", [[event eventId] integerValue]], @"eventId", nil];
    NSString *url = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/PhotoController/getPhotos?data=%@", [self parseToJSON:jsonTypeDictionary]];
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *photoList = [json objectForKey:@"photoList"];
    for(NSDictionary *photo in photoList)
    {
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

/** Method allowing upload of event. Takes an event object as input parameters. */
+ (Event*)uploadEvent:(Event*)eventIn;
{
    NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%f",eventIn.location.longitude], @"longitude",
                              [NSString stringWithFormat:@"%f",eventIn.location.latitude], @"latitude", nil];
    NSDictionary *eventDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               eventIn.name, @"name",
                               eventIn.privateOn, @"privateOn",
                               eventIn.date, @"date",
                               eventIn.description, @"description",
                               eventIn.password, @"password",
                               location, @"location",
                               nil];
    NSString *eventJSON = [self parseToJSON:eventDict];
    NSString *eventJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/EventController/storeEvent/?data=%@",eventJSON];
    NSURL *eventJSONUrl = [NSURL URLWithString:eventJSONUrlString];
    NSLog(@"New event has been assigned id: %@", eventJSONUrl);
    NSData *jsonData = [NSData dataWithContentsOfURL:eventJSONUrl];
    NSDictionary *serverOutput = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    Event *outEvent =  eventIn;
    outEvent.eventId = [NSNumber numberWithInt:[[serverOutput objectForKey:@"message"] integerValue]];
    NSLog(@"New event has been assigned id: %@", outEvent.eventId);
    return outEvent;
}

/** A JSON parser that are used to convert a normal string to an encoded JSON string. */
+ (NSString*) parseToJSON: (NSDictionary*)dataToParse
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataToParse options:kNilOptions error:nil];
    NSString *eventJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *encodedJSONString = [eventJSONString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return encodedJSONString;
}


+ (User*) regUserId:(FacebookUser*)facebookUser
{
    NSDictionary *dataToServer = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [facebookUser getFacebookID], @"facebookId",
                                  nil];
    
    NSString *dataToServerJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/UserController/getUser?data=%@", [self parseToJSON:dataToServer]];
    
    NSError* error = nil;
    NSURL *url = [NSURL URLWithString:dataToServerJSONUrlString];
    NSData *JASONData = [NSData dataWithContentsOfURL:url];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:JASONData options:kNilOptions error:&error];
    
    User *user = [[User alloc] init];
    
    user.userId = [data objectForKey:@"userId"];
    user.name = [data objectForKey:@"name"];
    user.facebookId = [data objectForKey:@"facebookId"];
    
    return user;
}


+ (UIImage*) reqPhotoFromServer:(NSURL*)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [[UIImage alloc] initWithData:data];

}

@end
