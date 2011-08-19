PSDADJD ;BIR/LTL-Review Adjustment Transactions for a Drug; 2 Nov 94 [ 11/02/94  3:53 PM ]
 ;;3.0; CONTROLLED SUBSTANCES ;**18,36**;13 Feb 97
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 N PSDOUT I '$D(PSDSITE) D ^PSDSET I '$D(PSDSITE) S PSDOUT=1 G END
 N C,CNT,DIC,DIR,DTOUT,DUOUT,PSD,PSDA,PSDC,PSDEV,PSDR,PSDU,PSDLOC,PSDLOCN,PSDT,PSDTB,X,Y S PSDOUT=1,(CNT,PSDU)=0,PSDCHO=2
 D DT^DICRW
 S PSDLOC=$P(PSDSITE,U,3),PSDLOCN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
LOOK S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S DIC("B")=$P(PSDSITE,U,4)
 W ! D ^DIC K DIC G:Y<0 END S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
 W !!,"You may select one, several, or ^ALL drugs."
CHKD F  S DIC="^PSD(58.8,+PSDLOC,1,",DIC(0)="AEMQZ",DIC("A")="Please Select "_PSDLOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('CNT) END Q:Y<0  S PSD(Y(0,0))=+Y,PSDA(+Y)=Y(0,0),CNT=CNT+1
 I CNT=1,'$O(^PSD(58.81,"F",+PSD($O(PSD(0))),"")) W !!,"There have been no adjustments for this drug.",!! G END
 I X="^ALL" F  S PSDU=$O(^PSD(58.8,+PSDLOC,1,PSDU)) Q:'PSDU  S:$P($G(^PSDRUG(PSDU,0)),U)]"" PSD($P(^(0),U))=PSDU,PSDA(PSDU)=$P(^(0),U)
 S DIR(0)="D^::AEPT",DIR("A")="Beginning date",DIR("?")="Adjustments will be listed for the selected drug(s) within the selected date range" W ! D ^DIR G:Y<1 END
 S (PSDT,PSDTB)=Y,PSDTB(2)=Y(0),DIR(0)="DA^"_PSDT_":NOW:AEPT"
 S DIR("A")="Ending date:  ",DIR("B")="Now"
 W ! D ^DIR K DIR G:Y<1 END S PSDTB(1)=Y,PSDTB(3)=Y(0)
 S:'$P(PSDTB(1),".",2) PSDTB(1)=PSDTB(1)+.999999
 D  G:Y<1 END
 .S DIR(0)="S^1:DATE/DRUG (132 column;2:DRUG/DATE (80 column, browser)"
 .S DIR("B")=1,DIR("?")="^S XQH=""PSD BALANCE ADJUSTMENT REPORT"" D EN^XQH" D ^DIR K DIR S PSDCHO=Y
 S Y=$P($G(^PSD(58.8,+PSDLOC,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(PSDCHO=2:"START^PSDADJD",1:"START^PSDADJW"),ZTDESC="Drug adjustment transaction review",ZTSAVE("PSD*")="" D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
 ;PSD*3*36 (11oct01 - USE SELECTED DEVICE Dave B.)
 U IO
 ;Eop36
 G:PSDCHO=1 ^PSDADJW
 ;(PSD*3*18 - Dave B changed next line to FM calls per SQA)
 I $E(IOST)="C" D CHK I $G(GOOD)'<21,$$TEST^DDBRT W !!,"Getting ready to browse...",!! G ^PSDADJB
START ;compiles and prints output
 N LN,PSDR,PG S (PG,PSDOUT)=0 D HEADER S PSDU=0
 F  S PSDU=$O(PSD(PSDU)) Q:PSDU']""  D  G:PSDOUT END S PSDT=PSDTB,PSDT(1)=0
LOOP .F  S PSDT=$O(^PSD(58.81,"ACT",PSDT)) W:$E(IOST)="C" "." Q:'PSDT!(PSDT>PSDTB(1))  D:$O(^PSD(58.81,"ACT",PSDT,0))=PSDLOC&($O(^PSD(58.81,"ACT",PSDT,PSDLOC,0))=PSD(PSDU))&($O(^PSD(58.81,"ACT",PSDT,PSDLOC,PSD(PSDU),9,0)))  Q:PSDOUT
 ..S PSDR(2)=$G(^PSD(58.81,+$O(^PSD(58.81,"ACT",PSDT,PSDLOC,PSD(PSDU),9,0)),0))
 ..D:$Y+7>IOSL HEADER Q:PSDOUT
 ..S PSDT(1)=$G(PSDT(1))+1 W:PSDT(1)=1 !,PSDU,!
 ..S Y=$E($P(PSDR(2),U,4),1,12) X ^DD("DD") W !,Y,"  "," -> "
 ..W $P(PSDR(2),U,6)," adjusted by ",$P($G(^VA(200,+$P(PSDR(2),U,7),0)),U),!!
 ..W "Reason:  ",$P(PSDR(2),U,16),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",80)="",PG=PG+1 W !,"Adjustments from ",PSDTB(2)," to ",PSDTB(3),?70,"PAGE: ",PG,!,LN W:$G(PSDT(1)) !,PSDU," (continued)",!
 ;
CHK ;(DAVE B 26OCT99)
 ;PSD*3*18 Had to change looking at 9.4 directly to FM calls (BS)
 ;
 S DIC="^DIC(9.4,",DIC(0)="QZ",X="VA FILEMAN" D ^DIC I +Y'>0 S GOOD=0 Q
 S GOOD=$$GET1^DIQ(9.4,+Y,13,"I")
 Q
