#import <UIKit/UIKit.h>

@interface SelectPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImage *img;
	UIImagePickerController *imgPicker;
}

@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UIImage *img;

@end
