PXVRPC8 ;ISP/LMT - PCE RPCs for Skin Tests ;Jan 18, 2023@14:49:16
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**216,217,233**;Aug 12, 1996;Build 3
 ;
 ;
 ; Reference to ^DIA(9999999.28,"C") in ICR #2602
 ;
 ;
SKSHORT(PXRSLT,PXDATE,PXFLTR,PXOREXC,PXLOC) ;
 ;
 ; Returns list of skin tests
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;    PXDATE - Date (optional; defaults to TODAY)
 ;             Used for determining skin test status
 ;    PXFLTR - Filter (Optional; Defaults to "S:A")
 ;             Possible values are:
 ;               R:X   - Return entry with IEN X.
 ;               N:X   - Return entry with #.01 field equal to X
 ;               S:A   - Return all active entries.
 ;               S:I   - Return all inactive entries.
 ;               S:B   - Return all entries (both active and inactive).
 ;   PXOREXC - Should entries defined in ORWPCE EXCLUDE SKIN TESTS be excluded? (optional)
 ;             Used when PXFLTR is set to S:x.
 ;     PXLOC - Used when excluding entries listed in ORWPCE EXCLUDE SKIN TESTS. (Optional)
 ;             This is the location used when getting the parameter value at the Location level.
 ;
 ;Returns:
 ;   (0)=Count of elements returned (0 if nothing found)
 ;   (n)=SK^IEN^NAME^PRINT NAME
 ;   (n)=CS^Coding System^Code^Variable pointer^Short Description
 ;
 N PXAUDIT,PXCNT,PXFLTRTYP,PXFLTRVAL,PXGETCSTAT,PXIEN,PXLST,PXNODE,PXSTAT
 ;
 I '$G(PXDATE) S PXDATE=DT
 I $P($G(PXFLTR),":",1)'?1(1"R",1"N",1"S") S PXFLTR="S:A"
 S PXFLTRTYP=$P(PXFLTR,":",1)
 S PXFLTRVAL=$P(PXFLTR,":",2)
 S PXCNT=0
 ;
 S PXAUDIT=0
 I $$GET1^DID(9999999.28,.03,"","AUDIT")="YES, ALWAYS" S PXAUDIT=1
 S PXGETCSTAT=$$GETCSTAT(PXDATE,PXAUDIT)
 ;
 I PXFLTRTYP="R" D
 . S PXIEN=PXFLTRVAL
 . I 'PXIEN Q
 . I '$D(^AUTTSK(PXIEN,0)) Q
 . D ADDENTRY(.PXRSLT,.PXCNT,.PXIEN,.PXDATE)
 ;
 I PXFLTRTYP="N" D
 . I PXFLTRVAL="" Q
 . S PXIEN=$O(^AUTTSK("B",PXFLTRVAL,0))
 . I 'PXIEN Q
 . D ADDENTRY(.PXRSLT,.PXCNT,.PXIEN,.PXDATE)
 ;
 I PXFLTRTYP="S" D
 . I PXFLTRVAL'?1(1"A",1"I",1"B") S PXFLTRVAL="A"
 . S PXIEN=0
 . F  S PXIEN=$O(^AUTTSK(PXIEN)) Q:'PXIEN  D
 . . I $G(PXOREXC),$$EXCLUDED^PXVRPC4(.PXLST,PXIEN,2,$G(PXLOC)) Q
 . . S PXSTAT=$$GETSTAT(PXIEN,PXDATE,PXGETCSTAT,PXAUDIT)
 . . I PXFLTRVAL="A",'PXSTAT Q
 . . I PXFLTRVAL="I",PXSTAT Q
 . . D ADDENTRY(.PXRSLT,.PXCNT,.PXIEN,.PXDATE)
 ;
 S PXRSLT(0)=PXCNT
 ;
 Q
 ;
