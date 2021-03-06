//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  6 2019 20:12:56).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSData;

@interface DVTCodeSignatureHash : NSObject
{
    unsigned int _digestAlgorithm;
    NSData *_cdHash;
}

@property(readonly) NSData *cdHash; // @synthesize cdHash=_cdHash;
@property(readonly) unsigned int digestAlgorithm; // @synthesize digestAlgorithm=_digestAlgorithm;
- (void).cxx_destruct;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)arg1;
- (id)description;
- (id)cdHashHexEncoded;
- (id)digestAlgorithmDescription;
- (id)initWithDigestAlgorithm:(unsigned int)arg1 cdHash:(id)arg2;

@end

