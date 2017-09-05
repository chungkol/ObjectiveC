
//
//  Util.m
//  Favor
//
//  Created by vudinhthuy on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "Util.h"
#import "ETCategory.h"
#import "MBProgressHUD.h"
#import "MainContainerVC.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "GAITracker.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "ArticleComment.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import <Repro/Repro.h>
#import "LanguageOption.h"
#import "AstrarsManager.h"

#define MAX_LENGTH_BODY_SHARE 75

@implementation Util

+(void) showBoxForView:(UIView *)view{
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor blueColor].CGColor;
}

+(float) heightOfString:(UILabel *) label{
    CGSize maximumLabelSize = CGSizeMake(label.frame.size.width, FLT_MAX);
    CGRect rect = [label.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font} context:nil];
    return rect.size.height;
}

+(float) widthOfString:(UILabel *) label{
    CGSize maximumLabelSize = CGSizeMake(FLT_MAX, label.frame.size.height);
    CGRect rect = [label.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font} context:nil];
    return rect.size.width;
}

+(void) showAlertViewWithTitle:(NSString *)title withMessage: (NSString *)message andTag:(NSInteger)tag{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
//    alertView 
    if (tag > 0) {
        alertView.tag = tag;
    }
    [alertView show];
}

+(UIImage*) sketchFromImage:(NSString*) skinName withCapWidth:(NSInteger) capWidth withCapHeight:(NSInteger) capHeight{
    UIImage *imageSkinHeader = [UIImage imageNamed:skinName];
    CGImageRef imageSkinButtonSelRef = [imageSkinHeader CGImage];
    imageSkinHeader = [UIImage imageWithCGImage:imageSkinButtonSelRef scale:2 orientation:UIImageOrientationUp];
    imageSkinHeader = [imageSkinHeader stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
    return imageSkinHeader;
}

+(void) blockView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainContainerVC.view animated:NO];
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
}

+(void) unblockView{
    [MBProgressHUD hideAllHUDsForView:mainContainerVC.view animated:NO];
}

+(void) blockViewInview:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
}

+(void) unblockViewInView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

+ (NSString *) platformString{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (UK+Europe+Asia+China)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (UK+Europe+Asia+China)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2 (China)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

+(NSString *) pathOfFileInDocs:(NSString *) filename folder:(NSString *) folder{
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (folder) {
        NSString *pathToFolder = [docs stringByAppendingPathComponent:folder];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pathToFolder]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:pathToFolder withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        return [pathToFolder stringByAppendingPathComponent:filename];
    }else{
        return [docs stringByAppendingPathComponent:filename];
    }
}

+(void) clearFolderInDocs:(NSString *) folder{
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathToFolder = [docs stringByAppendingPathComponent:folder];
    for(NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathToFolder error:nil]){
        [[NSFileManager defaultManager] removeItemAtPath:[pathToFolder stringByAppendingPathComponent:file] error:nil];
    }
}

+ (BOOL) hasInternet {
//    return [AFNetworkReachabilityManager sharedManager].reachable;
    return YES;
}

+(CGFloat) onePixel{
    UIScreen* mainScreen = [UIScreen mainScreen];
    CGFloat onePixel = 1.0 / mainScreen.scale;
    if ([mainScreen respondsToSelector:@selector(nativeScale)]){
        onePixel = 1.0 / mainScreen.nativeScale;
    }
    
    return onePixel;
}

+ (void) sendGAIScreen:(NSString *)screenName
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker setAllowIDFACollection:YES];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder
                    createScreenView] build]];
    [Repro track:screenName properties:@{@"Type":@"SCREEN"}];
    
}

+ (void) sendGAIAction:(NSString *)category andAction:(NSString *)eventAction andLabel:(NSString *)label
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker setAllowIDFACollection:YES];
    // Clear the screen name field when we're done.
    [tracker set:kGAIScreenName value:nil];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                          action:eventAction
                                                           label:label
                                                           value:nil] build]];
    [Repro track:label properties:@{@"Type":@"EVENT",
                                    @"EVENT CATEGORY":category,
                                    @"EVENT ACTION":eventAction}];
}


+(void)setValueForButton:(UIButton *)sender withComment:(ArticleComment *)comment{
    [sender setSelected:comment.isLiked];
    [sender setTitle:[NSString stringWithFormat:@"  %d", comment.numberLiked] forState:(UIControlStateNormal)];
    [sender setTitle:[NSString stringWithFormat:@"  %d", comment.numberLiked] forState:(UIControlStateSelected)];
}

