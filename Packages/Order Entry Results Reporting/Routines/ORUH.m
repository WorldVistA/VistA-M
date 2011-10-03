ORUH ; slc/JER - XECUTABLE HELP for format functions ;10/3/91  15:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
HELP ; XECUTABLE HELP for formatting functions
 Q:'$D(ORTYPE)
 N X
 S X=$P(^ORD(100.22,+ORTYPE,0),"^",5)
 I '$L($T(@X)) W !?5,"Sorry, no formats have been specified.",! Q
 W ?6,"Allowable values include: ",!
 D @X
 Q
NAME ; Xecutable help for name formats
 W ?10,"LAST  - Last Name",!
 W ?10,"FIRST - First Name",!
 W ?10,"MI    - Middle Initial",!
 W ?10,"FI    - First Initial",!
 W ?10,"LI    - Last Initial",!
 W ?6,"All other characters will be treated as delimiters.",!
 W ?6,"Examples: ",?16,"LAST,FIRST MI ==> DOE, JOHN M or",!?19,"FI MI LAST ==> J M DOE",!
 Q
DATE ; Xecutable help for date formats
 W ?10,"MM   - Numeric months",!
 W ?10,"DD   - Numeric Days",!
 W ?10,"YY   - Numeric Years",!
 W ?10,"CC   - Numeric Century",!
 W ?10,"HR   - Numeric Hour of Day",!
 W ?10,"MIN  - Numeric Minute",!
 W ?10,"SEC  - Numeric Second",!
 W ?10,"AMTH - Alphabetic Month",!
 W ?6,"All other characters will be treated as delimiters.",!
 W ?6,"Examples: ",?16,"MM/DD/YY HR:MIN ==> 04/29/91 11:15, or",!?19,"DD AMTH CCYY ==> 29 APR 1991",!
 Q
WORD ; Xecutable help for Word Processing formats
 W ?6,"Enter the WIDTH to which you want the word processing text to be justified.",!
 Q
FORMAT ; Xecutable help for Freetext formats
 W ?6,"Enter the WIDTH to which you want the freetext to be justified.",!
 Q
TEXT ; Xecutable help for TEXT formats
 W ?6,"Enter the WIDTH to which you want the order text to be justified.",!
 Q
TMPWRAP ;
 Q
