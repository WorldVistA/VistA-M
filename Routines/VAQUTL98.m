VAQUTL98 ;ALB/JFP,JRP - Builds Various Tables ;03FEB93
 ;;1.5;PATIENT DATA EXCHANGE;**6,13**;NOV 17, 1993
 ;
TABLE ; *************** Tables *************** 
 ;
BADSSN ; -- Builds a table of invalid SSN
 F I=1:1  S BSSN=$P($T(BADSSN1+I),"^",2)  Q:BSSN=""  S BADSSN(BSSN)=""
 K BSSN
 QUIT
BADSSN1 ;
 ;;   ^000000000
 ;;   ^111111111
 ;;   ^222222222
 ;;   ^333333333
 ;;   ^444444444
 ;;   ^555555555
 ;;   ^666666666
 ;;   ^777777777
 ;;   ^888888888
 ;;   ^999999999
 ;
FLECHK ; -- Table of the multiples files assocoaited with file 2
 F I=1:1  S FILE=$P($T(FLECHK1+I),"^",2)  Q:FILE=""  S FLE(FILE)=""
 K FILE
 QUIT
FLECHK1 ;
 ;;   ^2.001^enrollment clinic
 ;;   ^2.0361^eligibility 
 ;;   ^2.04^rated disability
 ;;   ^2.101^ 
 ;;   ^2.11^dental 
 ;;   ^2.16^ 
 ;;   ^2.312^insurance
 ;;   ^2.98^appt
 ;;   ^36^insurance
 ;;   ^355.3^insurance
 ;
FLDCHK ; -- Table of nonloadable fields for file 2
 F I=1:1  S FIELD=$P($T(FLDCHK1+I),"^",2)  Q:FIELD=""  S FLD(FIELD)=""
 K FIELD
 QUIT
FLDCHK1 ;
 ;;   ^.306^MONETARY BEN. VERIFY DATE
 ;;   ^.322^SERVICE VERIFICATION DATE
 ;;   ^.3611^ELIGIBILITY STATUS
 ;;   ^.3612^ELIGIBILITY STATUS DATE
 ;;   ^.3613^*ELIG DATA STATUS NODE
 ;;   ^.3614^ELIGIBILITY INTERIM RESPONSE
 ;;   ^.3615^ELIGIBILITY VERIF. METHOD
 ;;   ^.3616^ELIGIBILITY STATUS ENTERED BY
 ;;   ^.3192^COVERED BY HEALTH INSURANCE
 ;
