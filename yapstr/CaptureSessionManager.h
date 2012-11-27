#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@interface CaptureSessionManager : NSObject {

}

#define kImageCapturedSuccessfully @"Image Captured Successfully"
@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) UIImage *stillImage;


- (void)addVideoPreviewLayer;
- (void)addVideoInput;
- (void)addStillImageOutput;
- (UIImage*)captureStillImage;

@end
