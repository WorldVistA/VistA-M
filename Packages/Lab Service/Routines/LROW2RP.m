LROW2RP ;SLC/RWA - OPTION TO REPRINT A ORDER ;8/11/97
 ;;5.2;LAB SERVICE;**121,201,242**;Sep 27, 1994
 K %ZIS S IOP=0 D ^%ZIS K IOP S DTIME=$S($D(DTIME):DTIME,1:300) I $D(DT)#2+1 S X="T" D ^%DT
 S DIC="^DPT(",DIC(0)="QAEMZ" D ^DIC G:Y<1 Q S DFN=+Y,DFN(0)=$P(Y(0),"^")
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 I 'LRDFN W !!,$P(Y(0),"^")," has no lab data!" G Q
DATE K %DT S %DT="AE",%DT("A")="Date of order: ",%DT("B")="TODAY" D ^%DT G Q:Y<1 S (Y,LRODT)=Y\1
 D D^DIQ S LRODT(0)=Y I '$D(^LRO(69,LRODT,1,"AA",LRDFN)) W !!,DFN(0)," has no collect orders for ",LRODT(0) G Q
 K L S I=0 F  S I=$O(^LRO(69,LRODT,1,"AA",LRDFN,I)) Q:I<1  I $D(^LRO(69,LRODT,1,I,.1)) S X=+^(.1) D K:X
 I '$D(L) W !!,DFN(0)," has no collect orders for ",LRODT(0) G Q
 S Y=$O(L(0)),X=$O(L(Y)) I X W !!?6,"Choose from the following order numbers:",!! S X=0 X "S I=0 F  S I=$O(L(I)) Q:I<1  W:X>6 ! S:X>6 X=0 W ?(X*10+4),$J(I,7) S X=X+1" W !
A W !,"ENTER COLLECT ORDER No.: ",Y,"// " R X:DTIME G Q:'$T!(X["^") S:X="" X=Y G:+X\1'=X!'$D(L(X)) A
 S I=0 F  S I=$O(L(X,I)) Q:I<1  S LRSN(I)=I
IO W !! K %ZIS S %ZIS="N",IOP="P" D ^%ZIS K %ZIS,IOP S:'POP LRORDER=ION I POP S %ZIS="NQ",%ZIS("A")="ORDER COPY DEVICE:" D ^%ZIS S:'POP LRORDER=ION I POP S IOP="HOME" D ^%ZIS
 Q:'$D(LRORDER)  S ION=LRORDER S LRSN=0 F I=0:0 S LRSN=$O(LRSN(LRSN)) G:'LRSN Q D PR
PR ;Send out for printing
 I IO(0)=IO S IOP=LRORDER,%ZIS="" D ^%ZIS D ENT2^LROW2P H 3
 I IO'=IO(0) D ^LROW2P
 Q
Q K %DT,%ZIS,I,J,L,X,Y,DFN,DIC,LRBED,LRCS,LRCSS,LRDFN,LRDPF,LRDTO,LRLLOC,LRLWC,LRORDER,LRORDTIM,LRODT,LRPR,LRSN,LRTP,LRUR,LRUSI,LRUSNM,SSN,PNM,T,IO("Q") S IOP=0 D:'$D(ZTQUEUED) ^%ZISC K IOP,ZTSK,VA("BID"),VA("PID") Q
K I '$D(^LRO(69,LRODT,1,I,2,0)) S X=""
 I X,'$$GOT^LROE(X,LRODT) S X=""
 S:X]"" L(X,I)="" Q
