//
//  NetworkManager.m
//  Favor
//
//  Created by Tinhvv on 10/5/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "NetworkManager.h"
#import "LanguageOption.h"
#define API_USERNAME @"papelook"
#define API_PASSWORD @"pape0321ozawa"
@implementation NetworkManager
+ (instancetype)sharedManager {
    static NetworkManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        NSString *baseURL = @"http://api.favor.life";
        
        if (SERVER_TYPE == TEST_SERVER) {
            baseURL = @"http://rikkei.org:8888";
        }else if (SERVER_TYPE == DEV_SERVER){
            baseURL = @"http://api.dev.favor.life";
        }else if(SERVER_TYPE == STG_SERVER){
            baseURL = @"http://api.stg.favor.life";
        }else if (SERVER_TYPE == LOCAL_SERVER){
            baseURL = @"http://192.168.11.91:4000";
        }
        _sharedClient = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
//        self.requestSerializer.timeoutInterval = TIME_OUT;
        // Add missing accept content types
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"text/html"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"text/html"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
        //
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"text/plain"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"text/plain"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
//        if (![self.responseSerializer.acceptableContentTypes containsObject:@"text/plain"]) {
//            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
//            [acceptableTypes addObject:@"text/plain"];
//            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
//        }
        
        self.credential = [NSURLCredential credentialWithUser:API_USERNAME password:API_PASSWORD persistence:NSURLCredentialPersistenceForSession];
    }
    return self;
}

#pragma mark - Base functions

- (void)callWebserviceWithPath:(NSString *)path
                        method:(NSString *)method
                    parameters:(NSDictionary *)parameters
                    completion:(void (^) (ResponseObject *responseObject))completion {
    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path];
    
    if (request) {
        AFHTTPRequestOperation *operation  =  [self operationForRequest:request completion:completion];
        if (operation != nil) {
            [[NetworkManager sharedManager].operationQueue addOperation:operation];
        }
    }
}

- (void)callWebserviceWithPath:(NSString *)path
                        method:(NSString *)method
                    parameters:(NSDictionary *)parameters
                     filesData:(NSArray *)filesData
                     fileNames:(NSArray *)fileNames
          fileDescriptionNames:(NSArray *)descriptionNames
                    completion:(void (^) (ResponseObject *responseObject))completion {
    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path filesData:filesData fileNames:fileNames fileDescriptionNames:descriptionNames];
    if (request) {
        AFHTTPRequestOperation *operation  =  [self operationForRequest:request completion:completion];
        if (operation != nil) {
            [[NetworkManager sharedManager].operationQueue addOperation:operation];
        }
    }
}

/**
 Create request for special method, parameters and path
 @param method The HTTP method for the request
 @param parameters The parameters that will be include to the request
 @param path The url for the request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                      path:(NSString *)path {
    // 1
    NSError *error;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters
                                                                       error:&error];
    
    
    
    return request;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters path:(NSString *)path filesData:(NSArray *)filesData fileNames:(NSArray *)fileNames fileDescriptionNames:(NSArray *)descriptionNames {
    // 1
    NSError *error;
    NSMutableURLRequest *request = nil;
    
    if (filesData != nil) { // Request with data file
        if (filesData.count != fileNames.count || fileNames.count != descriptionNames.count || descriptionNames.count != filesData.count) {
            return nil;
        }
        request = [self.requestSerializer multipartFormRequestWithMethod:method
                                                               URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                              parameters:parameters
                                               constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
                                                   for (int i = 0; i < filesData.count; i++) {
                                                       double timeStamp = [NSDate new].timeIntervalSince1970;
                                                       NSString *fileName = [NSString stringWithFormat:@"%@-%ld-%f.jpg", [descriptionNames objectAtIndex:i], (long)favorUser.userId, timeStamp];
                                                       [formData appendPartWithFileData:[filesData objectAtIndex:i]
                                                                                   name:[fileNames objectAtIndex:i]
                                                                               fileName:fileName
                                                                               mimeType:@"image/jpeg"];
                                                   }
                                               }
                                                                   error:&error];
    }
    else { // Normal request
        [self.requestSerializer requestWithMethod:method
                                        URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                       parameters:parameters
                                            error:&error];
    }
    
    
    return request;
}

/**
 
 */
