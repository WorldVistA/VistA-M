PSDREVD ;BIR/LTL-Review Receipt Transactions for a Drug ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**18,46**;13 Feb 97
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 ;References to ^PRC(442 are covered by DBIA#682
 ;References to ^PRCS(410 are covered by DBIA#198
 N PSDOUT I '$D(PSDSITE) D ^PSDSET I '$D(PSDSITE) S PSDOUT=1 G END
 N C,CNT,DIC,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDEV,PSDR,PSDU,PSDLOC,PSDLOCN,PSDT,X,Y S PSDOUT=1,PSDU=0
 D DT^DICRW
 S PSDLOC=$P(PSDSITE,U,3),PSDLOCN=$P(PSDSITE,U,4)
 S CNT=0 G:$P(PSDSITE,U,5) CHKD
LOOK S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$P($G(^(0)),U,2)[""M""&($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S:$P($G(^PSD(58.8,+PSDLOC,0)),U,2)["M" DIC("B")=PSDLOCN
 W ! D ^DIC K DIC G:Y<0 END S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDLOCN
 S CNT=0 W !!,"You may select one, several, or ^ALL drugs.",!
CHKD F  S DIC="^PSD(58.8,+PSDLOC,1,",DIC(0)="AEMQ",DIC("A")="Please Select "_PSDLOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('CNT) END Q:Y<0  S PSD(+Y)="",CNT=CNT+1
 I CNT=1&('$O(^PSD(58.81,"F",+$O(PSD(0)),""))) W !!,"There have been no receipts for this drug.",!! G END
 I X="^ALL" F  S PSDU=$O(^PSD(58.8,+PSDLOC,1,PSDU)) Q:'PSDU  S PSD(PSDU)=""
 S DIR(0)="D:AEP",DIR("A")="How far back in time do you want to go? ",DIR("B")="T-6M",DIR("?")="I will list receipts for your selected drug(s) within the last six months if you press return" W ! D ^DIR K DIR G:$D(DIRUT) END
 S PSDT=Y
 S Y=$P($G(^PSD(58.8,+PSDLOC,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDREVD",ZTDESC="Drug receipt transaction review",ZTSAVE("PSD*")="" D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles and prints output
 N %DT,LN,PSDR,PG,RPDT S (PG,PSDOUT)=0,Y=DT,PSDR="" X ^DD("DD") S RPDT=Y,PSDU(1)=$O(PSD(0)) D HEADER S PSDU=0
 F  S PSDU=$O(PSD(PSDU)) Q:'PSDU  K PSDR(1) D  G:PSDOUT END I 'PSDR,$O(PSD(PSDU)) S PSDU(1)=$O(PSD(PSDU))
LOOP .F  S PSDR=$O(^PSD(58.81,"F",PSDU,PSDR)) Q:'PSDR  D:$Y+6>IOSL HEADER Q:PSDOUT  S PSDR(2)=$G(^PSD(58.81,+PSDR,0)) D:$P(PSDR(2),U,4)'<PSDT&($P(PSDR(2),U,2)=1)
 ..I $G(PSDLOC)'=$P(PSDR(2),U,3) Q  ;PSD*3*46
 ..S PSDR(1)=$G(PSDR(1))+1 W:PSDR(1)=1 $P($G(^PSDRUG(+PSDU,0)),U),!
 ..W:PSDR(1)=1 !,"Receiving Site: ",$P($G(^PSD(58.8,+PSDLOC,0)),U),!  ; PSD*3*46
 ..; PSD*3*46 Commented out the next two lines
 ..;I '$D(PSDLOC) S PSDLOC=$P(PSDR(2),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSDLOC,0)),U),!
 ..;I $G(PSDLOC)'=$P(PSDR(2),U,3) S PSDLOC=$P(PSDR(2),U,3) W !,"Receiving site: ",$P($G(^PSD(58.8,+PSDLOC,0)),U),!
 ..S Y=$E($P(PSDR(2),U,4),1,12) X ^DD("DD") W !,Y,"  "," -> "
 ..W $P(PSDR(2),U,6)," received by ",$P($G(^VA(200,+$P(PSDR(2),U,7),0)),U),!!
 ..W:$P($G(^PRC(442,+$P(PSDR(2),U,9),0)),U) "P.O.#:  "_$P($G(^(0)),U),?20
 ..W:$P($G(^PRCS(410,+$P(PSDR(2),U,8),0)),U) "TR#:  ",$P($G(^(0)),U),"  "
 ..W:$P($G(^PSD(58.81,+PSDR,8)),U)]"" "INV#:  ",$P($G(^(8)),U)
 ..W !,LN,!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !?2,"History of Drug Receipts",?50,RPDT,?70,"PAGE: ",PG,!,LN,!
