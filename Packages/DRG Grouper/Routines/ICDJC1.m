ICDJC1 ;ALB/ARH - DRG GROUPER CALCULATOR 2015 - ATTRIBUTES ;05/26/2016
 ;;18.0;DRG Grouper;**89**;Oct 20, 2000;Build 9
 ;
 ; DRG Calcuation for re-designed grouper ICD-10 2015, continuation
 ;
PRATT(ICDPR,ICDDATE,PRARR) ; get all attributes of Procedures - determine if event is Surgical or Medical and MDCs
 ;
 ; Input:  ICDPR(x) - array of Procedures into API,  ICDDATE - event date
 ; Output: PRARR    - 'O' if any procedure is an Operating Room procedure, 'N' if Non-OR only or blank
 ;                  - list of all MDC's associated with any of the Operating Room procedures, separated by ';'
 ;         PRARR(x) - pr ifn (#80.1) ^ O/N/blank for specific procedure w/'x' corresponds to entry in ICDPR array
 N PRI,PR,PRIFN,ATTLN K PRARR S PRARR=""
 ;
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  S PR=+$G(ICDPR(PRI)) S PRARR(PRI)=PR D
 . S PRIFN=$O(^ICDD(83.6,"B",PR,0)) Q:'PRIFN
 . S ATTLN=$$GETATT("PR",PRIFN,$G(ICDDATE))
 . S PRARR(PRI)=PR_U_$P(ATTLN,U,3) I PRARR'="O",$P(ATTLN,U,3)'="" S PRARR=$P(ATTLN,U,3)
 ;
 S PRARR=PRARR_U_$$GETMDC("PR",.ICDPR,$G(ICDDATE)) ; set event procedure attibutes - final OR/NonOR and MDC list
 Q
 ;
 ;
DXATT(ICDDX,ICDDATE,ICDEXP,DXARR) ; get all attributes of Diagnosis - determine if MCC or CC apply to event and MDCs
 ; the diagnosis event MDCs are determined by the primary Dx, based on the MDCs of its assigned code sets
 ; event MCC/CC is determined by secondary Dxs and the primary Dx if it is an MCC/CC of its Own
 ; the MCC/CC of a secondary Dx may be applied to the event DRG unless overridden by one of two cases:
 ; PDX is a member of the secondarys exclusion group or if patient has expired and MCC only if Alive
 ;
 ; Input:  ICDDX(x) - array of Dx into API,  ICDDATE - event date, ICDEXP - 1 if patient died before discharge
 ; Output: DXARR    - 'MCC' or 'CC' for event if either result from the diagnosis or blank
 ;                  - list if all MDC's associated with the Primary Diagnosis, separated by ';'
 ;         DXARR(x) - dx ifn (#80) ^ MCC/CC ^ exclude grp ^ alive exclude ^ (reserved HAC) ^  ^ MCC/CC applies
 N DXI,PDX,DX,DXIFN,ATTLN,DXCC,DXEXCL,DXALIVE,EXCLUDE,EXPIRED,CCMCC K DXARR S DXARR=""
 ;
 ; get primary diagnosis attributes to determine MCC/CC
 S DXI=+$O(ICDDX(0)),PDX=$G(ICDDX(DXI)) Q:'PDX  S DXARR(DXI)=PDX
 ;
 S DXIFN=$O(^ICDD(83.5,"B",PDX,0)) Q:'DXIFN
 S ATTLN=$$GETATT("DX",DXIFN,$G(ICDDATE))
 S DXCC=$S(+$P(ATTLN,U,4):"MCC",+$P(ATTLN,U,5):"CC",1:"") ; MCC/CC of its own
 S DXARR(DXI)=PDX_U_DXCC_U_0_U_0_U_U_U_DXCC
 ;
 ; get secondary diagnosis attributes to determine MCC/CC
 F  S DXI=$O(ICDDX(DXI)) Q:'DXI  S DX=+$G(ICDDX(DXI)) S DXARR(DXI)=DX D
 . ;
 . S DXIFN=$O(^ICDD(83.5,"B",DX,0)) Q:'DXIFN
 . S ATTLN=$$GETATT("DX",DXIFN,$G(ICDDATE))
 . S DXCC=$S(+$P(ATTLN,U,7):"MCC",+$P(ATTLN,U,8):"CC",1:"") ; MCC/CC
 . ;
 . S (EXPIRED,EXCLUDE)=0
 . S DXALIVE=$P(ATTLN,U,6) I +DXALIVE,+$G(ICDEXP) S EXPIRED=1 ; mcc only if alive but patient expired
 . S DXEXCL=$P(ATTLN,U,3) I DXEXCL'="",+$$EXCLD(PDX,DXEXCL,$G(ICDDATE)) S EXCLUDE=DXEXCL ; pdx in exclusion grp
 . ;
 . S CCMCC="" I 'EXCLUDE,'EXPIRED S CCMCC=DXCC
 . S DXARR(DXI)=DX_U_DXCC_U_EXCLUDE_U_EXPIRED_U_U_U_CCMCC
 ;
 S DXARR=$$GETEVT(.DXARR)_U_$$GETMDC("DX",.ICDDX,$G(ICDDATE)) ; get event attributes - final MCC/CC and MDC list
 Q
 ;
 ;
GETATT(TYP,CDIFN,DATE) ; get one codes Attributes for date, either diagnosis (83.5,10) or procedure (83.6,10)
 ; only one set of attributes may be active on a given date, returns entire node
 ; input:  TYP - type of codes 'DX' or 'PR', CDIFN - ptr to code in 83.5 or 83.6
 ; output: node of codes attributes active on date, if any, 83.5,10 or 83.6,10
 N IX,LINE,CDFILE,BEGIN,END,ATTLN S TYP=$G(TYP),CDIFN=+$G(CDIFN) S ATTLN="" I '$G(DATE) S DATE=DT
 S CDFILE=$S(TYP="DX":83.5,TYP="PR":83.6,1:0)
 ;
 S BEGIN=DATE+.00001 S BEGIN=+$O(^ICDD(CDFILE,CDIFN,10,"B",BEGIN),-1)
 S IX=+$O(^ICDD(CDFILE,CDIFN,10,"B",BEGIN,0))
 S LINE=$G(^ICDD(CDFILE,CDIFN,10,IX,0))
 S BEGIN=$P(LINE,U,1),END=$P(LINE,U,2) I 'END S END=9999999
 I DATE'<BEGIN,DATE'>END S ATTLN=LINE
 Q ATTLN
 ;
GETMDC(TYP,ICDARR,ICDDATE) ; get list of all MDC's the diagnosis/procedure codes are assigned to
 ; compile list of MDC's based on the codes assigned code sets (83.5,20&83.6,20), Primary Dx and OR Procedures only
 ; input:  TYP - type of codes 'DX' or 'PR', ICDARR is either diagnoais ICDDX or procedures ICDPRC
 ; output: returns list of codes MDC ID's - 00;03...  for Primary DX or all OR Procedures only
 N IX,CDFILE,CDIFN,CD,SETIFN,MDCIFN,MDC,MLIST,ARRCDS,ARRMDC S TYP=$G(TYP) S MLIST=""
 S CDFILE=$S(TYP="DX":83.5,TYP="PR":83.6,1:0)
 ;
 S IX=0 F  S IX=$O(ICDARR(IX)) Q:'IX  S CD=+$G(ICDARR(IX)) D  I TYP="DX" Q
 . S CDIFN=$O(^ICDD(CDFILE,"B",CD,0)) Q:'CDIFN
 . ;
 . I TYP="PR",$P($$GETATT("PR",CDIFN,$G(ICDDATE)),U,3)'="O" Q
 . ;
 . D GETCDS^ICDJC2(TYP,CDIFN,$G(ICDDATE),.ARRCDS,.ICDARR) ; get code sets on date for individual code
 . ;
 . S SETIFN=0 F  S SETIFN=$O(ARRCDS(SETIFN)) Q:'SETIFN  D  ; get MDC of all code sets the code is a member of
 .. S MDCIFN=$P($G(^ICDD(83.3,SETIFN,0)),U,2),MDC=$P($G(^ICDD(83,MDCIFN,0)),U,2) I MDC'="" S ARRMDC(MDC_";")=""
 ;
 ; list in order and no dups, separated by ';'
 S MDC="" F  S MDC=$O(ARRMDC(MDC)) Q:MDC=""  S MLIST=MLIST_MDC
 I MLIST'="" S MLIST=$E(MLIST,1,$L(MLIST)-1)
 Q MLIST
 ;
GETEVT(DXARR) ; get the events MCC/CC attribute, compiled from all diagnosis attributes
 ; check each dx for an MCC/CC that was not overridden and still applies, MCC highest priority then CC
 ; input:  DXARR list of each diagnosis attributes
 ; output: returns either MCC or CC or blank as the event attribute
 N DXEVT,DXI,CCMCC S DXEVT=""
 S DXI=0 F  S DXI=$O(DXARR(DXI)) Q:'DXI  S CCMCC=$P(DXARR(DXI),U,7) I CCMCC'="" S DXEVT=CCMCC I CCMCC="MCC" Q
 Q DXEVT
 ;
EXCLD(DX,EXCLGRP,DATE) ; determine if the Diagnosis is in the Exclusion group
 ; if primary Dx is member of a secondary Dxs Exclusion group then that secondary Dx can not impart MCC/CC to event
 ; input:  DX - ptr to 80, EXCLGRP - 4 character Exclusion Group ID (83.51, .01 and 83.5,10,.03)
 ; output: returns true if PDx is in SDx Exclusion group (83.51) on date and secondary Dxs MCC/CC should be ignored
 N LINE,EXIFN,BEGIN,END,EXCLUDE S EXCLUDE=0 S DX=+$G(DX) I '$G(DATE) S DATE=DT
 ;
 I $G(EXCLGRP)?4N S EXIFN=0 F  S EXIFN=$O(^ICDD(83.51,"ADE",DX,EXCLGRP,EXIFN)) Q:'EXIFN  D  Q:EXCLUDE
 . S LINE=$G(^ICDD(83.51,EXIFN,0))
 . S BEGIN=$P(LINE,U,3),END=$P(LINE,U,4) I 'END S END=9999999
 . I DATE'<BEGIN,DATE'>END S EXCLUDE=1
 Q EXCLUDE
 ;
 ;
 ;
DXHAC(ICDDX,ICDPR,ICDDATE,ICDPOA,DXARR) ; determine HAC for each Dx not POA (N,U), if found then re-set event MCC/CC
 ; identify any diagnosis defined as a HAC, if a Dx is HAC then its MCC/CC should be ignored
 ; a HAC applies only to diagnosis Not Present on Admission (N or U)
 ; if a Dx is Not Present on Admission (N,U) and a member of a HAC group then it can not impart MCC/CC to the event
 ; if the HAC group requires multiple Dx codes then the MCC/CC of all are screened out
 ; 
 ; Input:  ICDDX(x) and ICDPR(x)  - array of Dx/procedures input to API, ICDDATE - date of event
 ;         ICDPOA(x) - array of Dx POA input to API
 ;         DXARR(x)  - dx ifn ^ MCC/CC ^ exclude grp ^ alive exclude ^ (reserved HAC) ^  ^ MCC/CC applies
 ; Output: DXARR     - 'MCC' or 'CC' or blank, updated for any HAC Dx found
 ;         DXARR(x)  - (dx ifn) ^ (MCC/CC) ^ (exclude grp) ^ (alive exclude) ^ HAC Grp ^  ^ MCC/CC applies
 ;                   - if Dx is a member of a HAC group then 'HAC Grp' is set and 'MCC/CC applies' is updated
 ;                     to remove the Dxs MCC/CC from the event
 N FND,LINE,HCSIFN,HACCSE,HACIFN,HACID,DXI,ARRHCS,ARRHAC
 ;
 D HACSET(.ICDDX,.ICDPR,$G(ICDDATE),.ICDPOA,.ARRHCS) ; get all hac code sets defined by the event
 ;
 ; get HAC groups the identified hac code sets belong to, by case
 S HCSIFN=0 F  S HCSIFN=$O(ARRHCS(HCSIFN)) Q:'HCSIFN  D
 . S LINE=$G(^ICDD(83.71,HCSIFN,0)),HACCSE=$P(LINE,U,2)_U_+$P(LINE,U,5) S ARRHAC(HACCSE,HCSIFN)=""
 ;
 ; find the hac groups/cases with all code sets defined and update the diagnosis affected
 S HACCSE=0 F  S HACCSE=$O(ARRHAC(HACCSE)) Q:'HACCSE  S HACIFN=+HACCSE D
 . ;
 . ; for the hac group/case determine if all hac code sets are defined
 . S FND=1 S HCSIFN=0 F  S HCSIFN=$O(^ICDD(83.71,"D",+HACIFN,HCSIFN)) Q:'HCSIFN  D  Q:'FND
 .. I +$P($G(^ICDD(83.71,+HCSIFN,0)),U,5)=+$P(HACCSE,U,2) I '$D(ARRHCS(HCSIFN)) S FND=0
 . ;
 . ; if hac group fully defined, update each diagnosis in the group to indicate MCC/CC removed by hac
 . I +FND S HCSIFN=0 F  S HCSIFN=$O(ARRHAC(HACCSE,HCSIFN)) Q:'HCSIFN  D
 .. S HACID=$P($G(^ICDD(83.7,+HACIFN,0)),U,1)
 .. ;
 .. S DXI=0 F  S DXI=$O(ARRHCS(HCSIFN,"DX",DXI)) Q:'DXI  I $D(DXARR(DXI)) S $P(DXARR(DXI),U,5)=HACID,$P(DXARR(DXI),U,7)=""
 ;
 S DXARR=$$GETEVT(.DXARR)_U_$$GETMDC("DX",.ICDDX,$G(ICDDATE)) ; get event attributes, final MCC/CC and MDC list
 ;
 Q
 ;
HACSET(ICDDX,ICDPR,ICDDATE,ICDPOA,HCSARR) ; get all HAC Code Sets defined by event Diagnosis and Procedure codes
 ; a HAC only applies if Dx was not present on admission (N,U) and possibly only to secondary or primary Dx
 ; input:  ICDDX(x) and ICDPR(x)  - array of Dx/procedures input to API, ICDDATE - date of event
 ;         ICDPOA(x) - array of Dx POA input to API
 ; output: returns array of all HAC code sets applicable to the specific event
 ;         HCSARR( hac code set (83.71), "DX", x - code entry in ICDDX ) = "" 
 ;         HCSARR( hac code set (83.71), "PR", x - code entry in ICDPR ) = "" 
 N DXI,DX,DXIFN,POA,HCSIFN,LINE,PRI,PR,PRIFN,ARRHSX K HCSARR
 ;
 ; get all HAC sets defined by event diagnosis that are not POA
 S DXI=0 F  S DXI=$O(ICDDX(DXI)) Q:'DXI  S POA=$G(ICDPOA(DXI)) I (POA="N")!(POA="U") D
 . ;
 . ; get all hac code sets the dx is assigned to on date
 . S DX=+$G(ICDDX(DXI)) S DXIFN=$O(^ICDD(83.5,"B",DX,0)) Q:'DXIFN  D GETCDH("DX",DXIFN,$G(ICDDATE),.ARRHSX)
 . ;
 . ; for each hac set the dx is assigned, check if for this event the dx passes the hac set criteria (P/S)
 . S HCSIFN=0 F  S HCSIFN=$O(ARRHSX(HCSIFN)) Q:'HCSIFN  D
 .. S LINE=$G(^ICDD(83.71,HCSIFN,0)) Q:'HCSIFN
 .. ;
 .. I $P(LINE,U,4)="" S HCSARR(HCSIFN,"DX",DXI)="" Q  ; set for any type of dx
 .. I $P(LINE,U,4)="P",$O(ICDDX(0))=DXI S HCSARR(HCSIFN,"DX",DXI)="" Q   ; set for primary dx
 .. I $P(LINE,U,4)="S",$O(ICDDX(0))'=DXI S HCSARR(HCSIFN,"DX",DXI)="" Q   ; set for secondary dx
 ;
 ; get all HAC sets defined by the event procedures
 S PRI=0 F  S PRI=$O(ICDPR(PRI)) Q:'PRI  D
 . S PR=+$G(ICDPR(PRI)) S PRIFN=$O(^ICDD(83.6,"B",PR,0)) Q:'PRIFN  D GETCDH("PR",PRIFN,$G(ICDDATE),.ARRHSX)
 . ; 
 . S HCSIFN=0 F  S HCSIFN=$O(ARRHSX(HCSIFN)) Q:'HCSIFN  S HCSARR(HCSIFN,"PR",PRI)=""
 ;
 Q
 ;
GETCDH(TYP,CDIFN,DATE,ARRHSX) ; get HAC code sets for a single code on a date, either diagnosis (83.5,30) or procedure (83.6,30)
 ; input:  TYP - type of codes 'DX' or 'PR', CDIFN - ptr to code in 83.5 or 83.6
 ; output: ARRHSX - array of HAC code sets the Code is a member of on the date
 ;         ARRHSX(hac code set ifn (83.71)) = CDIFN
 N IX,LINE,CDFILE,BEGIN,END S TYP=$G(TYP),CDIFN=+$G(CDIFN) K ARRHSX I '$G(DATE) S DATE=DT
 S CDFILE=$S(TYP="DX":83.5,TYP="PR":83.6,1:0) I 'CDFILE Q
 ;
 S IX=0 F  S IX=$O(^ICDD(CDFILE,CDIFN,30,IX)) Q:'IX  D
 . S LINE=$G(^ICDD(CDFILE,CDIFN,30,IX,0)) Q:'LINE
 . S BEGIN=$P(LINE,U,1),END=$P(LINE,U,2) I 'END S END=9999999
 . I DATE'<BEGIN,DATE'>END S ARRHSX(+$P(LINE,U,3))=CDIFN
 Q
