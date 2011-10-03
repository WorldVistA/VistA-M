PXRMAPI ; SLC/PKR - Clinical Reminders APIs.;12/15/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;========================================================
PUSAGE(IEN) ;Return true if the reminder definition contains a "P"
 ;in the Usage field. This means it is ok for a patient to use the
 ;reminder. IEN is the internal entry number.
 N OK,USAGE
 S USAGE=$P($G(^PXD(811.9,IEN,100)),U,4)
 S OK=$S(USAGE["P":1,1:0)
 Q OK
 ;
 ;========================================================
USAGE(IEN) ;Return the Usage for a reminder definition. IEN is the
 ;internal entry number.
 Q $P($G(^PXD(811.9,IEN,100)),U,4)
 ;
