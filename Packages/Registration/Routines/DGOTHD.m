DGOTHD ;SLC/SS,RM - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;Feb 14, 2019@09:57
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RM - Feb 14, 2019@09:57
 ;
 ;ICR#   TYPE       DESCRIPTION
 ;-----  ----       ---------------------
 ; 2056  Sup        ^DIQ  : GET1
 ;10061  Sup        ELIG^VADPT
 ;
 Q
 ;
 ;ask for the starting date for the ENTRY in file #33 (OTH ELIGIBILITY)
STRDATE(DGDFN) ;
 I '$G(DGDFN) Q
 N DGSTRDT,Y,DGEXPMH,DGIEN33
 I '$$ISOTHD(DGDFN) Q
 S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN)
 I DGIEN33 Q:$D(^DGOTH(33,DGIEN33,1))
 S DGEXPMH=$$GET1^DIQ(2,DGDFN,.5501,"I")
 S DGEXPMH=$$ISOTH(DGEXPMH)
 Q:'DGEXPMH
 D FRSTNTRY^DGOTHD1(DGDFN,DT,DGEXPMH)
 Q
 ;
 ;Functionality:
 ; checks OTHD eligibility
 ;
 ;Parameters:
 ; DFN - patient's IEN in the file (#2)
 ;
 ;Return values:
 ; 0 - not eligible for OTHD
 ; 1 - eligible for OTHD
 ;
ISOTHD(DFN) ;
 N VAEL,DGOTHD
 D ELIG^VADPT
 S DGOTHD=0
 I +VAEL(1)>0,$$GET1^DIQ(8,+VAEL(1)_",",8)="EXPANDED MH CARE NON-ENROLLEE" S DGOTHD=1
 Q DGOTHD
 ;
 ;retrieve the default EXPANDED MH CARE TYPE
GETEXPMH(DFN) ;
 ;  Input:
 ;    DFN - Patient IEN
 ;
 ;  Output:
 ;    EXPANDED MH CARE TYPE (File #2,Field #.5501)
 ;
 N VAEL
 I '$D(^DPT(DFN)) Q "-1^Patient not found"
 D ELIG^VADPT
 Q $P($G(VAEL(10)),U)
 ;
 ;this API returns the EXPANDED MH CARE TYPE
GETEXPR(DFN) ;
 ;  Input:
 ;    DFN - Patient IEN
 ;
 ;  Output:
 ;    RET - EXPANDED MH CARE TYPE
 ;
 Q $$GETEXPMH(DFN)
 ;
ISOTH(DGEXP) ;
 Q $S("/OTH-90/"[("/"_DGEXP_"/"):2,1:0)
 ;