+(NSString *) stringValueForKey:(NSString *) key fromDict:(NSDictionary *) dict{
    if (([dict objectForKey:key]  == [NSNull null]) || ![dict objectForKey:key]) {
        return @"";
    }
    id value = [dict objectForKey:key];
    return [value isKindOfClass:[NSString class]] ? value:[value description];
}

+(int) intValueForKey:(NSString *) key fromDict:(NSDictionary *) dict{
    if (([dict objectForKey:key]  == [NSNull null]) || ![dict objectForKey:key]) {
        return 0;
    }
    
    return [[dict objectForKey:key] intValue];
}

+(float) floatValueForKey:(NSString *) key fromDict:(NSDictionary *) dict{
    if (([dict objectForKey:key]  == [NSNull null]) || ![dict objectForKey:key]) {
        return 0;
    }
    
    return [[dict objectForKey:key] floatValue];
}

+(void) checkNotificationCount:(void (^)(BOOL haveNew, NSString *lastTime)) completion{
    [[HttpRequester requester] requestNotificationCountWithResponseHandler:^(BOOL success, id responseObject) {
         if (success) {
            int count = [[[responseObject objectForKey:@"unread"] objectForKey:@"count"] intValue];
                if (count > 0) {
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    if (![user objectForKey:@"LastTimeCheckNotify"]) {
                        completion(YES, [[responseObject objectForKey:@"unread"] objectForKey:@"last_notification"]);
                    }else{
                        NSDate *lastTimeCheck = [Util convertStringToDate:[user objectForKey:@"LastTimeCheckNotify"]];
                        if ([lastTimeCheck compare:[Util convertStringToDate:[[responseObject objectForKey:@"unread"] objectForKey:@"last_notification"]]] == NSOrderedAscending) {
                            completion(YES, [[responseObject objectForKey:@"unread"] objectForKey:@"last_notification"]);
                        }
                    }
                    
                }
        }
    }];
}

+(float) heightOfLabel:(NSString *) text andFontSize: (float)size andWidth:(float)width{
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:size];
    CGSize maximumLabelSize = CGSizeMake(width, FLT_MAX);
    CGRect rect = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size.height + 4;
}

+(float) heightOfLabel:(NSString *) text andFont:(UIFont *)font andWidth:(float)width andLineSpacing: (CGFloat) lineSpacing {
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    [attribute setObject:font forKey:NSFontAttributeName];
    if (lineSpacing > 0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = lineSpacing;
        [attribute setObject:paragraph forKey:NSParagraphStyleAttributeName];
    }
    CGSize maximumLabelSize = CGSizeMake(width, FLT_MAX);
    CGRect rect = [text boundingRectWithSize:maximumLabelSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil];
    
    return rect.size.height;
}

+(float)getReplyCellHeigtWithReplyComment: (ReplyComment *)reply WithFullComment:(BOOL)isFull{
    float height = 56;
    NSString *text = reply.comment;
    float maxHeight = MAXFLOAT;
    if (!isFull) {
        maxHeight = 50;
//        if (reply.comment.length > 40) {
//            text = [[reply.comment substringToIndex:40] stringByAppendingString:@"..."];
//        }
    }
    height += MIN([self heightOfLabel:text andFontSize:16 andWidth:(SCREEN_WIDTH - 66)], maxHeight);
    if (reply.commentImage.length > 0) {
        height += 14;
        height += (reply.imageCommentSize.height/reply.imageCommentSize.width*((SCREEN_WIDTH - 44)*0.61));
    }
    return height;
}

+(float)getReplyTableHeightWithReplies: (NSArray *)replies withFullComment:(BOOL) isFull{
    float height = 0;
    for (ReplyComment *reply in replies) {
        height +=[self getReplyCellHeigtWithReplyComment:reply WithFullComment:isFull];
    }
    return height;
}

+(float) getCommentCellHeightWithComment: (ArticleComment *) comment widthFullComment:(BOOL) isFull{
    
    float height = 81;
    
    //Height to comment label
    NSString *text = comment.comment;
    float maxHeight = MAXFLOAT;
    if (!isFull) {
        maxHeight = 50;
//        if (comment.comment.length > 40) {
//            text = [[comment.comment substringToIndex:40] stringByAppendingString:@"..."];
//        }
    }
    height += MIN([self heightOfLabel:text andFontSize:16 andWidth:SCREEN_WIDTH - 55], maxHeight);
    
    if (comment.commentImage.length > 0) {
        //top margin
        height += 14;
        //image height
        height += (SCREEN_WIDTH*0.61)*(comment.imageCommentSize.height/comment.imageCommentSize.width);
    }
    
    if (comment.replies.count > 0) {
        height += 10;
        height += [Util getReplyTableHeightWithReplies:comment.replies withFullComment:isFull];
    }
    
    height += 16;
    height += [self onePixel];
    return height;
}

