//
//  Util.h
//  Favor
//
//  Created by vudinhthuy on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleComment.h"
#import "ReplyComment.h"
#import "Common.h"
@interface Util : NSObject

+(void) showBoxForView:(UIView *) view;
+(float) heightOfString:(UILabel *) label;
+(float) widthOfString:(UILabel *) label;
+(void) showAlertViewWithTitle:(NSString *)title withMessage: (NSString *)message andTag:(NSInteger) tag;
+(UIImage*) sketchFromImage:(NSString*) skinName withCapWidth:(NSInteger) capWidth withCapHeight:(NSInteger) capHeight;
+(void) blockView;
+(void) unblockView;
+(void) blockViewInview:(UIView *)view;
+(void) unblockViewInView:(UIView *)view;
+ (NSString *) platformString;
+(NSString *) pathOfFileInDocs:(NSString *) filename folder:(NSString *) folder;
+(void) clearFolderInDocs:(NSString *) folder;
+(BOOL) hasInternet;
+(CGFloat) onePixel;
+ (void) sendGAIScreen:(NSString *)screenName;
+ (void) sendGAIAction:(NSString *)category andAction:(NSString *)eventAction andLabel:(NSString *)label;
+(void)setValueForButton:(UIButton *)sender withComment:(ArticleComment *)comment;
+(NSString *) stringValueForKey:(NSString *) key fromDict:(NSDictionary *) dict;
+(int) intValueForKey:(NSString *) key fromDict:(NSDictionary *) dict;
+(void) checkNotificationCount:(void (^)(BOOL haveNew, NSString *lastTime)) completion;
+(float) heightOfLabel:(NSString *) text andFontSize: (float)size andWidth:(float)width;
+(float) heightOfLabel:(NSString *) text andFont:(UIFont *)font andWidth:(float)width andLineSpacing: (CGFloat) lineSpacing;
+(float) getReplyCellHeigtWithReplyComment: (ReplyComment *)reply WithFullComment:(BOOL)isFull;
+(float) getReplyTableHeightWithReplies: (NSArray *)replies withFullComment:(BOOL) isFull;
+(float) getCommentCellHeightWithComment: (ArticleComment *) comment widthFullComment:(BOOL) isFull;
+(NSDate *)convertStringToDate:(NSString *)string;
+(NSString *)convertDateToString:(NSDate *)date;
+(NSString *)shareMessageWithTitle:(NSString *) title andSubTitle: (NSString *)subTitle;
+(void)setArticleImage:(UIImageView *)imgView WithURL:(NSString *)url andPlaceHolderImage:(UIImage *)placeholderImage andHandler: (void (^)(BOOL finished, UIImage *image)) completion;
+(void)setLikeButton:(UIButton *) button withLike: (BOOL)isLike andLikeNumber:(int)number;
+(NSMutableAttributedString *)getAttributedStringFrom:(NSString *)text withFontName:(NSString *)fontName size:(float) size andLineSpacing:(float)spacing;
+(void)sendLikeArticleNotificationWith:(int)likeCount andIsLike:(BOOL)isLiked forArticle:(int)articleId;
+(void) changeIndexInArray:(NSMutableArray *)array fromIndex:(int) startIndex toIndex:(int) endIndex;
+(void)sendReloadNotificationWith:(int)notiId;
+(void)setBottomBarHeightfor:(UIView *)bottomBar withLine:(UIImageView *)line;
+(float)getBotomBarHeight;
+(NSString *)shareMessageWith:(NSString *)body andTag:(NSString *)tagString;
+(NSString *)getLocale;
+(void)fitSizeButton:(UIButton *)button;
+(void)settingForBtnPostOrComment:(UIButton *)button withTitle:(NSString *)title;
//+ (void) getAdsWriterWithCompletion:(void (^) (BOOL isUpdate, NSArray *listAds))completion;
+ (void) getAdsUserWithCompletion:(void (^) (BOOL isUpdate, NSArray *listAds))completion;
+(NSMutableAttributedString *)getAttributedStringFrom:(NSString *)text withFontName:(NSString *)fontName size:(float) size andLineSpacing:(float)spacing andColor:(UIColor *)color;
+ (void) addActionWithAdsForKey:(NSString *)key;
+(void)adsAddImageParamWithId:(int) adsId onScreen:(NSString *)screen andAction: (NSString *)action andIsTop: (BOOL)isTop forAstrars:(BOOL) isAstrar;
+(void)adsAddVideoParamWithId:(int) adsId onScreen:(NSString *)screen andAction: (NSString *)action andIsTop: (BOOL)isTop forAstrars:(BOOL) isAstrar;
+(NSMutableDictionary *)getDictionaryWithKey:(NSString *)dicKey fromDictionary:(NSMutableDictionary *)dic;
+(UIFont *)getFontHiraProNW3WithSize:(float)size;
+(UIFont *)getFontHiraProNW6WithSize:(float)size;
+(UIFont *)getFontHiraProW3WithSize:(float)size;
/**
 *  Get custom font Hiragino Pro W6 with size
 *
 *  @param size float
 *
 *  @return UIFont
 */
