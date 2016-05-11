PSOSUPAT ;BIR/RTR - Pull all Rx's from suspense for a patient ;03/01/96
 ;;7.0;OUTPATIENT PHARMACY;**8,130,185,427**;DEC 1997;Build 21
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSSLOCK supported by DBIA 2789
PAT N PSOALRX,PSOALRXS
 S POP=0 K RXP,RXRR,RXFL,RXRP,RXPR,ASKED,BC,DELCNT,WARN,PSOAL,PSOPROFL,PSOQFLAG,PSOPULL,PSOWIN,PSOWINEN,PPLHOLD,PPLHOLDX
 W ! S DIR("A")="Are you entering the patient name or barcode",DIR(0)="SBO^P:Patient Name;B:Barcode"
 S DIR("?")="Enter P if you are going to enter the patient name. Enter B if you are going to enter or wand the barcode."
 D ^DIR K DIR G:$D(DIRUT) ^PSOSUPRX S BC=Y D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2)
BC S (OUT,POP)=0 I BC="B" W ! S DIR("A")="Enter/wand barcode",DIR(0)="FO^5:20",DIR("?")="Enter or wand a prescription barcode for the patient you wish to pull all Rx's for" D ^DIR K DIR G:$G(DIRUT) PAT S BCNUM=Y D
 .D PSOINST Q:OUT  S RX=$P(BCNUM,"-",2) D:$D(^PSRX(RX,0))
 ..S (DFN,PSODFN)=$P(^PSRX(RX,0),"^",2) W " ",$P($G(^DPT(DFN,0)),"^")
 ..D ICN^PSODPT(DFN)
 .I '$D(^PSRX(RX,0)) W !,$C(7),"NO PRESCRIPTION RECORD FOR THIS BARCODE." S OUT=1
 G:OUT BC
