//
//  RCTLocale.m
//  RCTLocale
//

#import "RCTLocale.h"
#import "RCTUtils.h"

@implementation RCTConvert (NSDateFormatterStyle)
RCT_ENUM_CONVERTER(NSDateFormatterStyle, (@{
                                            @"none": @(NSDateFormatterNoStyle),
                                            @"full": @(NSDateFormatterFullStyle),
                                            @"long": @(NSDateFormatterLongStyle),
                                            @"medium": @(NSDateFormatterMediumStyle),
                                            @"short": @(NSDateFormatterShortStyle),
                                            }), NSDateFormatterFullStyle, integerValue);
@end

@interface RCTLocale ()
@end

@implementation RCTLocale
RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(decimalStyle:(nonnull NSNumber *)myNumber
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve([NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterDecimalStyle]);
}

RCT_EXPORT_METHOD(currencyStyle:(nonnull NSNumber *)myNumber
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve([NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterCurrencyStyle]);
}

RCT_EXPORT_METHOD(percentStyle:(nonnull NSNumber *)myNumber
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve([NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterPercentStyle]);
}

RCT_EXPORT_METHOD(scientificStyle:(nonnull NSNumber *)myNumber
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve([NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterScientificStyle]);
}

RCT_EXPORT_METHOD(spelloutStyle:(nonnull NSNumber *)myNumber
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve([NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterSpellOutStyle]);
}

RCT_EXPORT_METHOD(numberFromDecimalString:(nonnull NSString *)inputString
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.lenient = YES;
    NSNumber *number = [numberFormatter numberFromString:inputString];
    if(number) {
        resolve(number);
    } else {
        reject(nil, nil, nil);
    }
}

RCT_EXPORT_METHOD(dateFormat:(nonnull NSDate *)date
                  dateStyle:(NSDateFormatterStyle)dateStyle
                  timeStyle:(NSDateFormatterStyle)timeStyle
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = dateStyle;
    dateFormatter.timeStyle = timeStyle;
    
    resolve([dateFormatter stringFromDate:date]);
}

- (NSDictionary *)constantsToExport
{
    
    NSLocale *locale = [NSLocale currentLocale];
    NSCalendar *cal = [locale objectForKey:NSLocaleCalendar];
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    NSString* timeZoneName = [timeZone localizedName:NSTimeZoneNameStyleStandard locale:[NSLocale currentLocale]];

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    NSMutableDictionary *formats = [[NSMutableDictionary alloc]initWithCapacity:4];
    [formats setObject:dateFormatter.dateFormat forKey:@"full"];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [formats setObject:dateFormatter.dateFormat forKey:@"long"];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [formats setObject:dateFormatter.dateFormat forKey:@"medium"];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    [formats setObject:dateFormatter.dateFormat forKey:@"short"];

    return @{
            @"localeIdentifier": [locale objectForKey:NSLocaleIdentifier],
            @"localeLanguageCode": [locale objectForKey:NSLocaleLanguageCode],
            @"countryCode": [locale objectForKey:NSLocaleCountryCode],
            @"calendar": cal.calendarIdentifier,
            @"usesMetricSystem": [locale objectForKey:NSLocaleUsesMetricSystem],
            @"measurementSystem": [locale objectForKey:NSLocaleMeasurementSystem],
            @"decimalSeparator": [locale objectForKey:NSLocaleDecimalSeparator],
            @"groupingSeparator": [locale objectForKey:NSLocaleGroupingSeparator],
            @"currencySymbol": [locale objectForKey:NSLocaleCurrencySymbol],
            @"currencyCode": [locale objectForKey:NSLocaleCurrencyCode],
            @"collatorIdentifier": [locale objectForKey:NSLocaleCollatorIdentifier],
            @"quotationBeginDelimiterKey": [locale objectForKey:NSLocaleQuotationBeginDelimiterKey],
            @"quotationEndDelimiterKey": [locale objectForKey:NSLocaleQuotationEndDelimiterKey],
            @"alternateQuotationBeginDelimiterKey": [locale objectForKey:NSLocaleAlternateQuotationBeginDelimiterKey],
            @"alternateQuotationEndDelimiterKey": [locale objectForKey:NSLocaleAlternateQuotationEndDelimiterKey],
            @"preferredLanguages": [NSLocale preferredLanguages],
            @"timeZoneName": timeZoneName,
            @"localeDateFormats": formats
   };
}
@end
