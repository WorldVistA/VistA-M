IBRREL ;ALB/CPM - RELEASE MEANS TEST CHARGES 'ON HOLD' ; 03-MAR-92
 ;;2.0;INTEGRATED BILLING;**95,153,199,347,452,651,663**;21-MAR-94;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry point for stand-alone 'release' option
 I '$D(^IB("AH")) W !!,"There are no patients with charges 'on hold' at this time.",! Q
 ;
 D HOME^%ZIS
 W !!,"This option is used to release Means Test charges which have been"
 W !,"placed 'on hold.'  Please enter a patient with charges 'on hold,' and these"
 W !,"charges will be displayed and may be selected to be released to Accounts",!,"Receivable.",!
 ;
ASK ;
 R !,"Select PATIENT NAME: ",X:DTIME G END:"^"[$E(X)
 I $E(X,1,2)="??" D HLP1 G ASK
 I $E(X)="?" D HLP G ASK
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="QME" D ^DIC K DIC G ASK:Y<1 S DFN=+Y
 ;
 K IBA,PRCABN
 S IBI=0 F IBNUM=1:1 S IBI=$O(^IB("AH",DFN,IBI)) Q:'IBI  S IBA(IBNUM)=IBI
 I '$D(IBA) W !!,"This patient does not have any charges 'on hold.'",! G ASK
 ;
 S IBPT=$$PT^IBEFUNC(DFN) W @IOF,$P(IBPT,"^"),"      Pt ID: ",$P(IBPT,"^",2),! S I="",$P(I,"-",80)="" W I K I
 ;
RESUME ; - display header and list charges
 ;
 ; *** This tag is also called by ECME routine IBNCPDPR ***
 ; Special variable IBNCPDPR will be set to 1 when called from ECME.
 ; If this variable is set, then processing in this routine will GOTO tag END and quit rather than go back up
 ; and ask for another patient.
 ; Also, special variable IBNCPDPRDEF is the entry# in the list if a specific Rx# was chosen from the ECME screen.
 ; 
 ;
 W !!,"The following IB Actions ",$S($D(PRCABN):"associated with this bill",1:"for this patient")," are ON HOLD:"
 D HDR
 ;
 ; display the list of IB charges on hold
 S IBQ=0 F IBNUM=1:1 Q:'$D(IBA(IBNUM))!IBQ  D  Q:IBQ
 . I $Y+5>IOSL D PAUSE^VALM1 S:$D(DIRUT) IBQ=1 Q:IBQ  S $Y=0 D HDR
 . S IBN=IBA(IBNUM) D LST
 . Q
 ;
 ; - prompt user to select IB Actions
 S DIR(0)="LA^1:"_(IBNUM-1)_"^K:X[""."" X"
 S DIR("A")="Select IB Action"_$E("s",IBNUM>2)_" (REF #) to release (or '^' to exit): "
 I $G(IBNCPDPRDEF) S DIR("B")=IBNCPDPRDEF    ; default value if coming in from ECME
 S DIR("?")="^D HELP^IBRREL"
 W ! D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) G END:($D(PRCABN)!$G(IBNCPDPR)) D END W ! G ASK
 ;
 S IBRANGE=Y,IBSEQNO=1,IBDUZ=DUZ
 ;
 S DIR(0)="Y",DIR("A")="OK to pass "_$S($P(Y,",",2):"these charges",1:"this charge")_" to Accounts Receivable"
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G END:($D(PRCABN)!$G(IBNCPDPR)) D END W ! G ASK
 ;
 ; - pass charges to Accounts Receivable
 W !!,"Passing charges to Accounts Receivable...",! D HDR
 F IBCTR=1:1 S IBNUM=$P(IBRANGE,",",IBCTR) Q:'IBNUM  I $D(IBA(IBNUM)) S IBNOS=IBA(IBNUM) D ^IBR,ERR:Y<1 I Y>0 S IBN=IBA(IBNUM) D UPDUCDB(IBNOS) D LST
 W !!,"The charge"_$E("s",$P(IBRANGE,",",2)>0)_" listed above "_$S($P(IBRANGE,",",2):"have",1:"has")_" been passed to Accounts Receivable.",!
 ;
 I $G(IBNCPDPR) W !! S DIR(0)="E" D ^DIR K DIR G END   ; exit for ECME
 ;
 I '$D(PRCABN) W !! S DIR(0)="E" D ^DIR K DIR D END W ! G ASK
 ;
