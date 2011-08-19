PSOCSTX ;BHAM ISC/SAB - COMMON CALL FOR ALL THE COST REPORTS ; 09/09/99 08:00
 ;;7.0;OUTPATIENT PHARMACY;**31**;DEC 1997
CDT K QUIT,%DT W ! S %DT(0)=-DT,%DT("A")="BEGINNING DATE: ",%DT="AEP" D ^%DT S:Y<0!($D(DTOUT)) CTR=1 Q:CTR  S (%DT(0),BEGDATE)=Y
 I $E(DT,1,5)'=$E(Y,1,5),+$E(Y,6,7)>1 D CTR Q:$G(CTR)
 I $E(DT,1,5)'=$E(BEGDATE,1,5),+$E(BEGDATE,6,7)>0 S BEGDATE=$E(BEGDATE,1,5)_"00"
 W ! S %DT("A")="ENDING DATE: ",%DT="AEP" D ^%DT S:Y<0!($D(DTOUT)) CTR=1 Q:$G(CTR) 
 S ENDDATE=Y,X1=DT,X2=Y D ^%DTC
 I X>1,$E(DT,1,5)'=$E(Y,1,5) S ENDDATE=$E(ENDDATE,1,5)_"00"
 I $E(DT,1,5)=$E(Y,1,5),+$E(Y,6,7)=0 S ENDDATE=DT-1
 Q
CTR ;Check for valid month selection
 K DIR S DIR(0)="Y",DIR("A")="Continue generating the monthly report ",DIR("B")="YES"
 S DIR("A",1)="Breakdown of daily data is not available for the past months "
 S DIR("A",2)="only monthly reports can be generated."
 S DIR("?")="Breakdown of daily cost is available only for the current month."
 S DIR("?",1)="Preferred format for past month start date entry is MMYY."
 S DIR("?",2)="The month-end process accumulates the monthly totals for the current"
 S DIR("?",3)="month and removes the daily cost breakdowns."
 D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT))!(Y<1) CTR=1 Q:$G(CTR)
 S BEGDATE=$E(BEGDATE,1,5)_"00"
 Q
CMC K DIR S DIR(0)="Y",DIR("A")="Do you want to look at data concerning a specific "_TTA,DIR("B")="YES"
 S DIR("?")="Report can be obtained for a particluar "_TTA_" by entering YES"
 S DIR("?",1)="Enter NO to generate the report for all "_TTB_" or ^ to quit."
 D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) CTR=1 Q:$G(CTR)  S IFN=Y
 Q
DRS D CMC Q:$G(CTR)
 I IFN S DIC(0)="AEQM",DIC="^PSDRUG(",DIC("A")="Select DRUG: " D ^DIC K DIC S:Y<0 CTR=1 Q:CTR  S DRUG=+Y
 Q
CTP W !!,"Report for the period: " S Y=BEGDATE D DT^DIO2 W " to " S Y=ENDDATE D DT^DIO2 W " will be generated "
 K DIR S DIR(0)="Y",DIR("A")="Continue generating the "_$S(RRM>80:132,1:80)_" column report for the shown period ",DIR("B")="YES"
 S DIR("?")="If the period shown is incorrect Enter NO or ^ to quit"
 S DIR("?",1)="Daily cost breakdown is available only for the current month and can be"
 S DIR("?",2)="obtained by selecting the start date & the end date within the current month."
 D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) CTR=1 Q:$G(CTR)  S:Y<1 RP=1
 Q
