//
//  LanguageOption.h
//  Favor
//
//  Created by DUCDM on 9/23/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageOption : NSObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
//@property (nonatomic, strong) NSString *locale;

@property (nonatomic, assign) FVLanguage type;
- (NSString *) locale;
+(instancetype) sharedInstance;
+(instancetype) instance;
+(instancetype) japanese;
+(instancetype) chineseSimple;
+(instancetype) chineseTraditional;
+(instancetype) thai;
//-(instancetype) initWithName: (NSString *)name andCode: (NSString *)code andLocale: (NSString *)locale andRegion: (FVLanguage) region;
-(instancetype) initWithName: (NSString *)name andCode: (NSString *)code andType:(FVLanguage)type;
@end
