DVBCLMHD ;ALB/CMM HEADER FILE ;16FEB93
 ;;2.7;AMIE;;Apr 10, 1995
EN ;
 ;   perform initializations for pkg wide vars
 ;
 ;
 S VWLINE=1,VALMBG=1
 ;
 ;  where to place the results array
 S RSLTAR="^TMP(""DVBC"","_$J_")"
 ;
 ;  set initial query number 0, so 1st domain build becomes 1
 S @RSLTAR@(0)=0
 ;
 Q
