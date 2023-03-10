PSOSUPRX ;BIR/RTR - Suspense pull early ;3/1/96
 ;;7.0;OUTPATIENT PHARMACY;**8,36,130,185,148,287,358,385,427,544,562**;DEC 1997;Build 19
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSSLOCK supported by DBIA 2789
ST N PSOPLLRX D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) ST
 N SUSROUTE,BBRX S SUSPT=1,PSLION=$G(PSOLAP),PSOQFLAG=0 W !! S DIR("A")="Print a specific Rx # or all Rx's for a patient",DIR(0)="SBO^S:SPECIFIC RX;A:ALL RXs FOR A PATIENT"
 S DIR("?",1)="Enter 'S' to print a suspended prescription label early.",DIR("?")="Enter 'A' to print all prescription suspense labels for a patient."
 D ^DIR K DIR S SA=Y G:$G(DIRUT)!(Y<0) EXIT I SA="A" D ^PSOSUPAT G EXIT
LU D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2) ;setup start time for bingo
 K SUSROUTE,BBRX,RXP,RXFL,RXRP,RXPR,RXRR
 K PSOPROFL,PSOE,RXP1,RXPR,PRF,PSOWIN,PSOWINEN S MW="" W ! S DIR("A")="Select SUSPENDED Rx #: ",DIR(0)="FOA",DIR("?")="Enter the Rx # or wand the barcode. For a list of suspense prescriptions, type '??'",DIR("??")="^D LIST^PSOSUPRX"
 S POP=0 D ^DIR K DIR G:$D(DIRUT)!('Y) ST S OUT=0 D:Y["-" PSOINST^PSOSUPAT G:OUT LU
 S:Y'["-" X=Y S:Y["-" Y=$P(Y,"-",2),X=$P(^PSRX(+Y,0),"^") K Y G:$G(X)="" ST K DIC W ! D  S DIC="^PS(52.5,",DIC(0)="ZQE" D ^DIC K DIC,PSOSPINT W ! G:$D(DTOUT)!($D(DUOUT)) ST G LU:Y<0 S RXREC=+Y(0),SFN=+Y
 .S PSOSPINT=X S DIC("S")="I $D(^PSRX(+$P(^PS(52.5,+Y,0),""^""),0)),$P($G(^(""STA"")),""^"")=5,$P($G(^(0)),""^"")=PSOSPINT"
 S PSOPLLRX=$G(RXREC) I PSOPLLRX D PSOL^PSSLOCK(PSOPLLRX) I '$G(PSOMSG) D  K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR K PSOMSG,PSOPLLRX,X,Y G LU
 .I $P($G(PSOMSG),"^",2)'="" W !,$P($G(PSOMSG),"^",2),! Q
 .W !,"Another person is editing this order.",!
 K PSOMSG
 S PSOLOUD=1 D:$P($G(^PS(55,$P(Y(0),"^",3),0)),"^",6)'=2 EN^PSOHLUP($P(Y(0),"^",3)) K PSOLOUD
 I $G(PSODIV),$P($G(^PS(52.5,SFN,0)),"^",6)'=$G(PSOSITE) S PSPOP=0,PSOSAV=Y,PSOSAVO=Y(0) D CKDIV^PSOSUPAT S Y=PSOSAV,Y(0)=PSOSAVO K PSOSAV,PSOSAVO,PSOPRFLG D:PSPOP UNLK G:PSPOP LU
 D CHKDEAD W:DEAD !!,?10,$G(PSDNAME)," DIED ",$G(PSDDDATE) D:'DEAD BEG D:$G(PSOQFLAG) RESET^PSOSUPAT K PSOQFLAG,PSOPULL D UNLK G LU
EXIT K ASKED,CBD,CNT,COM,DA,DEAD,DEL,DFN,DIRUT,DR,DTOUT,DUOUT,HOLDDFN,HDSFN,JJ,MW,OLD,OUT,PDUZ,PSODFN,TM,TM1,RXLTOP,RXRR,PSOGET,PSOGETF,PSOGETFN
 K PPL,PSOPULL,PSOWIN,PSOWINEN,PRF,PSODBQ,PSPOP,PSOQFLAG,PSOPROFL,RF,RFCNT,RX,RXP1,RXPR,RXREC,SA,SFN,STOP,SUSPT,VADM,ZTSK,RXFL
 K X,Y,Z,PSOPRFLG,PSDDDATE,PSDNAME,ZZZZ,RXRP Q
CHKDEAD S (DFN,PSODFN)=+$P(Y(0),"^",3) D DEM^VADPT S PSDNAME=$G(VADM(1)) I VADM(1)="" W !?10,"PATIENT UNKNOWN" S DEAD=0 Q
 I VADM(6)="" S DEAD=0 Q
 S PSDDDATE=$P(VADM(6),"^",2),(PDUZ,PSOCLC)=DUZ F ZZZZ=0:0 S ZZZZ=$O(^PS(55,DFN,"P",ZZZZ)) Q:'ZZZZ  I $D(^PS(55,DFN,"P",ZZZZ,0)),$P($G(^(0)),"^") S (DA,RXREC)=$P(^(0),"^") I $O(^PS(52.5,"B",DA,0)) D DEAD
 Q
DEAD S HOLD=DA,REA="C",COM="Died ("_$G(PSDDDATE)_")",DA=RXREC,DEAD=1 D CAN^PSOCAN S DA=HOLD K HOLD,REA Q
BEG S PDUZ=DUZ I +$G(^PS(52.5,SFN,"P")) W !,">>> Rx #",$P(^PSRX(+$P(^(0),"^"),0),"^")," ALREADY PRINTED FROM SUSPENSE.",!,?5,"USE THE REPRINT OPTION TO REPRINT LABEL.",! Q
 I +$P($G(^PSRX(RXREC,2)),"^",6)<DT,+$P($G(^("STA")),"^")<11 D  S DIE=52,DA=RXREC,DR="100///"_11 D ^DIE S DA=SFN,DIK="^PS(52.5," D ^DIK K DIE,DA,DIK W !,"Rx # "_$P(^PSRX(RXREC,0),"^")_" has expired!" F PSOE=1:1:3 W "." H 1
 .D EX^PSOSUTL
 I '$D(^PS(52.5,SFN,0)) K PSOE Q
 ; 
 ; PSO*7*427 - 7/24/2015
 ; Check if Label Log indicates a label was already printed. If it does, ask the user if they still
 ; want to print. If they don't, remove from Suspense queue, then quit.
 N PRNTED,REFILL
 S REFILL=$P($G(^PS(52.5,SFN,0)),"^",13)
 S PRNTED=$$PRINTED^PSOSULBL(SFN,RXREC,REFILL)
 I PRNTED N CONT S CONT=$$PRTQUES(RXREC,REFILL) I CONT'=1 D  Q
 . I CONT=0 D REMOVE^PSOSULBL(SFN,RXREC,REFILL,DUZ,1,PRNTED)
 . I CONT=-1 W !,"This prescription will not be pulled but will be left on suspense."
 ;
 D ICN^PSODPT(+$P(^PSRX(RXREC,0),"^",2))
 S RXFL(RXREC)=$P($G(^PS(52.5,SFN,0)),"^",13)
 S HDSFN=SFN,(PPL,DA)=RXREC S:$P(^PS(52.5,SFN,0),"^",5) (RXP1,RXPR(RXREC))=$P(^(0),"^",5)
 S:$P(^PS(52.5,SFN,0),"^",12) RXRP(RXREC)=1 D QUES Q:$G(PSOQFLAG)
 S (PSOPULL,PSODBQ,PSONOPRT)=1,RXLTOP=1 D WIND D Q^PSORXL S PPL=RXREC
 I '$G(PSOQFLAG) W !!,"LABEL QUEUED TO PRINT",! K RX
 I '$G(PSOQFLAG) D PRF D:'$G(PSOQFLAG)  S PSOQFLAG=0
 .S:'$G(PSOPROFL) PSOPRFLG=1 W:$G(PSOPROFL) !!,"PROFILE QUEUED TO PRINT"
 K PSONOPRT,RXPR,RXP1
 S PPL=RXREC
 ;call to bingo board
 S:$G(SUSROUTE) BBRX(1)=PPL
 D:$G(BINGRTE)&($D(DISGROUP))&('$G(PSOQFLAG)) ^PSOBING1 K BINGRTE,BBRX
 Q
 ; PSO*427-DMB-7/27/2015. PSOSUPAT (Pull Early for all Rx for a patient) used to call QUES. Because of that, the code below
 ; had checks to make sure that Routing, Method of P/U, and Pull Rx question was only asked for the first Rx.  Now that PSOSUPAT
 ; no longer calls QUES, those checks/variables were removed.
QUES ;
 ; Ask Routing, method of pickup, and whether to continue. Also update RX and RX Suspense records with new values. Save off old
 ; values in case we need to reset them later.
 W ! K DIR S DIR("A")="Select routing for Rx(s)",DIR(0)="S^M:MAIL;W:WINDOW",DIR("B")="WINDOW" D ^DIR K DIR S MW=Y I Y["^"!($D(DTOUT)) W !!?5,"Nothing pulled from suspense!",! S PSOQFLAG=1 Q
 S PSOGET="M" D GETMW^PSOSUPOE S RXRR(RXREC)=$S($P(^PS(52.5,SFN,0),"^",4)="W":"W",1:"M")_"^"_$P($G(^PSRX(RXREC,"MP")),"^")_"^"_$G(PSOGETF)_"^"_$G(PSOGETFN)_"^"_$S($G(PSOGET)="W":"W",1:"M")
 S:$G(MW)="W" SUSROUTE=1 S $P(^PS(52.5,SFN,0),"^",4)=$G(MW) D:$G(MW)="W"  Q:$G(PSOQFLAG)  D MAIL^PSOSUPAT
 .I $P(PSOPAR,"^",12) S DA=RXREC,DIE="^PSRX(",DR=35 D ^DIE S:$D(Y)!($D(DTOUT)) PSOQFLAG=1 Q:$G(PSOQFLAG)  S PSOWIN=1,PSOWINEN=$P($G(^PSRX(RXREC,"MP")),"^") Q
 W !! S DIR("A")="Pull Rx(s) and delete from suspense",DIR("B")="Y",DIR(0)="Y" D  D ^DIR K DIR I Y'=1 W $C(7),!!?5,"Nothing pulled from suspense!",! S PSOQFLAG=1 Q
 .S DIR("?",1)="Enter Yes to pull selected Rx(s) from suspense. Since Rx(s) pulled early from",DIR("?",2)="suspense are not associated with a printed batch, these Rx(s) cannot be"
 .S DIR("?",3)="reprinted from suspense using the 'Reprint batches from Suspense' option.",DIR("?")="Therefore, any Rx(s) pulled early from suspense will be deleted from suspense."
 S HDSFN=SFN
 ;
 ; - Submitting Rx to ECME for 3rd Party Billing
 N RFL S RFL=RXFL(RXREC) I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RXREC)
 ;
 ; Do not send a claim if the last submission was rejected and
 ; all rejects have been closed.
 ;
 I '$$SEND^PSOBPSU2(RXREC,RFL) Q
 ;
 D ECMESND^PSOBPSU1(RXREC,RFL,,"PE")
 ; Quit if there is an unresolved TRICARE/CHAMPVA non-billable reject code, PSO*7*358
 I $$PSOET^PSOREJP3(RXREC,RFL) S PSOQFLAG=1 Q
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RXREC,RFL,.PSOTRIC)
 I $$FIND^PSOREJUT(RXREC,RFL),$$HDLG^PSOREJU1(RXREC,RFL,"79,88,943","PE","IOQ","I")="Q" S PSOQFLAG=1 Q
 I $P($G(^PSRX(RXREC,"STA")),"^")=12 S PSOQFLAG=1 Q  ;No label if discontinued via Reject Notification screen
 ;
 Q
PRF S:'$D(DFN) DFN=+$P(^PS(52.5,SFN,0),"^",3) I $P(PSOPAR,"^",8),'$D(^PSRX(RXREC,1)),'$D(PRF(DFN)),'$G(RXP1) S PSOPROFL=1,HOLDDFN=DFN D ^PSOPRF S DFN=HOLDDFN K HOLDDFN S PRF(DFN)=""
 Q
LIST S X="?",DIC("S")="I $D(^PSRX(+$P(^PS(52.5,+Y,0),""^""),0)),$P($G(^(""STA"")),""^"")=5",DIC="^PS(52.5,",DIC(0)="ZQ" D ^DIC K DIC W ! Q:Y<0!($D(DTOUT))  Q
NEXT S PSOX("IRXN")=RX D NEXT^PSOUTIL(.PSOX) S NEXT=$P(PSOX("RX3"),"^",2)
 S DA=RX,DIE=52,DR="102///"_NEXT D ^DIE K DIE Q:$D(DTOUT)!($D(DUOUT))
 K NEXT,PSOX Q
WIND ;
 N RRT,RRTT,XXXX,JJJJ,PSINTRX,RTETEST,PSOPSO,SSSS
 S BINGRTE=0
 S RRT=1 F XXXX=1:1:$L(PPL) S RRTT=$E(PPL,XXXX) I RRTT="," S RRT=RRT+1
 F JJJJ=1:1:RRT Q:$G(BINGRTE)  S PSINTRX=$P(PPL,",",JJJJ) I $D(^PSRX(+PSINTRX,0)) D
 .I $G(RXPR(PSINTRX)) S RTETEST=$P($G(^PSRX(PSINTRX,"P",RXPR(PSINTRX),0)),"^",2) S:RTETEST="W" BINGRTE=1 Q
 .S PSOPSO=0 F SSSS=0:0 S SSSS=$O(^PSRX(PSINTRX,1,SSSS)) Q:'SSSS  S PSOPSO=SSSS
 .I 'PSOPSO S RTETEST=$P($G(^PSRX(PSINTRX,0)),"^",11) S:RTETEST="W" BINGRTE=1 Q
 .I PSOPSO S RTETEST=$P($G(^PSRX(PSINTRX,1,PSOPSO,0)),"^",2) S:RTETEST="W" BINGRTE=1 Q
 Q
UNLK ;Unlock prescription
 Q:'$G(PSOPLLRX)
 D PSOUL^PSSLOCK(PSOPLLRX)
 K PSOPLLRX
 Q
 ;
PRTQUES(RX,RFL) ;
 ; Prompt if the user wants to continue when a label has been printed already
 ; Input:
 ;   RX  - Prescription (#52) file IEN
 ;   RFL - Fill Number
 ; Output:
 ;   0 - Do not continue (user said No)
 ;   1 - Continue (user said Yes)
 ;  -1 - Up-arrow, time-out, invalid parameter or any other non-YES/NO response
 ;
 I '$G(RX) Q -1
 I $G(RFL)="" S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 N DIR,Y,DIRUT,DTOUT,DIRUT,DIROUT
 W !!,"Label for Rx#",$P($G(^PSRX(RX,0)),"^")," Fill#",RFL," has already been printed"
 S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="No"
 D ^DIR
 I Y=0 Q 0
 I Y=1 Q 1
 Q -1
