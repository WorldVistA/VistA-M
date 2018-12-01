GMTSPSTR ;PBM/RMS - USAGE TRACKER for HEALTH SUMMARY COMPONENT ;06/28/17  10:32
 ;;2.7;Health Summary;**94**;Oct 20, 1995;Build 41
 Q
 ;This routine tracks usage of Health Summary Components
 ;
 ;Global is: ^GMT(142.3,"TRACKING")
 ;  where each entry is an array of TAGs:
 ;   format: ^GMT(142.3,"TRACKING",TAG)
 ;    where each TAG is an array of SITEs:
 ;     format: ^GMT(142.3,"TRACKING",TAG,SITE)
 ;      where each SITE is an array of usage records:
 ;       format: ^GMT(142.3,"TRACKING",TAG,SITE,IEN)=USER^TIMESTAMP
 ;        where:
 ;         IEN is unique index number for each record
 ;         USER is NEW PERSON (file #200) IEN/DUZ of user
 ;         TIMESTAMP is date and time of usage
 ;
 ; Entry Point: ADD
 ;   Adds a new tracking record to ^GMT(142.3,"TRACKING") global
 ;   Parameter(s):      TAG - identifying string (usually component/routine name)
 ;   Returns:           <nothing>
 ;
ADD(TAG) ;
 N SITE,IEN,RECORD
 S SITE=DUZ(2)
 F  L +^GMT(142.3,"TRACKING"):$G(DILOCKTM,3) I  Q
 S IEN=$$NEXTI(TAG,SITE)
 L -^GMT(142.3,"TRACKING")
 S RECORD=DUZ_"^"_$$NOW^XLFDT
 S ^GMT(142.3,"TRACKING",TAG,SITE,IEN)=RECORD
 Q
 ;
 ; Sub-routine: NEXTI
 ;   Retrieves next index value for ^GMT(142.3,"TRACKING",TAG,SITE)
 ;   Parameter(s):      TAG - identifying string, SITE - division identifier passed from ADD
 ;   Returns:           IEN - integer of next record number
 ;
NEXTI(TAG,SITE) ;
 N IEN
 I '$D(^GMT(142.3,"TRACKING",TAG,SITE)) S ^GMT(142.3,"TRACKING",TAG,SITE)="",IEN=1
 I $D(^GMT(142.3,"TRACKING",TAG,SITE))=11 S IEN=$O(^GMT(142.3,"TRACKING",TAG,SITE,":"),-1)+1
 S ^GMT(142.3,"TRACKING",TAG,SITE,IEN)=""
 Q IEN
