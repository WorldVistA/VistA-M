PXRRPRSE ;ISL/PKR - Sort encounter for provider count report. ;10/10/96
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
 . S DESC="Provider Encounter Report - print"
 . I $P(PXRRPRTY,U,1)="D" S ROUTINE="PXRRPRDP"
 . E  S ROUTINE="PXRRPRSP"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"PRZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D
 . I $P(PXRRPRTY,U,1)="D" D ^PXRRPRDP
 . E  D ^PXRRPRSP
 Q
