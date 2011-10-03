IBNCPDPR ;WOIFO/SS - ECME RELEASE CHARGES ON HOLD ;3/6/08  16:23
 ;;2.0;INTEGRATED BILLING;**276,347,384**;21-MAR-94;Build 74
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;==========
 ;version of "IB MT RELEASE CHARGES" option (^IBREL) without PATIENT prompt
 ;(patient is selected from the User Screen)
 ;designed to use from ECME User Screen (IA #) in order to access Release
 ;copay functionality from ECME
 ;
RELH(DFN,IBRXIEN,IBREFL,IBMODE) ;
 K IBA,PRCABN,BPX,IBI,IBCNT,IB350
 S IB350=0
 S IBI=0 F IBNUM=1:1 S IBI=$O(^IB("AH",DFN,IBI)) Q:'IBI  S IBA(IBNUM)=IBI
 I '$D(IBA) W !!,"This patient does not have any charges 'on hold.'",! G ASK
 ;
 S IBPT=$$PT^IBEFUNC(DFN) W @IOF,$P(IBPT,"^"),"      Pt ID: ",$P(IBPT,"^",2),! S I="",$P(I,"-",80)="" W I K I
 ;if the user selected specific RX/refill
 I IBMODE="C" D  S:IB350>0 DIR("B")=$P(IB350,U,2)
 . ;find item that matches selected RX/refill
 . S IBCNT=0
 . F  S IBCNT=$O(IBA(IBCNT)) Q:+IBCNT=0  D  Q:IB350>0
 . . S BPX=$P($G(^IB(IBA(IBCNT),0)),U,4)
 . . I $P(BPX,":")'=52 Q  ;if not RX type
 . . I $P($P(BPX,";"),":",2)'=IBRXIEN Q  ;if not given RX#
 . . I IBREFL>0 I $P($P(BPX,";",2),":",2)'=IBREFL Q  ;if not given refill #
 . . S IB350=IBA(IBCNT)_"^"_IBCNT
 ;
 I IBMODE="C",IB350=0 D  G ASK
 . W !!,"There is no copay charge 'on hold' for this Rx.",!
 . D PAUSE^VALM1
 D RESUME
 Q
 ;
 ;
ASK ;stub for  ASK
 Q
 ;
 ;the following code was borrowed from IBRREL without changes.
 ;This was done to avoid code changes in the original code and
 ;re-testing it in IB package
 ; - display header and list charges
RESUME W !!,"The following IB Actions ",$S($D(PRCABN):"associated with this bill",1:"for this patient")," are ON HOLD:" D HDR
 S IBQ=0 F IBNUM=1:1 Q:'$D(IBA(IBNUM))  D:'(IBNUM#15)  Q:IBQ  S IBN=IBA(IBNUM) D LST
 . R !,"Enter RETURN to continue or '^' to stop: ",X:DTIME S:X["^"!('$T) IBQ=1 Q
 ;
 ; - prompt user to select IB Actions
 S DIR(0)="LA^1:"_(IBNUM-1)_"^K:X[""."" X",DIR("A")="Select IB Action"_$E("s",IBNUM>2)_" (REF #) to release (or '^' to exit): ",DIR("?")="^D HELP^IBRREL"
 W ! D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) G END:$D(PRCABN) D END W ! G ASK
 ;
 S IBRANGE=Y,IBSEQNO=1,IBDUZ=DUZ
 ;
 S DIR(0)="Y",DIR("A")="OK to pass "_$S($P(Y,",",2):"these charges",1:"this charge")_" to Accounts Receivable"
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G END:$D(PRCABN) D END W ! G ASK
 ;
 ; - pass charges to Accounts Receivable
 W !!,"Passing charges to Accounts Receivable...",! D HDR
 F IBCTR=1:1 S IBNUM=$P(IBRANGE,",",IBCTR) Q:'IBNUM  I $D(IBA(IBNUM)) S IBNOS=IBA(IBNUM) D ^IBR,ERR:Y<1 I Y>0 S IBN=IBA(IBNUM) D LST
 W !!,"The charge"_$E("s",$P(IBRANGE,",",2)>0)_" listed above "_$S($P(IBRANGE,",",2):"have",1:"has")_" been passed to Accounts Receivable.",!
 ;
 I '$D(PRCABN) W !! S DIR(0)="E" D ^DIR K DIR D END W ! G ASK
 ;
END K DIC,DIRUT,DUOUT,DTOUT,IBA,IBAFY,IBARTYP,IBATYP,IBCTR,IBN,IBDA,IBDUZ
 K IBFAC,IBI,IBIL,IBRANGE,IBNOS,IBNUM,IBPT,IBQ,IBSEQNO,IBSERV,IBSITE
 K IBTOTL,IBTRAN,IBWHER,VA,VAERR,VADM
 K:'$D(PRCABN) DFN
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBRREL" D T1^%ZOSV ;stop rt clock
 Q
 ;
 ;
HDR ; Display charge header.
 N IBLINE S $P(IBLINE,"=",81)=""
 W !,IBLINE,!," REF   Action ID  Bill Type",?42,"Bill #",?51,"Fr/Fl Dt",?61,"To/Rls Dt",?73,"Charge"
 W !,IBLINE Q
 ;
LST ; Display individual IB Action.
 N IBND,IBND1,IBRXN,IBRX,IBRF,IBRDT,IENS
 S IBND=$G(^IB(IBN,0)),IBND1=$G(^IB(IBN,1)),(IBRXN,IBRX,IBRF,IBRDT)=0
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I $P(IBND,"^",4)["52:"  D
 .I IBRF>0 S IENS=+IBRF,IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,+IENS,52,.01)
 .E  S IENS=+IBRXN,IBRDT=$$FILE^IBRXUTL(+IENS,22)
 W !?1,$J(IBNUM,2),?7,$J(+IBND,9)
 W ?18,$S(IBRXN>0:"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),1:$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",8))
 W ?42,$P($P(IBND,"^",11),"-",2)
 W ?51,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,"^",14)))
 W ?61,$$DAT1^IBOUTL($S($P(IBND,"^",15)'="":($P(IBND,"^",15)),1:$P(IBND1,"^",2)))
 W ?70,$J(+$P(IBND,"^",7),9,2)
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
 ;
AR ; Accounts Receivable entry point to release charges.
 ;   Input: PRCABN -- ien of Bill/Accounts Receivable
 Q:$D(PRCABN)[0  Q:'$$IB^IBRUTL(PRCABN,1)  G RESUME
 ;
