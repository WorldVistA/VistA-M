DGENLCD1 ;ALB/CJM,Zoltan,JAN - Enrollment Catastrophic Disability- Build List Area;13 JUN 1997 08:00 am,NOV 14 2001
 ;;5.3;Registration;**121,232,387**;Aug 13,1993
 ;
EN(DGARY,DFN,DGCNT) ;Entry point to build list area
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ; Output -- DGCNT    Number of lines in the list
 N DGCDIS,DGLINE
 I $$GET^DGENCDA(DFN,.DGCDIS) ;set-up catastrophic disability array
 S DGLINE=1,DGCNT=0
 D CD(DGARY,DFN,.DGCDIS,.DGLINE,.DGCNT)
 Q
 ;
CD(DGARY,DFN,DGCDIS,DGLINE,DGCNT) ;
 ;Description: Writes Catastrophic Disabilty info to list.
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGCDIS    Enrollment array
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGSTART,HASCAT,PERM
 ;
 S DGSTART=DGLINE ; starting line number
 D SET^DGENL1(DGARY,DGLINE," Catastrophic Disability ",28,IORVON,IORVOFF,,,,.DGCNT)
 S DGLINE=DGLINE+2
 S HASCAT=$$HASCAT^DGENCDA(DFN)
 D SET^DGENL1(DGARY,DGLINE,$J("Veteran Catastrophically Disabled:   ",41)_$S(HASCAT:"YES",1:"NO"),1,,,,,,.DGCNT)
 ;
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Date of Decision:   ",41)_$$EXT^DGENCDU("DATE",DGCDIS("DATE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Decided By:   ",41)_$$EXT^DGENCDU("BY",DGCDIS("BY")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Facility Making Determination:   ",41)_$$EXT^DGENCDU("FACDET",DGCDIS("FACDET")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Review Date:   ",41)_$$EXT^DGENCDU("REVDTE",DGCDIS("REVDTE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Method of Determination:   ",41)_$$EXT^DGENCDU("METDET",DGCDIS("METDET")),1,,,,,,.DGCNT)
 ;
 ; Display reasons for CD Determination.
 I '$D(DGCDIS("DIAG")),'$D(DGCDIS("PROC")),'$D(DGCDIS("COND")) Q
 S DGLINE=DGLINE+2
 D SET^DGENL1(DGARY,DGLINE," Reason(s) for CD Determination ",24,IORVON,IORVOFF,,,,.DGCNT)
 S DGLINE=DGLINE+1
 S (ITEM,SUBITEM)=""
 F  S ITEM=$O(DGCDIS("DIAG",ITEM)) Q:ITEM=""  D
 . S DGLINE=DGLINE+1
 . D SET^DGENL1(DGARY,DGLINE,$J("CD Status Diagnosis:   ",25)_$$EXT^DGENCDU("DIAG",DGCDIS("DIAG",ITEM)),1,,,,,,.DGCNT)
 F  S ITEM=$O(DGCDIS("PROC",ITEM)) Q:ITEM=""  D
 . F  S SUBITEM=$O(DGCDIS("EXT",ITEM,SUBITEM)) Q:SUBITEM=""  D
 . . S DGLINE=DGLINE+1
 . . D SET^DGENL1(DGARY,DGLINE,$J("CD Status Procedure:   ",25)_$$EXT^DGENCDU("PROC",DGCDIS("PROC",ITEM)),1,,,,,,.DGCNT)
 . . S DGLINE=DGLINE+1
 . . D SET^DGENL1(DGARY,DGLINE,$J("Affected Extremity:   ",30)_$$EXT^DGENCDU("EXT",DGCDIS("EXT",ITEM,SUBITEM)),1,,,,,,.DGCNT)
 F  S ITEM=$O(DGCDIS("COND",ITEM)) Q:ITEM=""  D
 . S DGLINE=DGLINE+1
 . D SET^DGENL1(DGARY,DGLINE,$J("CD Status Condition:   ",25)_$$EXT^DGENCDU("COND",DGCDIS("COND",ITEM)),1,,,,,,.DGCNT)
 . S DGLINE=DGLINE+1
 . D SET^DGENL1(DGARY,DGLINE,$J("Score:   ",30)_$$EXT^DGENCDU("SCORE",DGCDIS("SCORE",ITEM)),1,,,,,,.DGCNT)
 . S DGLINE=DGLINE+1
 . I '$$RANGEMET^DGENA5(DGCDIS("COND",ITEM),DGCDIS("SCORE",ITEM),1) S PERM="N/A"
 . E  S PERM=$$EXT^DGENCDU("PERM",DGCDIS("PERM",ITEM))
 . D SET^DGENL1(DGARY,DGLINE,$J("Permanent Indicator:   ",30)_PERM,1,,,,,,.DGCNT)
 ;
 Q
