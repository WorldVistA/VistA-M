SRSAVL ;B'HAM ISC/MAM - DISPLAY AVAILABILITY ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50,165**;24 Jun 93;Build 6
START K SRSDATE S SRSOUT=0,SRBPRG=1 D CURRENT^SRSBUTL
 S X="IOPTCH10;IOPTCH16" D ENDR^%ZISS S SR10=IOPTCH10,SR16=IOPTCH16 D KILL^%ZISS
 W @IOF,!,"Do you want to view all Operating Rooms on one day ?  YES //  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to view the availabilty of all operating rooms for a",!,"particular date, or 'NO' to view the availability of one specific operating",!,"room over a two week period."
 I "YyNn"'[SRYN W !!,"Press RETURN to continue  " R X:DTIME G START
 I "Yy"[SRYN D REQ G:SRSOUT END D:SREQ ^SRSAVL1 G END
 W !! K %DT S %DT="AEFX",%DT("A")="Begin Display on which Date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSDATE=+Y,SR1DAY=1
 W !! K DIC S DIC="^SRS(",DIC(0)="QEAMZ",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^(0),""^"",6))" D ^DIC I Y<0 S SRSOUT=1 G END
 S SROR=+Y,SROOM=$P(Y(0),"^"),SROOM=$P(^SC(SROOM,0),"^") I SR16="" D ^SRSDIS1 G END
 S IOP=IO_";132",%ZIS="" D ^%ZIS W SR16
 W @IOF,!,"Operating Room: "_SROOM,!!,"  DATE   12    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24"
 S SRDT=SRSDATE F SRDAZE=0:1:14 S X1=SRDT,X2=SRDAZE D C^%DTC S SRSDATE=X,SRDATE=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3)_"  " D LINE
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 S IOP=IO_";80",%ZIS="" D ^%ZIS W SR10 W @IOF K SRTN,SRBFLG,SRBSER1,SRBPRG D ^SRSKILL
 Q
REQ ; list requests ?
 S SREQ=0 W !!,"Do you want to list requests also ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you only want to view the availability of operating",!,"rooms, or 'YES' to also list requested cases for the date selected.",! G REQ
 I "Yy"[SRYN S SREQ=1
 K SR1DAY I '$D(SRSDATE) W ! K %DT S %DT="AEFX",%DT("A")="Display Operating Room Availability for which Date ?  " D ^%DT S:+Y SRSDATE=+Y I Y<0 S SRSOUT=1 Q
 I SR16="" D ^SRSDISP Q
 S IOP=IO_";132",%ZIS="" D ^%ZIS W SR16
 W @IOF,!!,"ROOM    12   1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20   21   22   23   24"
 S SROR=0 F  S SROR=$O(^SRS(SROR)) Q:'SROR  I '$P(^(SROR,0),"^",6) D:$$ORDIV^SROUTL0(SROR,SRSITE("DIV")) LINE
 Q
LINE I '$D(^SRS(SROR,"S",SRSDATE,1)) D GRAPH
 S SROR1=$P(^SRS(SROR,0),"^"),SROR1=$P(^SC(SROR1,0),"^")
 W !,$S($D(SR1DAY):SRDATE,1:$E(SROR1,1,6)),?8,$E(^SRS(SROR,"S",SRSDATE,1),11,200)
 Q
GRAPH ; set graph in ^SRS
 S ^SRS(SROR,"S",SRSDATE,0)=SRSDATE,^SRS(SROR,"SS",SRSDATE,0)=SRSDATE
 S ^SRS(SROR,"S",SRSDATE,1)=$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)_"  |____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|"
 S ^SRS(SROR,"SS",SRSDATE,1)=^SRS(SROR,"S",SRSDATE,1)
 S X1=SRSDATE,X2=2830103 D ^%DTC S SRDAY=$P("MO^TU^WE^TH^FR^SA^SU","^",X#7+1),X3=X#2+8 S X1=SRSDATE,X2=$E(SRSDATE,1,5)_"01" D ^%DTC S SRDY=X\7+1
 S SRTIME=0 F I=0:0 S SRTIME=$O(^SRS("R",SRDAY,SROR,SRTIME)) Q:SRTIME=""  S NUMB="" F I=0:0 S NUMB=$O(^SRS("R",SRDAY,SROR,SRTIME,NUMB)) Q:NUMB=""  S SRXREF=^(NUMB),SRSDAY=$P(SRXREF,"^",2) S SRNUMB=$E(SRSDAY,3),FLAG=0 D CHNG
 Q
CHNG ; change graph
 I SRSDAY[SRDAY,SRDY=4,SRNUMB=5 S X1=SRSDATE,X2=7,X5=$E(SRSDATE,4,5) D C^%DTC I $E(X,4,5)'=X5 S FLAG=1
 I 'FLAG,SRSDAY[SRDAY,(SRNUMB=0!(SRNUMB=SRDY))!(SRNUMB=X3) S FLAG=1
 I 'FLAG Q
 S SRST=$P(SRXREF,"^",3),SRET=$P(SRXREF,"^",4),SERV=$P(SRXREF,"^",5),P=""
 S SRX1=11+((SRST\1)*5)+(SRST-(SRST\1)*100\15),SRX2=11+((SRET\1)*5)+(SRET-(SRET\1)*100\15)
 F X=SRX1:1:SRX2-1 S P=P_$S('(X#5):"|",$E(SERV,X#5)'="":$E(SERV,X#5),1:".")
 S X1=^SRS(SROR,"S",SRSDATE,1),^(1)=$E(X1,1,SRX1)_P_$E(X1,SRX2+1,200),^SRS(SROR,"SS",SRSDATE,1)=^(1),^SRS(SROR,"S",SRSDATE,0)=SRSDATE,^SRS(SROR,"SS",SRSDATE,0)=SRSDATE Q
 Q 
