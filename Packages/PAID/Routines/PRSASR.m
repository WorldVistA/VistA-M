PRSASR ;HISC/MGD,WOIFO/JAH/PLT - Supervisor Certification ;02/05/2005
 ;;4.0;PAID;**2,7,8,22,37,43,82,93,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Called by Pay Per Cert Option on T&A Superv menu. Timecard 4 each 
 ;employee in this supervs T&L is displayed.  Superv prompted at each 
 ;display as to whether card is ready 4 certification. Cards that r
 ;ready r saved in ^TMP.  After this review--elect sign code is 
 ;required to release approved cards to payroll. Upon ES
 ; 8b, exceptions, & ot warnings r stored & timecard status 
 ;changed to 'P'--'released to payroll' 
 ;
 ;=====================================================================
 ;
 ;Set up reverse video ON & OFF for tour error highlighting
 N IORVOFF,IORVON,IOINHI,IOINORM,IOBOFF,IOBON,RESP
 S X="IORVOFF;IORVON;IOBOFF;IOBON;IOINHI;IOINORM" D ENDR^%ZISS
 ;
 N MIDPP,DUMMY
 S MIDPP="In middle of Pay Period; Cannot Certify & Release."
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?27,"SUPERVISORY CERTIFICATION"
 S PRSTLV=3 D ^PRSAUTL G:TLI<1 EX
 D NOW^%DTC
 S DT=%\1,APDT=%,Y=$G(^PRST(458,"AD",DT)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I DAY>5,DAY<11 W $C(7),!!,MIDPP G EX
 I DAY<6 S X1=DT,X2=-7 D C^%DTC S PPI=$P($G(^PRST(458,"AD",X)),"^",1) G:'PPI EX
 ;     -----------------------------------------
P0 ;PDT     = string of pay period dates with format - Sun 29-Sep-96^
 ;PDTI    = string of pay period dates in fileman format.
 ;PPI     = pay period internal entry number in file 458.
 ;GLOB    = global reference for employees pay period record
 ;          returned from $$AVAILREC & passed to UNLOCK.
 ;     -----------------------------------------
 ;
 S PDT=$G(^PRST(458,PPI,2)),PDTI=$G(^(1)),QT=0 K ^TMP($J)
 ;
 ;     -----------------------------------------
 ;Loop thru this supervisor's T&L unit on x-ref in 450.
 ;$$availrec() ensures there's data & node with employee's 
 ;pay period record is NOT locked, then locks node.
 ;Call to CHK checks for needed approvals for current employee
 ;If supervisor decides record is not ready, during this call,
 ;then node is unlocked.  Records that super accepts for release
 ;are not unlocked until they are processed thru temp global
 ;& their status' are updated.
 ;     ---------------------------------------------------
 ;
 S NN="",CKS=1
 F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $$AVAILREC^PRSLIB00("SUP",.GLOB) D CHK I QT G T0
 ;
 ;     ---------------------------------------------------
 ;Loop through T&L unit file x-ref 2 c if this supervisor certifies
 ;payperiod data for other supervisors of other T&L units.  If so
 ;process after ensuring node to be certified is available.
 ;     ---------------------------------------------------
 ;
 S CKS=0
 F VA2=0:0 S VA2=$$TLSUP Q:VA2<1  S SSN=$$SSN I SSN'="" S DFN=$$DFN S Z=$P($G(^PRSPC(+DFN,0)),"^",8) I Z'="",Z'=TLE,$$AVAILREC^PRSLIB00("SUP",.GLOB) D CHK I QT G EX:'$T,T0
 ;
 ;     ---------------------------------------------------
T0 I $D(^TMP($J,"E")) G T1
 W !!,"No records have been selected for certification."
 S DUMMY=$$ASK^PRSLIB00(1) G EX
 ;
 ;     ---------------------------------------------------
 ;
T1 ;if supervisor signs off then update all records in tmp
 ;otherwise remove any auto posting.
 D ^PRSAES I ESOK D
 .D NOW^%DTC S APDT=%
 .F DFN=0:0 S DFN=$O(^TMP($J,"E",DFN)) Q:DFN<1  S VAL=$G(^(DFN)) D PROC
 I 'ESOK D
 .F DFN=0:0 S DFN=$O(^TMP($J,"E",DFN)) Q:DFN<1  D
 ..D AUTOPINI^PRS8(PPI,DFN)
 D EX
 Q
 ;
 ;     ---------------------------------------------------
CHK ; Check for needed approvals
 N PRSENT,PRSWOC
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) I "PX"[STAT Q
 I USR=DFN Q:'$D(^XUSEC("PRSA SIGN",DUZ))
 E  I CKS S SSN=$P($G(^PRSPC(DFN,0)),"^",9) I SSN S EDUZ=+$O(^VA(200,"SSN",SSN,0)) I $D(^PRST(455.5,"AS",EDUZ,TLI)) Q:$P($G(^PRST(455.5,TLI,"S",EDUZ,0)),"^",2)'=TLE
 S HDR=0 D HDR,^PRSAENT S PRSENT=ENT
 ;
 ;Loop to display tour, exceptions(leave, etc..) & errors.
 ;
 S (XF,X9)=0
 F DAY=1:1:14 D TOURERR($P(PDT,"^",DAY),.X9,.XF) D:$Y>(IOSL-6)&(DAY<14) HDR G:QT O1
 ;
 ;Display VCS commission sales, if applicable
 S Z=$G(^PRST(458,PPI,"E",DFN,2))
 I Z'="" D:$Y>(IOSL-11) HDR Q:QT  D VCS^PRSASR1
 ;
 ;
 S Z=$G(^PRST(458,PPI,"E",DFN,4))
 I Z'="" D:$Y>(IOSL-9) HDR Q:QT  D ED^PRSASR1
 I XF W !,IORVON,"Serious error; cannot release.",IORVOFF S QT=$$ASK^PRSLIB00() Q
 S QT=$$ASK^PRSLIB00() Q:QT
 ;
 ;PRS8 call creates & stores 8B string in employees attendance
 ;record.  Later, under a payroll option, string will be
 ;transmitted to Austin.
 ;
 N NN D ONE^PRS8 S C0=$G(^PRSPC(DFN,0)),PY=PPI D CERT^PRS8VW S QT=0
 ;
 ;Show OT (approve-vs-8B) warning & save in TMP.
 N WK,OTERR,O8,OA
 F WK=1:1:2 D
 .  D WARNSUP^PRSAOTT(PPE,DFN,VAL,WK,.OTERR,.O8,.OA)
 .  I OTERR S ^TMP($J,"OT",DFN,WK)=O8_"^"_OA
 ;
 ;warning message for rs/rn and on type of time
 I $E(PRSENT,5) D
 . I @($TR($$CD8B^PRSU1B2(VAL,"RS^3^RN^3",1),U,"+")_"-("_$TR($$RSHR^PRSU1B2(DFN,PPI),U,"+")_")") W !,?3,"WARNING: The total scheduled recess hours for this pay period does not match the total RS/RN posted."
 . I $G(PRSWOC)]"" W !,?3,"Warning: The entire tour for day# ",PRSWOC," is posted RECESS. The On-Call will be paid unless posted UNAVAILABLE."
 . QUIT
 ;
