DINIT00O ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;3:18 PM  25 May 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**85**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9041,2,1,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9041,2,2,0)
 ;;=Enter 'NO' to compare and display the two entries.
 ;;^UTILITY(U,$J,.84,9041,2,3,0)
 ;;=Enter 'YES' to choose valid fields from each entry then merge into the
 ;;^UTILITY(U,$J,.84,9041,2,4,0)
 ;;=record selected as the default.
 ;;^UTILITY(U,$J,.84,9041,2,5,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9041,2,6,0)
 ;;=If you merge two entries within a file that is pointed-to by many other
 ;;^UTILITY(U,$J,.84,9041,2,7,0)
 ;;=files (such as the PATIENT file), then the re-pointing process can be time
 ;;^UTILITY(U,$J,.84,9041,2,8,0)
 ;;=consuming and can create many tasked jobs.
 ;;^UTILITY(U,$J,.84,9101,0)
 ;;=9101^3^^5
 ;;^UTILITY(U,$J,.84,9101,1,0)
 ;;=^^1^1^2930810^
 ;;^UTILITY(U,$J,.84,9101,1,1,0)
 ;;=The "CHOOSE FROM:" prompt.
 ;;^UTILITY(U,$J,.84,9101,2,0)
 ;;=^^1^1^2930908^^
 ;;^UTILITY(U,$J,.84,9101,2,1,0)
 ;;=Choose from:
 ;;^UTILITY(U,$J,.84,9103,0)
 ;;=9103^3^^5
 ;;^UTILITY(U,$J,.84,9103,1,0)
 ;;=^^2^2^2930810^^
 ;;^UTILITY(U,$J,.84,9103,1,1,0)
 ;;=First line of Variable Pointer help that shows the Prefixes and Messages
 ;;^UTILITY(U,$J,.84,9103,1,2,0)
 ;;=for a field.
 ;;^UTILITY(U,$J,.84,9103,2,0)
 ;;=^^1^1^2930810^
 ;;^UTILITY(U,$J,.84,9103,2,1,0)
 ;;=Enter one of the following:
 ;;^UTILITY(U,$J,.84,9105,0)
 ;;=9105^3^y^5
 ;;^UTILITY(U,$J,.84,9105,1,0)
 ;;=^^2^2^2931229^
 ;;^UTILITY(U,$J,.84,9105,1,1,0)
 ;;=The beginning of the help text used to give list of fields that can
 ;;^UTILITY(U,$J,.84,9105,1,2,0)
 ;;=be used for a look-up.
 ;;^UTILITY(U,$J,.84,9105,2,0)
 ;;=^^1^1^2931229^
 ;;^UTILITY(U,$J,.84,9105,2,1,0)
 ;;=Answer with |1|.
 ;;^UTILITY(U,$J,.84,9105,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9105,3,1,0)
 ;;=1^File name and list of fields that can be used for look-up.
 ;;^UTILITY(U,$J,.84,9105,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9105,5,1,0)
 ;;=DIE^HELP
 ;;^UTILITY(U,$J,.84,9107,0)
 ;;=9107^3^y^5
 ;;^UTILITY(U,$J,.84,9107,1,0)
 ;;=^^1^1^2940513^
 ;;^UTILITY(U,$J,.84,9107,1,1,0)
 ;;=LAYGO allowed.
 ;;^UTILITY(U,$J,.84,9107,2,0)
 ;;=^^1^1^2940513^
 ;;^UTILITY(U,$J,.84,9107,2,1,0)
 ;;=You may enter a new |1| if you wish.
 ;;^UTILITY(U,$J,.84,9107,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9107,3,1,0)
 ;;=1^File Name.
 ;;^UTILITY(U,$J,.84,9110,0)
 ;;=9110^3^y^5
 ;;^UTILITY(U,$J,.84,9110,1,0)
 ;;=^^1^1^2990323^^^^
 ;;^UTILITY(U,$J,.84,9110,1,1,0)
 ;;=Instructions for entering date data.
 ;;^UTILITY(U,$J,.84,9110,2,0)
 ;;=^^7^7^2990323^^^
 ;;^UTILITY(U,$J,.84,9110,2,1,0)
 ;;=Examples of Valid Dates:
 ;;^UTILITY(U,$J,.84,9110,2,2,0)
 ;;=   JAN 20 1957 or 20 JAN 57 or 1/20/57 |1|
 ;;^UTILITY(U,$J,.84,9110,2,3,0)
 ;;=   T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc.
 ;;^UTILITY(U,$J,.84,9110,2,4,0)
 ;;=   T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc.
 ;;^UTILITY(U,$J,.84,9110,2,5,0)
 ;;=If the year is omitted, the computer |2|
 ;;^UTILITY(U,$J,.84,9110,2,6,0)
 ;;=|3|
 ;;^UTILITY(U,$J,.84,9110,2,7,0)
 ;;=|4|
 ;;^UTILITY(U,$J,.84,9110,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,9110,3,1,0)
 ;;=1^If numeric dates are allowed, " or 012057" is written.
 ;;^UTILITY(U,$J,.84,9110,3,2,0)
 ;;=2^Conditionally, indicates if past, future, or current year is assumed.
 ;;^UTILITY(U,$J,.84,9110,3,3,0)
 ;;=3^Conditionally indicates the way FileMan determines century to use if 2 digit year is provided, or indicates that day is not needed if past or future year assumed.
 ;;^UTILITY(U,$J,.84,9110,3,4,0)
 ;;=4^Conditionally, indicates that day is not needed (unless past or future date is assumed, in which case this information goes into parameter 3).
 ;;^UTILITY(U,$J,.84,9110,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110,5,1,0)
 ;;=DIEH1^DT
 ;;^UTILITY(U,$J,.84,9110.7,0)
 ;;=9110.7^3^y^5^Instructions for entering date data.
 ;;^UTILITY(U,$J,.84,9110.7,1,0)
 ;;=^.842^1^1^3010525^^^^
 ;;^UTILITY(U,$J,.84,9110.7,1,1,0)
 ;;=Instructions for entering date data, when the "M" flag is used.
 ;;^UTILITY(U,$J,.84,9110.7,2,0)
 ;;=^.844^8^8^3010525^^^
 ;;^UTILITY(U,$J,.84,9110.7,2,1,0)
 ;;=Examples of Valid Dates:
 ;;^UTILITY(U,$J,.84,9110.7,2,2,0)
 ;;=  JAN 1957 or JAN 57 |1|
 ;;^UTILITY(U,$J,.84,9110.7,2,3,0)
 ;;=  T    (for this month)
 ;;^UTILITY(U,$J,.84,9110.7,2,4,0)
 ;;=  T+3M (for 3 months in the future)
 ;;^UTILITY(U,$J,.84,9110.7,2,5,0)
 ;;=  T-3M (for 3 months ago)
 ;;^UTILITY(U,$J,.84,9110.7,2,6,0)
 ;;=Only month and year are accepted. You must omit the precise day.
 ;;^UTILITY(U,$J,.84,9110.7,2,7,0)
 ;;=If the year is omitted, the computer |2|
 ;;^UTILITY(U,$J,.84,9110.7,2,8,0)
 ;;=|3|
 ;;^UTILITY(U,$J,.84,9110.7,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9110.7,3,1,0)
 ;;=1^If numeric dates are allowed, " or 0157" is written.
 ;;^UTILITY(U,$J,.84,9110.7,3,2,0)
 ;;=2^Conditionally, indicates if past, future, or current year is assumed.
 ;;^UTILITY(U,$J,.84,9110.7,3,3,0)
 ;;=3^Conditionally indicates the way FileMan determines century to use if 2 digit year is provided.
 ;;^UTILITY(U,$J,.84,9110.7,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.7,5,1,0)
 ;;=DIEH1^DT
 ;;^UTILITY(U,$J,.84,9111,0)
 ;;=9111^3^y^5
 ;;^UTILITY(U,$J,.84,9111,1,0)
 ;;=^^1^1^2930806^
 ;;^UTILITY(U,$J,.84,9111,1,1,0)
 ;;=Instructions for entering time data.
 ;;^UTILITY(U,$J,.84,9111,2,0)
 ;;=^^5^5^2931104^^
 ;;^UTILITY(U,$J,.84,9111,2,1,0)
 ;;=If the date is omitted, the current date is assumed.
 ;;^UTILITY(U,$J,.84,9111,2,2,0)
 ;;=Follow the date with a time, such as JAN 20@10, T@10AM, 10:30, etc.
 ;;^UTILITY(U,$J,.84,9111,2,3,0)
 ;;=You may enter NOON, MIDNIGHT, or NOW to indicate the time.
 ;;^UTILITY(U,$J,.84,9111,2,4,0)
 ;;=|1|
 ;;^UTILITY(U,$J,.84,9111,2,5,0)
 ;;=|2|
 ;;^UTILITY(U,$J,.84,9111,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9111,3,1,0)
 ;;=1^Conditionally, give instructions for entering seconds.
 ;;^UTILITY(U,$J,.84,9111,3,2,0)
 ;;=2^Conditionally, state that time is required.
 ;;^UTILITY(U,$J,.84,9115,0)
 ;;=9115^3^^5
 ;;^UTILITY(U,$J,.84,9115,1,0)
 ;;=^^1^1^2930810^
 ;;^UTILITY(U,$J,.84,9115,1,1,0)
 ;;=The short help for variable pointers.
 ;;^UTILITY(U,$J,.84,9115,2,0)
 ;;=^^1^1^2930810^
 ;;^UTILITY(U,$J,.84,9115,2,1,0)
 ;;=To see the entries in any particular file, type <Prefix.?>.
 ;;^UTILITY(U,$J,.84,9116,0)
 ;;=9116^3^^5
 ;;^UTILITY(U,$J,.84,9116,1,0)
 ;;=^^1^1^2930810^
 ;;^UTILITY(U,$J,.84,9116,1,1,0)
 ;;=Long help for variable pointers.
 ;;^UTILITY(U,$J,.84,9116,2,0)
 ;;=^^15^15^2930810^
 ;;^UTILITY(U,$J,.84,9116,2,1,0)
 ;;=If you enter just a name, the system will search each of the 
 ;;^UTILITY(U,$J,.84,9116,2,2,0)
 ;;=above files for the name you have entered.  If a match is found,
 ;;^UTILITY(U,$J,.84,9116,2,3,0)
 ;;=the system will ask you if it is the entry you desire.
 ;;^UTILITY(U,$J,.84,9116,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9116,2,5,0)
 ;;=However, if you know the file the entry should be in, you can
 ;;^UTILITY(U,$J,.84,9116,2,6,0)
 ;;=speed processing by using the following syntax to select an entry:
 ;;^UTILITY(U,$J,.84,9116,2,7,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9116,2,8,0)
 ;;=     <Prefix>.<entry name>
 ;;^UTILITY(U,$J,.84,9116,2,9,0)
 ;;=             or
 ;;^UTILITY(U,$J,.84,9116,2,10,0)
 ;;=     <Message>.<entry name>
 ;;^UTILITY(U,$J,.84,9116,2,11,0)
 ;;=             or
 ;;^UTILITY(U,$J,.84,9116,2,12,0)
 ;;=     <File Name>.<entry name>
 ;;^UTILITY(U,$J,.84,9116,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9116,2,14,0)
 ;;=You do not need to enter the entire file name or message.
 ;;^UTILITY(U,$J,.84,9116,2,15,0)
 ;;=The first few characters will suffice.
 ;;^UTILITY(U,$J,.84,9117,0)
 ;;=9117^3^y^5
 ;;^UTILITY(U,$J,.84,9117,1,0)
 ;;=^^1^1^2930810^^
 ;;^UTILITY(U,$J,.84,9117,1,1,0)
 ;;=Variable pointer help - prefix and message.
 ;;^UTILITY(U,$J,.84,9117,2,0)
 ;;=^^1^1^2930810^^^
 ;;^UTILITY(U,$J,.84,9117,2,1,0)
 ;;=|1|.EntryName to select a |2|.
 ;;^UTILITY(U,$J,.84,9117,3,0)
 ;;=^.845^2^2
