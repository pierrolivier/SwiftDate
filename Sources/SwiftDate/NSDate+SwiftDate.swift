//
//	SwiftDate, an handy tool to manage date and timezones in swift
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation

/// Extension for initialisation

// swiftlint:disable file_length
extension NSDate {

    /// Initialise a `NSDate` object from a number of date properties.
    /// Parameters are kind of fuzzy; they can overlap functionality and can contradict eachother.
    /// In such a case the parameter highest in the parameter list below has priority. All
    /// parameters but `fromDate` are optional.
    ///
    /// Use this initialiser if you have a source date from which to copy the properties.
    ///
    /// - Parameters:
    /// - fromDate: DateInRegion,
    /// - era: era to set (optional)
    /// - year: year number  to set (optional)
    /// - month: month number to set (optional)
    /// - day: day number to set (optional)
    /// - hour: hour number to set (optional)
    /// - minute: minute number to set (optional)
    /// - second: second number to set (optional)
    /// - nanosecond: nanosecond number to set (optional)
    /// - region: region to set (optional)
    ///
    public convenience init(
        fromDate: NSDate, era: Int? = nil, year: Int? = nil, month: Int? = nil, day: Int? = nil,
        hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil,
        region: Region? = nil) {

            let dateInRegion = DateInRegion(fromDate: fromDate.inRegion(region: region), era: era,
                year: year, month: month, day: day, hour: hour, minute: minute, second: second,
                nanosecond: nanosecond, region: region)
            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
    }

    public convenience init(
        era: Int? = nil, year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil,
        second: Int? = nil, nanosecond: Int? = nil, calendarID: String = "",
        timeZoneID: String = "", localeID: String = "", region: Region? = nil) {

            let dateInRegion = DateInRegion(era: era, year: year, month: month, day: day,
                hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: region)

            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
    }


    public convenience init(
        era: Int? = nil, yearForWeekOfYear: Int, weekOfYear: Int, weekday: Int, hour: Int? = nil,
        minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, calendarID: String = "",
        timeZoneID: String = "", localeID: String = "", region: Region? = nil) {

            let dateInRegion = DateInRegion(era: era, yearForWeekOfYear: yearForWeekOfYear,
                weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute,
                second: second, nanosecond: nanosecond, region: region)

            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
    }
    
    public convenience init(
        fromJulianDay: Double, region: Region? = nil) {
        
            let dateInRegion = DateInRegion(fromJulianDay: fromJulianDay, region: region)
            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
    }

    public convenience init(
        fromModifiedJulianDay: Double, region: Region? = nil) {
        
        let dateInRegion = DateInRegion(fromModifiedJulianDay: fromModifiedJulianDay, region: region)
        self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
    }
    
    public convenience init(components: NSDateComponents) {
        let dateInRegion = DateInRegion(components)
        let absoluteTime = dateInRegion.absoluteTime
        self.init(timeIntervalSinceReferenceDate: absoluteTime!.timeIntervalSinceReferenceDate)
    }

    //// Initialize a new NSDate instance by passing components in a dictionary.
    //// Each key of the component must be an NSCalendarUnit type. All values are supported.
    ///
    //// - parameter dateComponentDictionary: paramters dictionary, each key must be an
    ///     NSCalendarUnit
    ///
    /// - remark: deprecated! You should init(components) or init(year:month: etc) instead
    ///
    @available(*, deprecated: 3.0.5, message: "Use init(components) or init(year:month: etc) instead")
    public convenience init?(dateComponentDictionary: DateComponentDictionary) {

        let absoluteTime = dateComponentDictionary.absoluteTime()
        guard absoluteTime != nil else { return nil }
        self.init(timeIntervalSinceReferenceDate: absoluteTime!.timeIntervalSinceReferenceDate)
    }

