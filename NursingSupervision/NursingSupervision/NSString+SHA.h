//
//  NSString+SHA.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/7/11.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString(SHA)
-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;

+(NSString*) sha256Uid;
@end