- (AFHTTPRequestOperation *)operationForRequest:(NSMutableURLRequest *)request completion:(void (^) (ResponseObject *responseObject))completion {
    if (request == nil) {
        abort();
    }
    return [self HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseObject *responseObj = [ResponseObject responseObjectWithRequestOperation:operation error:nil];
        if (completion) {
            completion(responseObj);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        ResponseObject *responseObj = [ResponseObject responseObjectWithRequestOperation:operation error:error];
        if (completion) {
            completion(responseObj);
        }
    }];
}

-(NSDictionary *) prepareParams:(NSDictionary *) input{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (input) {
        [params addEntriesFromDictionary:input];
    }
    
    [params setObject:[Util getAppVersion] forKey:@"app_version"];
    [params setObject:CLIENT_TYPE forKey:@"client_type"];
//    [params setObject:@"97eb00b2-f10b-496d-b18e-5fcc413c9194" forKey:@"token"];
//    [params setObject:[NSNumber numberWithInteger:10328] forKey:@"user_id"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:FAVOR_USER_TOKEN]) {
        [params setObject:[user objectForKey:FAVOR_USER_TOKEN] forKey:@"token"];
    }
    
    if ([user objectForKey:FAVOR_USER_ID]) {
        [params setObject:[user objectForKey:FAVOR_USER_ID] forKey:@"user_id"];
    }
    
    if (![[input allKeys] containsObject:@"locale"]) {
        [params setObject:[Util getLocale] forKey:@"locale"];
    }
    [params setObject:[NSNumber numberWithInteger:[Util settingLanguage]]
               forKey:@"type_language"];
    return params;
}

- (void)updateUserProfile:(NSDictionary *)params avatar:(NSData *)avatarData completion:(void (^)(ResponseObject *))completion {
    
    NSMutableArray *paramData = @[].mutableCopy;
    NSMutableArray *paramNames = @[].mutableCopy;
    if (avatarData) {
        [paramData addObject:avatarData];
        [paramNames addObject:@"image"];
        
        [self callWebserviceWithPath:@"/users" method:@"POST" parameters:[self prepareParams:params] filesData:paramData fileNames:@[@"image"] fileDescriptionNames:paramNames completion:completion];
    }else{
        if (paramData.count == 0) {
            paramData = nil;
        }
        if (paramNames.count == 0) {
            paramNames = nil;
        }
        
        
        [self callWebserviceWithPath:@"/users" method:@"POST" parameters:[self prepareParams:params] completion:completion];
    }
    
    
}


- (void)commentArticleWithID:(NSInteger)articleID params:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion {
    
    NSMutableArray *paramData = @[].mutableCopy;
    NSMutableArray *paramNames = @[].mutableCopy;
    if (imageData) {
        [paramData addObject:imageData];
        [paramNames addObject:@"image"];
        [self callWebserviceWithPath:[NSString stringWithFormat:@"/articles/%li/add_comment", (long)articleID] method:@"POST" parameters:[self prepareParams:params] filesData:paramData fileNames:@[@"image"] fileDescriptionNames:paramNames completion:completion];
    }else{
        if (paramData.count == 0) {
            paramData = nil;
        }
        if (paramNames.count == 0) {
            paramNames = nil;
        }
        [self callWebserviceWithPath:[NSString stringWithFormat:@"/articles/%li/add_comment", (long)articleID] method:@"POST" parameters:[self prepareParams:params] completion:completion];
    }
    
}

- (void) replyCommentWithID:(NSInteger)commentID params:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion{
    NSMutableArray *paramData = @[].mutableCopy;
    NSMutableArray *paramNames = @[].mutableCopy;
    if (imageData) {
        [paramData addObject:imageData];
        [paramNames addObject:@"image"];
        [self callWebserviceWithPath:[NSString stringWithFormat:@"/comments/%ld/add_reply",(long)commentID] method:@"POST" parameters:[self prepareParams:params] filesData:paramData fileNames:@[@"image"] fileDescriptionNames:paramNames completion:completion];
    }else{
        if (paramData.count == 0) {
            paramData = nil;
        }
        if (paramNames.count == 0) {
            paramNames = nil;
        }
        [self callWebserviceWithPath:[NSString stringWithFormat:@"/comments/%ld/add_reply",(long)commentID] method:@"POST" parameters:[self prepareParams:params] completion:completion];
    }
    
}