+(NSDate *)convertStringToDate:(NSString *)string{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"JST"]];
    return [format dateFromString:string];
}
+(NSString *)convertDateToString:(NSDate *)date{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"JST"]];
    return [format stringFromDate:date];
}

+(NSString *)shareMessageWithTitle:(NSString *) title andSubTitle: (NSString *)subTitle{
    NSString *message = [NSString stringWithFormat:@"【%@】%@【FAVORフェイバー】詳しくは→", title, subTitle];
    return message;
}

+(void)setArticleImage:(UIImageView *)imgView WithURL:(NSString *)url andPlaceHolderImage:(UIImage *)placeholderImage andHandler: (void (^)(BOOL finished, UIImage *image)) completion{
    __weak UIImageView *imageView = imgView;
    if ([url rangeOfString:@".gif"].location == NSNotFound) {
        //Set image is not gif image
        //Set ImageView with URL by SdWebImage
        [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error && image) {
                //Change image and frame of ImageView when success
                imageView.image = image;
            }
            completion(YES, image);
        }];
        
    }else{
        //set gif image
        [imgView setGIFImageWithURLRequest:url placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image, BOOL fromCache) {
            //Change image and frame of ImageView
            imageView.image = image;
            completion(YES, image);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            completion(YES, nil);
        }];
    }
}
+(void)setLikeButton:(UIButton *) button withLike: (BOOL)isLike andLikeNumber:(int)number{
    if (isLike) {
        [button setBackgroundImage:[UIImage imageNamed:@"iconLikeon.png"] forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"iconLike.png"] forState:UIControlStateNormal];
    }
    [button setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
}
+(NSMutableAttributedString *)getAttributedStringFrom:(NSString *)text withFontName:(NSString *)fontName size:(float) size andLineSpacing:(float)spacing{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (spacing > 0) {
        [paragraphStyle setLineSpacing:spacing];
    }
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attString;
}

+(NSMutableAttributedString *)getAttributedStringFrom:(NSString *)text withFontName:(NSString *)fontName size:(float) size andLineSpacing:(float)spacing andColor:(UIColor *)color{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (spacing > 0) {
        [paragraphStyle setLineSpacing:spacing];
    }
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{NSFontAttributeName: font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attString;
}

+(void)sendLikeArticleNotificationWith:(int)likeCount andIsLike:(BOOL)isLiked forArticle:(int)articleId{
    //Send notification to update info of article
    NSMutableDictionary *infos = [[NSMutableDictionary alloc] init];
    [infos setObject:@"like" forKey:@"type"];
    [infos setObject:[NSNumber numberWithInt:likeCount] forKey:@"like_count"];
    [infos setObject:[NSNumber numberWithBool:isLiked] forKey:@"user_liked"];
    [infos setObject:[NSNumber numberWithInt:articleId] forKey:@"article_id"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_ARTICLE object:nil userInfo:infos];
    if (isLiked) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_LIKED_ARTICLES object:nil userInfo:nil];
    } else {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:NOTIFICATION_REMOVE_FAVOURITE
         object:nil
         userInfo:@{@"article_id": [NSNumber numberWithInt:articleId]}];
    }
    
}

+(void)sendReloadNotificationWith:(int)notiId{
    NSMutableDictionary *infos = [[NSMutableDictionary alloc] init];
    [infos setObject:[NSNumber numberWithInt:notiId] forKey:@"noti_id"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_NOTIFICATION object:nil userInfo:infos];
}

+(void) changeIndexInArray:(NSMutableArray *)array fromIndex:(int) startIndex toIndex:(int) endIndex{
    id object= [array objectAtIndex:startIndex];
    [array removeObjectAtIndex:startIndex];
    if(startIndex < endIndex){
        endIndex--;
    }
    [array insertObject:object atIndex:endIndex];
}

+(void)setBottomBarHeightfor:(UIView *)bottomBar withLine:(UIImageView *)line{
    CGRect frame  = bottomBar.frame;
    float diff = frame.size.height - mainContainerVC.tabBar.frame.size.height;
    frame.size.height = mainContainerVC.tabBar.frame.size.height;
    frame.origin.y = frame.origin.y + diff;
    bottomBar.frame = frame;
}

