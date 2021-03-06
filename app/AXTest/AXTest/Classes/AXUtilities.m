#import "AXUtilities.h"

@implementation AXUtilities

+ (NSArray*) attributeNamesOfUIElement:(AXUIElementRef)element
{
  if (! element) return nil;

  CFArrayRef attrNames = NULL;

  AXUIElementCopyAttributeNames(element, &attrNames);
  if (! attrNames) return nil;

  return (__bridge_transfer NSArray*)(attrNames);
}

+ (id) valueOfAttribute:(NSString*)attribute ofUIElement:(AXUIElementRef)element
{
  if (! attribute) return nil;
  if (! element) return nil;

  NSArray* attributeNames = [AXUtilities attributeNamesOfUIElement:element];

  if (! attributeNames) return nil;
  if ([attributeNames indexOfObject:attribute] == NSNotFound) return nil;

  CFTypeRef result = NULL;
  if (AXUIElementCopyAttributeValue(element, (__bridge CFStringRef)(attribute), &result) != kAXErrorSuccess) {
    return nil;
  }
  if (! result) return nil;

  return (__bridge_transfer id)(result);
}

+ (NSString*) titleOfUIElement:(AXUIElementRef)element
{
  if (! element) return nil;
  return (NSString*)[AXUtilities valueOfAttribute:NSAccessibilityTitleAttribute ofUIElement:element];
}

+ (NSString*) roleOfUIElement:(AXUIElementRef)element
{
  if (! element) return nil;
  return (NSString*)[AXUtilities valueOfAttribute:NSAccessibilityRoleAttribute ofUIElement:element];
}

@end
