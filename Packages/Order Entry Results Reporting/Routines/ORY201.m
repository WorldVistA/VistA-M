ORY201 ;slc/dcm - Post/Pre inits for patch OR*3.0*201
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**201**;Dec 17, 1997
PRE ; -- preinit
 ;
 Q
 ;
POST ; -- postinit
 ;
 Q
 ;
SENDRPT(ANAME) ;Return true if the current report should be sent.
 I ANAME="ORRPW PCE IMMUNIZATION" Q 1
 I ANAME="ORRPW PCE SKIN TEST" Q 1
 I ANAME="ORRPW ADT DISAB" Q 1
 Q 0
