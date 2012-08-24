DGPFAPIU ;ALB/SCK - PRF API UTILITIES FOR HIGH RISK MENTAL HEALTH ; Jan 21, 2011
 ;;5.3;Registration;**836**;Aug 13, 1993;Build 35
 ;
 Q  ; No direct entry
 ;
CHKDATE(DGSTART,DGEND,DGRANGE) ; Check for valid start and end dates, set DGRANGE parameter
 N DGRSLT
 ;
 S DGSTART=+$G(DGSTART),DGEND=+$G(DGEND)
 S:DGSTART<0 DGSTART=0
 ;
 I 'DGSTART&('DGEND) D
 . S DGRANGE="A"
 . S DGSTART=0,DGEND=$P($$NOW^XLFDT,".")
 E  D
 . S DGRANGE="S"
 ;
 S DGRANGE("START")=DGSTART,DGRANGE("END")=DGEND
 Q 1
 ;
CHKDFN(DGDFN,DGNAME) ; Check for a valid entry in the PATIENT file
 N DGERR,DGRSLT
 ;
 S DGRSLT=1
 S DGNAME=$$GET1^DIQ(2,DGDFN,.01,,,"DGERR")
 I $D(DGERR) S DGRSLT=0,DGNAME=DGERR("DIERR",1,"TEXT",1)
 Q $G(DGRSLT)
 ;
ASGNDATE(DGIEN) ; Get intial assignment date from new record history entry
 N DGRSLT,DGX
 ;
 S DGX=0
 F  S DGX=$O(^DGPF(26.14,"B",DGIEN,DGX)) Q:'DGX  D
 . I $P($G(^DGPF(26.14,DGX,0)),U,3)=1 S DGRSLT=$P($G(^DGPF(26.14,DGX,0)),U,2)
 ;
 Q +$G(DGRSLT)
 ;
