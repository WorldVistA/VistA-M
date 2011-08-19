PSOBGMG3 ;BHAM ISC/LC - BINGO BOARD MANAGER (CONT'D) ; 06/19/96
 ;;7.0;OUTPATIENT PHARMACY;**11,77**;DEC 1997
 ;External reference to PS(50.7 is supported by DBIA 2223
 ;External reference to PSDRUG( is supported by DBIA 221
 ;
STATUS ;
STATUS1 N DA,DIC,DIK,NDA,NDA1,PAS,PAS1,RX,RX1,RXNUM,XX,Y
 S (EXT,DTME,RX,OLDT)="",(CNT,CNT1,RXNUM)=0
 W ! K DIC,DLAYGO S DIC=2,DIC(0)="AEMQZ",DIC("S")="I $D(^PS(52.11,""B"",+Y))!($D(^PS(52.41,""AOR"",+Y)))",DIC("A")="Enter Patient Name: " D ^DIC K DIC G:+Y'>0!($G(DTOUT))!($G(DUOUT)) EX S NAM=Y(0,0),NNUM=+Y
BING ;do not remove this entry point SAB
 S NNAM="" F  S NNAM=$O(^PS(52.11,"BA",NNAM)) Q:NNAM=""  I NAM=NNAM D
 .F NDA=0:0 S NDA=$O(^PS(52.11,"BA",NNAM,NDA)) Q:'NDA  I +$G(^PS(52.11,NDA,0))=$G(NNUM) S CNT=CNT+1,NDA(CNT)=NDA
PEND F NNAM=0:0  S NNAM=$O(^PS(52.41,"AOR",NNAM)) Q:'NNAM  I NNAM=$G(NNUM),NAM=$P($G(^DPT(NNAM,0)),"^") D
 .F NDAINS=0:0 S NDAINS=$O(^PS(52.41,"AOR",NNAM,NDAINS)) Q:'NDAINS  F NDA=0:0 S NDA=$O(^PS(52.41,"AOR",NNAM,NDAINS,NDA)) Q:'NDA  S CNT1=CNT1+1,NDA1(CNT1)=NDA
 F LP=0:0 S LP=$O(NDA(LP)) Q:('LP)!$G(EXT)  S DA=NDA(LP) D OLDT,PRSE
 F LP=0:0 S LP=$O(NDA1(LP)) Q:('LP)!$G(EXT)  S DA=NDA1(LP) D:$G(^PS(52.41,DA,0)) PRSE1
 K CNT,CNT1,LP,NDA,NDA1,NAM,NNAM,OI,OLDT,PAS,PAS1,NDAINS
 G:'$G(PSOHA) STATUS1
EX K CNT,CNT1,DG,EXT,LP,NDA,NDA1,NAM,NNAM,NNUM,OI,OLDT,PAS,PAS1,DA,DIC,DIK,DTME,DIS,DIV,PKP,TIN,TOUT,XX,Y,PN,ODTP,EBY,PROV,DRG,LOGDT,MW
 Q
 ;
OLDT ;
 S OLDT="" I $P($P($G(^PS(52.11,DA,0)),"^",5),".")'=DT S Y=$P($P($G(^PS(52.11,DA,0)),"^",5),".") D DD^%DT S OLDT="***Entered on "_Y_"***"
 Q
 ;
PRSE ;
 S RX="",RX1="",RXNUM=0
 F XX=0:0 S XX=$O(^PS(52.11,DA,2,"B",XX)) Q:'XX  S XX1=$S($G(^PSRX(XX,0)):$P(^(0),"^"),1:XX) D
 .S:$L(RX_XX1)>200 RX1=RX1_XX1_", " S:$L(RX_XX1)<200 RX=RX_XX1_", ",RXNUM=RXNUM+1
 S DTME=$P(^PS(52.11,DA,0),"^",5),DIS=$S($P(^(0),"^",7)'="":1,1:0),DIV=$P(^(0),"^",4),DG=$P(^(0),"^",3),TIN=$P(^(0),"^",6),TOUT=$P(^(0),"^",7)
 S PKP=$S($D(^PS(52.11,"AD",DG,DA)):1,1:0),PKPD=$S($D(^PS(52.11,"ANAMK",DA,DG,NNUM)):1,1:0)
 S TIN=+$E(TIN,1,2)_":"_$E(TIN,3,4),TOUT=+$E(TOUT,1,2)_":"_$E(TOUT,3,4) S Y=DTME X ^DD("DD") S DTME=Y
 W:'$G(PAS) @IOF,!,?8,NAM_" has the following orders for "_+$E(DT,4,5)_"/"_+$E(DT,6,7)_"/"_$E(DT,2,3)
 I '$G(DIS) W !!,"Being Processed: "_OLDT,!,?3,"Division: "_$P(^PS(59,DIV,0),"^"),?42,"Time In: "_TIN,?60,"Time Out: ",!,?3,"Rx #: "_RX W:$G(RX1) !,?3,RX1
 I $Y+6>IOSL D ENPG Q:$G(EXT)
 I $G(DIS),$G(PKP),'$G(PKPD) W !!,"Ready For Pickup: ",!,?3,"Division: "_$P(^PS(59,DIV,0),"^"),?42,"Time In: "_TIN,?60,"Time Out: "_TOUT,!,?3,"Rx #: "_RX W:$G(RX1) !,?3,RX1
 I $Y+6>IOSL D ENPG Q:$G(EXT)
 ;*****Picked Up status is dependent on wait time stored in ^PSRX*****
 I $G(DIS),$G(PKPD) W !!,"Picked Up: ",!,?3,"Division: "_$P(^PS(59,DIV,0),"^"),?42,"Time In: "_TIN,?60,"Time Out: "_TOUT,!,?3,"Rx #: "_RX W:$G(RX1) !,?3,RX1
 I $Y+6>IOSL D ENPG Q:$G(EXT)
 S PAS=1
STEX K DA,DIC,DG,DIK,DTME,DIS,DIV,PKP,PKPD,TIN,TOUT,XX,XX1,Y
 Q
PRSE1 ;PENDING
 Q:$P(^PS(52.41,DA,0),"^",3)="RF"
 S PN=$P(^PS(52.41,DA,0),"^"),ODTP=$P(^(0),"^",3),EBY=$P(^(0),"^",4),PROV=$P(^(0),"^",5),DRG=$P(^(0),"^",9),LOGDT=$P(^(0),"^",12),MW=$P(^(0),"^",17),OI=$P(^(0),"^",8)
 S Y=LOGDT,LOGDT=+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_"@"_$E($P(Y,".",2),1,2)_":"_$E($P(Y,".",2),3,4)
 ;format text for screen
 W:'$G(PAS)&('$G(PAS1)) @IOF,!,?8,NAM_" has the following orders for "_+$E(DT,4,5)_"/"_+$E(DT,6,7)_"/"_$E(DT,2,3)
 ;
 W !!,"Pending: ",!,?3,"Orderable Item: "_$P(^PS(50.7,OI,0),"^"),?52,"Provider: "_$P(^VA(200,PROV,0),"^")
 W !,?3,"Entered By: "_$P(^VA(200,EBY,0),"^"),?52,"Time In: "_LOGDT
 W !,?3,"Drug: "_$S($G(DRG):$P(^PSDRUG(DRG,0),"^"),1:""),?52,"Routing: "_$S($G(MW)="M":"MAIL",1:"WINDOW")
 I $Y+6>IOSL D ENPG Q:$G(EXT)
STEX1 K DA,DIC,DIK,PN,ODTP,EBY,PROV,DRG,LOGDT,MW,XX,XX1,Y
 S PAS1=1
 Q
ENPG K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E"
 D ^DIR S:'Y EXT=1
 K DIR,DTOUT,DIRUT,DUOUT W @IOF
 Q
