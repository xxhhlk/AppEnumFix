#import <Foundation/Foundation.h>

// The bundle argument of this selector is spelled "forBundleInfo:" on recent
// systems and "forApplication:" on older ones; hook both.

static void SanitizeFatalError(NSError **fatalError) {
	if (!fatalError || !*fatalError) return;

	NSError *err = *fatalError;

	// if the system gave a Security error, swap it with a generic NotFound
	if ([err.domain isEqualToString:@"FBSOpenApplicationErrorDomain"] && err.code == 3) {
		*fatalError = [NSError errorWithDomain:err.domain code:4 userInfo:err.userInfo];
	}
}

%hook FBSystemService

-(BOOL)_isTrustedRequest:(id)request forCaller:(id)caller fromClient:(id)client forBundleInfo:(id)bundleInfo withOptions:(id)options fatalError:(NSError **)fatalError {
	BOOL result = %orig;
	SanitizeFatalError(fatalError);
	return result;
}

-(BOOL)_isTrustedRequest:(id)request forCaller:(id)caller fromClient:(id)client forApplication:(id)application withOptions:(id)options fatalError:(NSError **)fatalError {
	BOOL result = %orig;
	SanitizeFatalError(fatalError);
	return result;
}

%end
