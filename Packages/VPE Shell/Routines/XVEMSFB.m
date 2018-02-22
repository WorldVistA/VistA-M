XVEMSFB ;DJB/VSHL**%DT,COMMA [04/17/94];2017-08-15  4:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
%DT ;;;
 ;;; % D T     Date and Time Input and Conversion
 ;;;
 ;;; 1. ENTRY POINT: ^%DT
 ;;;    Returns date in VA Fileman format: YYYMMDD.HHMMSS
 ;;;    Date is a canonic number - no trailing zeroes after the decimal.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %DT.......A = Ask for date input
 ;;;              E = Echo the answer
 ;;;              F = Future dates are assumed
 ;;;              P = Pure numeric input not allowed
 ;;;              R = Require time input
 ;;;              S = Seconds should be returned
 ;;;              T = Time input allowed but not required
 ;;;              X = Exact date required (with month and day).
 ;;;    X.........If %DT doesn't contain A, X must equal value to be processed.
 ;;;    %DT("A")..Default prompt.
 ;;;    %DT("B"...Default answer.
 ;;;    %DT(0)....Optional. Prevents input date from being before or after a
 ;;;              particular date:
 ;;;              %DT(0)=2930101 Allows input only of dates GREATER THAN or
 ;;;                             EQUAL TO that date.
 ;;;              %DT(0)=-2930101 Allows input only of dates LESS THAN or EQUAL
 ;;;                              TO that date.
 ;;;              %DT(0)="NOW" Allows dates from current time forward.
 ;;;              %DT(0)="-NOW" Allows dates up to the current time.
 ;;;    DTIME.....Time out.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y.........-1 (Date/time was invalid) -or- YYYMMDD.HHMMSS.
 ;;;    X.........What was passed (%DT doesn't contain A) or what was entered.
 ;;;    DTOUT.....%DT timed out.
 ;;;
 ;;; 1. ENTRY POINT: DD^%DT
 ;;;    Converts internal date in Y to its external format.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    Y.......Internal date.
 ;;;    %DT.....Optional. If it contains S, forces seconds to be returned.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y.......Date in external format.
 ;;;
 ;;; 1. ENTRY POINT: X ^DD("DD")
 ;;;    Converts a date from internal to external format. Set Y=internal date
 ;;;    and X ^DD("DD"). Y will equal external format.
 ;;;***
COMMA ;;;
 ;;; % D T C     Number Formatting
 ;;;
 ;;; 1. ENTRY POINT: COMMA^%DTC
 ;;;    Formats a number with commas.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X........Number to be formatted. May be positive or negative.
 ;;;    X2.......Number of decimal digits. If X2 is undefined, 2 decimal digits
 ;;;             are returned. If X2 is a number followed by a dollar sign
 ;;;             (e.g. 3$), then a dollar sign will be prefixed to X.
 ;;;    X3.......Length of the desired output. If X3 is less than the formatted X,
 ;;;             X3 will be ignored. If X3 is not defined, then a length of 12
 ;;;             is used.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    X........The initial value of X formatted.
 ;;;              Examples of COMMA^%DTC output:
 ;;;                 S X=12345.678 D COMMA^%DTC       X="  12,345.68 "
 ;;;                 S X=9876.54,X2="0$"              X="     $9,877 "
 ;;;                 S X=-3,X2="2$"                   X="     ($3.00)"
 ;;;                 S X=12345.678,X3=10              X="12,345.68 "
 ;;;***