+(float)getBotomBarHeight{
    return mainContainerVC.tabBar.frame.size.height;
}

+(NSString *)shareMessageWith:(NSString *)body andTag:(NSString *)tagString{
    if (body.length == 0) {
        body = @"";
    }else if(MAX_LENGTH_BODY_SHARE > 0 && body.length > MAX_LENGTH_BODY_SHARE){
        body = [[body substringToIndex:MAX_LENGTH_BODY_SHARE] stringByAppendingString:@"..."];
    }
    NSString *message = [NSString stringWithFormat:@"%@%@ 【FAVORフェイバー】詳しくは→", body, tagString];
    return message;
}

+(NSString *)getLocale{
    //20160926 Change locale manualy
//    NSLocale *currentSetting = [NSLocale currentLocale];
//    NSString *languageCode = [currentSetting objectForKey:NSLocaleLanguageCode];
//    //Chinese Simplified zh_hans
//    //Chinese traditional zh_hant
//    //Chinese traiditional zh_HK
//    //Chinese traiditional zh_TW
//    languageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
////    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
//        languageCode = [languageCode substringToIndex:2];
////    }
//    NSString *locale = [NSString stringWithFormat:@"%@_%@", languageCode, [(NSString *)[currentSetting objectForKey:NSLocaleCountryCode] lowercaseString]];
//    return locale;
//    return [[LanguageOption sharedInstance] locale];
    NSMutableString *locale = [NSMutableString string];
    switch ([self settingLanguage]) {
        case FVLanguageJapanese:
        [locale appendString:@"ja_"];
        break;
        case FVLanguageChineseSimplied:
        [locale appendString:@"zh_"];
        break;
        case FVLanguageChineseTraditional:
        [locale appendString:@"zh_"];
        break;
        case FVLanguageThaiLand:
        [locale appendString:@"th_"];
        break;
        default:
        [locale appendString:@"ja_"];
        break;
    }
    NSLocale *currentSetting = [NSLocale currentLocale];
    NSString *region = [(NSString *)[currentSetting objectForKey:NSLocaleCountryCode] lowercaseString];
    [locale appendString:region];
    return locale;
}
    
+ (FVLanguage) settingLanguage {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger setting = [user integerForKey:kRegion];
    if (setting == 0) {
        NSString *languageCode = [[[NSLocale preferredLanguages] objectAtIndex:0] lowercaseString];
        FVLanguage type = FVLanguageJapanese;
        //    FVLanguage type = FVLanguageJapanese;
        if ([languageCode rangeOfString:@"zh-hans"].location != NSNotFound) {
            type = FVLanguageChineseSimplied;
        } else if ([languageCode rangeOfString:@"zh-hant"].location != NSNotFound) {
            type = FVLanguageChineseTraditional;
        } else if ([languageCode rangeOfString:@"th"].location != NSNotFound) {
            if (languageCode.length > 2 && [[languageCode substringToIndex:2] isEqualToString:@"th"]) {
                type = FVLanguageThaiLand;
            }
        }
        return type;
    }
    switch (setting) {
        case 1:
            return FVLanguageJapanese;
        break;
        case 2:
            return FVLanguageChineseSimplied;
        break;
        case 3:
            return FVLanguageChineseTraditional;
        break;
        case 4:
            return FVLanguageThaiLand;
        break;
        default:
            return FVLanguageJapanese;
        break;
    }
}

+ (BOOL) isJapanese {
    //20160926 Change locale manualy
//    NSLocale *currentSetting = [NSLocale currentLocale];
//    NSString *languageCode = [currentSetting objectForKey:NSLocaleLanguageCode];
//    languageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
//    languageCode = [languageCode substringToIndex:2];
//    if ([languageCode isEqualToString:@"ja"]) {
//        return YES;
//    }
//    return NO;
    return [self settingLanguage] == FVLanguageJapanese;
}

+(void)fitSizeButton:(UIButton *)button{
    UIFont *font = button.titleLabel.font;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [button.titleLabel.text sizeWithAttributes:attribute];
    CGRect frame = button.frame;
    frame.size.width = size.width;
    button.frame = frame;
}

