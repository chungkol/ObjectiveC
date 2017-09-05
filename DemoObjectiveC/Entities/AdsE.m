//
//  AdsE.m
//  Favor
//
//  Created by Tinhvv on 10/20/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "AdsE.h"

@implementation AdsE

+(instancetype) shareAds{
    AdsE *adsE = [[AdsE alloc] init];
    return adsE;
}

/**
 Prart data from JSON
 @param data: NSDictionary
 *
 */
-(void)parseData:(NSDictionary *)data{
    _adsID = [Util intValueForKey:@"id" fromDict:data];
    _width = [Util intValueForKey:@"width_first" fromDict:data];
    _height = [Util intValueForKey:@"height_first" fromDict:data];
    NSString *location = [Util stringValueForKey:@"location" fromDict:data];
    if ([location isEqualToString:@"top"]) {
        _location = AdsLocationTop;
    } else if ([location isEqualToString:@"list"]) {
        _location = AdsLocationList;
    } else if ([location isEqualToString:@"splash"]) {
        _location = AdsLocationSplash;
    } else {
        _location = AdsLocationUndefined;
    }
    
    NSString *type = [Util stringValueForKey:@"type" fromDict:data];
    if ([type isEqualToString:@"image"]) {
        _type = AdsImage;
    } else if ([type isEqualToString:@"video"]) {
        _type = AdsVideo;
    } else {
        _type = AdsUndefined;
    }
    
    _title = [Util stringValueForKey:@"title" fromDict:data];
    _device = [Util stringValueForKey:@"device" fromDict:data];
    _firstContent = [Util stringValueForKey:@"first_content" fromDict:data];
    _firstURL = [Util stringValueForKey:@"first_url" fromDict:data];
    _secondContent = [Util stringValueForKey:@"second_content" fromDict:data];
    _secondURL = [Util stringValueForKey:@"second_url" fromDict:data];
    NSString *string = [Util stringValueForKey:@"video_type" fromDict:data];
    _videoType = [Util adsVideoTypeFrom:string];
    _firstThumb = [Util stringValueForKey:@"first_thumb" fromDict:data];
    _secondThumb = [Util stringValueForKey:@"second_thumb" fromDict:data];
    _youtube_url = [Util stringValueForKey:@"youtube_url" fromDict:data];
    _isYoutube = [Util intValueForKey:@"youtube_video" fromDict:data] == 1;
    if (_isYoutube) {
        _width = 16;
        _height = 9;
    }
}
/**
 Parse data from Astrars SDK
 *@param data: AstrarsContentData
 *@param location: AdsLocation of AdsE
 *//*
-(void) adsFromAstrars:(AstrarsContentData *)data withLocation:(AdsLocation) location {
    _location = location;
    _type = AdsVideo;
    //    _videoType = [Util adsVideoTypeFrom:data.code];
    if ([data.code isEqualToString:@"TypeA"]) {
        _videoType = AdsVideoTypeA;
    } else if ([data.code isEqualToString:@"TypeB"]) {
        _videoType = AdsVideoTypeB;
    } else if ([data.code isEqualToString:@"TypeC"]) {
        _videoType = AdsVideoTypeC;
    } else {
        _videoType = AdsVideoUndefined;
    }
    _firstContent = data.iconImgUrl;
    _secondContent = data.mainImgUrl;
    _firstURL = data.mainText;
    _adsID = data.contentId;
    _isAstrars = YES;
    NSString *size = data.title;
    if (size.length > 0) {
        NSArray *array = [size componentsSeparatedByString:@"*"];
        if (array.count == 2) {
            _width = [array[0] intValue];
            _height = [array[1] intValue];
        }
    }
}*/

@end