LD ; Check for changes to the Labor Distribution Codes made during the pay
 ; period.
 I $D(^PRST(458,PPI,"E",DFN,"LDAUD")) D LD^PRSASR1
 ;     ---------------------------------------------------
OK ;Prompt Supervisor to release timecard.  If yes, store in ^TMP(.
 ;If supervisor answers no then bypass & unlock record.
 ;     ---------------------------------------------------
 W !!,IORVON,"Release to Payroll?",IORVOFF," "
 R X:DTIME S:'$T!(X["^") QT=1 Q:QT  S:X="" X="*" S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W $C(7)," Answer YES or NO" G OK
 I X?1"Y".E S ^TMP($J,"E",DFN)=VAL
 E  D
 .  D AUTOPINI^PRS8(PPI,DFN) ; remove any auto posting
 .  D UNLOCK^PRSLIB00(GLOB) ; unlock record
 .  K ^TMP($J,"LOCK",DFN) ;clean out of local lock list.
O1 Q
 ;
PROC ; Set Approval, file any exceptions & update 8B string
 ;
 ; get employees entitlement string in variable A1
 D ^PRSAENT
 ;
 ; set approvals
 S $P(^PRST(458,PPI,"E",DFN,0),"^",3,5)=DUZ_"^"_APDT_"^"_A1
 ; VCS approval
 I $D(^PRST(458,PPI,"E",DFN,2)) S $P(^(2),"^",17,18)=DUZ_"^"_APDT
 ;
 ; loop thru any exceptions & file in 458.5
 I $D(^TMP($J,"X",DFN)) S K="" F  S K=$O(^TMP($J,"X",DFN,K)) Q:K=""  S DAY=$P(K," ",1),X1=$P(PDTI,"^",DAY),X2=$G(^(K)) D ^PRSATPF
 ;
 ; file overtime warnings
 F WK=1:1:2 I $G(^TMP($J,"OT",DFN,WK))'="" D
 .  S O8=$P(^TMP($J,"OT",DFN,WK),"^")
 .  S OA=$P(^TMP($J,"OT",DFN,WK),"^",2)
 .  D FILEOTW^PRSAOTTF(PPI,DFN,WK,O8,OA)
 ;
 ;set 8b string & change status of timecard to payroll
 S ^PRST(458,PPI,"E",DFN,5)=VAL S $P(^PRST(458,PPI,"E",DFN,0),"^",2)="P"
 ;
 ; If employee is a PT Phys w/ memo update hours credited
 D PTP^PRSASR1(DFN,PPI)
 ;
 ;unlock employees time card record
 S GLOB="^PRST(458,"_PPI_","_"""E"""_","_DFN_",0)"
 D UNLOCK^PRSLIB00(GLOB)
 K ^TMP($J,"LOCK",DFN) ;clean out of local lock list.
 Q
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ;
HDR ; Display Header
 I HDR S QT=$$ASK^PRSLIB00() Q:QT
 S X=$G(^PRSPC(DFN,0)) W !,@IOF,?3,$P(X,"^",1) S X=$P(X,"^",9) I X W ?68,$E(X),"XX-XX-",$E(X,6,9) S HDR=1
 W !,?6,"Date",?20,"Scheduled Tour",?40,"Tour Exceptions",?63,IORVON,"Tour Errors",IORVOFF
 W !?3 F I=1:1:72 W "-"
 Q
 ;====================================================================
HDR2 ; Display Header don't quit
 N HOLD
 S HOLD=$$ASK^PRSLIB00(1)
 S X=$G(^PRSPC(DFN,0)) W !,@IOF,?3,$P(X,"^",1) S X=$P(X,"^",9) I X W ?68,$E(X),"XX-XX-",$E(X,6,9)
 W !,?6,"Date",?20,"Scheduled Tour",?40,"Tour Exceptions",?63,IORVON,"Tour Errors",IORVOFF
 W !?3 F I=1:1:72 W "-"
 Q
 ;====================================================================
 ;
EX ; clean up variables & unlock any leftover time card nodes
 N EMPREC
 S EMPREC=""
 F  S EMPREC=$O(^TMP($J,"LOCK",EMPREC))  Q:EMPREC=""  D
 .  S GLOB="^PRST(458,"_PPI_","_"""E"""_","_EMPREC_",0)"
 .  D UNLOCK^PRSLIB00(GLOB)
 K ^TMP($J) G KILL^XUSCLEAN
 Q
 ;
 ;
 ;These extrinsic functions simply remove lengthy code from long, 
 ;single line, nested loop.
 ;     ---------------------------------------------------
TLSUP() ;get next supervisor who certifies other supervisors
 Q $O(^PRST(455.5,"ASX",TLE,VA2))
 ;     ---------------------------------------------------
SSN() ;get ssn of supervisor to be certified by this supervisor.
 Q $P($G(^VA(200,VA2,1)),"^",9)
 ;     ---------------------------------------------------
DFN() ;get internal entry number of supvisor of other T&L 2b approved
 ;by current supervisor.
 Q $O(^PRSPC("SSN",SSN,0))
 ;====================================================================
TOURERR(DTE,X9,XF) ;DISPLAY TOUR & ERRORS
 ;
 N IORVOFF,IORVON,RESP,ERRLEN
 S X="IORVOFF;IORVON" D ENDR^%ZISS
 D F1^PRSADP1,^PRSATPE
 F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  D
 . I $Y>(IOSL-4) D HDR2
 . W:K>1 !
 . W:$D(Y1(K)) ?21,Y1(K)
 . W:$P($G(Y2(K)),"^")'="" ?45,$P(Y2(K),"^",1)
 . I $P($G(Y2(K)),"^",2)'="" W:$X>44 ! W ?45,$P(Y2(K),"^",2)
 W:Y3'="" !?10,Y3
 I $D(ER) S:FATAL XF=1 F K=0:0 S K=$O(ER(K)) Q:K<1  D
 .  I $Y>(IOSL-4) D HDR2
 .  S ERRLEN=$S($P(ER(K),U,2)'="":$L(ER(K)),1:$L($P($G(ER(K)),U))+1)
 .  W:X9!((ERRLEN+1)>(IOM-$X)) !
 .  W ?(IOM-(ERRLEN+1)),IORVON
 .  W:$P(ER(K),"^",2)'="" $P(ER(K),"^",2)
 .  W " ",$P(ER(K),"^",1),IORVOFF
 .  S X9=0 S:'XF ^TMP($J,"X",DFN,DAY_" "_K)=ER(K)
 .  Q
 Q
