//
//  LanguageOption.m
//  Favor
//
//  Created by DUCDM on 9/23/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import "LanguageOption.h"

@implementation LanguageOption

static LanguageOption *_sharedInstance;

+ (instancetype)sharedInstance {
    if (!_sharedInstance) {
        _sharedInstance = [[LanguageOption alloc] init];
    }
    return _sharedInstance;
}

+(instancetype) instance{
    return [[LanguageOption alloc] init];
}

+(instancetype) japanese {
    return [[LanguageOption alloc] initWithName:@"日本語" andCode:@"ja" andType:FVLanguageJapanese];
}

+(instancetype) chineseSimple {
    return [[LanguageOption alloc] initWithName:@"简体中文" andCode:@"zh-Hans" andType:FVLanguageChineseSimplied];
}

+(instancetype) chineseTraditional {
    return [[LanguageOption alloc] initWithName:@"繁體中文" andCode:@"zh-Hant" andType:FVLanguageChineseTraditional];
}

+(instancetype) thai {
    return [[LanguageOption alloc] initWithName:@"ไทย" andCode:@"th" andType:FVLanguageThaiLand];
}

-(instancetype) initWithName: (NSString *)name andCode: (NSString *)code andType:(FVLanguage)type{
    self = [super init];
    if (self) {
        self.name = name;
        self.code = code;
//        self.locale = locale;
        self.type = type;
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_code forKey:@"code"];
//    [coder encodeObject:_locale forKey:@"locale"];
    [coder encodeInteger:_type forKey:@"type"];
}

- (id) initWithCoder:(NSCoder *)coder {
    self = [[LanguageOption alloc] init];
    if (self = [super init]) {
        _name = [coder decodeObjectForKey:@"name"];
        _code = [coder decodeObjectForKey:@"code"];
//        _locale = [coder decodeObjectForKey:@"locale"];
        _type = (FVLanguage)[coder decodeIntegerForKey:@"type"];
    }
    return self;
}

- (NSString *) locale {
    NSMutableString *locale = [NSMutableString string];
    switch (self.type) {
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

@end