    /// Initialize a new NSDate instance by taking initial components from date object and setting
    /// only specified components if != nil
    //
    /// - parameter date: reference date
    /// - parameter era: era to set (nil to ignore)
    /// - parameter year: year to set  (nil to ignore)
    /// - parameter month: month to set  (nil to ignore)
    /// - parameter day: day to set  (nil to ignore)
    /// - parameter yearForWeekOfYear: yearForWeekOfYear to set  (nil to ignore)
    /// - parameter weekOfYear: weekOfYear to set  (nil to ignore)
    /// - parameter weekday: weekday to set  (nil to ignore)
    /// - parameter hour: hour to set  (nil to ignore)
    /// - parameter minute: minute to set  (nil to ignore)
    /// - parameter second: second to set  (nil to ignore)
    /// - parameter nanosecond: nanosecond to set  (nil to ignore)
    /// - parameter region: region to set (if not specified Region.defaultRegion will be used instead
    ///
 //   @available(*, renamed: "init(fromDate, ...)")
    public convenience init(refDate date: NSDate, era: Int? = nil, year: Int? = nil,
        month: Int? = nil, day: Int? = nil, yearForWeekOfYear: Int? = nil, weekOfYear: Int? = nil,
        weekday: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil,
        nanosecond: Int? = nil, region: Region? = nil) {

            self.init(fromDate: date, era: era, year: year, month: month, day: day, hour: hour,
                minute: minute, second: second, nanosecond: nanosecond, region: region)
    }

    /// Create a new DateInRegion object. It will represent an absolute time expressed in a
    /// particular world region.
    ///
    /// - parameter region: region to associate. If not specified defaultRegion() will be used
    ///         instead. Use Region.setDefaultRegion() to define a default region for your
    ///         application.
    //
    /// - returns: a new DateInRegion instance representing this date in specified region. You can
    ///     query for each component and it will be returned taking care of the region components
    ///     specified.
    ///
    // Unknown why swiftlint warns here...
    // swiftlint:disable:next valid_docs
    public func inRegion(region: Region? = nil) -> DateInRegion {
        let dateInRegion = DateInRegion(absoluteTime: self, region: region)
        return dateInRegion
    }

    /**
     This is a shortcut to express the date into the default region of the app.
     You can specify a default region by calling Region.setDefaultRegion(). By default default
     region for you app is Gregorian Calendar/UTC TimeZone and current locale.

     - returns: a new DateInRegion instance representing this date in default region
     */
    public func inDefaultRegion() -> DateInRegion {
        return self.inRegion()
    }

    /**
     Create a new date from self by adding specified component values. All values are optional.
     Date still remain expressed in UTC.

     - parameter years: years to add
     - parameter months: months to add
     - parameter weeks: week of year to add
     - parameter days: days to add
     - parameter hours: hours to add
     - parameter minutes: minutes to add
     - parameter seconds: seconds to add
     - parameter nanoseconds: nanoseconds to add

     - returns: a new absolute time from self plus passed components
     */
    public func add(years: Int? = nil, months: Int? = nil, weeks: Int? = nil,
        days: Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil,
        nanoseconds: Int? = nil) -> NSDate {

            let date = self.inRegion()
            let newDate = date.add(years: years, months: months, weeks: weeks, days: days,
                hours: hours, minutes: minutes, seconds: seconds, nanoseconds: nanoseconds)
            return newDate.absoluteTime
    }

    /**
     Add components to the current absolute time by passing an NSDateComponents intance

     - parameter components: components to add

     - returns: a new absolute time from self plus passed components
     */
    public func add(components: NSDateComponents) -> NSDate {
        let date = self.inRegion().add(components)
        return date.absoluteTime
    }

    /**
     Add components to the current absolute time by passing NSCalendarUnit dictionary

     - parameter params: dictionary of NSCalendarUnit components

     - returns: a new absolute time from self plus passed components dictionary
     */
    @available(*, deprecated: 3.0.5, message: "Use add(components) or + instead")
    public func add(params: [NSCalendar.Unit : AnyObject]) -> NSDate {
        let date = self.inRegion().add(components: params)
        return date.absoluteTime
    }

    /**
     Diffenence between the receiver and toDate for the units provided

     - parameters:
     - toDate: date to calculate the difference with
     - unitFlags: calendar component flags to express the difference in

     - returns: date components with the difference calculated, `nil` on error
     */
    public func difference(toDate: NSDate, unitFlags: NSCalendar.Unit) -> NSDateComponents {
        return self.inRegion().difference(toDate: toDate.inRegion(), unitFlags: unitFlags)
    }

