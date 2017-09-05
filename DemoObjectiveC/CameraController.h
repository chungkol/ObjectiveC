//
//  CameraController.h
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    front = 0,
    rear
} CameraPosition;
typedef enum  {
    captureSessionAlreadyRunning,
    captureSessionIsMissing,
    inputsAreInvalid,
    invalidOperation,
    noCamerasAvailable,
    unknown
}CameraControllerError;
@interface CameraController : NSObject
@property AVCaptureSession *captureSession;
@property CameraPosition *currentCameraPosition;
@property AVCaptureDevice *frontCamera;
@property AVCaptureDeviceInput *frontCameraInput;
@property AVCapturePhotoOutput *photoOutput;
@property AVCaptureDevice *rearCamera;
@property AVCaptureDeviceInput *rearCameraInput;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property AVCaptureFlashMode *flashMode;
@property (nonatomic, copy) void (^photoCaptureCompletionBlock)(UIImage *image, NSError *error);

- (void) prepare: (void (^)(NSError *error))completionHandler;
- (void) displayPreview:(UIView *)view;
- (void) switchCameras;
- (void) captureImage: (void (^)(UIImage *image, NSError *error))completion;
@end