NAM I BC="P" W ! S DIC(0)="AEMZQ",DIC="^DPT(",DIC("S")="I $D(^PS(52.5,""AC"",+Y))!($D(^PS(52.5,""AG"",+Y)))" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) PAT S (DFN,PSODFN)=+Y
 S PSOLOUD=1 D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN) K PSOLOUD
 ;
 ; PSO*7*427 - DMB - 7/24/2015 - Remove call to QUES^PSOSUPRX so that a ECME reject would not cause the entire process to abort.  TEST/BEG still checks
 ;   for valid data, labels already printed, and locks but does not build PPLHOLD/arrays nor does it call QUES^PSOSPRX. If there still valid Rx's
 ;   to process, then ask Routing, Pickup Method and whether to Pull the Rx's.  After that, we call ECME (but only quit for each
 ;   RX if it fails), then add to PPLHOLD/arrays, and update the Routing/Pickup Method for RX SUSPENSE and the RX.
 S (ASKED,DELCNT,WARN)=0
 F CBD=0:0 S CBD=$O(^PS(55,DFN,"P",CBD)) Q:CBD'>0  D TEST
 I $G(PSOQFLAG) G EXIT
 ;
 ; After the TEST/BEG checks, check if there are any prescription left to process
 I '$D(PSOALRXS) W !!,"There are no prescriptions left to process - exiting!" D PAUSE G EXIT
 ;
 ; Get Routing
 W !
 K DIR,DTOUT S DIR("A")="Select routing for Rx(s)",DIR(0)="S^M:MAIL;W:WINDOW",DIR("B")="WINDOW" D ^DIR S MW=Y
 I Y["^"!($D(DTOUT)) W !!,"Nothing pulled from suspense!" D PAUSE G EXIT
 I MW="W" S SUSROUTE=1
 ;
 ; If Routing is Window and site paramter to ask Method of Pickup, then get Method of Pickup
 I MW="W",$P(PSOPAR,"^",12) K DIR,DTOUT,DUOUT S DIR(0)="52,35" D ^DIR S PSOWIN=1,PSOWINEN=Y I $G(DTOUT)!$G(DUOUT) W !!,"Nothing pulled from suspense!" D PAUSE G EXIT
 ;
 ; Ask to Pull Rx's
 W !!
 K DIR
 S DIR("A")="Pull Rx(s) and delete from suspense",DIR("B")="Y",DIR(0)="Y"
 S DIR("?",1)="Enter Yes to pull selected Rx(s) from suspense. Since Rx(s) pulled early from",DIR("?",2)="suspense are not associated with a printed batch, these Rx(s) cannot be"
 S DIR("?",3)="reprinted from suspense using the 'Reprint batches from Suspense' option.",DIR("?")="Therefore, any Rx(s) pulled early from suspense will be deleted from suspense."
 D ^DIR
 I Y'=1 W $C(7),!!,"Nothing pulled from suspense!" D PAUSE G EXIT
 ;
 ; Loop through the remaining Rx and process
 S RXREC="" F  S RXREC=$O(PSOALRXS(RXREC)) Q:RXREC=""  D
 . ; Resubmit to ECME if needed and check results
 . N RFL S RFL=$P(PSOALRXS(RXREC),U,1) I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RXREC)
 . D ECMESND^PSOBPSU1(RXREC,RFL,,"PE")
 . I $$PSOET^PSOREJP3(RXREC,RFL) Q  ; Quit if there is an unresolved TRICARE/CHAMPVA non-billable reject code
 . N PSOTRIC S PSOTRIC=$$TRIC^PSOREJP1(RXREC,RFL)
 . I $$FIND^PSOREJUT(RXREC,RFL),$$HDLG^PSOREJU1(RXREC,RFL,"79,88","PE","IOQ","I")="Q" Q
 . I $P($G(^PSRX(RXREC,"STA")),"^")=12 Q  ;No label if discontinued via Reject Notification screen
 . ;
 . ; Put on queue to be printed
 . S SFN=$P(PSOALRXS(RXREC),U,2)
 . S DA=$P(^PS(52.5,SFN,0),"^"),RXPR(DA)=+$P(^(0),"^",5),RXFL(DA)=$P($G(^(0)),"^",13)
 . I $L($G(PPLHOLD))<240 S PPLHOLD=$S($G(PPLHOLD)="":$P(^PS(52.5,SFN,0),"^"),1:$G(PPLHOLD)_","_+^PS(52.5,SFN,0)) S:$P(^PS(52.5,SFN,0),"^",12) RXRP(DA)=1
 . I $L($G(PPLHOLD))'<240 S PPLHOLDX=$S($G(PPLHOLDX)="":$P(^PS(52.5,SFN,0),"^"),1:$G(PPLHOLDX)_","_+^PS(52.5,SFN,0)) S:$G(RXPR(DA)) RXPR1(DA)=DA_"^"_RXPR(DA) S:$P(^PS(52.5,SFN,0),"^",12) RXRP1(DA)=1 K RXPR(DA)
 . I '$D(^PSRX(RXREC,1)),'$G(RXPR(RXREC)),'$G(RXPR1(RXREC)) S PSOPROFL=1
 . ;
 . ; Save off old Routing/Method of Pickup values
 . S PSOGET="M" D GETMW^PSOSUPOE
 . S RXRR(RXREC)=$S($P(^PS(52.5,SFN,0),"^",4)="W":"W",1:"M")_"^"_$P($G(^PSRX(RXREC,"MP")),"^")_"^"_$G(PSOGETF)_"^"_$G(PSOGETFN)_"^"_$S($G(PSOGET)="W":"W",1:"M")
 . ;
 . ; Update Routing and Method of Pickup
 . S $P(^PS(52.5,SFN,0),"^",4)=MW
 . D MAIL
 ;
 ;S HOLDPROF=$G(PSOPROFL) K PSOPROFL
 ;I $D(PSOPART) S (PSOPULL,PSODBQ)=1 F RR=0:0 S RR=$O(PSOPART(RR)) Q:'RR  S PDUZ=DUZ,PPL=RR,RXP=PSOPART(RR) D Q^PSORXL
 ;S PSOPROFL=HOLDPROF I $D(ZTSK),'$G(PPLHOLD) W !!,"LABEL(S) ARE QUEUED TO PRINT",!
 F GGGG=0:0 S GGGG=$O(RXPR(GGGG)) Q:'GGGG  K:'$G(RXPR(GGGG)) RXPR(GGGG)
 K RXP,PPL S PDUZ=DUZ,PSONOPRT=1
 I $G(PPLHOLD)'="" S PPL=PPLHOLD S:$G(SUSROUTE) BBRX(1)=PPL S HOLDPPL=PPL,PSOPULL=1,PSODBQ=1,RXLTOP=1 D WIND^PSOSUPRX D Q^PSORXL I '$G(PSOQFLAG) W !!,"LABEL(S) ARE QUEUED TO PRINT",! S PPL=$P(HOLDPPL,",") D PRF D:'$G(PSOQFLAG)  S PSOQFLAG=0
 .I $P(PSOPAR,"^",8),$G(PSOPROFL) W !!,"PROFILE(S) ARE QUEUED TO PRINT"
 ;call to bingo board
 I $G(PPLHOLDX),'$G(PSOQGLAG),$G(SUSROUTE) S BBRX(2)=PPLHOLDX
 D:$G(BINGRTE)&($D(DISGROUP))&('$G(PSOQFLAG)) ^PSOBING1 K BINGRTE,BBRX
 I $G(PPLHOLDX),'$G(PSOQFLAG) D  S PDUZ=DUZ,PPL=PPLHOLDX,PSNP=0,(PSODBQ,PSOPULL)=1 D Q^PSORXL
 .F XXX=0:0 S XXX=$O(RXPR1(XXX)) Q:'XXX  S RXPR(XXX)=$P(RXPR1(XXX),"^",2)
 .F WWWW=0:0 S WWWW=$O(RXRP1(WWWW)) Q:'WWWW  S:$D(RXRP1(WWWW)) RXRP(WWWW)=1
 I $G(PSOQFLAG) D RESET
EXIT K ACT,BCNUM,CBD,CNT,COM,DA,DEAD,DEL,DELCNT,DFN,DIRUT,DR,DTOUT,DUOUT,DTTM,GG,HOLD,HOLDPPL,OUT,PSOPULL,PSOWIN,PSOWINEN,PSODBQ,PPLHOLD,PPLHOLDX,HOLDPROF,RR,ZZZZ,PSDNAME,PSDDDATE,ZTSK,WWWW,RXRP,RXRP1,PSONOPRT,RXFL,RXRR
 S PSOALRX="" F  S PSOALRX=$O(PSOALRXS(PSOALRX)) Q:PSOALRX=""  D PSOUL^PSSLOCK(PSOALRX)
 K MW,PDUZ,PPL,PRF,PSPOP,PSOPROFL,RF,RFCNT,RX,RXPR,RXPR1,RXREC,SFN,GGGG,STOP,SUB,VADM,WARN,X,Y,Y(0),%,%W,%Y,%Y1,RXLTOP,PSOGET,PSOGETF,PSOGETFN
 Q
 ;
TEST I $D(^PS(55,DFN,"P",CBD,0)) S RXREC=+^(0) I +$P($G(^PSRX(RXREC,"STA")),"^")=5,$D(^PS(52.5,"B",RXREC)) S SFN=+$O(^(RXREC,0)) Q:SFN'>0!($G(PSOQFLAG))!('$D(^PS(52.5,SFN,0)))  S PSPOP=0 D:$G(PSODIV) DIV I 'PSPOP D CHKDEAD Q:DEAD  D BEG
 Q
 ;
