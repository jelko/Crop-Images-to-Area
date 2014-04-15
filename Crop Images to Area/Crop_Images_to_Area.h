//
//  Crop_Images_to_Area.h
//  Crop Images to Area
//
//  Created by Jelko Arnds on 15.04.14.
//  Copyright (c) 2014 Jelko Arnds. All rights reserved.
//

#import <Automator/AMBundleAction.h>

@interface Crop_Images_to_Area : AMBundleAction

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