+(void)settingForBtnPostOrComment:(UIButton *)button withTitle:(NSString *)title{
    UIFont *font = button.titleLabel.font;
    float height = 47;
    float width = 232;
    if (SCREEN_WIDTH < 414) {
        height = 87/2.0f;
        width = 211;
        font = [font fontWithSize:14.5];
    }else{
        font = [font fontWithSize:16];
    }
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    NSDictionary *atrribute = @{NSFontAttributeName:font};
    CGSize size = [button.titleLabel.text sizeWithAttributes:atrribute];
    float marginTop = (height - size.height)/2;
    float marginLeft = (width - size.width)/2;
    if (marginLeft < 0) {
        marginLeft = 10;
    }
    [button setContentEdgeInsets:UIEdgeInsetsMake(marginTop, marginLeft, marginTop, marginLeft)];
}
+ (void) getAdsTimeLinesWithCompletion:(void (^) (BOOL isUpdate, NSDictionary *timeLineAds))completion {
    [[HttpRequester requester] requestAPI:@"/advertisments/for_timeline" withParams:nil andHanler:^(BOOL success, id responseObject) {
        if (success) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict = (NSDictionary *)responseObject;
            BOOL isUpdate = NO;
            NSString *preUpdate = [userDefault objectForKey:kLastUpdateWriter];
            //Settings
            NSDictionary *setting = [dict objectForKey:@"setting"];
            if ([setting isKindOfClass:[NSDictionary class]]) {
                NSString *rangeShowAds = [setting objectForKey:@"count"];
                [userDefault setObject:rangeShowAds forKey:RangeShowAdsNo1];
                NSString *timeUpdated = [[setting objectForKey:@"time_update"] stringValue];
                if (preUpdate != nil) {
                    if (![timeUpdated isEqualToString:preUpdate]) {
                        isUpdate = YES;
                        [userDefault setObject:timeUpdated forKey:kLastUpdateWriter];
                    }
                }else{
                    [userDefault setObject:timeUpdated forKey:kLastUpdateWriter];
                }
                [userDefault synchronize];
            }
            BOOL showAstrar = NO;
            /*
            if ([dict objectForKey:@"astrars_setting"]) {
                NSDictionary *astrarsSetting = [dict objectForKey:@"astrars_setting"];
                if ([astrarsSetting objectForKey:@"setting"]) {
                    showAstrar = [[astrarsSetting objectForKey:@"setting"] boolValue];
                }
            }*/
            //Ads
            NSArray *arrTimeLineAds = [dict objectForKey:@"advertisment_timelines"];
            NSMutableDictionary *timeLineAds = [NSMutableDictionary dictionary];
            AstrarsManager *astrars = [AstrarsManager sharedManager];
            for (NSDictionary *dictAds in arrTimeLineAds) {
                NSArray *arrAds = [dictAds objectForKey:@"advertisment"];
                NSMutableArray *listAds = [[NSMutableArray alloc] init];
                if (showAstrar) {
                    if (astrars.topAds.count > 0) {
                        [listAds addObject:astrars.topAds[0]];
                    }
                    if (astrars.listAds.count > 0) {
                        [listAds addObjectsFromArray:astrars.listAds];
                    }
                    if (astrars.topAds.count == 0 || astrars.listAds.count == 0) {
                        [arrAds enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                            AdsE *adsE = [[AdsE alloc] init];
                            [adsE parseData:dict];
                            if ((adsE.location == AdsLocationTop && astrars.topAds.count == 0)
                                || (adsE.location == AdsLocationList && astrars.listAds.count == 0)) {
                                [listAds addObject:adsE];
                            }
                        }];
                    }
                } else {
                    [arrAds enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                        AdsE *adsE = [[AdsE alloc] init];
                        [adsE parseData:dict];
                        [listAds addObject:adsE];
                    }];

                }
                NSNumber *timeLineId = [NSNumber numberWithInteger:[Util intValueForKey:@"timeline_id" fromDict:dictAds]];
                [timeLineAds setObject:listAds forKey:timeLineId];
            }
            //Splash Ads
            if ([[AstrarsManager sharedManager] splashAds] && showAstrar) {
                [timeLineAds setObject:[[AstrarsManager sharedManager] splashAds] forKey:kAdsLocationSplash];
            } else if ([dict objectForKey:@"advertisments_splash"] ||
                [dict objectForKey:@"advertisments_splash"] != [NSNull null]) {
                NSArray *arrSplashAds = [dict objectForKey:@"advertisments_splash"];
                if (arrSplashAds && arrSplashAds.count > 0) {
                    NSDictionary *firstDict = arrSplashAds.firstObject;
                    AdsE *splashAds = [AdsE shareAds];
                    [splashAds parseData:firstDict];
                    [timeLineAds setObject:splashAds forKey:kAdsLocationSplash];
                }
            }
            
            if(completion) {
                completion(isUpdate, timeLineAds);
            }
        } else {
            completion(NO, nil);
        }
    }];
}

