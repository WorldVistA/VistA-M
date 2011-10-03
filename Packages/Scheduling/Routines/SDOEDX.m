SDOEDX ;ALB/MJK - ACRP DX APIs For An Encounter ;8/12/96
 ;;5.3;Scheduling;**131,556**;Aug 13, 1993;Build 3
 ;
DX(SDOE,SDERR) ; -- SDOE ASSIGNED A DIAGNOSIS
 ;   API ID: 64
 ;
 ;
 N SDOK
 S SDOK=0
 ;
 ; -- do validation checks
 IF '$$VALOE^SDOEOE(.SDOE,$G(SDERR)) G DXQ
 IF $$OLD^SDOEUT(SDOE) S SDOK=$$OLDDX(SDOE) G DXQ
 ;
 S SDOK=$$DX^PXAPIOE($$VIEN^SDOEUT(.SDOE),$G(SDERR))
DXQ Q SDOK
 ;
 ;
GETDX(SDOE,SDDX,SDERR) ; -- SDOE GET DIAGNOSES
 ;   API ID: 56
 ;
 ;
GETDXG ; -- goto entry point
 ;
 ; -- do validation checks
 IF '$$VALOE^SDOEOE(.SDOE,$G(SDERR)) G GETDXQ
 IF $$OLD^SDOEUT(SDOE) D OLDDXS(SDOE,.SDDX) G GETDXQ
 ;
 D GETDX^PXAPIOE($$VIEN^SDOEUT(.SDOE),.SDDX,$G(SDERR))
GETDXQ Q
 ;
 ;
FINDDX(SDOE,SDDXID,SDERR) ; -- SDOE FIND DIAGNOSIS
 ;   API ID: 70
 ;
 ;
 N SDDXS,SDOK,I
 S SDDXS="SDDXS"
 ;
 ; -- do validation checks
 IF '$$VALDX(.SDDXID,$G(SDERR)) S SDOK=0 G FINDDXQ
 ;
 D GETDX(.SDOE,.SDDXS,$G(SDERR))
 S (I,SDOK)=0
 F  S I=$O(SDDXS(I)) Q:'I  S SDOK=(+SDDXS(I)=SDDXID) Q:SDOK
FINDDXQ Q SDOK
 ;
 ;
GETPDX(SDOE,SDERR) ; -- SDOE GET PRIMARY DIAGNOSIS
 ;   API ID: 73
 ;
 ;
 N SDDXS,I,SDPDX,CNT
 S SDDXS="SDDXS"
 D GETDX(.SDOE,.SDDXS,$G(SDERR))
 ;
 ; -- how many are primaries / kill secondaries from array
 S (CNT,I)=0
 F  S I=$O(SDDXS(I)) Q:'I  S X=$P(SDDXS(I),"^",12) S:X="P" CNT=CNT+1 K:X'="P" SDDXS(I)
 S SDPDX=+$G(SDDXS(+$O(SDDXS(0))))
 ;
 ; -- check for too many primaries & build error msg
 IF CNT>1 D
 . N DFN,DFN0,SDIN,SDOUT,Y,I,VA
 . ;
 . S SDPDX=0
 . S DFN=+$P($G(^SCE(+SDOE,0)),"^",2)
 . S DFN0=$G(^DPT(DFN,0))
 . D PID^VADPT6
 . ;
 . S SDIN("ID")=SDOE,SDOUT("ID")=SDOE
 . S SDIN("DFN")=DFN,SDOUT("DFN")=DFN
 . S SDIN("PATNAME")=$P(DFN0,"^"),SDOUT("PATNAME")=$P(DFN0,"^")
 . S SDIN("PID")=VA("PID"),SDOUT("PID")=VA("PID")
 . ;
 . S I=0,Y=""
 . F  S I=$O(SDDX(I)) Q:'I  S Y=$P($G(^ICD9(+SDDXS,0)),"^")_"  "
 . S SDIN("CODES")=Y,SDOUT("CODES")=Y
 . ;
 . D BLD^SDQVAL(4096800.025,.SDIN,.SDOUT,$G(SDERR))
 ;
GETPDXQ Q SDPDX
 ;
 ;
VALDX(SDDXID,SDERR) ; -- validate dx input
 ;
 ; -- do checks
 ;IF SDDXID,$D(^ICD9(SDDXID,0)) Q 1
 I SDDXID,+$$ICDDX^ICDCODE(SDDXID)>0 Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("ID")=SDDXID
 S SDOUT("ID")=SDDXID
 D BLD^SDQVAL(4096800.004,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
OLDDX(SDOE) ; -- at least one dx for OLD encounter?
 Q ($O(^SDD(409.43,"OE",+SDOE,0))>0)
 ;
OLDDXS(SDOE,SDARY) ; -- get DX's for OLD encounter
 N SDIEN,SDCNT,Y,X
 S (SDIEN,SDCNT)=0
 F  S SDIEN=$O(^SDD(409.43,"OE",SDOE,SDIEN)) Q:'SDIEN  D
 . S SDCNT=SDCNT+1,X=$G(^SDD(409.43,SDIEN,0))
 . S $P(Y,U,1)=+X                           ; -- dx ien
 . S $P(Y,U,12)=$S($P(X,"^",3)=1:"P",1:"S") ; -- primary dx?
 . S @SDARY@(SDIEN)=Y
 S @SDARY=SDCNT
 Q
 ;