- (void) userPostArticleWithParams:(NSDictionary *)params image:(NSData *)imageData isProduct:(BOOL)isProductrate completion:(void (^)(ResponseObject *))completion{
    NSMutableDictionary *newParams = params.mutableCopy;
    if (isProductrate) {
        [newParams setValue:[NSNumber numberWithInt:1] forKey:@"rate_product"];
    }
    NSMutableArray *paramData = @[].mutableCopy;
    NSMutableArray *paramNames = @[].mutableCopy;
    if (imageData) {
        [paramData addObject:imageData];
        [paramNames addObject:@"image"];
        [self callWebserviceWithPath:@"/articles" method:@"POST" parameters:[self prepareParams:newParams] filesData:paramData fileNames:@[@"image"] fileDescriptionNames:paramNames completion:completion];
    }else{
        if (paramData.count == 0) {
            paramData = nil;
        }
        if (paramNames.count == 0) {
            paramNames = nil;
        }
        [self callWebserviceWithPath:@"/articles" method:@"POST" parameters:[self prepareParams:newParams] completion:completion];
    }

}

- (void) userPostArticleWithParams:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion{
    
    [self userPostArticleWithParams:params image:imageData isProduct:NO completion:completion];
    /*
    NSMutableArray *paramData = @[].mutableCopy;
    NSMutableArray *paramNames = @[].mutableCopy;
    if (imageData) {
        [paramData addObject:imageData];
        [paramNames addObject:@"image"];
        [self callWebserviceWithPath:@"/articles" method:@"POST" parameters:[self prepareParams:params] filesData:paramData fileNames:@[@"image"] fileDescriptionNames:paramNames completion:completion];
    }else{
        if (paramData.count == 0) {
            paramData = nil;
        }
        if (paramNames.count == 0) {
            paramNames = nil;
        }
        [self callWebserviceWithPath:@"/articles" method:@"POST" parameters:[self prepareParams:params] completion:completion];
    }*/
    
}

- (void) sendAdsAnalytics:(NSString *)imageShow01
              imageShow20:(NSString *)imageShow20
            imageTapped01:(NSString *)imageTapped01
            imageTapped20:(NSString *)imageTapped20
              videoPlay01:(NSString *)videoPlay01
              videoPlay20:(NSString *)videoPlay20
            videoTapped01:(NSString *)videoTapped01
            videoTapped20:(NSString *)videoTapped20
              videoDone01:(NSString *)videoDone01
              videoDone20:(NSString *)videoDone20
         videoCompleted01:(NSString *)videoCompleted01
         videoCompleted20:(NSString *)videoCompleted20
               completion:(void (^)(ResponseObject *))completion{
    NSDictionary *params = @{@"image_show01":imageShow01,
                             @"image_show20":imageShow20,
                             @"image_tapped01":imageTapped01,
                             @"image_tapped20":imageTapped20,
                             @"video_play01":videoPlay01,
                             @"video_play20":videoPlay20,
                             @"video_tapped01":videoTapped01,
                             @"video_tapped20":videoTapped20,
                             @"video_done01":videoDone01,
                             @"video_done20":videoDone20,
                             @"video_completed01":videoCompleted01,
                             @"video_completed20":videoCompleted20
                             };
    [self callWebserviceWithPath:@"statiscal_app/statiscal" method:@"POST" parameters:[self prepareParams:params] completion:completion];
}

- (void) sendAdsAnalytics:(NSDictionary *)data
               completion:(void (^)(ResponseObject *))completion{
//    NSDictionary *params = @{@"AdsStatistic":data};
//    self.requestSerializer
    [self callWebserviceWithPath:@"statiscal_app/statiscal" method:@"POST" parameters:[self prepareParams:data] completion:completion];
}

- (void) sendAdsAstrarsAnalytics:(NSDictionary *)data
               completion:(void (^)(ResponseObject *))completion{
    //    NSDictionary *params = @{@"AdsStatistic":data};
    //    self.requestSerializer
    [self callWebserviceWithPath:@"astrars_statiscal/astrars_statiscal" method:@"POST" parameters:[self prepareParams:data] completion:completion];
}

@end