// Get ads at screen 20 - for user
+ (void) getAdsUserWithCompletion:(void (^) (BOOL isUpdate, NSArray *listAds))completion{
    [[HttpRequester requester] requestListAdsWithUserType:kUser responseHandler:^(BOOL success, id responseObject) {
        
        if (success) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict = (NSDictionary *)responseObject;
            [userDefault setObject:dict forKey:kListAdsUser];
            
            BOOL isUpdate = NO;
            NSString *preUpdate = [userDefault objectForKey:kLastUpdateUser];
            
            //Settings
            NSDictionary *dictSettings = [dict objectForKey:@"setting"];
            if ([dictSettings isKindOfClass:[NSDictionary class]]) {
//                NSString *rangeShowAds = [dictSettings objectForKey:@"count"];
                int rangeShowAds = [[dictSettings objectForKey:@"count"] intValue];
                if (rangeShowAds %2 !=0) {
                    rangeShowAds++;
                }
                [userDefault setObject:[NSNumber numberWithInt:rangeShowAds] forKey:RangeShowAdsNo20];
                NSString *timeUpdated = [[dictSettings objectForKey:@"time_update"] stringValue];
                if (preUpdate != nil) {
                    if (![timeUpdated isEqualToString:preUpdate]) {
                        isUpdate = YES;
                        [userDefault setObject:timeUpdated forKey:kLastUpdateUser];
                    }
                }else{
                    [userDefault setObject:timeUpdated forKey:kLastUpdateUser];
                }
                
                
            }
            
            [userDefault synchronize];
            
            //Ads
            NSArray *arrAds = [dict objectForKey:@"advertisments"];
            NSMutableArray *listAds = [[NSMutableArray alloc] init];
            [arrAds enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                AdsE *adsE = [[AdsE alloc] init];
                [adsE parseData:dict];
                [listAds addObject:adsE];
            }];
            
            if (completion) {
                completion(isUpdate,listAds);
            }
            
            
        }else{
            if (completion) {
                completion(NO,nil);
            }
        }
    }];
}

+ (void) addActionWithAdsForKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger currentActionNum = [user integerForKey:key];
    currentActionNum++;
    [user setInteger:currentActionNum forKey:key];
}

+(void)adsAddImageParamWithId:(int) adsId onScreen:(NSString *)screen andAction: (NSString *)action andIsTop: (BOOL)isTop forAstrars:(BOOL) isAstrar{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *all = [[user dictionaryForKey:kAdsStatistics] mutableCopy];
    NSMutableDictionary *dic = [[all objectForKey:kImageAdsStatistics] mutableCopy];
    NSMutableDictionary *adsStatistic = [self getDictionaryWithKey:[NSString stringWithFormat:@"%d", adsId] fromDictionary:dic];
    NSMutableDictionary *screenDic = [self getDictionaryWithKey:screen fromDictionary:adsStatistic];
    NSString *position = @"Top";
    if (!isTop) {
        position = @"List";
    }
    NSMutableDictionary *positionDic = [self getDictionaryWithKey:position fromDictionary:screenDic];
    int count = 0;
    if ([positionDic objectForKey:action]) {
        count = [[positionDic objectForKey:action] intValue];
    }
    count++;

    NSNumber *ob = [NSNumber numberWithInt:count];
    [positionDic setObject:ob forKey:action];
    [screenDic setObject:positionDic forKey:position];
    [adsStatistic setObject:screenDic forKey:screen];
    [dic setObject:adsStatistic forKey:[NSString stringWithFormat:@"%d", adsId]];
    [all setObject:dic forKey:kImageAdsStatistics];
    [user setObject:all forKey:kAdsStatistics];
    
}

