PSOCSTM ;BHAM ISC/SAB - monthly rx cost compilation ;7/10/06 4:36pm
 ;;7.0;OUTPATIENT PHARMACY;**4,17,19,28,89,212,246**;DEC 1997;Build 12
 ;External Ref. to ^PS(55 DBIA# 2228
 ;External Ref. to ^DPT DBIA# 10035
 ;External Ref. to ^PSDRUG DBIA# 221
 ;
 ;*212 don't allow this request, if monthly compile is running
 ;*246 alter SRCH1 For loop to not init to numeric values
 ;
 Q:$$MTHLCK(1)            ;get lock, quit if already locked    PSO*212
 K BDT,EDT W !!,"**** Date Range Selection ****" S LATE=$E(DT,1,5)_"00"
BEG W ! S %DT="APE",%DT("A")="   Beginning MONTH/YEAR : " D ^%DT G:Y<0 Q W:Y'<LATE !!,$C(7),"Run 'DAILY' compilation routine for selected month!",! G:Y'<LATE BEG I (+$E(Y,6,7)'=0)!(+$E(Y,4,5)=0) D QUES G BEG
 S BDT=Y
END S %DT(0)=BDT W ! S %DT="APE",%DT("A")="   Ending    MONTH/YEAR : " D ^%DT K %DT G:Y<0 Q W:Y'<LATE !!,$C(7),"Run 'DAILY' compilation routine for selected month!",! G:Y'<LATE END I (+$E(Y,6,7)'=0)!(+$E(Y,4,5)=0) D QUES G END
 W ! S EDT=Y
 S ZTIO="",ZTRTN="START^PSOCSTM",ZTDESC="Rx Monthly Cost Compile" F G="EDT","BDT" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Task #"_ZTSK_" Queued!" K G,BDT,EDT,ZTSAVE,ZTIO,ZTRTN,ZTDESC Q
 L -^PSOCSTM                                    ;unlock month end flag
 ;
START Q:$$MTHLCK^PSOCSTM(1)      ;get lock, quit if already locked  PSO*212
 K ^TMP($J) S PSG=0 F I=1:1 S X=$T(G+I) Q:$P(X,";",3)=""  S A(I)=$P(X,";",3),B(I)=$P(X,";",4),PSG=PSG+1,A1(I)=$P(X,";",5),B1(I)=$P(X,";",6)
 S PSD=0 F I=1:1 S X=$T(D+I) Q:X=""  S C(I)=$P(X,";",3),D(I)=$P(X,";",4),PSD=PSD+1,C1(I)=$P(X,";",5),D1(I)=$P(X,";",6)
 F PSDT=BDT:100:EDT K ^PSCST(PSDT),^PSCST("B",PSDT)
 S STOP=$E(EDT,1,5)_"31.2359",PSDT=BDT F  S PSDT=$O(^PSCST(PSDT)) Q:'PSDT!(PSDT>STOP)  K ^PSCST(PSDT),^PSCST("B",PSDT)
 K STOP
 ;
SRCH F PSDT=BDT:100:EDT S PSDTX=PSDT+100 D:$E(PSDT,4,5)<13 SRCH1,SET1 S:$E(PSDT,4,5)>12 PSDT=$E(PSDT,1,2)_($E(PSDT,3)+1)_"0000"
 S PSOCNT=0 F PSDT=0:0 S PSDT=$O(^PSCST("B",PSDT)) Q:'PSDT  S PSD=PSDT,PSOCNT=PSOCNT+1
 S ^PSCST(0)="DRUG COST^50.9D^"_PSD_"^"_PSOCNT D ZNODE
Q K ^TMP($J),%DT,A,B,BDT,COST,DATA,DATA1,DATA2,DRG,DFN,EDT,I,II,LATE,ML,OR,PAST,PHYS,PSOCNT,PSD,PSDT,PSDT1,PSDTX,RXF,PSG,QTY,RF,RX0
 K RX2,DIV,D,C,CLINIC,A1,B1,C1,D1,RX1,RXN,VAL,VAR,PGM,VALUE,CDT,NDT,VISITS,DV,VIS,WD,X,X1,X2,Y S:$D(ZTQUEUED) ZTREQ="@"
 L -^PSOCSTM                                    ;unlock month end flag
 Q
 ;
SRCH1 D INI
 ;refill
 S PSDT1=PSDT                                ;*246
 F  S PSDT1=$O(^PSRX("AL",PSDT1)) Q:($E(PSDT1,1,7)<PSDT)!($E(PSDT1,1,7)>PSDTX)  D
 .S CDT=$P(PSDT1,".") F RXN=0:0 S RXN=$O(^PSRX("AL",PSDT1,RXN)) Q:'RXN  S RXF="" F  S RXF=$O(^PSRX("AL",PSDT1,RXN,RXF)) Q:RXF=""  D CHK
 .S NDT=$O(^PSRX("AL",PSDT1)) D:$P(NDT,".")'=CDT VST
 ;partial fill
 S PSDT1=PSDT                                ;*246
 F  S PSDT1=$O(^PSRX("AM",PSDT1)) Q:($E(PSDT1,1,7)<PSDT)!($E(PSDT1,1,7)>PSDTX)  D
 .S CDT=$P(PSDT1,"."),RXN=0 F  S RXN=$O(^PSRX("AM",PSDT1,RXN)) Q:'RXN  S RXF=0 F  S RXF=$O(^PSRX("AM",PSDT1,RXN,RXF)) Q:RXF=""  S PAR=1 D CHK
 .S NDT=$O(^PSRX("AM",PSDT1)) D:$P(NDT,".")'=CDT VST K PAR
 Q
INI K VIS S (VISITS,DV)=0 F  S DV=$O(^PS(59,DV)) Q:'+DV  S VIS(DV)=0
 Q
VST S DV=0 F  S DV=$O(^TMP($J,"PAT",DV)) Q:'DV  D
 .S DFN=0 F  S DFN=$O(^TMP($J,"PAT",DV,DFN)) Q:'DFN  S VIS(DV)=VIS(DV)+1,VISITS=VISITS+1
 K ^TMP($J,"PAT") Q
CHK I '$D(^PSRX(RXN,0)) K ^PSRX("AL",PSDT,RXN,RXF) Q
 Q:'$D(^PSRX(RXN,2))  S RX0=^PSRX(RXN,0),RX2=^PSRX(RXN,2)
 S DFN=+$P(RX0,"^",2) Q:'$D(^DPT(DFN,0))  D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 S DRG=+$P(RX0,"^",6) Q:'$D(^PSDRUG(DRG,0))
 ;S CLASS=+$P(^(0),"^",2) Q:'$D(^PS(50.605,CLASS,0))
 S DIV=+$P(RX2,"^",9) Q:'$D(^PS(59,DIV,0))
 S PHYS=+$P(RX0,"^",4) Q:'$D(^VA(200,PHYS,0))
 S PAST=+$P(RX0,"^",3) Q:'$D(^PS(53,PAST,0))
 S CLINIC=+$P(RX0,"^",5) K:'$D(^SC(CLINIC,0)) CLINIC
 S COST=$S(+$P(RX0,"^",17):+$P(RX0,"^",17),$D(^PSDRUG(DRG,660)):+$P(^(660),"^",6),1:0)
 I $G(PAR) D  S PR=0 Q
 .I '$D(^PSRX(RXN,"P",RXF,0)) K ^PSRX("AM",PSDT,RXN,RXF) Q
 .I $P(^PSRX(RXN,"P",RXF,0),"^",19) D
 ..S RX1=^PSRX(RXN,"P",RXF,0),DIV=$S($P(RX1,"^",9):$P(RX1,"^",9),1:$P(RX2,"^",9))
 ..S PHYS=$S($P(RX1,"^",17):$P(RX1,"^",17),1:$P(RX0,"^",4))
 ..S OR=0,RF=1,QTY=+$P(RX1,"^",4),ML=$S($P(RX1,"^",2)="M":1,1:0),WD=$S($P(RX1,"^",2)="W":1,1:0) S COST=QTY*COST D SET,SF
 I $P(RX2,"^",13),'RXF D  Q
 .S OR=1,RF=0,QTY=+$P(RX0,"^",7),ML=$S($P(RX0,"^",11)="M":1,1:0),WD=$S($P(RX0,"^",11)="W":1,1:0),COST=QTY*COST D SET,SF
 D:RXF 
 .I '$D(^PSRX(RXN,1,RXF,0)) K ^PSRX("AL",PSDT,RXN,RXF) Q
 .Q:'$P(^PSRX(RXN,1,RXF,0),"^",18)  S RX1=^PSRX(RXN,1,RXF,0)
 .S OR=0,RF=1,QTY=+$P(RX1,"^",4),ML=$S($P(RX1,"^",2)="M":1,1:0),WD=$S($P(RX1,"^",2)="W":1,1:0) S COST=QTY*COST
 .S PHYS=$S($P(RX1,"^",17):$P(RX1,"^",17),1:$P(RX0,"^",4)),DIV=$S($P(RX1,"^",9):$P(RX1,"^",9),1:$P(RX2,"^",9))
 .D SET,SF
 Q
SF S DATA="^"_OR_"^"_RF_"^"_COST_"^"_QTY_"^"_ML_"^"_WD,^TMP($J,"PAT",DIV,DFN)=""
 F I=1:1:PSG Q:('$D(CLINIC))&(I=PSG)  S DATA1=$S($D(@A(I))#2:^(0),1:@(B(I))_"^0^0^0^0") S DATA2=+$P(DATA1,"^") D
 .F II=2:1:7 S VALUE=$P(DATA,"^",II)+$P(DATA1,"^",II),DATA2=DATA2_"^"_VALUE S:II=7 @A(I)=DATA2
 .S:'$D(@A1(I)) @A1(I)=B1(I) S $P(@A1(I),"^",4)=+$P(@A1(I),"^",4)+1,$P(@A1(I),"^",3)=@B(I)
 F I=1:1:PSD S DATA1=$S(($D(@(C(I)))#2):$G(^(0)),1:@(D(I))_"^0^0^0^0") S DATA2=+$P(DATA1,"^") D
 .F II=2:1:7 S VALUE=$P(DATA,"^",II)+$P(DATA1,"^",II),DATA2=DATA2_"^"_VALUE S:II=7 @C(I)=DATA2 D
 .S:'$D(@C1(I)) @C1(I)=D1(I) S $P(@C1(I),"^",4)=+$P(@C1(I),"^",4)+1,$P(@C1(I),"^",3)=@D(I)
 Q
 ;
SET S:'$D(^PSCST(PSDT,0)) ^PSCST(PSDT,0)=PSDT,^PSCST("B",PSDT,PSDT)="" Q
SET1 S ^PSCST(PSDT,1)=DT_"^"_VISITS
 S DV=0 F  S DV=$O(VIS(DV)) Q:'DV  S $P(^PSCST(PSDT,"V",DV,0),"^",8)=+VIS(DV)
 Q
QUES W !,$C(7),"??",!,"For example, September 1993 could be entered as 9/93 or SEP 93.",!,"For Year 2000 Compliance enter date as 9/2000 or SEP 2000." Q
ZNODE ;update zero nodes
 F PSDT=BDT:$S('$D(BEGDATE):100,1:1):EDT S NDZ=0 F ND="D","P","PS","S","V" S NODE(ND)=0 D:$O(^PSCST(PSDT,"D",0))
 .F  S NDZ=$O(^PSCST(PSDT,ND,NDZ)) Q:'NDZ  S NODE(ND)=NODE(ND)+1,NDZ2=NDZ D:ND="V"
 ..S NDZ1=0,NODE(ND,"P")=0 F  S NDZ1=$O(^PSCST(PSDT,ND,NDZ2,"P",NDZ1)) Q:'NDZ1  S NODE(ND,"P")=NODE(ND,"P")+1
 ..S $P(^PSCST(PSDT,ND,NDZ2,"P",0),"^",4)=NODE(ND,"P"),NDZ1=0
 .S:$G(^PSCST(PSDT,ND,0))]"" $P(^PSCST(PSDT,ND,0),"^",4)=NODE(ND),NDZ=0
 K NDZ,ND,NODE,NDZ2,NDZ1 Q
 ;
MTHLCK(GET) ;lock for month end run or query if month end is running
 ; INPUT:  GET = 1  try to get lock and keep locked
 ;               0  query if locked only, leave as unlocked
 ; RETURNS: 1 - already locked
 ;          0 - was not already locked
 ;
 I '$D(ZTQUEUED) W !,"checking for duplicate job..."
 N GOTLOCK
 L +^PSOCSTM:10 S GOTLOCK=$T   ;delay 10 secs to handle slower systems
 I GOTLOCK,'GET L -^PSOCSTM Q 0
 I GOTLOCK,GET Q 0
 N AST S AST="",$P(AST,"*",79)=""
 D:'($D(ZTQUEUED))
 .W !!,*7,AST,!
 .W "Monthly Rx Cost Compilation is currently running, "
 .W "Try your request later",!
 .W AST,!!
 Q 1
 ;
 ;
G ;;
 ;;^PSCST(PSDT,0);PSDT;^TMP($J,"A1");1
 ;;^PSCST(PSDT,"P",PHYS,0);PHYS;^PSCST(PSDT,"P",0);^50.9001PA^^
 ;;^PSCST(PSDT,"P",PHYS,"D",DRG,0);DRG;^PSCST(PSDT,"P",PHYS,"D",0);^50.9002PA^^
 ;;^PSCST(PSDT,"D",DRG,0);DRG;^PSCST(PSDT,"D",0);^50.9003PA^^
 ;;^PSCST(PSDT,"D",DRG,"P",PHYS,0);PHYS;^PSCST(PSDT,"D",DRG,"P",0);^50.9004PA^^
 ;;^PSCST(PSDT,"PS",PAST,0);PAST;^PSCST(PSDT,"PS",0);^50.9005PA^^
 ;;^PSCST(PSDT,"S",CLINIC,0);CLINIC;^PSCST(PSDT,"S",0);^50.9008PA^^
 ;;
D ;;
 ;;^PSCST(PSDT,"V",DIV,0);DIV;^PSCST(PSDT,"V",0);^50.9006PA^^
 ;;^PSCST(PSDT,"V",DIV,"D",DRG,0);DRG;^PSCST(PSDT,"V",DIV,"D",0);^50.9007PA^^
 ;;^PSCST(PSDT,"V",DIV,"P",PHYS,0);PHYS;^PSCST(PSDT,"V",DIV,"P",0);^50.901PA^^
