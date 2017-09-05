//
//  AdsE.h
//  Favor
//
//  Created by Tinhvv on 10/20/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsE : NSObject
+(instancetype) shareAds;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *firstContent;
@property (nonatomic, strong) NSString *firstURL;
@property (nonatomic, strong) NSString *secondContent;
@property (nonatomic, strong) NSString *secondURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *firstThumb;
@property (nonatomic, strong) NSString *secondThumb;
@property (nonatomic, assign) AdsType type;
//@property (nonatomic, strong) NSString *videoType;
@property (assign) AdsVideoType videoType;
@property (nonatomic, assign) AdsLocation location;
@property (nonatomic, assign) int adsID;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL isAstrars;
@property (nonatomic, assign) BOOL isYoutube;
@property (nonatomic, strong) NSString *youtube_url;

-(void) parseData:(NSDictionary *) data;
//-(void) adsFromAstrars:(AstrarsContentData *)data withLocation:(AdsLocation) location;
@end