    /**
     Get the NSDateComponents from passed absolute time by converting it into specified region
     timezone

     - parameter inRegion: region of destination

     - returns: date components
     */
    public func components(inRegion region: Region? = nil) -> NSDateComponents {
        return self.inRegion(region: region).components
    }

    /// The same of calling components() without specify a region: current region is used instead
    public var components: NSDateComponents {
        get {
            return components()
        }
    }

    /**
     Takes a date unit and returns a date at the start of that unit.

     - parameter unit: unit
     - parameter region: region of the date

     - returns: the date representing that start of that unit
     */
    public func startOf(unit: NSCalendar.Unit, inRegion region: Region? = nil) -> NSDate {
        return self.inRegion(region: region).startOf(unit: unit).absoluteTime
    }

    /**
     Takes a date unit and returns a date at the end of that unit.

     - parameter unit: unit
     - parameter region: region of the date

     - returns: the date representing that end of that unit
     */
    public func endOf(unit: NSCalendar.Unit, inRegion region: Region? = nil) -> NSDate {
        return self.inRegion(region: region).endOf(unit: unit).absoluteTime
    }


    /**
     Return the string representation the date in specified region

     - parameter format: format of date
     - parameter region: region of destination (Region.defaultRegion is used when argument is not specified)

     - returns: string representation of the date into the region
     */
    public func toString(format: DateFormat, inRegion region: Region? = nil) -> String? {
        return self.inRegion(region: region).toString(format)
    }

    /**
     Convert a DateInRegion date into a date with date & time style specific format style

     - parameter style: style to format both date and time (if you specify this you don't need to
     specify dateStyle,timeStyle)
     - parameter dateStyle: style to format the date
     - parameter timeStyle: style to format the time
     - parameter inRegion: region in which you want to represent self absolute time
     - parameter relative: indication whether or not this is a relative time

     - returns: a new string which represent the date expressed into the current region or nil if
     egion does not contain valid date
     */
    public func toString(
        style: DateFormatter.Style? = nil, dateStyle: DateFormatter.Style? = nil,
        timeStyle: DateFormatter.Style? = nil, inRegion region: Region? = nil,
        relative: Bool = false) -> String? {

            let refDateInRegion = DateInRegion(absoluteTime: self, region: region)
            return refDateInRegion.toString(style, dateStyle: dateStyle, timeStyle: timeStyle,
                relative: relative)
    }

	/**
	Return a string representation of the interval between self date and a reference date.
	You can specify a style of the output: the first group (`.Positional`, `.Abbreviated`,
    `.Short`, `.Full`) will print
	single non-zero time unit components. `.Colloquial` can be used to print a more natural
    version of the difference.
	If you need to apply more control upon the formatter you can use `DateFormatter` class directly.

     - parameters:
        - fromDate: reference date in absolute time
        - inRegion: region for which to format the output string

	- returns: string representation of the difference between self and a reference date
	*/
	public func toString(fromDate: NSDate? = nil, inRegion region: Region? = nil,
        style: DateFormatterComponentsStyle) -> String? {
		let selfInRegion = DateInRegion(absoluteTime: self, region: region)
		let refDateInRegion = DateInRegion(absoluteTime: fromDate, region: region)
		return selfInRegion.toString(fromDate: refDateInRegion, style: style)
	}

}

// MARK: - Adoption of Comparable protocol


extension NSDate : Comparable {}

/**
 Compare two dates and return true if the left date is earlier than the right date

 - parameter left: left date
 - parameter right: right date

 - returns: true if left < right
 */
public func < (left: NSDate, right: NSDate) -> Bool {
    return (left.compare(right as Date) == ComparisonResult.orderedAscending)
}

// MARK: - Date calculations with date components

/**
Subtract date components from date

- parameter lhs: date
- parameter rhs: date components

- returns: a new date result of the difference between two dates
*/
public func - (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return lhs + (-rhs)
}

