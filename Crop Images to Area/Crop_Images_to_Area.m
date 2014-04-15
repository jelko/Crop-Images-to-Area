//
//  Crop_Images_to_Area.m
//  Crop Images to Area
//
//  Created by Jelko Arnds on 15.04.14.
//  Copyright (c) 2014 Jelko Arnds. All rights reserved.
//

#import "Crop_Images_to_Area.h"

@implementation Crop_Images_to_Area

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    for (NSString *path in input) {
        
        NSURL *url = [NSURL fileURLWithPath:path];
		
		if (!url) {
			[self logMessageWithLevel:AMLogLevelError format:@"The path '%@' is invalid", path];
			continue;
		}
        
        NSDictionary * mImageProperties;
        
        CGImageRef          image = NULL;
        CGImageSourceRef    isr = CGImageSourceCreateWithURL((__bridge CFURLRef) url, NULL);
        
        
        image = CGImageSourceCreateImageAtIndex(isr, 0, NULL);
        if (image)
        {
            mImageProperties = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(
                                                                                          isr, 0, (__bridge CFDictionaryRef)mImageProperties);
        }else{
            [self logMessageWithLevel:AMLogLevelError format:@"Image could not be opend."];
        }
        CFRelease(isr);
        CGRect rect = CGRectMake(
                                 [[[self parameters] objectForKey:@"x"] intValue],
                                 [[[self parameters] objectForKey:@"y"] intValue],
                                 [[[self parameters] objectForKey:@"width"] intValue],
                                 [[[self parameters] objectForKey:@"height"] intValue]
        );
        
        CGImageRef croped_image = CGImageCreateWithImageInRect(image, rect);
        
        if(!croped_image){
            [self logMessageWithLevel:AMLogLevelError format:@"Image could not be cropped. Check your dimensions."];
        }
        
        // NSURL * url = [NSURL fileURLWithPath: path];
        CGImageDestinationRef dest = CGImageDestinationCreateWithURL((__bridge CFURLRef)url,
                                                                     (CFStringRef)@"public.png", 1, NULL);
        if (dest)
        {
            CGImageDestinationAddImage(dest, croped_image, NULL);
            CGImageDestinationFinalize(dest);
            CFRelease(dest);
        }else{
            [self logMessageWithLevel:AMLogLevelError format:@"Image could not be saved."];
        }
        CGImageRelease(image );
        CGImageRelease(croped_image);
	
    }
    
	return input;
}

@end
