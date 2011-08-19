PSOMGMRP ;BHAM ISC/JMB - MONTHLY MANAGEMENT REPORT ; 3/30/93
 ;;7.0;OUTPATIENT PHARMACY;**72**;DEC 1997
 ;External reference ^PS(50.8 supported by DBIA 296
 ;
BEG G:'$D(RUN) END S SDT=0,SDT=$O(^PS(59.12,"B",SDT)) G:$G(SDT)=""!($L(SDT)'=7) IV
 G:$G(SDT)="" IV S Y=SDT D DD^%DT S PSDT=Y
IV S OK=$O(^PS(50.8,0)) I '$D(OK)!(OK="") G DISP
 S IVS=0 F IEN=0:0 S IEN=$O(^PS(50.8,IEN)) Q:'IEN!($L(IVS)=7)  F IVS=0:0 S IVS=$O(^PS(50.8,IEN,2,IVS)) S:$L(IVS)=7 IVSDT=IVS Q:$L(IVS)=7!('IVS)
 G:$G(IVSDT)="" DISP S Y=IVSDT D DD^%DT S PIVSDT=Y
DISP K OK W:$G(SDT)'=""&(RUN'=4) !!!!?5,"**Prescription data available to print starts with "_PSDT_".**"
 I ('$D(SDT)!($G(SDT)=""))&(RUN'=4) W !!?13,$C(7),$C(7),"**There is no prescription data available to print.**",!?8,"Use the Date Range Compile data option to make the data available." K EDT,SDT
 W:$D(IVSDT) !!?10,"**IV data available to print starts with "_PIVSDT_".**"
 I '$D(IVSDT) W !!?18,$C(7),$C(7),"**There is no IV data available to print.**" K IVSDT,IVEDT G:RUN=4 END
 I '$D(IVSDT)&('$D(SDT)) W !!,"There is no prescription and IV data available to print." G END
 S DVCNT=0 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  S DVCNT=DVCNT+1,DV=DIV
 I RUN=4 S ANS="A" G PAP
PRTDV S:DVCNT=1 ANS="S",DIV=DV I DVCNT>1 W !! S DIR("A")="Print data for all or a specific division",DIR(0)="SBO^A:ALL;S:SPECIFIC",DIR("?")="Answer 'A' for all if you want to print all divisions' report." D
 .S DIR("??")="Answer 'S' for specific if you want to print one division's report." D ^DIR K OUT S:$D(DIRUT) OUT=1 K DIR S ANS=Y
 G:$G(OUT) END I ANS="S",DVCNT>1 W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEMQZ" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) PRTDV S DIV=+Y
PAP W !!?12,"*** PLEASE PRINT ON WIDE PAPER, I.E., 132 COLUMNS. ***",!
 K BDT,EDT,%DT W !!,"**** Date Range Selection ****" S LATE=$E(DT,1,5)_"00"
SDT W ! S %DT="APEM",%DT("A")="Beginning    MONTH/YEAR : " D ^%DT G:"^"[X!(Y<0) END G:Y'<LATE SDT G:(+$E(Y,6,7)'=0)!(+$E(Y,4,5)=0) SDT
 ;S Y=$E(Y,1,5)_"01" I RUN'=4&(Y<$G(SDT)) W !!,$C(7),"Data available to print starts with "_PSDT_".",! G SDT
 ;I RUN=4&(Y<$G(IVSDT)) W !!,$C(7),"Data available to print starts with "_PIVSDT_".",! G SDT
 S SDT=Y
EDT S %DT(0)=SDT W ! S %DT="APEM",%DT("A")="   Ending    MONTH/YEAR : " D ^%DT K %DT G:"^"[X END G:+$E(Y,6,7)'=0!(+$E(Y,4,5)=0) EDT G:Y<0 END I Y'<LATE W $C(7),"  End of month cannot be in the future" G EDT
 W ! S EDT=$E(Y,1,5)_$P("31^29^31^30^31^30^31^31^30^31^30^31","^",$E(Y,4,5))
 S FND=$O(^PS(59.12,SDT)) I RUN'=4,(FND>EDT!(+FND=0)) S Y=$E(SDT,1,5)_"01" X ^DD("DD") S SDATE=Y,Y=EDT X ^DD("DD") S EDATE=Y D  G END
 .W !!,?5,$C(7),"There is no prescription data between "_SDATE_" and "_EDATE_".**",!?7,"Use the Date Range Compile option to make the data available.",!,?5,"For IV data, use the Intravenous Admixture option."
 S (QTR,Q1,Q2)=0,SMN=$E(SDT,4,5),EMN=$E(EDT,4,5)
 I SMN=10!(SMN="01")!(SMN="04")!(SMN="07") S EMN=$P("3^^^6^^^9^^^12^","^",SMN),EQTR=$E(SDT,1,3)_EMN_$P("31^29^31^30^31^30^31^31^30^31^30^31","^",EMN) S:EDT'<EQTR QTR=$P("2^^^3^^^4^^^1^","^",SMN)
 S:QTR=1 Q1=10,Q2=12 S:QTR=2 Q1=1,Q2=3 S:QTR=3 Q1=4,Q2=6 S:QTR=4 Q1=7,Q2=9
QUE K %DT,%ZIS,IOP,ZTSK S PSOION=ION,%ZIS("B")="",%ZIS="QM" D ^%ZIS
 I POP S IOP=PSOION D ^%ZIS U IO K DVCNT,IOP,PSOION W !,$C(7),$C(7),"Report not Queued!" G END
 K DVCNT I $D(IO("Q")) S ZTRTN=$S(RUN="A":"ENQ^PSOMGMN1",RUN=1:"EN^PSOMGMN1",RUN=2:"EN^PSOMGMN2",RUN=3:"EN^PSOMGMN3",1:"EN^PSOMGMN4"),ZTDESC="Outpatient Management Report" F G="SDT","EDT","DIV","ANS","QTR","Q1","Q2","RUN" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued !" K G,Y,X,%DT G END
 D:RUN="A" ENQ^PSOMGMN1 D:RUN=1 EN^PSOMGMN1 D:RUN=2 EN^PSOMGMN2 D:RUN=3 EN^PSOMGMN3 D:RUN=4 EN^PSOMGMN4
END D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,%DT,ANS,BEG,CNT,DIR,DIRUT,DIV,DV,DVMN,DTOUT,DUOUT,EDT,EMN,END,EQTR,G,K,I,IEN,IVE,IVS,LATE,M1,M2,M3,MM,MN,OUT,PG,POP,PRT,PRV,PDATE,PSDT,PIVSDT,PSOION
 K Q1,Q2,QCST,QMREQ,QTCST,QTMREQ,QTR,RUN,SDT,S1,S2,S3,SMN,SUBS,T1,T2,T3,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