/**
 Add date components to date

 - parameter lhs: date
 - parameter rhs: date components

 - returns: a new date result of the sum between two dates
 */
public func + (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return lhs.add(rhs)
}

extension NSDate {

    /// Get the year component of the date in current region (use inRegion(...).year to get the year
    /// component in specified time zone)
    public var year: Int {
        return self.inRegion().year
    }

    /// Get the month component of the date in current region (use inRegion(...).month to get the
    /// month component in specified time zone)
    public var month: Int {
        return self.inRegion().month
    }

    /// Get the month name component of the date in current region (use inRegion(...).monthName to
    /// get the month's name component in specified time zone)
    public var monthName: String {
        return self.inRegion().monthName
    }
	
	/// Get the short month name component of the date in current region (use inRegion(...).shortMonthName to
	/// get the month's short name component in specified time zone)
	public var shortMonthName: String {
		return self.inRegion().shortMonthName
	}

    /// Get the week of month component of the date in current region (use inRegion(...).weekOfMonth
    /// to get the week of month component in specified time zone)
    public var weekOfMonth: Int {
        return self.inRegion().weekOfMonth
    }

    /// Get the year for week of year component of the date in current region (use
    /// `inRegion(...).yearForWeekOfYear` to get the year week of year component in specified
    /// time zone)
    public var yearForWeekOfYear: Int {
        return self.inRegion().yearForWeekOfYear
    }

    /// Get the week of year component of the date in current region (use inRegion(...).weekOfYear
    /// to get the week of year component in specified time zone)
    public var weekOfYear: Int {
        return self.inRegion().weekOfYear
    }

    /// Get the weekday component of the date in current region (use inRegion(...).weekday to get
    /// the weekday component in specified time zone)
    public var weekday: Int {
        return self.inRegion().weekday
    }

    /// Get the weekday ordinal component of the date in current region
    /// (use inRegion(...).weekdayOrdinal to get the weekday ordinal component in specified
    /// time zone)
    public var weekdayOrdinal: Int {
        return self.inRegion().weekdayOrdinal
    }

    /// Get the day component of the date in current region (use inRegion(...).day to get the day
    /// component in specified time zone)
    public var day: Int {
        return self.inRegion().day
    }

    /// Get the number of days of the current date's month in current region (use
    /// inRegion(...).monthDays to get it in specified time zone)
    public var monthDays: Int {
        return self.inRegion().monthDays
    }

    /// Get the hour component of the current date's hour in current region (use inRegion(...).hour
    /// to get it in specified time zone)
    public var hour: Int {
        return self.inRegion().hour
    }

    /// Get the nearest hour component of the current date's hour in current region (use
    /// inRegion(...).nearestHour to get it in specified time zone)
    public var nearestHour: Int {
        return self.inRegion().nearestHour
    }

    /// Get the minute component of the current date's minute in current region (use
    /// inRegion(...).minute to get it in specified time zone)
    public var minute: Int {
        return self.inRegion().minute
    }

    /// Get the second component of the current date's second in current region (use
    /// inRegion(...).second to get it in specified time zone)
    public var second: Int {
        return self.inRegion().second
    }

    /// Get the nanoscend component of the current date's nanosecond in current region (use
    /// inRegion(...).nanosecond to get it in specified time zone)
    public var nanosecond: Int {
        return self.inRegion().nanosecond
    }

    /// Get the era component of the current date's era in current region (use inRegion(...).era
    /// to get it in specified time zone)
    public var era: Int {
        return self.inRegion().era
    }
    
    /// Compute the julian day corresponding to the curren date. The julian day and its modified
    /// version below are used as linear time stamps in astronomy. 
    public func julianDay() -> Double {
        return self.inRegion().julianDay()
    }

    public func modifiedJulianDay() -> Double {
        return self.inRegion().modifiedJulianDay()
    }

    /**
     Get the first day of the week in current self absolute time in calendar

     - parameter inRegion: region to use, default region if empty or nil

     - returns: first day of the week in calendar, nil if region is not valid
     */
    public func firstDayOfWeek(inRegion region: Region? = nil) -> Int? {
        return self.inRegion(region: region).startOf(unit: .weekOfYear).day
    }

