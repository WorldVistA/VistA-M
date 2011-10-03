PXRRLCSE ;ISL/PKR - Sort encounters for location count report. ;10/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10**;Aug 12, 1996
 ;
 ;Sort the encounters according to the selection criteria.
SORT ;
 ;Allow the task to be cleaned up on successful completion.
 S ZTREQ="@"
 ;
 D SORT^PXRRECSE
 ;
 ;Print the report.
 I PXRRQUE D 
 .;Start the report that was queued but not scheduled.
 . N DESC,ROUTINE,TASK
 . I $P(PXRRLCSC,U,1)["C" S ROUTINE="PXRRLCCP"
 . E  S ROUTINE="PXRRLCHP"
 . S DESC="Location Encounter Report - print"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"PRZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D
 . I $P(PXRRLCSC,U,1)["C" D ^PXRRLCCP
 . E  D ^PXRRLCHP
 Q