+(void)adsAddVideoParamWithId:(int) adsId onScreen:(NSString *)screen andAction: (NSString *)action andIsTop: (BOOL)isTop forAstrars:(BOOL) isAstrar{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *all;
    if (isAstrar) {
        all = [NSMutableDictionary dictionaryWithDictionary:[[AstrarsManager sharedManager] astrarsStatiscal]];
    } else {
        all = [[user dictionaryForKey:kAdsStatistics] mutableCopy];
    }
    NSMutableDictionary *dic = [[all objectForKey:kVideoAdsStatistics] mutableCopy];
    NSMutableDictionary *adsStatistic = [self getDictionaryWithKey:[NSString stringWithFormat:@"%d", adsId] fromDictionary:dic];
    NSMutableDictionary *screenDic = [self getDictionaryWithKey:screen fromDictionary:adsStatistic];
    NSString *position = @"Top";
    if (!isTop) {
        position = @"List";
    }
    NSMutableDictionary *positionDic = [self getDictionaryWithKey:position fromDictionary:screenDic];
    int count = 0;
    if ([positionDic objectForKey:action]) {
        count = [[positionDic objectForKey:action] intValue];
    }
    count++;
    //    [screenDic setValue:[NSNumber numberWithInt:count] forKey:action];
    NSNumber *ob = [NSNumber numberWithInt:count];
    [positionDic setObject:ob forKey:action];
    [screenDic setObject:positionDic forKey:position];
    [adsStatistic setObject:screenDic forKey:screen];
    if (isAstrar) {
        [[AstrarsManager sharedManager] addVideoStatiscal:@{[NSString stringWithFormat:@"%d", adsId]: adsStatistic}];
    } else {
        [dic setObject:adsStatistic forKey:[NSString stringWithFormat:@"%d", adsId]];
        [all setObject:dic forKey:kVideoAdsStatistics];
        [user setObject:all forKey:kAdsStatistics];
    }
    
    //    [user synchronize];
}

+(NSMutableDictionary *)getDictionaryWithKey:(NSString *)dicKey fromDictionary:(NSMutableDictionary *)dic{
    NSMutableDictionary *dictionary;
    if ([dic objectForKey:dicKey]) {
        dictionary = [[dic objectForKey:dicKey] mutableCopy];
    }else{
        dictionary = [[NSMutableDictionary alloc] init];
        [dic setObject:dictionary forKey:dicKey];
    }
    return dictionary;
}

+(UIFont *)getFontHiraProNW3WithSize:(float)size{
    return [UIFont fontWithName:@"HiraKakuProN-W3" size:size];
}
+(UIFont *)getFontHiraProNW6WithSize:(float)size{
    return [UIFont fontWithName:@"HiraKakuProN-W6" size:size];
}
+(UIFont *)getFontHiraProW3WithSize:(float)size{
    return [UIFont fontWithName:@"HiraKakuPro-W3" size:size];
}
+(UIFont *)getFontHiraProW6WithSize:(float)size{
    return [UIFont fontWithName:@"HiraKakuPro-W6" size:size];
}

+(NSString *)getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}
+(void) hideTabbar{
    [mainContainerVC.tabBar setHidden:YES];
}

+(void)setTitle:(NSString *)title forButton:(UIButton *)button{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateFocused];
    [button setTitle:title forState:UIControlStateSelected];
}

+(CGSize) sizeOfString:(NSString *) string withFont:(UIFont *)font{
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    return [string sizeWithAttributes: userAttributes];
}
#pragma mark - 1.1.8
+(NSAttributedString *)attributeStringForButtonShowLiked:(int)likeNumer{
    NSString *title = [NSString stringWithFormat:FVLocalized(@"button_show_user_liked", nil), likeNumer];
    UIFont *regularFont = [Util getFontHiraProNW3WithSize:(SCREEN_WIDTH == 414)?14:12.68];
    UIFont *boldFont = [UIFont fontWithName:@"Helvetica-Bold" size:(SCREEN_WIDTH == 414)?14:12.68];
    NSDictionary *attributes = @{NSFontAttributeName:regularFont,NSForegroundColorAttributeName : ColorWith(160, 160, 160, 1),};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title
                                                                                         attributes:attributes];
    [attributedString beginEditing];
    [attributedString addAttribute:NSFontAttributeName
                             value:boldFont
                             range:[title rangeOfString:[NSString stringWithFormat:@"%d", likeNumer]]];
    [attributedString endEditing];
    return attributedString;
}

+(NSAttributedString *)getAttributedStringFrom:(NSString *)text withFont:(UIFont *)font andLineSpacing:(float)spacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (spacing > 0) {
        [paragraphStyle setLineSpacing:spacing];
    }
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attString;
}

+(NSString *)convertIntToString:(int)intValue{
    return [NSString stringWithFormat:@"%d", intValue];
}
+(NSString *)convertFloatToString:(float)floatValue{
    return [NSString stringWithFormat:@"%f", floatValue];
}