    /**
     Get the last day of week according to region specified

     - parameter inRegion: region to use, default region if empty or nil

     - returns: last day of the week in calendar, nil if region is not valid
     */
    public func lastDayOfWeek(inRegion region: Region? = nil) -> Int? {
        return self.inRegion(region: region).endOf(unit: .weekOfYear).day
    }

    public func isIn(unit: NSCalendar.Unit, ofDate date: NSDate, inRegion region: Region? = nil)
        -> Bool {
            return self.inRegion(region: region).isIn(unit: unit, ofDate: date.inRegion(region: region))
    }

    public func isBefore(unit: NSCalendar.Unit, ofDate date: NSDate,
        inRegion region: Region? = nil) -> Bool {
            return self.inRegion(region: region).isBefore(unit: unit, ofDate: date.inRegion(region: region))
    }

    public func isAfter(unit: NSCalendar.Unit, ofDate date: NSDate,
        inRegion region: Region? = nil) -> Bool {

            return self.inRegion(region: region).isAfter(unit: unit, ofDate: date.inRegion(region: region))
    }

    @available(*, deprecated, renamed: "isInToday")
    public func isToday() -> Bool {
        return self.isInToday()
    }

    public func isInToday(inRegion region: Region? = nil) -> Bool {
        return self.inRegion(region: region).isInToday()
    }

    @available(*, deprecated, renamed: "isInYesterday")
    public func isYesterday() -> Bool {
        return self.isInYesterday()
    }

    public func isInYesterday(inRegion region: Region? = nil) -> Bool {
        return self.inRegion(region: region).isInYesterday()
    }

    @available(*, deprecated, renamed: "isInTomorrow")
    public func isTomorrow() -> Bool {
        return self.isInTomorrow()
    }

    public func isInTomorrow(inRegion region: Region? = nil) -> Bool {
        return self.inRegion(region: region).isInTomorrow()
    }

    @available(*, deprecated, renamed: "isInSameDayAsDate")
    public func inSameDayAsDate(date: NSDate) -> Bool {
        return self.isInSameDayAsDate(date: date)
    }


    public func isInSameDayAsDate(date: NSDate, inRegion optRegion: Region? = nil) -> Bool {
        let region = optRegion ?? Region.defaultRegion
        return self.inRegion(region: region).isInSameDayAsDate(date: date.inRegion(region: region))
    }

    @available(*, deprecated, renamed: "isInWeekend")
    public func isWeekend() -> Bool? {
        return self.inRegion().isInWeekend()
    }


    /**
     Return true if date is a weekend day into specified region calendar
     - parameter inRegion: region to use, default region if empty or nil

     - returns: true if date is tomorrow into specified region calendar
     */
    public func isInWeekend(inRegion region: Region? = nil) -> Bool? {
        return self.inRegion(region: region).isInWeekend()
    }

    public func isInLeapYear(inRegion region: Region? = nil) -> Bool? {
        return self.inRegion(region: region).leapYear
    }

    public func isInLeapMonth(inRegion region: Region? = nil) -> Bool? {
        return self.inRegion(region: region).leapMonth
    }


    /// Returns whether the given date is in the past.
    ///
    /// - Returns: a boolean indicating whether the receiver is in the past
    ///
    public func isInPast() -> Bool {
        return self < NSDate()
    }

    /// Returns whether the given date is in the past.
    ///
    /// - Returns: a boolean indicating whether the receiver is in the past
    ///
    public func isInFuture() -> Bool {
        return self > NSDate()
    }


}

extension NSDate {

    public class func today(inRegion optRegion: Region? = nil) -> NSDate {
        let region = optRegion ?? Region.defaultRegion
        return region.today().absoluteTime
    }

    public class func yesterday(inRegion optRegion: Region? = nil) -> NSDate {
        let region = optRegion ?? Region.defaultRegion
        return region.yesterday().absoluteTime
    }

    public class func tomorrow(inRegion optRegion: Region? = nil) -> NSDate {
        let region = optRegion ?? Region.defaultRegion
        return region.tomorrow().absoluteTime
    }

}
