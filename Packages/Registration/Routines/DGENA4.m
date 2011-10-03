DGENA4 ;ISA/KWP - Enrollment API - Retrieve data; 05/11/99
 ;;5.3;Registration;**232**;Aug 13, 1993
 ;Phase II API's
CATEGORY(DFN,STATUS)   ;
 ;Description: Returns ENROLLMENT CATEGORY from the patient's current
 ;       enrollment.
 ;Input:
 ;  DFN - Patient IEN
 ;  STATUS - Optional.  If passed will get the CATEGORY for
 ;        this status otherwise the Current enrollment status is used,
 ;Output:
 ;  Returns patients ENROLLMENT CATEGORY or the ENROLLMENT CATEGORY
 ;  of the status passed if available
 ;  otherwise defaults to "NOT ENROLLED" category.
 ;  E-Enrolled
 ;  N-Not Enrolled
 ;  P-In Process
 ;
 I $G(STATUS)="" S STATUS=""
 N CATEGORY
 S:STATUS="" STATUS=$$STATUS^DGENA($G(DFN))
 Q:'STATUS "N"
 S CATEGORY=$P($G(^DGEN(27.15,STATUS,0)),"^",2)
 I CATEGORY="" Q "N"
 Q CATEGORY
 ;
ENRSBGRP(DFN) ;
 ;Description: Returns ENROLLMENT SUBGROUP for patient's current
 ;      enrollment. ENROLLMENT PRIORITY 7 will be the only priority
 ;      group stratified into ENROLLMENT SUBGROUPS.
 ;Input:
 ;  DFN - Patient IEN
 ;Output:
 ;  Function Value - Returns the current ENROLLMENT SUBGROUP if defined
 ;       otherwise returns NULL.
 ;
 N DGENRIEN
 S DGENRIEN=$$FINDCUR^DGENA($G(DFN))
 Q:'DGENRIEN ""
 Q $P($G(^DGEN(27.11,DGENRIEN,0)),"^",12)
 ;
EXTCAT(CATEGORY) ;
 ;Description: Returns the external name for the defined ENROLLMENT
 ;             CATEGORY flag.
 ;
 ;Input:
 ;  CATEGORY - Category flag
 ;Output:
 ;  Function Value - Returns the external name for the defined CATEGORY
 ;           flag otherwise returns NULL.
 ;
 Q $$EXTERNAL^DILFD(27.15,.02,"F",CATEGORY)