PRV D CMC Q:$G(CTR)
 I IFN S DIC("S")="I $G(^VA(200,+Y,""PS""))]""""",DIC(0)="AEQM",DIC="^VA(200,",DIC("A")="Select Provider: " D ^DIC K DIC S:Y<0 CTR=1 Q:CTR  S PHY=+Y
 Q
PTS D CMC Q:$G(CTR)
 I IFN S DIC(0)="AEQM",DIC="^PS(53,",DIC("A")="Select Patient Status: " D ^DIC K DIC S:Y<0 CTR=1 Q:CTR  S STA=+Y
 Q
HD D HD0
 W !!,$G(TT1),!,$G(TT2),! F I=1:1:RRM W "-"
 Q
HD0 I PAGE>1,$E(IOST)="C" S DIR(0)="E" D ^DIR I $D(DIRUT) S CTR=1 Q
 W @IOF,!,$G(TT0) S Y=BEGDATE D DT^DIO2 W " to " S Y=ENDDATE D DT^DIO2 W !,"Run Date: " S Y=DT D DT^DIO2
 W ?$S(RP=12:90,1:71),"Page: ",PAGE S PAGE=PAGE+1
 Q
HDC S RRM=$S(RP=12:110,1:80) S CTR=0,PAGE=1
 S TT=$S(RP=2:"Drug",RP=3:"Drug by Provider",RP=4:"Provider",RP=5:"Provider by Drug",RP=6:"Patient Status",RP=7:"Classification",RP=8:"Division",RP=9:"Division by Provider",RP=11:"Clinic",RP=12:"Division by Drug",1:"N/A")
 S TTA=$S(RP=2!(RP=3):"drug",RP=4!(RP=5):"provider",RP=6:"patient status",RP=7:"classification",RP=8!(RP=9)!(RP=12):"division",RP=11:"clinic",1:"")
 S TTB=TTA_$S(RP=6:"",1:"s")
 S TTC="$P(^"_$S(RP=2!(RP=3):"PSDRUG(DRUG",RP=4!(RP=5):"VA(200,PHY",RP=6:"PS(53,STA",RP=7:"PS(50.605,CLA",RP=8!(RP=9)!(RP=12):"PS(59,DIV",RP=11:"SC(CLA",1:"N/A")_",0),U)"
 I RP=2!(RP=5) S C1=41,C2=47,C3=53
 E  S C1=37,C2=43,C3=52
 S TT0="Drug Costs by "_$G(TT)_" for the period: "
 S TT1="",$E(TT1,C1)="Orign",$E(TT1,C3)="Total",$E(TT1,65)="Total",$E(TT1,73)="Avg Cost"
 S TT2=$G(TT),$E(TT2,C1)="Fills",$E(TT2,C2)="Refil",$E(TT2,C3)="Fills",$E(TT2,65)="Cost",$E(TT2,73)="per Fill"
 Q
HDN W !!,"**No Data Found for Requested Date Range for "
 I IFN W TTA_" ",@TTC
 E  W "All "_TTA_"s"
 W "**",!! D EX Q
DVC K %ZIS,IOP,POP,ZTSK S PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION S CTR=1
 Q
PRT S FILLS=($P(Y,"^",2)+$P(Y,"^",3)),CNT=CNT+FILLS,CNTO=CNTO+$P(Y,"^",2),CNTR=CNTR+$P(Y,"^",3),COST=COST+$P(Y,"^",4)
 W !,$G(TTX),?(C1-1),$J($P(Y,"^",2),5),?(C2-1),$J($P(Y,"^",3),5),?(C3-1),$J(FILLS,5),?59,$J($P(Y,"^",4),10,2),?72 S AVG=$S(FILLS=0:0,1:($P(Y,"^",4)/FILLS)) W $J(AVG,8,2)
 Q
FTX D FTU^PSOCSTX W !,"Total" D FTT^PSOCSTX,FTU^PSOCSTX W ! Q
FTU W !,?(C1-1),"-----",?(C2-1),"-----",?(C3-1),"-----",?59,"----------",?72,"--------"
 Q
FTT W ?(C1-1),$J(CNTO,5),?(C2-1),$J(CNTR,5),?(C3-1),$J(CNT,5),?59,$J(COST,10,2),?72 S AVG=$S(CNT=0:0,1:(COST/CNT)) W $J(AVG,8,2)
 Q
EX W ! W:$E(IOST)'["C" @IOF D ^%ZISC
 K ^TMP($J),%ZIS,ANS,AVG,BEGDATE,CNT,CNTO,CNTR,COST,CTR,RP,G,DIC,DRUG,DRUGX,ENDDATE,FILLS,I,IFN,IFNX,PAGE,PGM,PHY,PHYX,POP,PSDT,PSI
 K UTL,VAL,VAR,X,Y,%DT,ZTRTN,ZTDESC,ZTSK,STAX,STA,CLA,CLAX,DIV,DIVX,TTA,TTB,TTC,T1,T2,T3,T4,C1,C2,C3,CTR,RP,TT,TT0,TT1,TT2,TTX,RRM S:$D(ZTQUEUED) ZTREQ="@"
 Q
DVS D CMC Q:$G(CTR)
 I IFN S DIC(0)="AEQM",DIC="^PS(59,",DIC("A")="Select Division: " D ^DIC K DIC S:Y<0 CTR=1 Q:$G(CTR)  S IFN=1,DIV=+Y
 Q
SUB S T1=T1+CNTO,T2=T2+CNTR,T3=T3+CNT,T4=T4+COST,(CNTO,CNTR,COST,CNT,AVG)=0
 Q
TOT S CNTO=T1,CNTR=T2,CNT=T3,COST=T4 D HD:($Y+2)>IOSL D FTX Q
ZER S (CNT,CNTO,CNTR,COST,T1,T2,T3,T4)=0 Q
PAS F G="BEGDATE","ENDDATE","IFN","DRUG","PHY","STA","CLA","DIV","CTR","RP","RRM","PAGE","TT","TT0","TT1","TT2","TTA","TTB","TTC","C1","C2","C3" S:$D(@G) ZTSAVE(G)=""
 Q