ADDENTRY(PXRSLT,PXCNT,PXIEN,PXDATE) ;
 ;
 N PXNODE
 ;
 S PXCNT=$G(PXCNT)+1
 S PXNODE=$G(^AUTTSK(PXIEN,0))
 S PXRSLT(PXCNT)="SK^"_PXIEN_U_$P(PXNODE,U,1)_U_$P($G(^AUTTSK(PXIEN,12)),U,1)
 D GETCS(.PXRSLT,.PXCNT,.PXIEN,.PXDATE)
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
 ; Try first to get list from parameter
 D GETLST^XPAR(.PXRSLT,"ALL","PXV SKIN TEST ADMIN SITES","N")
 I $G(PXRSLT)>0 D  Q
 . S PXRSLT(0)=PXRSLT
 ;
 ; if parameter is not set, use these sites
 S PXSITES("RA")=""
 S PXSITES("LA")=""
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
SKLIST(PXRSLT,DFN,PXSK,PXDATE,PXMAX) ;
 ;
 ; Returns a list of V Skin Test entries that have been placed within the last x days.
 ; The number of days to look back is defined in the PXV SK DAYS BACK parameter.
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;       DFN - Patient's DFN (Required)
 ;             Only V Skin Test entries for this patient will be returned.
 ;      PXSK - Skin Test IEN (Optional)
 ;             If passed in, only V Skin Test entries for this Skin Test will be returned.
 ;             If not passed in, all V Skin Tests entries will be returned.
 ;    PXDATE - Date (Optional; defaults to Today)
 ;             The system will search back x number of days from this date.
 ;     PXMAX - The max number of entries to return per skin test (Optional)
 ;
 ;Returns:
 ;   (0)=Count of elements returned (0 if nothing found)
 ;   (1)=DATERANGE ^ Start Date ^ Stop Date
 ;   (n)=PLACEMENT ^ V Skin Test IEN ^ Skin Test IEN ^ Skin Test Name ^ Date/Time of Placement
 ;
 N PXARR,PXCNT,PXDAYSBACK,PXEVENTDT,PXI,PXNUM,PXSKIEN,PXSTART,PXSTOP,PXVSK0,PXVISIT,PXVSK
 N PXPPDIEN,PXSKNM,PXSORT1
 ;
 S PXCNT=0
 ;
 I '$G(DFN) D  Q
 . S PXRSLT(0)=PXCNT
 I '$G(PXDATE) S PXDATE=DT
 S PXSK=$G(PXSK)
 ;
 S PXPPDIEN=$O(^AUTTSK("B","PPD TUBERCULIN",0))
 I 'PXPPDIEN S PXPPDIEN=$O(^AUTTSK("AVUID",5198083,0))
 ;
 S PXSTOP=$P(PXDATE,".",1)
 S PXDAYSBACK=$$GET^XPAR("ALL","PXV SK DAYS BACK")
 I PXDAYSBACK<1 S PXDAYSBACK=7
 S PXSTART=$P($$FMADD^XLFDT(PXDATE,-PXDAYSBACK),".",1)
 ;
 S PXVSK=0
 F  S PXVSK=$O(^AUPNVSK("C",DFN,PXVSK)) Q:'PXVSK  D
 . S PXVSK0=$G(^AUPNVSK(PXVSK,0))
 . S PXSKIEN=$P(PXVSK0,U,1)
 . I 'PXSKIEN Q
 . I PXSK,PXSK'=PXSKIEN Q
 . ; if both Reading and Results are populated, quit
 . I $P(PXVSK0,U,4)'="",$P(PXVSK0,U,5)'="" Q
 . I $D(^AUPNVSK("APT",PXVSK)) Q
 . S PXEVENTDT=$P($G(^AUPNVSK(PXVSK,12)),U,1)
 . I 'PXEVENTDT D
 . . S PXVISIT=$P(PXVSK0,U,3)
 . . S PXEVENTDT=$P($G(^AUPNVSIT(+PXVISIT,0)),U,1)
 . I 'PXEVENTDT Q
 . I PXEVENTDT<PXSTART Q
 . I PXEVENTDT>(PXSTOP_".24") Q
 . S PXSKNM=$P($G(^AUTTSK(PXSKIEN,0)),U,1)
 . S PXSORT1=PXSKNM
 . ; Sort PPD first
 . I PXSKIEN=PXPPDIEN S PXSORT1="0"_PXSORT1
 . S PXARR(PXSORT1,PXEVENTDT)="PLACEMENT^"_PXVSK_U_PXSKIEN_U_PXSKNM_U_PXEVENTDT
 ;
 S PXCNT=PXCNT+1
 S PXRSLT(PXCNT)="DATERANGE"_U_PXSTART_U_PXSTOP
 ;
 S PXSORT1=""
 F  S PXSORT1=$O(PXARR(PXSORT1)) Q:PXSORT1=""  D
 . S PXNUM=0
 . S PXEVENTDT=""
 . F  S PXEVENTDT=$O(PXARR(PXSORT1,PXEVENTDT),-1) Q:'PXEVENTDT  D
 . . S PXNUM=PXNUM+1
 . . I $G(PXMAX),PXNUM>PXMAX Q
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)=$G(PXARR(PXSORT1,PXEVENTDT))
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
 ;
GETSKCD(PXRSLT,PXSK,PXDATE) ;
 ;
 N PXCNT,PXCODE,PXCODES,PXCODESYS,PXI,PXLEX,PXLEXADATE,PXLEXARY,PXLEXIDATE,PXLEXNODE
 I '$G(PXDATE) S PXDATE=$$NOW^XLFDT()
 S PXCNT=0
 D GETCS(.PXCODES,.PXCNT,PXSK,PXDATE)
 ;
 F PXI=1:1:PXCNT D
 . S PXCODESYS=$P($G(PXCODES(PXI)),U,2)
 . S PXRSLT(PXI)=$P($G(PXCODES(PXI)),U,2,5)_U_$S(PXCODESYS="CPT":"P",1:"B")
 ;
 S PXCODE=$$GET^XPAR("ALL","PXV SKIN TEST READING CPT",1,"I")
 I PXCODE="" Q
 S PXCODESYS="CPT"
 K PXLEXARY
 S PXLEX=$$PERIOD^LEXU(PXCODE,PXCODESYS,.PXLEXARY)
 I $P(PXLEX,U,1)=-1 Q
 S PXLEXADATE=$O(PXLEXARY((PXDATE+.00001)),-1)
 I PXLEXADATE="" Q
 S PXLEXNODE=$G(PXLEXARY(PXLEXADATE))
 S PXLEXIDATE=$P(PXLEXNODE,U,1)
 I PXLEXIDATE,PXDATE>PXLEXIDATE Q
 S PXCNT=PXCNT+1
 S PXRSLT(PXCNT)=PXCODESYS_U_PXCODE_U_$P(PXLEXNODE,U,3)_U_$P(PXLEXNODE,U,4)_U_"R"
 ;
 Q
