//
//  AESCrypt.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/12.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "AESCrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES128

#define DEF_KEY         @"sfsafasdfsafasff"
#define DEF_IV          @"phjlknslfdhksldf"

@implementation AESCrypt

+ (NSString *)encyptaes128:(NSString *)message
{
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSData *datakey = [DEF_KEY dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataIV = [DEF_IV dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *endata = [AESCrypt encryptData:data key:datakey iv:dataIV];
    NSString *string = [NSString base64StringFromData:endata length:[endata length]];
    
    return string;
}

+ (NSString *)decryptaes128:(NSString *)message
{
    NSData *data = [NSData base64DataFromString:message];
    NSData *datakey = [DEF_KEY dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataIV = [DEF_IV dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *endata = [AESCrypt decryptData:data key:datakey iv:dataIV];
    NSString *string = [[NSString alloc] initWithData:endata encoding:NSUTF8StringEncoding];
    
    return string;
}

+ (NSData*)encryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv;
{
    NSData* result = nil;
    
    // setup key
    unsigned char cKey[FBENCRYPT_KEY_SIZE];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
    
    // setup iv
    char cIv[FBENCRYPT_BLOCK_SIZE];
    bzero(cIv, FBENCRYPT_BLOCK_SIZE);
    if (iv) {
        [iv getBytes:cIv length:FBENCRYPT_BLOCK_SIZE];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          FBENCRYPT_ALGORITHM,
                                          kCCOptionPKCS7Padding,
                                          cKey,
                                          FBENCRYPT_KEY_SIZE,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[ERROR] failed to encrypt|CCCryptoStatus: %d", cryptStatus);
    }
    
    return result;
}

+ (NSData*)decryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv;
{
    NSData* result = nil;
    
    // setup key
    unsigned char cKey[FBENCRYPT_KEY_SIZE];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
    
    // setup iv
    char cIv[FBENCRYPT_BLOCK_SIZE];
    bzero(cIv, FBENCRYPT_BLOCK_SIZE);
    if (iv) {
        [iv getBytes:cIv length:FBENCRYPT_BLOCK_SIZE];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
    void *buffer = malloc(bufferSize);
    
    // do decrypt
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          FBENCRYPT_ALGORITHM,
                                          kCCOptionPKCS7Padding,
                                          cKey,
                                          FBENCRYPT_KEY_SIZE,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[ERROR] failed to decrypt| CCCryptoStatus: %d", cryptStatus);
    }
    
    return result;
}

@end