+(UIFont *)getFontHiraProW6WithSize:(float)size;
/**
 *  Get current App version
 *
 *  @return NSString
 */
+(NSString *)getAppVersion;
/**
 *  Hide bototm tabbar
 */
+(void) hideTabbar;
/**
 *  Set title of UIButton at three state : normal, focuced and selected
 *
 *  @param title  NSString
 *  @param button UIButton
 */
+(void)setTitle:(NSString *)title forButton:(UIButton *)button;
/**
 *  Get size of NSString depend font
 *
 *  @param string NSString
 *  @param font   UIFont
 *
 *  @return CGSize size of string with font
 */
+(CGSize) sizeOfString:(NSString *) string withFont:(UIFont *)font;
/**
 *  Attribute string for button show number user were liked article
 *
 *  @param likeNumer int
 *
 *  @return NSAttributedString
 */
+(NSAttributedString *)attributeStringForButtonShowLiked:(int)likeNumer;
/**
 *  Attribute string with font and line space from input
 *
 *  @param text    NSString
 *  @param font    UIFont
 *  @param spacing float
 *
 *  @return NSAttributedString
 */
+(NSAttributedString *)getAttributedStringFrom:(NSString *)text withFont:(UIFont *)font andLineSpacing:(float)spacing;
/**
 *  Convert int format to NSString format
 *
 *  @param intValue int
 *
 *  @return NSString
 */
+(NSString *)convertIntToString:(int)intValue;
/**
 *  Convert float format to NSString format
 *
 *  @param floatValue float
 *
 *  @return NSString
 */
+(NSString *)convertFloatToString:(float)floatValue;
/**
 *  get float value from NSDictionary with key
 *
 *  @param key NSString
 *  @param dict NSDictionary
 *
 *  @return float
 */
+(float) floatValueForKey:(NSString *) key fromDict:(NSDictionary *) dict;
+(int)getValueOfQueryforKey:(NSString *)key withQuery:(NSString *)query;
+ (void) getAdsTimeLinesWithCompletion:(void (^) (BOOL isUpdate, NSDictionary *timeLineAds))completion;
+ (UIImage *) launchImage;
+ (AdsVideoType)adsVideoTypeFrom:(NSString *) string;
+ (BOOL) isJapanese;
+ (NSString *)localized: (NSString *) key commend: (NSString *)commend;
+ (BOOL) willShowTerm;
+(CGFloat) stringWidth:(NSString *) text andFont:(UIFont *) font;
#pragma mark: 1.2.0
+ (BOOL)isKatakana:(unichar)c;
+ (BOOL)isHiragana:(unichar)c;
+ (BOOL)isKana:(unichar)c;
+ (BOOL)isKanji:(unichar)c;
+ (BOOL)isAlphabet:(unichar)c;
+ (FVLanguage) settingLanguage;
+ (NSString *)toHalfSize:(NSString *) fullSize;
+ (NSString *)toFullSize:(NSString *) halfSize;
+ (NSString *)extractYoutubeIdFromLink:(NSString *)link;
@end