+(int)getValueOfQueryforKey:(NSString *)key withQuery:(NSString *)query{
    int value = -1;
    if ([query rangeOfString:key].location != NSNotFound) {
        //Go to an article
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            if ([pair rangeOfString:key].location != NSNotFound) {
                NSArray *elements = [pair componentsSeparatedByString:@"="];
                NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                value = [val intValue];
                break;
            }
        }
    }
    return value;
}

+ (UIImage *) launchImage{
    NSString *launchImageName;
    if([UIScreen mainScreen].bounds.size.height > 667.0f) {
        launchImageName = @"LaunchImage-800-Portrait-736h"; // iphone6 plus
    }
    else if([UIScreen mainScreen].bounds.size.height > 568.0f) {
        launchImageName = @"LaunchImage-800-667h"; // iphone6
    }
    else if([UIScreen mainScreen].bounds.size.height > 480.0f){
        launchImageName = @"LaunchImage-700-568h";// iphone5/5plus
    } else {
        launchImageName = @"LaunchImage-700"; // iphone4 or below
    }
    UIImage *launchImage = [UIImage imageNamed:launchImageName];
    return launchImage;
}

+ (NSString *)adsVideoTypeRawValue:(AdsVideoType) type {
    switch (type) {
        case AdsVideoTypeA:
            return @"Type A";
            break;
        case AdsVideoTypeB:
            return @"Type B";
            break;
        case AdsVideoTypeC:
            return @"Type C";
            break;
        default:
            return @"";
            break;
    }
}

+ (AdsVideoType)adsVideoTypeFrom:(NSString *) string {
    if ([string isEqualToString: @"Type A"]) {
        return AdsVideoTypeA;
    } else if ([string isEqualToString: @"Type B"]) {
        return AdsVideoTypeB;
    } else if ([string isEqualToString: @"Type C"]) {
        return AdsVideoTypeC;
    }
    
    return AdsVideoUndefined;
}

+ (NSString *)localized: (NSString *) key commend: (NSString *)commend {
//    NSString *lang = [[LanguageOption sharedInstance] code];
//    if (!lang) {
//        lang = @"ja";
//    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
//    NSBundle *bundle = [[NSBundle alloc] initWithPath:path];
//    return NSLocalizedStringWithDefaultValue(key, nil, bundle, @"", @"");
    return NSLocalizedString(key, comment);
}

#pragma mark: - 1.1.9
+ (BOOL) willShowTerm {
    if (!ENABLE_ASTRARS) {
        return NO;
    }
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:kAstrarsCount];
    BOOL show = [[NSUserDefaults standardUserDefaults] boolForKey:kDidShowTerm];
    BOOL isJapanses = [self isJapanese];
    return (count >= 3 && !show && isJapanses);
}

#pragma mark: 1.1.9
+(CGFloat) stringWidth:(NSString *) text andFont:(UIFont *) font{
    return [text sizeWithAttributes:@{NSFontAttributeName: font}].width;
}

#pragma mark: 1.2.0
+ (BOOL)isKatakana:(unichar)c
{
    /*
     * Unicode for Katakana 0x30a0-0x30ff, but we exclude some uncommon characters
     */
    return c >= 0x30a1 && c <= 0x30f6;
}

+ (BOOL)isHiragana:(unichar)c
{
    /*
     * Unicode for Hiragana 0x3040-0x309f, but we exclude some uncommon characters and some unassigned values
     */
    return c >= 0x3041 && c <= 0x3096;
}

+ (BOOL)isKana:(unichar)c
{
    return [self isKatakana:c] || [self isHiragana:c];
}

+ (BOOL)isKanji:(unichar)c
{
    /*
     * Unicode for unified CJK ideographs 0x4e00-0x9faf
     */
    return c >= 0x4e00 && c <= 0x9faf;
}

+ (NSString *)toHalfSize:(NSString *) fullSize{
    CFMutableStringRef text = (__bridge CFMutableStringRef)[NSMutableString stringWithString:fullSize];
    CFStringTransform(text, nil, kCFStringTransformFullwidthHalfwidth, NO);
    return (__bridge NSString *)text;
}

+ (NSString *)toFullSize:(NSString *) halfSize{
    CFMutableStringRef text = (__bridge CFMutableStringRef)[NSMutableString stringWithString:halfSize];
    CFStringTransform(text, nil, kCFStringTransformFullwidthHalfwidth, YES);
    return (__bridge NSString *)text;
}

+ (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}

@end