CHKDEAD D DEM^VADPT S PSDNAME=$G(VADM(1)) I VADM(1)="" W !?10,"PATIENT NAME UNKNOWN" S DEAD=0 Q
 I VADM(6)="" S DEAD=0 Q
 S PSDDDATE=$P(VADM(6),"^",2) F ZZZZ=0:0 S ZZZZ=$O(^PS(55,DFN,"P",ZZZZ)) Q:'ZZZZ  I $D(^PS(55,DFN,"P",ZZZZ,0)),$P($G(^(0)),"^") S (DA,RXREC)=$P(^(0),"^") I $O(^PS(52.5,"B",DA,0)) D DEAD
 Q
 ;
DEAD S HOLD=DA,REA="C",COM="Died ("_$G(PSDDDATE)_")",DA=RXREC,DEAD=1 D CAN^PSOCAN W:'$G(WARN) !!,?10,$G(PSDNAME)," DIED ",$G(PSDDDATE) S WARN=1,DA=HOLD K HOLD,REA
 Q
 ;
DIV I $D(^PS(52.5,SFN,0)),$D(^PSRX(+$P(^PS(52.5,SFN,0),"^"),2)),$P(^PS(52.5,SFN,0),"^",6)'=$G(PSOSITE) S RXREC=+$P(^PS(52.5,SFN,0),"^") D CKDIV
 Q
 ;
