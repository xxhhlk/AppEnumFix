Jailbreak tweak to patch CVE-2025-31207, a bug that allows sandboxed applications to enumerate a user's installed apps.

[Patched by Apple in iOS 18.5](https://support.apple.com/en-us/122404)
- [22F5053j / iOS 18.5 Beta 3 diff](https://github.com/blacktop/ipsw-diffs/blob/main/18_5_22F5053f__vs_18_5_22F5053j/DYLIBS/FrontBoard.md)

## iOS 13 support

This fork also runs on iOS 13. On those older systems the private method takes a
`forApplication:` argument instead of `forBundleInfo:`, so both spellings are hooked
and the deployment target is lowered to 13.0.
