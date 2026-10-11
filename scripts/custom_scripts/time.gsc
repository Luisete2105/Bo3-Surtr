// UTC TIME UTILITY
function daysInYear(year)
{
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
        return 366; // Leap year
    return 365;
}

function daysInMonth(month, year)
{
    if (month == 2)
        return isLeapYear(year) ? 29 : 28;
    if (month == 4 || month == 6 || month == 9 || month == 11)
        return 30;
        
    return 31;
}

function isLeapYear(year)
{
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// Str Month Int Day, Int Year (Str Day)
function GetUtcDate()
{
    timestamp = float( GetUTC() ); // Maybe forcing a Float makes it to be more accurate? I don't think so...

    // Days since Unix epoch (1970-01-01)
    days = int( timestamp / SECONDS_IN_A_DAY );
    
    // Unix epoch starts on Thursday, Jan 1, 1970
    weekdayOffset = 4; // Thursday = 4
    weekday = (days + weekdayOffset) % 7;
    
    weekdays = [];
    weekdays[0] = "Sun";
    weekdays[1] = "Mon";
    weekdays[2] = "Tue";
    weekdays[3] = "Wed";
    weekdays[4] = "Thu";
    weekdays[5] = "Fri";
    weekdays[6] = "Sat";
    
    // Approximate year calculation
    year = 1970;
    while (days >= daysInYear( year )){
        year++;
        days -= daysInYear( year );
    }
    
    // Calculate month and day
    month = 1;
    while (days >= daysInMonth(month, year))
    {
        days -= daysInMonth(month, year);
        month++;
    }
    
    day = days + 1; // Days are 1-indexed

    monthNames = [];
    monthNames[1] = "Jan"; monthNames[2] = "Feb"; monthNames[3] = "Mar";
    monthNames[4] = "Apr"; monthNames[5] = "May"; monthNames[6] = "Jun";
    monthNames[7] = "Jul"; monthNames[8] = "Aug"; monthNames[9] = "Sep";
    monthNames[10] = "Oct"; monthNames[11] = "Nov"; monthNames[12] = "Dec";

    str = "";
    str += monthNames[month] + " ";
    str += day + ", ";
    str += year + " (";
    str += weekdays[weekday] + ")";

    return str;
}

// Int current utc day time
function GetUtcTimeOfDay()
{
    timestamp = GetUTC();

    // Remaining time
    //time = timestamp % SECONDS_IN_A_DAY; // Number is too big and returns undefined
    time_days   = int(timestamp / SECONDS_IN_A_DAY);
    timeInDay   = timestamp - (time_days * SECONDS_IN_A_DAY);

    return timeInDay;
}

// Int time until next utc day
function GetTimeForNextUtcDay()
{
    // === TIME UNTIL NEXT UTC DAY ===
    secsUntilMidnight = 86399 - GetUtcTimeOfDay();  // 23:59:59 max
    return secsUntilMidnight;
}