END K DIC,DIRUT,DUOUT,DTOUT,IBA,IBAFY,IBARTYP,IBATYP,IBCTR,IBN,IBDA,IBDUZ
 K IBFAC,IBI,IBIL,IBRANGE,IBNOS,IBNUM,IBPT,IBQ,IBSEQNO,IBSERV,IBSITE
 K IBTOTL,IBTRAN,IBWHER,VA,VAERR,VADM
 K:'$D(PRCABN) DFN
 Q
 ;
 ;
HDR ; Display charge header.
 N IBLINE S $P(IBLINE,"=",81)=""
 W !,IBLINE,!," REF  Action ID    Bill Type",?42,"Bill #",?51,"Fr/Fl Dt",?61,"To/Rls Dt",?73,"Charge"
 W !,IBLINE Q
 ;
LST ; Display individual IB Action.
 N IBND,IBND1,IBRXN,IBRX,IBRF,IBRDT,IENS,IBECME
 S IBND=$G(^IB(IBN,0)),IBND1=$G(^IB(IBN,1)),(IBRXN,IBRX,IBRF,IBRDT,IBECME)=0
 I $P(IBND,"^",4)["52:" D
 . S IBRXN=+$P($P(IBND,"^",4),":",2)   ; Rx ien
 . S IBRX=$P($P(IBND,"^",8),"-")       ; external Rx#
 . S IBRF=+$P($P(IBND,"^",4),":",3)    ; fill# or 0 for original fill
 . S IBECME=$P($$CLAIM^BPSBUTL(IBRXN,IBRF),U,6)   ; ecme#  DBIA# 4719
 . I IBRF S IENS=+IBRF,IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,+IENS,52,.01)
 . I 'IBRF S IENS=+IBRXN,IBRDT=$$FILE^IBRXUTL(+IENS,22)
 . Q
 ;
 W !?1,$J(IBNUM,2),?6,$J(+IBND,9)
 W ?19,$S(IBRXN>0:"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),1:$P(IBND,"^",8)) ;IB*2.0*651
 W ?42,$P($P(IBND,"^",11),"-",2)
 W ?51,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,"^",14)))
 W ?61,$$DAT1^IBOUTL($S($P(IBND,"^",15)'="":($P(IBND,"^",15)),1:$P(IBND1,"^",2)))
 W ?70,$J(+$P(IBND,"^",7),9,2)
 I IBECME W !?19,"ECME #: ",IBECME
 Q
 ;
ERR ; Display error message.
 W !?1,$J(IBNUM,2),?7,"Error encountered - a separate bulletin has been posted"
 Q
 ;
HLP ; Display basic help message.
 W !!,"Enter:    the name of a patient with charges 'on hold,' or"
 W !?10,"'??' --  to see all patients with charges 'on hold,' or"
 W !?10,"'^'  --  to quit this option.",!
 Q
 ;
HLP1 ; Display all patients with charges 'on hold.'
 N DFN,I,IBQ,PID
 W !!,"The following patients have charges 'on hold:'"
 S (DFN,IBQ)=0 F I=1:1 S DFN=$O(^IB("AH",DFN)) Q:'DFN  D:'(I#15)  Q:IBQ  S PID=$$PT^IBEFUNC(DFN) W !?3,$P(PID,"^"),$J("",10),$P(PID,"^",2)
 . R !,"Enter RETURN to continue or '^' to stop: ",X:DTIME S:X["^"!('$T) IBQ=1 Q
 W ! Q
 ;
HELP ; Help for the 'Select' prompt.
 W !!?4,"Please enter a list or range of IB Actions (i.e. 1,3,5 or 2-4,8), none"
 W !?4,"greater than ",IBNUM-1,", to be passed to Accounts Receivable, or '^' to quit."
 Q
 ;
AR ; Accounts Receivable entry point to release charges.
 ;   Input: PRCABN -- ien of Bill/Accounts Receivable
 Q:$D(PRCABN)[0  Q:'$$IB^IBRUTL(PRCABN,1)  G RESUME
 ;
 ;Start - IB*2.0*663
UPDUCDB(IBN) ;Update the Visit Tracking DB with the bill Number
 N IBND,IBVSTIEN
 S IBND=$G(^IB(IBN,0))
 ;IB*2.0*663 If charge successfully passed, extract the bill number and update the visit tracking database if this is a CC URGENT CARE Charge
 I $P(IBND,U,11)'="",$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["CC URGENT CARE" D
 . ; send update to the Visit Tracking file.
 . S IBVSTIEN=$$FNDVST^IBECEA4("ON HOLD",$P(IBND,U,14),$P(IBND,U,2))
 . ;ADD THE NOT FOUND MESSAGE HERE?
 . D:+IBVSTIEN UPDATE^IBECEA38(IBVSTIEN,2,$P(IBND,U,11),"",1,.IBERROR)
 Q
 ;End IB*2.0*663
