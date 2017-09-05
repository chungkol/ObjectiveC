//
//  ResponseObject.h
//  Favor
//
//  Created by Tinhvv on 10/5/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "JSONModel.h"
#import "AFHTTPRequestOperation.h"

@interface ResponseObject : JSONModel
@property (strong, nonatomic) id <Optional> responsePost;
@property (strong, nonatomic) id <Optional> responseComment;
@property (strong, nonatomic) id <Optional> responseUser;
@property (strong, nonatomic) NSString <Optional>* message;
@property (strong, nonatomic) NSNumber<Optional>* error;
@property (strong, nonatomic) NSNumber<Optional>* status;

+ (ResponseObject *)responseObjectWithRequestOperation:(AFHTTPRequestOperation *)operation
                                                   error:(NSError *)error;
@end
