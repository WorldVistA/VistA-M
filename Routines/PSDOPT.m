PSDOPT ;BIR/JPW,LTL,BJW - Outpatient Rx Entry ;2/5/04 12:15pm
 ;;3.0;CONTROLLED SUBSTANCES;**10,11,15,21,30,39,48,62,69,71**;13 Feb 97;Build 29
 ;Reference to ^PSDRUG( supported by DBIA #221
 ;References to ^PSD(58.8 are covered by DBIA #2711
 ;References to file 58.81 are covered by DBIA #2808
 ;Reference to PSRX( supported by DBIA #986
 ;Reference to PSOFUNC supported by DBIA #981
 ;Line Tag FINAL^PSOLSET supported by DBIA #982
 ;
 ;mod.for nois:tua-0498-32173,askp,bc1;ver
 ;enhancement for Outpat V7 status code of 12,13,14,15 in askp
 ;
 ;further modifications related to the deletion of
 ;refills made in April 1999 
 ;
 ;PSD*3*39 Kill all variables
 D PSDKLL^PSDOPT2
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) W !!,"Please contact your Pharmacy Coordinator for access",!,"to log Outpatient Prescriptions. Either the PSJ RPHARM",!,"or PSD TECH ADV security key required.",!! Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G END
 N X,X1 D SIG^XUSESIG I X1="" G END
 N LN S (PSDOUT,NEW)=0,PSDUZ=DUZ,$P(LN,"-",80)="",Y=DT
 X ^DD("DD") S RPDT=Y
ASKD ;ask disp site
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0),$S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 W ! D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no stocked drugs for this Pharmacy Vault!!",!! G END
ASKPH ;ask releasing RPH
 S DIC="^VA(200,",DIC(0)="QEAM",DIC("S")="I $D(^XUSEC(""PSORPH"",+Y))"
 S DIC("A")="Please identify Pharmacist for Outpatient Release: "
 S:$D(^XUSEC("PSORPH",DUZ)) DIC("B")=$P($G(^VA(200,DUZ,0)),U)
 W ! D ^DIC K DIC G:Y<1 END S PSDRPH=+Y
ASKP ;ask rx #
 K PSDSEL,PSDPOST,PSDREL
 ;PSD*3*30 (Dave Blocker ) Lock the script node
 I $G(PSDRX)'="" L -^PSRX(PSDRX)
 W ! K DIR,NEW,PSDRX,PSDRXIN,RXNUM S PSDOUT=0 S DIR("A")="Enter/Wand PRESCRIPTION number"
 S DIR("?")="^D HELP^PSODISP",DIR(0)="F^1:35" D ^DIR K DIR
 G:$D(DTOUT)!($D(DUOUT)) END G:X="" ASKPH
 S X=$$UP^XLFSTR(X)
 I X'["-" D  S PSDRX=$G(PSDRXIN)
 .S PSDRX=0 F  S PSDRX=$O(^PSRX("B",X,PSDRX)) Q:'PSDRX  S PSDRXIN=PSDRX D VER
 I X'["-",'$G(PSDRX)!('$D(^PSRX(+$G(PSDRX),0))) W !,"INVALID PRESCRIPTION NUMBER" G ASKP
 ;
 ;PSD*3*30 - lock the script
 I X'["-" L +^PSRX(PSDRX):5 I '$T W !!,"Sorry, someone else is editing this prescription. Please try again later." K PSDRX G ASKP
 ;
 ;DAVE B (PSD*3*15) Show previous postings
 I X'["-" I $G(PSOVR)=1,$G(PSDSTA)=12!($G(PSDSTA)=13)!($G(PSDSTA)=14)!($G(PSDSTA)=15)!($G(PSDSTA)=11) S PSDXXX=X D CHKRF I $G(PSDNEXT)=1 G ASKP
 ;<JD *62
 ;
 S PSD(1)=X,DIC="^DIC(4,",DR=99,DA=+$P($G(^XMB(1,1,"XUS")),U,17)
 K DIQ S DIQ="PSD" D EN^DIQ1 S X=PSD(1) K DIC,DR,DIQ
 I X["-",$P(X,"-")'=PSD(4,DA,99) K DA,PSD W !?7,$C(7),"   INVALID STATION NUMBER !!",! G ASKP
 K DA,PSD
 I X["-" S PSDRX=$P(X,"-",2) I (PSDRX'?1N.N.1U) W !?7,$C(7),"   INVALID PRESCRIPTION NUMBER" G ASKP
 I X["-" I '$D(^PSRX(+$G(PSDRX),0))!($G(PSDRX)']"") W !?7,$C(7),"   NON-EXISTENT PRESCRIPTION" G ASKP
 ;
 I X["-",$D(^PSRX(PSDRX,0)) S PSDRXIN=+PSDRX D VER I PSOVR=1,$G(PSDSTA)=12!($G(PSDSTA)=13)!($G(PSDSTA)=14)!($G(PSDSTA)=15) D CHKRF I $G(PSDNEXT)=1 G ASKP
 I X["-" L +^PSRX(PSDRX):5 I '$T W !!,"Sorry, someone else is editing this prescription. Please try again later." K PSDRX G ASKP
 ;
 ; (PSD*3*21) Check for transmission status for barcode entry
 ;
 G:$D(^PSRX(PSDRX,0)) BC1
 W !?7,$C(7),"   IMPROPER BARCODE FORMAT" G ASKP
BC1 ;
 S PSDRXIN=+PSDRX D VER
 I $G(PSDSTA)=13!(+$P($G(^PSRX(+PSDRX,0)),"^",2)=0) W !?7,$C(7),"    PRESCRIPTION HAS BEEN DELETED." G ASKP
 I $G(PSDSTA),$S($G(PSDSTA)=2:0,$G(PSDSTA)=5:0,$G(PSDSTA)=11:0,$G(PSDSTA)=12:0,$G(PSDSTA)=14:0,$G(PSDSTA)=15:0,1:1) D  K J,RX0,RX2,ST,ST0 G ASKP
 .S RX0=$G(^PSRX(+PSDRX,0)),RX2=^PSRX(+PSDRX,2),J=PSDRX S $P(RX0,"^",15)=$G(PSDSTA) D ^PSOFUNC
 .W !!,$C(7),"     Status of ",ST," is not appropriate for selection."
 K PSDSTA,PSOVR,PSDRXIN
 S RXNUM=$P($G(^PSRX(+PSDRX,0)),U),PSDR=+$P($G(^(0)),U,6),DFN=+$P($G(^(0)),U,2),QTY=$P($G(^(0)),U,7),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 N C S Y=DFN,C=$P(^DD(58.81,73,0),U,2) D Y^DIQ S PATN=Y
 D PID^VADPT6
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) W !!,PSDRN," is not currently stocked in ",PSDSN,".",!!,"** No action taken. **",!! G END
 I $D(^PSD(58.81,"AOP",PSDRX)) D ^PSDOPT2 I PSDOUT D MSG G END
 G ^PSDOPT0
CHK ;displays and checks if ok
CLLDIR I $D(PSDSEL("OR")) S DIR(0)="S^1:Original;",CNT=1
 I $D(PSDSEL("RF")) D
 .S X1=0 F  S X1=$O(PSDSEL("RF",X1)) Q:X1=""  D
 ..I $D(PSDRET("RF",X1)),(PSDRET("RF",X1)\1)=$P(PSDSEL("RF",X1),"^") D RTSDTC^PSDOPT2 Q
 ..I $D(PSDRET("RF",X1)),PSDRET("RF",X1)<$P(PSDSEL("RF",X1),"^") D CLLDIR2 Q
 ..I '$D(PSDRET("RF",X1)) D CLLDIR2 Q
 ..Q
 I $D(PSDSEL("PR")) D
 .S X1=0 F  S X1=$O(PSDSEL("PR",X1)) Q:X1=""  I '$D(PSDRET("PR",X1)) S CNT=$G(CNT)+1,DIR(0)=$S($G(CNT)=1:"S^1:Partial #"_X1,1:DIR(0)_CNT_":Partial #"_X1)_" ("_$P(PSDSEL("PR",X1),"^",2)_");"
 I $G(DIR(0))'="" D
 .K PSDERR D ^DIR I $D(DIRUT) S PSDERR=1 Q
 .S PSDA=$E(Y(0))
 Q:$D(PSDERR)
 Q:'$D(Y(0))  I PSDA="O" S DAT=$P($G(^PSRX(PSDRX,2)),U,2),PSDPOST=$P(PSDSEL("OR"),"^",3),PSDREL=$P(PSDSEL("OR"),"^",4) G PROCESS
 I PSDA="R" S XX=$P(Y(0),"#",2),XXX=$P(XX," ",1),DAT=$P($G(PSDSEL("RF",XXX)),"^",1),QTY=$P(PSDSEL("RF",XXX),U,2),PSDPOST=$P(PSDSEL("RF",XXX),U,3),PSDREL=$P(PSDSEL("RF",XXX),U,4) G PROCESS
 I PSDA="P" S XX=$P(Y(0),"#",2),XXX=$P(XX," ",1),DAT=$P($G(PSDSEL("PR",XXX)),"^",1),QTY=$P(PSDSEL("PR",XXX),U,2),PSDPOST=$P(PSDSEL("PR",XXX),U,3),PSDREL=$P(PSDSEL("PR",XXX),U,4) G PROCESS
 W !,"Error somewhere" G ASKP
PROCESS ;process selection
 I PSDA'="O" S PSDFLNO=XXX ;fill number
 I PSDA="O" S NEW=1,(NEW(1),NEW(2))=0 ;Original
 I PSDA="R" S NEW(1)=XXX,(NEW,NEW(2))=0 ;Refill
 I PSDA="P" S NEW(2)=XXX,(NEW,NEW(1))=0 ;Partial
 S X=0 F  S X=$O(^PSRX(PSDRX,4,X)) Q:X'>0  S STATUS=$P($G(^PSRX(PSDRX,4,X,0)),"^",4),NUMBER=$P($G(^PSRX(PSDRX,4,X,0)),"^",3) I $G(STATUS)'=3 D
 .I NUMBER=0,$G(NEW)=1,$G(NEW(1))=0 D CMOPMSG
 .I NUMBER=$G(NEW(1)),$G(NEW)=0,PSDA'="P",'$D(PSDRET("RF",NUMBER)) D CMOPMSG
 I $G(PSDOUT)=1 G ASKP
 ;
 D:PSDA="O" PSDORIG^PSDOPT1 D:PSDA="R" PSDRFL^PSDOPT1 D:PSDA="P" PSDPRTL^PSDOPT1
 I $G(PSDOUT)=1 G ASKP
 I $G(PSDPOST)=1,$G(PSDREL)="" W !,"This fill has already been posted." D CHKEY D:'$G(PSDOUT) PSDREL^PSDOPT1 G ASKP
 I $G(PSDREL)'="",$G(PSDPOST)'>0 W !,"This fill has already been released."
 I $G(PSDREL)'="",$G(PSDPOST)>0 W !,"This fill has already been posted & released, no further action required." G ASKP
 D DISPLAY G:PSDOUT END
 K DA,DIR,DIRUT S DIR(0)="YA",DIR("B")="YES",DIR("A")="Is this OK? "
 S DIR("?",1)="Answer 'YES' to log this RX transaction in your CS vault,",DIR("?")="answer 'NO' to reselect a prescription, or '^' to quit."
 D ^DIR K DIR I Y<1 D MSG G:$D(DIRUT) END G:Y<1 ASKP
 D ^PSDOPT1 G ASKP
END K %,%H,%I,BAL,C,CNT,DA,DAT,DD,DFN,DIC,DIE,DIK,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DO,DR,JJ,LN,NEW,NODE,NODE6 D FINAL^PSOLSET
 I $G(PSDRX)'="" L -^PSRX(PSDRX)
 K PATN,PHARM,PHARMN,PRF,PSDA,PSDATE,PSDOUT,PSDR,PSDRN,PSDRPH,PSDRX,PSDS,PSDSN,PSDT,PSDUZ,PSOCSUB,QTY,RF,RPDT,RXNUM,X,Y
 D KVAR^VADPT K VA("PID"),VA("BID")
 Q
CHKEY ;check if user has access
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) D  S PSDOUT=1
 .W !!?12,"** You have no access to release this prescription."
 .W !?15,"The PSJ RPHARM security key is required. **",!
 Q
CLLDIR2 S CNT=$G(CNT)+1,DIR(0)=$S($G(CNT)=1:"S^1:Refill #"_X1,1:DIR(0)_CNT_":Refill #"_X1)_";"
 Q
DISPLAY ;disp data
 W !!,?20,"View Controlled Substances Rx # ",RXNUM,!,?28,RPDT,!,LN,!!
 W "Location: ",?10,PSDSN,?55
 S PSDRN(1)=$S(NEW:"Original",$G(NEW(1)):"Refill #"_NEW(1),1:"Partial #"_$G(NEW(2))) W PSDRN(1)
 W !,"Drug: ",?10,PSDRN,?55,"Quantity: ",QTY
 ;
 ;DAVE B (PSD*3*15) check for Non-numeric quantity
 I QTY'?.N W !,"The Quantity is not strictly numeric. This will cause the new balance to be",!,"calculated incorrectly.",!
 W !,"Patient: ",?10,PATN_"  ("_VA("BID")_")",?55,PSDRN(1)," Date: ",?65,$E(DAT,4,5)_"/"_$E(DAT,6,7)_"/"_$E(DAT,2,3),!
 S BAL=+$P($G(^PSD(58.8,+PSDS,1,PSDR,0)),"^",4) I QTY>BAL W !!,?5,"Your balance is ",BAL,".",!,?5,"You may not dispense lower than your balance.",!! D MSG S PSDOUT=1 Q
 W !!,?15,"Old Balance: ",BAL,?40,"New Balance: ",BAL-QTY,!!
 Q
MSG W $C(7),!!,"No action taken.  This transaction has not been recorded.",!!
 Q
VER ;Current Outpatient Version, and Rx status added 6/17/98
 K PSDSTA S PSDHOLDX=$G(X) S PSOVR=$$VERSION^XPDUTL("PSO") S X=$G(PSDHOLDX) K PSDHOLDX S PSOVR=$S($G(PSOVR)>6:1,1:0)
 I $G(PSDRXIN) S PSDSTA=$S(PSOVR:$P($G(^PSRX(PSDRXIN,"STA")),"^"),1:$P($G(^PSRX(PSDRXIN,0)),"^",15))
 Q
CHKRF ;Dave B (PSD*3*30) if its deleted, show status.
 W !,"This RX has a status of '"_$S(PSDSTA=11:"EXPIRED",PSDSTA=12:"DISCONTINUED",PSDSTA=13:"DELETED",PSDSTA=14:"DISCONTINUED BY PROVIDER",PSDSTA=15:"DISCONTINUED (EDIT)",1:"Unknown  Procedure")_$S(PSDSTA=12:"'.",1:"', no action can be taken.")
 ;< JD*62
 I $O(^PSRX(PSDRX,"A",0))>0 W !!,"Below is a list of actions taken on the prescription.",!!,"DATE/TIME",?22,"PERSON",?45,"ACTIVITY",! F X=1:1:53 W "=" F X=1:1:(IOM-1) W "="
 S X3=0 F  S X3=$O(^PSRX(PSDRX,"A",X3)) Q:X3=""  S DATA=$G(^PSRX(PSDRX,"A",X3,0)),Y=$P(DATA,"^",1) X ^DD("DD") S DATE=Y,X=$P(DATA,"^",2) D
 .I $G(X)'="" S ACTIVITY=$$EXTERNAL^DILFD(52.3,.02,,X)
 .S DELDUZ=$$EXTERNAL^DILFD(52.3,.03,,$P(DATA,"^",3)) S DELDUZ=$S($G(DELDUZ)="":"Unknown ("_$P(DATA,"^",3)_")",1:DELDUZ)
 .K DELREAS S DELREAS=$P(DATA,"^",5)
 .W !,DATE,?22,DELDUZ,?45,ACTIVITY I $G(DELREAS)'="" W !,"Comment: ",$G(DELREAS)
 I $G(PSDSTA)'=12 S PSDNEXT=1 Q
ASK12 R !,"Do you wish to continue? NO // ",AN:DTIME S:AN="" AN="N"
 I "YyNn"'[AN W !,"Answer 'N'o, and you will prompted for another prescription." G ASK12
 I "nN"[AN S PSDNEXT=1 Q
 K PSDNEXT
 Q
CMOPMSG W !,?10,"This is a CMOP fill and has been transmitted, dispensed or ",!?10,"retransmitted.",! S PSDOUT=1 Q
KLLALL ;Kill all
