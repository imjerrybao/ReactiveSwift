//
//  UITextField+RACSignalSupport.m
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 4/17/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "UITextField+RACSignalSupport.h"
#import "EXTScope.h"
#import "NSObject+RACDeallocating.h"
#import "RACSignal+Operations.h"
#import "UIControl+RACSignalSupport.h"
#import "NSObject+RACDescription.h"

@implementation UITextField (RACSignalSupport)

- (RACSignal *)rac_textSignal {
	@weakify(self);
	return [[[[[RACSignal
		defer:^{
			@strongify(self);
			return [RACSignal return:self];
		}]
		concat:[self rac_signalForControlEvents:UIControlEventEditingChanged]]
		map:^(UITextField *x) {
			return x.text;
		}]
		takeUntil:self.rac_willDeallocSignal]
		setNameWithFormat:@"%@ -rac_textSignal", [self rac_description]];
}

@end