CKDIV I '$P($G(PSOSYS),"^",2) W !!?10,$C(7),"Rx # ",$P(^PSRX(RXREC,0),"^")," is not a valid choice. (Different Division)" S PSPOP=1 Q
 I $P($G(PSOSYS),"^",3) W !!?10,$C(7) S DIR("A")="Rx # "_$P(^PSRX(RXREC,0),"^")_" is from another division.  Continue",DIR(0)="Y",DIR("B")="Y" D ^DIR K DIR I $G(DIRUT)!('Y) S PSPOP=1
 Q
 ;
BEG I $P($G(^PSRX(RXREC,2)),"^",6)<DT,$P($G(^("STA")),"^")<11 D  S DIE=52,DA=RXREC,DR="100///"_11 D ^DIE S DA=SFN,DIK="^PS(52.5," D ^DIK K DIE,DA,DIK W !!,"Rx #"_$P(^PSRX(RXREC,0),"^")_" has expired!" D PAUSE Q
 .D EX^PSOSUTL
 I '$D(^PS(52.5,SFN,0)) K PSOAL Q
 I +$G(^PS(52.5,SFN,"P")) W !!,$C(7),">>> Rx #",$P(^PSRX(+$P(^(0),"^"),0),"^")_" has already been printed from suspense.",!,?5,"Use the reprint routine under the rx option to produce a label." D PAUSE Q
 ; PSO*7*427 - 7/24/2015
 ; Check if Label Log indicates a label was already printed. If it does, ask the user if they still
 ; want to print. If they don't, remove from Suspense queue, then quit.
 N PRNTED,REFILL
 S REFILL=$P($G(^PS(52.5,SFN,0)),"^",13)
 S PRNTED=$$PRINTED^PSOSULBL(SFN,RXREC,REFILL)
 I PRNTED N CONT S CONT=$$PRTQUES^PSOSUPRX(RXREC,REFILL) I CONT'=1 D  Q
 . I CONT=0 D REMOVE^PSOSULBL(SFN,RXREC,REFILL,DUZ,1,PRNTED)
 . I CONT=-1 W !,"This prescription will not be pulled but will be left on suspense." D PAUSE
 ;
 S PSOALRX=$P($G(^PS(52.5,SFN,0)),"^") I 'PSOALRX Q
 ;
 ; Check if we can lock the order
 D PSOL^PSSLOCK(PSOALRX) I '$G(PSOMSG) D  D PAUSE K PSOMSG,PSOALRX Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,"Rx: "_$P($G(^PSRX(PSOALRX,0)),"^")_" cannot be pulled from suspense.",!,$P($G(PSOMSG),"^",2),! Q
 .W !!,"Another person is editing Rx "_$P($G(^PSRX(PSOALRX,0)),"^"),!,"It cannot be pulled from suspense.",!
 ;
 ; Set array for Rx's that can still be processed
 S PSOALRXS(PSOALRX)=REFILL_"^"_SFN
 K PSOMSG,PSOALRX
 Q
 ;
PRF I $P(PSOPAR,"^",8),'$D(PRF(DFN)),$G(PSOPROFL) S HOLD=DFN D ^PSOPRF S DFN=HOLD,PRF(DFN)=""
 Q
 ;
PSOINST I '$D(^PSRX(+$P(Y,"-",2),0)) W !!,$C(7),"Non-existent prescription" S OUT=1 Q
 I $P(Y,"-")'=PSOINST W !!,$C(7),"The prescription is not from this institution." S OUT=1 Q
 Q
 ;
 ; Populate RX Suspense and RX with new Routing Code and Pickup Method
MAIL I $D(PSOWINEN),$G(PSOWIN) S ^PSRX(RXREC,"MP")=$S(PSOWINEN'="":PSOWINEN,1:"")
MAILS I $G(RXPR(RXREC)) S DA(1)=RXREC,DA=RXPR(RXREC),DIE="^PSRX("_DA(1)_",""P"",",DR=".02///"_MW D ^DIE K DIE Q
 I $G(RXPR1(RXREC)) S DA(1)=RXREC,DA=$P(RXPR1(RXREC),U,2),DIE="^PSRX("_DA(1)_",""P"",",DR=".02///"_MW D ^DIE K DIE Q
 S RFCNT=0 F RR=0:0 S RR=$O(^PSRX(RXREC,1,RR)) Q:'RR  S RFCNT=RR
 I 'RFCNT S DA=RXREC,DIE=52,DR="11///"_MW D ^DIE
 I RFCNT S DA(1)=RXREC,DA=RFCNT,DIE="^PSRX("_DA(1)_",1,",DR="2///"_MW D ^DIE
 K DIE,RFCNT,RR
 Q
 ;
RESET ;
 ; Reset Mail/Window value for all prescriptions in the RXRR array
 N PRSDA
 F PRSDA=0:0 S PRSDA=$O(RXRR(PRSDA)) Q:'PRSDA  D RESETRX(PRSDA)
 Q
 ;
RESETRX(RX) ;
 ; Reset fields in RX Suspense and Prescription files
 ; Input:
 ;   RX: Prescription IEN
 ;
 I '$G(RX) Q
 N SFN,PRMW,PRMP,PRFILL,PRFILLN,PRPSRX,DIE,DA,DR,DTOUT
 S SFN=$O(^PS(52.5,"B",RX,0))
 I 'SFN Q
 I '$D(^PS(52.5,SFN,0)) Q
 S PRMW=$S($P($G(RXRR(RX)),"^")="":"M",1:$P($G(RXRR(RX)),"^")),PRMP=$P($G(RXRR(RX)),"^",2)
 S PRFILL=$P($G(RXRR(RX)),"^",3),PRFILLN=$P($G(RXRR(RX)),"^",4)
 S PRPSRX=$S($P($G(RXRR(RX)),"^",5)="":"M",1:$P($G(RXRR(RX)),"^",5))
 I PRMW'="" S $P(^PS(52.5,SFN,0),"^",4)=PRMW D
 .I PRFILL="P" D  Q
 ..I $D(^PSRX(RX,"P",+$G(PRFILLN),0)) S $P(^PSRX(RX,"P",+$G(PRFILLN),0),"^",2)=$G(PRPSRX),$P(^PSRX(RX,"MP"),"^")=PRMP
 .I PRFILL="R",$G(PRFILLN) S DA(1)=RX,DA=PRFILLN,DIE="^PSRX("_DA(1)_",1,",DR="2////"_PRPSRX D ^DIE K DIE
 .I PRFILL="O" S DA=RX,DIE="^PSRX(",DR="11////"_PRPSRX D ^DIE K DIE
 .S $P(^PSRX(RX,"MP"),"^")=PRMP
 Q
 ;
PAUSE ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
