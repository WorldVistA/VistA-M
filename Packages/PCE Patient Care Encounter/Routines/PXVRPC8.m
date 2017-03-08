PXVRPC8 ;BPFO/LMT - PCE RPCs for Skin Tests ;07/12/16  14:31
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**216**;Aug 12, 1996;Build 11
 ;
 ;
 ; External References           ICR#
 ; -------------------          -----
 ; ^DIA(9999999.28,"C")          2602
 ;
 ;
SKSHORT(PXRSLT,PXDATE) ;
 ;
 ; Returns active list of skin tests
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;    PXDATE - Date (optional; defaults to TODAY)
 ;             Used for determining skin test status
 ;
 ;Returns:
 ;   (0)=Count of elements returned (0 if nothing found)
 ;   (n)=SK^IEN^NAME^PRINT NAME
 ;   (n)=CS^Coding System^Code^Variable pointer^Short Description
 ;
 N PXAUDIT,PXCNT,PXGETCSTAT,PXIEN,PXNODE,PXSTAT
 ;
 I '$G(PXDATE) S PXDATE=DT
 S PXAUDIT=0
 I $$GET1^DID(9999999.28,.03,"","AUDIT")="YES, ALWAYS" S PXAUDIT=1
 S PXGETCSTAT=$$GETCSTAT(PXDATE,PXAUDIT)
 ;
 S PXCNT=0
 S PXIEN=0
 F  S PXIEN=$O(^AUTTSK(PXIEN)) Q:'PXIEN  D
 . S PXSTAT=$$GETSTAT(PXIEN,PXDATE,PXGETCSTAT,PXAUDIT)
 . I 'PXSTAT Q
 . S PXCNT=PXCNT+1
 . S PXNODE=$G(^AUTTSK(PXIEN,0))
 . S PXRSLT(PXCNT)="SK^"_PXIEN_U_$P(PXNODE,U,1)_U_$P($G(^AUTTSK(PXIEN,12)),U,1)
 . D GETCS(.PXRSLT,.PXCNT,.PXIEN,.PXDATE)
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
GETSTAT(PXSK,PXDATE,PXCURR,PXAUDIT) ;
 ;
 N PXLASTEDIT,PXSTAT
 ;
 I PXCURR Q '$P($G(^AUTTSK(PXSK,0)),U,3)
 ;
 I PXAUDIT D
 . S PXLASTEDIT=$P($$LAST^DIAUTL(9999999.28,PXSK,".03"),U,1)
 . I PXDATE>PXLASTEDIT S PXCURR=1
 I PXCURR Q '$P($G(^AUTTSK(PXSK,0)),U,3)
 ;
 S PXSTAT=$P($$GETSTAT^XTID(9999999.28,"",PXSK_",",$G(PXDATE)),U,1)
 I PXSTAT="" S PXSTAT=1
 Q PXSTAT
 ;
GETCSTAT(PXDATE,PXAUDIT) ;
 ;
 ; Should we get current status of SK entries or should we call GETSTAT^XTID
 ; to get status as of a specific date?
 ; Since GETSTAT^XTID is slow, we try to avoid it when possible.
 ;
 ; Returns: 0 - Call GETSTAT^XTID
 ;          1 - Get current status
 ;
 N PXLASTEDITDT,PXRSLT
 ;
 S PXRSLT=0
 ;
 I '$G(PXDATE) D  Q PXRSLT
 . S PXRSLT=1
 ;
 I $P(PXDATE,".",1)=DT D  Q PXRSLT
 . S PXRSLT=1
 ;
 ; If Inactive Flag is being audited (which should be the case)
 ; then get current status, if file has not been updated since PXDATE
 I PXAUDIT D
 . S PXLASTEDITDT=$O(^DIA(9999999.28,"C",""),-1)   ;ICR #2602
 . I PXDATE>PXLASTEDITDT S PXRSLT=1
 ;
 Q PXRSLT
 ;
