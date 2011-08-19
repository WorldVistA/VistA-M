ESPUOR ;DALISC/CKA - converts Date/Time Received to UOR#;10/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
 ;Extrinsic function, Call with string, Returns converted string
CONV(X) ;This program takes the Date/Time Received -.02 in file 912-Offense filein internal form and converts it to UOR#
 ;UOR #= The last digit of the year-2 digit month-2 digit day-military time; example 2921031.1500  UOR#=210301500
 S X=$E(X,3,7)_$TR($E($P(X,".",2)_"ZZZZ",1,4),"Z",0)
 Q X
 ;
PRT(X) ;This prints the UOR# in format YR-MO-DY-TIME
 S X=$E(X,2,3)_"-"_$E(X,4,5)_"-"_$E(X,6,7)_"-"_$TR($E($P(X,".",2)_"ZZZZZ",1,4),"Z",0)
QUIT Q X
