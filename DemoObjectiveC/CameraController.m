//
//  CameraController.m
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "CameraController.h"
@interface CameraController ()<AVCapturePhotoCaptureDelegate>
@end
@implementation CameraController


- (void) createCaptureSession {
    self.captureSession  = [[AVCaptureSession alloc] init];
}
- (void) configureCaptureDevices {
    AVCaptureDeviceDiscoverySession *session = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position: AVCaptureDevicePositionUnspecified];
    NSArray *cameras = session.devices;
    if ((cameras != (NSArray *)[NSNull null]) && (cameras.count > 0)) {
        for (AVCaptureDevice *camera in cameras) {
            if (camera.position == AVCaptureDevicePositionFront) {
                self.frontCamera = camera;
            }
            if (camera.position == AVCaptureDevicePositionBack) {
                self.rearCamera = camera;
                [camera lockForConfiguration:nil];
                camera.focusMode = AVCaptureFocusModeAutoFocus;
                [camera unlockForConfiguration];
            }
        }
    }else {
        NSLog(@"CameraControllerError.invalidOperation");
    }
}



//    func prepare(completionHandler: @escaping (Error?) -> Void) {
//      //        func configureDeviceInputs() throws {
//            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
//            
//            if let rearCamera = self.rearCamera {
//                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
//                
//                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
//                
//                self.currentCameraPosition = .rear
//            }
//            
//            else if let frontCamera = self.frontCamera {
//                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
//                
//                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
//                else { throw CameraControllerError.inputsAreInvalid }
//                
//                self.currentCameraPosition = .front
//            }
//            
//            else { throw CameraControllerError.noCamerasAvailable }
//        }
//        
//        func configurePhotoOutput() throws {
//            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
//            
//            self.photoOutput = AVCapturePhotoOutput()
//            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])], completionHandler: nil)
//            
//            if captureSession.canAddOutput(self.photoOutput) { captureSession.addOutput(self.photoOutput) }
//            captureSession.startRunning()
//        }
//        
//        DispatchQueue(label: "prepare").async {
//            do {
//                createCaptureSession()
//                try configureCaptureDevices()
//                try configureDeviceInputs()
//                try configurePhotoOutput()
//            }
//            
//            catch {
//                DispatchQueue.main.async {
//                    completionHandler(error)
//                }
//                
//                return
//            }
//            
//            DispatchQueue.main.async {
//                completionHandler(nil)
//            }
//        }
//    }








-(void)captureImage:(void (^)(UIImage *, NSError *))completion {
    if ((self.captureSession == (AVCaptureSession *) [NSNull null]) && (self.captureSession.isRunning)) {
        if( completion ) completion(nil, nil);
    }else {
        AVCapturePhotoSettings *settings = [[AVCapturePhotoSettings alloc] init];
        settings.flashMode = AVCaptureFlashModeOff;
        [self.photoOutput capturePhotoWithSettings:settings delegate:self];
        self.photoCaptureCompletionBlock = completion;
    }
}
-(void)displayPreview:(UIView *)view {
    if ((self.captureSession) && (self.captureSession.isRunning)) {
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [view.layer insertSublayer:self.previewLayer atIndex:0];
        self.previewLayer.frame = view.frame;
    }else {
        NSLog(@"CameraControllerError.captureSessionIsMissing");
    }
}
- (void)switchCameras {
    if ((self.currentCameraPosition) && (self.captureSession) && (self.captureSession.isRunning)) {
        [self.captureSession beginConfiguration];
        if (self.currentCameraPosition == front) {
            [self switchToRearCamera];
        }else if (self.currentCameraPosition == rear) {
            [self switchToFrontCamera];
        }else  {
            NSLog(@"null");
        }
        [self.captureSession commitConfiguration];
    }else {
        NSLog(@"CameraControllerError.captureSessionIsMissing");
    }
}
- (void) switchToFrontCamera {
    NSArray *inputs = self.captureSession.inputs;
    if ((inputs != (NSArray *)[NSNull null]) && (self.rearCameraInput) && [inputs containsObject:self.rearCameraInput] && (self.frontCamera)) {
        self.frontCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:self.frontCamera error:nil];
        [self.captureSession removeInput:self.rearCameraInput];
        if ([self.captureSession canAddInput:self.frontCameraInput]) {
            [self.captureSession addInput:self.frontCameraInput];
            self.currentCameraPosition = front;
        }else {
            NSLog(@"CameraControllerError.invalidOperation");
        }
    }else {
        NSLog(@"CameraControllerError.invalidOperation");
    }
}
- (void) switchToRearCamera {
    NSArray *inputs = self.captureSession.inputs;
    if ((inputs != (NSArray *)[NSNull null]) && (self.frontCameraInput) && [inputs containsObject:self.frontCameraInput] && (self.rearCamera)) {
        self.rearCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:self.rearCamera error:nil];
        [self.captureSession removeInput:self.frontCameraInput];
        if ([self.captureSession canAddInput:self.rearCameraInput]) {
            [self.captureSession addInput:self.rearCameraInput];
            self.currentCameraPosition = rear;
        }else {
            NSLog(@"CameraControllerError.invalidOperation");
        }
    }else {
        NSLog(@"CameraControllerError.invalidOperation");
    }
}
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error {
    if (error) {
        self.photoCaptureCompletionBlock(nil, error);
    }
    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        self.photoCaptureCompletionBlock(image, nil);
    }
}

@end