GETFLAG(DGPRF,DGCAT) ; Get the variable pointer value for the flag text passed in
 ;  Input:  DGPRF - Flag name, i.e. BEHAVIORAL
 ;          DGCAT - Flag Category, N - National  [Optional]
 ;                                 L - Local
 ;
 ;  Output:  Returns the variable pointer value for the flag, i.e. "1;DGPF(25.15"
 ;           If not found, returns "-1;NOT FOUND"
 ;           If not Active, returns "-1;NOt ACTIVE"
 ;
 N DGIEN,DGDONE,DGRSLT,DGSTAT
 ;
 S DGCAT=$G(DGCAT)
 S DGCAT=$S(DGCAT="N":1,DGCAT="L":2,1:0)
 ;
 I DGCAT=1 D
 . S DGIEN=$O(^DGPF(26.15,"B",DGPRF,0))
 . I DGIEN S DGDONE=1,DGRSLT=DGIEN_";DGPF(26.15,"
 ;
 I DGCAT=2 D
 . S DGIEN=$O(^DGPF(26.11,"B",DGPRF,0))
 . I DGIEN S DGDONE=1,DGRSLT=DGIEN_";DGPF(26.11,"
 ;
 I DGCAT=0 D
 . ; Check the PRF local flag file for the flag first.  If found, return the appropriate variable pointer
 . S DGIEN=$O(^DGPF(26.11,"B",DGPRF,0))
 . I DGIEN S DGDONE=1,DGRSLT=DGIEN_";DGPF(26.11,"
 . ; If not found in the PRF Local Flag file, then check the PRF National Flag file.  If found, return the appropriate variable pointer. 
 . I '$G(DGDONE) D
 .. S DGIEN=$O(^DGPF(26.15,"B",DGPRF,0))
 .. I DGIEN S DGDONE=1,DGRSLT=DGIEN_";DGPF(26.15,"
 ;
 I '$G(DGDONE) S DGRSLT="-1;NOT FOUND"
 ;
 ; Check active status
 I +$G(DGRSLT)>0 D
 . S DGSTAT=$$GET1^DIQ($S(DGRSLT[26.11:26.11,1:26.15),+DGRSLT,.02,"I")
 . I 'DGSTAT S DGRSLT="-1;NOT ACTIVE"
 ; 
 Q $G(DGRSLT)
 ;
ACTIVE(DGIEN,DGRANGE) ; Check if "active" during date range
 ; Input
 ;       DGIEN    - Pointer to PRF Assignment File (#26.13)
 ;       DGRANGE  - Array containg Start Date/End Date
 ;
 ; Output
 ;       DGRSLT: 1 - "Active"
 ;               0 - "Not Active"
 ;
 N DGDT,DGX,DGACT,DGRSLT,DGACT2,DGPRE,DGPST,DGRSLT,DGCNT,DGDTPRE,DGDTPST
 ;
 S DGRSLT=0
 ; Build array of actions fro processing
 S (DGCNT,DGDT)=0
 F  S DGDT=$O(^DGPF(26.14,"C",DGIEN,DGDT)) Q:'DGDT  D
 . S DGX=$O(^DGPF(26.14,"C",DGIEN,DGDT,0)) Q:'DGX
 . S DGACT(DGX)=$P($G(^DGPF(26.14,DGX,0)),U,3)_"^"_$P($P($G(^DGPF(26.14,DGX,0)),U,2),".")
 . S DGCNT=DGCNT+1
 S DGACT=DGCNT
 ;
 ; Check for last action of Entered in Error, if there is one, all previous actions are void
 ; Quit, returning inactive status
 S DGX=$O(DGACT(99999999),-1)
 I $P(DGACT(DGX),U)=5 S DGRSLT=0 G CHKQ
 ;
 ; Begin checking history file
 I DGRANGE["A" D
 . I DGACT=1 D  ; If only one entry, should be NEW, process as active
 .. S DGX=$O(DGACT(0))
 .. S DGRSLT=$S($P(DGACT(DGX),U)=1:1,1:0)
 . E  D
 .. S DGX=$O(DGACT(99999999),-1)
 .. I "3,5"[$P(DGACT(DGX),U) S DGRSLT=0 ; Check last entry for EiE or Inact
 .. E  S DGRSLT=1
 E  D
 . I $P($$ASGNDATE^DGPFAPIU(DGIEN),".")>DGRANGE("END") S DGRSLT=0 Q
 . S (DGACT2,DGX)=0
 . F  S DGX=$O(DGACT(DGX)) Q:'DGX  D
 .. I $P(DGACT(DGX),U,2)>DGRANGE("START")&($P(DGACT(DGX),U,2)<DGRANGE("END")) S DGACT2(DGX)=DGACT(DGX),DGACT2=DGACT2+1
 . ; If actions are found within the date range, process for active status.
 . I DGACT2>0 D
 .. S DGX=0 F  S DGX=$O(DGACT2(DGX)) Q:'DGX  D
 ... S DGRSLT=$S("1,2,4"[$P(DGACT2(DGX),U):1,1:0)
 . ; If no action entry is found within the date range specified, then try to determine the status from
 . ; the nearest action.
 . E  D
 .. S DGDTPRE=DGRANGE("START")_".999999"
 .. S DGDTPRE=$O(^DGPF(26.14,"C",DGIEN,DGDTPRE),-1)
 .. S DGPRE=$S(DGDTPRE>0:$O(^DGPF(26.14,"C",DGIEN,DGDTPRE,0)),1:0)
 .. S DGDTPST=$O(^DGPF(26.14,"C",DGIEN,DGRANGE("END")))
 .. S DGPST=$S(DGDTPST>0:$O(^DGPF(26.14,"C",DGIEN,DGDTPST,0)),1:0)
 .. S DGRSLT=$S("1,2,4"[$P(DGACT(DGPRE),U):1,1:0)
 .. I DGPST>0,$P(DGACT(DGPST),U)="5" S DGRSLT=0
 ;
CHKQ ;
 ;
 Q +$G(DGRSLT)