SKSITES(PXRSLT) ;
 ;
 ; Returns a list of default sites for skin tests.
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;
 ;Returns:
 ;   (0)=Count of elements returned (0 if nothing found)
 ;   (n)=IEN^NAME
 ;   (n)=IEN^NAME
 ;
 N PXCNT,PXIEN,PXSITE,PXSITES
 ;
 S PXSITES("RLFA")=""
 S PXSITES("LLFA")=""
 ;
 S PXCNT=0
 ;
 S PXSITE=""
 F  S PXSITE=$O(PXSITES(PXSITE)) Q:PXSITE=""  D
 . S PXIEN=$O(^PXV(920.3,"B",PXSITE,0))
 . I 'PXIEN Q
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)=PXIEN_U_$P($G(^PXV(920.3,PXIEN,0)),U,1)
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
SKLIST(PXRSLT,DFN,PXSK,PXDATE) ;
 ;
 ; Returns a list of V Skin Test entries that have been placed within the last x days.
 ; The number of days to look back is defined in the PXV SK DAYS BACK paramater.
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;       DFN - Patient's DFN (Required)
 ;             Only V Skin Test entries for this patient will be returned.
 ;      PXSK - Skin Test IEN (Required)
 ;             Only V Skin Test entries for this Skin Test will be returned.
 ;    PXDATE - Date (Optional; defaults to Today)
 ;             The system will search back x number of days from this date.
 ;
 ;Returns:
 ;   (0)=Count of elements returned (0 if nothing found)
 ;   (n)=DATERANGE^Start Date^Stop Date
 ;   (n)=PLACEMENT^IEN^Skin Test Name^Date/Time of Placement
 ;
 N PXCNT,PXDAYSBACK,PXEVENTDT,PXSTART,PXSTOP,PXVSK0,PXVISIT,PXVSK
 ;
 S PXCNT=0
 ;
 I '$G(DFN) D  Q
 . S PXRSLT(0)=PXCNT
 I '$G(PXSK) D  Q
 . S PXRSLT(0)=PXCNT
 I '$G(PXDATE) S PXDATE=DT
 ;
 S PXSTOP=$P(PXDATE,".",1)
 S PXDAYSBACK=$$GET^XPAR("ALL","PXV SK DAYS BACK")
 I PXDAYSBACK<1 S PXDAYSBACK=7
 S PXSTART=$P($$FMADD^XLFDT(PXDATE,-PXDAYSBACK),".",1)
 ;
 S PXCNT=PXCNT+1
 S PXRSLT(PXCNT)="DATERANGE"_U_PXSTART_U_PXSTOP
 ;
 S PXVSK=0
 F  S PXVSK=$O(^AUPNVSK("C",DFN,PXVSK)) Q:'PXVSK  D
 . S PXVSK0=$G(^AUPNVSK(PXVSK,0))
 . I PXSK'=$P(PXVSK0,U,1) Q
 . ; if both Reading and Results are populated, quit
 . I $P(PXVSK0,U,4)'="",$P(PXVSK0,U,5)'="" Q
 . S PXEVENTDT=$P($G(^AUPNVSK(PXVSK,12)),U,1)
 . I 'PXEVENTDT D
 . . S PXVISIT=$P(PXVSK0,U,3)
 . . S PXEVENTDT=$P($G(^AUPNVSIT(+PXVISIT,0)),U,1)
 . I 'PXEVENTDT Q
 . I PXEVENTDT<PXSTART Q
 . I PXEVENTDT>(PXSTOP_".24") Q
 . S PXCNT=PXCNT+1
 . S PXRSLT(PXCNT)="PLACEMENT^"_PXVSK_U_$P($G(^AUTTSK(PXSK,0)),U,1)_U_PXEVENTDT
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
GETCS(PXRSLT,PXCNT,PXSK,PXDATE) ;
 ;
 N PXCODE,PXCODESYS,PXLEX,PXLEXADATE,PXLEXARY,PXLEXIDATE,PXLEXNODE,PXX,PXY
 ;
 S PXDATE=$P(PXDATE,".",1)
 ;
 S PXX=0
 F  S PXX=$O(^AUTTSK(PXSK,3,PXX)) Q:'PXX  D
 . S PXCODESYS=$G(^AUTTSK(PXSK,3,PXX,0))
 . I PXCODESYS="" Q
 . S PXY=0 F  S PXY=$O(^AUTTSK(PXSK,3,PXX,1,PXY)) Q:'PXY  D
 . . S PXCODE=$G(^AUTTSK(PXSK,3,PXX,1,PXY,0))
 . . I PXCODE="" Q
 . . ;
 . . K PXLEXARY
 . . S PXLEX=$$PERIOD^LEXU(PXCODE,PXCODESYS,.PXLEXARY)
 . . ;
 . . I $P(PXLEX,U,1)=-1 D  Q
 . . . I PXCODESYS?1(1"CPT",1"10D") Q
 . . . S PXCNT=PXCNT+1
 . . . S PXRSLT(PXCNT)="CS^"_PXCODESYS_U_PXCODE
 . . ;
 . . S PXLEXADATE=$O(PXLEXARY((PXDATE+.00001)),-1)
 . . I PXLEXADATE="" Q
 . . S PXLEXNODE=$G(PXLEXARY(PXLEXADATE))
 . . S PXLEXIDATE=$P(PXLEXNODE,U,1)
 . . I PXLEXIDATE,PXDATE>PXLEXIDATE Q
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)="CS^"_PXCODESYS_U_PXCODE_U_$P(PXLEXNODE,U,3)_U_$P(PXLEXNODE,U,4)
 ;
 Q
