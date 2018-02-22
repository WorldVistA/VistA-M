XVEMSFC ;DJB/VSHL**%DTC [04/17/94];2017-08-15  4:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
%DTC ;;;
 ;;; % D T C     Date/Time Manipulation
 ;;;
 ;;; 1. ENTRY POINT: ^%DTC
 ;;;    Return number of days between two dates.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X1.......1st date
 ;;;    X2.......2nd date
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    X........Number of days between the 2 dates (X2-X1).
 ;;;    %Y.......1 = Dates have both month and day values.
 ;;;             0 = Dates were imprecise and not workable.
 ;;;
 ;;; 1. ENTRY POINT: C^%DTC
 ;;;    Add or subtract a number of days to a date.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X1.......Date in VA Fileman format.
 ;;;    X2.......If positive, number of days to add. If negative, number of
 ;;;             days to subtract.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    X........Resulting date.
 ;;;    %H.......The $H form of the date.
 ;;;
 ;;; 1. ENTRY POINT: H^%DTC
 ;;;    Converts a VA Fileman date/time to a $H format.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X.......Date in VA Fileman format.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    %H.......The $H form of the date. If date is imprecise, then first of
 ;;;             the month or year is returned.
 ;;;    %T.......The time in $H format. If no time, %T equals zero.
 ;;;    %Y.......Day-of-week as numberic from 0 to 6. 0=Sunday. If the date is
 ;;;             imprecise, %Y equals -1.
 ;;;
 ;;; 1. ENTRY POINT: DW^%DTC
 ;;;    This entry point produces results similar to H^%DTC. The difference is
 ;;;    that X is reset to the name of the day. If the date is imprecise, X
 ;;;    is returned equal to null.
 ;;;
 ;;; 1. ENTRY POINT: NOW^%DTC
 ;;;    Returns the current date/time in VA Fileman and $H formats.
 ;;;
 ;;; 2. OUTPUT VARIABLES
 ;;;    %..........VA Fileman date/time to the second.
 ;;;    %H.........$H date/time.
 ;;;    %I(1)......Numeric value of the month.
 ;;;    %I(2)......Numeric value of the day.
 ;;;    %I(3)......Numeric value of the year.
 ;;;    X..........VA Fileman date only.
 ;;;
 ;;; 1. ENTRY POINT: YMD^%DTC
 ;;;    Converts $H format date to VA Fileman format.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %H.........A $H format date/time.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    %..........Time to the second, as a decimal. If %H doesn't have time,
 ;;;               % equals zero.
 ;;;    X..........Date in VA Fileman format.
 ;;;
 ;;; 1. ENTRY POINT: YX^%DTC
 ;;;    Converts $H format date to VA Fileman format and to a printable date/time.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %H.........A $H format date/time.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y..........The date and time (if time's sent) in external format. Seconds
 ;;;               will be included if the input contained seconds.
 ;;;    %..........Time to the second, as a decimal. If %H doesn't have time,
 ;;;               then % equals zero.
 ;;;    X..........Date in VA Fileman format.
 ;;;
 ;;; 1. ENTRY POINT: S^%DTC
 ;;;    Converts seconds from midnight to hours, min, and sec as decimal part
 ;;;    of a VA Fileman date.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %..........Number of seconds from midnight, $P($H,",",2).
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    %..........Decimal part of a VA Fileman date.
 ;;;
 ;;; 1. ENTRY POINT: HELP^%DTC
 ;;;    Displays help prompt based on %DT and %DT(0).
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %DT........Same as %DT
 ;;;    %DT(0).....Optional. Causes HELP to display upper or lower bound
 ;;;               that is acceptable for this particular call.
 ;;;***
