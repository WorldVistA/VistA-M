LRWU ;SLC/RWF/MILW/J - UTILITY FUNTIONS ; 12/28/88  11:04 ; 9/27/19 3:32pm
 ;;5.2;LAB SERVICE;**42,138,153,432,531**;Sep 27, 1994;Build 7
Z ;;set up 0th nodes for globals
 I '$D(@(LRZO_"0)")) S ^(0)="^"_LRZ1_"^^"
 S LRZI1=$S($P(@(LRZO_"0)"),"^",3)>LRZ3:$P(^(0),"^",3),1:LRZ3),LRZI2=$P(^(0),"^",4)+1,$P(^(0),"^",3,4)=LRZI1_"^"_LRZI2
 I $D(LRZB) S B="B",@(LRZO_"B,LRZB,LRZ3)")=""
 K LRZO,LRZ1,LRZ3,LRZI1,LRZI2 Q
LOC ;get pt. location, called by LRPDA1
 I $G(LRORDRR)="R" D  Q
 . S LRCAPLOC="Z",LRLLOC=$P(LRRSITE("RSITE"),U,2),(LROLLOC,LRTREA)=""
 N %
 I +LRDPF=LRDPF S LRDPF=LRDPF_^DIC(LRDPF,0,"GL")
 S LREND=0,LRCAPLOC="Z"
 I $D(LRDPF),+$G(LRDPF)=2,$G(DFN),$D(@("^"_$S(LRDPF["^":$P(LRDPF,"^",2),1:"DPT(")_DFN_",.1)")) S LRLLOC=^(.1) D DPT G ASK
 I $D(^LR(LRDFN,.1)) S LRLLOC=^(.1) G ASK
 S LRLLOC="UNKNOWN"
ASK W !,"PATIENT LOCATION: ",LRLLOC,$S(LRLLOC]"":"// ",1:"") R X:DTIME G QUIT:'$T,QUIT:X[U I $L(X)>30!(X'?.ANP) W "  Enter 2 - 30 alpha-numeric name" G LOC
 K DIC S DIC("S")="I '$G(^(""OOS""))&(""FI""'[$P($G(^(0)),""^"",3))"
 S LROLLOC="",DIC=44,DIC(0)="EMOQZ" S:X="" X=LRLLOC D ^DIC K DIC G LOC:X["?"
 S:Y>0 LROLLOC=+Y,LRLLOC=$P(Y(0),U,2),LRCAPLOC=$S($L($P(Y(0),U,3)):$P(Y(0),U,3),1:LRCAPLOC)
 I $L(LRLLOC) S ^LR(LRDFN,.1)=LRLLOC
 S:'$L(LRLLOC) LRLLOC="NO ABRV"
 S ^LR(LRDFN,.092)=LRCAPLOC
INACT K LRIA,LRRA I $D(^SC(+Y,"I")) S LRIA=+^("I"),LRRA=$P(^("I"),U,2)
 I $S('$D(LRIA):0,'LRIA:0,LRIA>DT:0,LRRA'>DT&(LRRA):0,1:1) W $C(7),"  Location is inactive, Not allowed." G LOC
 I Y<0,('$D(LRLABKY)!($P(^LAB(69.9,1,1),"^",8))) W "  You must select a standard location." G LOC
 I Y<0 W !,?7,"THAT MATCHES NO STANDARD LOCATION,",!,?12,"ARE YOU SURE" S %=2 D YN^DICN G LOC:%'=1 S LRLLOC=X,^LR(LRDFN,.1)=LRLLOC,^(.092)="Z"
 K DIC,LRIA,LRRA,% Q
QUIT S LREND=1 K DIC,LRIA,LRRE,% Q
DATE ;
 K DTOUT,DUOUT S LREND=0
 W !,$S($D(%DT("A")):%DT("A"),1:"DATE: "),$S($D(%DT("B")):%DT("B"),1:"TODAY"),"//" R X:DTIME S:X="^" DUOUT=1 S:'$T X="^",DTOUT=1 I $D(DUOUT)!($D(DTOUT)) S LREND=1,Y=-1 Q
 S:X="" X=$S($D(%DT("B")):%DT("B"),1:"T") S:$D(%DT)[0 %DT="E" S:%DT["A" %DT=$P(%DT,"A",1)_$P(%DT,"A",2) S:%DT'["E" %DT="E"_%DT D ^%DT G DATE:X="?"!(Y<1)
 K %DT Q
ADATE ;
 K %DT S %DT("A")="Accession Date: ",%DT="EP" D DATE
 I $D(LRAA)#2,$D(^LRO(68,LRAA,0)) S %=$P(^LRO(68,LRAA,0),U,3),Y=$S("D"[%:Y,%="Y":$E(Y,1,3)_"0000","M"[%:$E(Y,1,5)_"00","Q"[%:$E(Y,1,3)_"0000"+(($E(Y,4,5)-1)\3*300+100),1:Y)
 S LRAD=Y,LREND=(Y<1) Q
 Q
LOCA ;
 K DIC
 S LRLLOC="" R !,"Select HOSPITAL LOCATION NAME: ",X:DTIME S:'$L(X) X=U G LOCE:'$T!(X[U),LOCHELP:($L(X)>20)!(X'?.ANP)!(X="") S LRLLOC=X,DIC=44,DIC(0)="EMOQ",DIC("S")="I '$G(^(""OOS""))"
 D ^DIC K DIC I Y'<1 S LROLLOC=+Y,LRLLOC=$S($L($P(^SC(+Y,0),U,2)):$P(^(0),U,2),1:$P(^(0),U))
 G LOCHELP:X["?"!(X="")
 I Y<0 W !,?7,"THAT MATCHES NO STANDARD LOCATION,",!,?12,"ARE YOU SURE" S %=2 D YN^DICN G LOCA:%'=1
LOCE K DIC Q
LOCHELP W !,"Enter a location of 1 to 20 characters." G LOCA
DPT ;
 Q:'$D(LRLLOC)  K DIC S X=LRLLOC,DIC(0)="XM",DIC=42 D ^DIC K DIC I Y<1 Q
 I $D(^DIC(42,+Y,44)) S X=$P(^(44),U) I X,$D(^SC(X,0))#2,'$G(^("OOS")) D
 . S LRLLOC=$S($L($P(^SC(X,0),U,2)):$P(^(0),U,2),1:$P(^(0),U)),LROLLOC=X S:'$G(LRTREA) LRTREA=$P(^(0),U,20)
 Q
IO ;outputs ZTRTN
 D IOX K ZTRTN,ZTSAVE,IO("Q") D ^%ZISC
 Q
IOX S:'$D(%ZIS) %ZIS="Q" D ^%ZIS I POP S LREND=1 Q
 I $D(IO("Q")) K IO("Q") S ZTSAVE("L*")="" D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED" K ZTSK,ZTIO Q
 D @ZTRTN
 Q
A ;
 S X1=$A(X)_"." F I1=2:1:$L(X) S X1=X1_$A(X,I1)
 S X1=+X1
 Q
COLTY ;N DIR("A"),DIR(0)
 I $G(LRORDRR)="R" S LRLWC="R"
 I $G(LRLWC)="R" Q
 S DIR("B")=$S($D(LRLWC)=1:LRLWC,1:"SP") S LREND=0,DIR("A")="Specimen collected how ? ",DIR(0)="S^LC:LAB COLLECT(INPATIENTS-MORN. DRAW);SP:SEND PATIENT;WC:WARD COLLECT"
 S:$P($G(^LAB(69.9,1,7,DUZ(2),0)),U,6) DIR(0)=DIR(0)_";I:Immed COLLECT"
 D ^DIR S:X="^"!($D(DIRUT))!($D(DTOUT)) LREND=1 Q:LREND  S LRLWC=Y
 Q
 ;LR*5.2*531 DD code for DD 64.52 TYPE OF DISPLAY
TODIT ; Input transform for DD 64.52 TYPE OF DISPLAY
 N LRIEN
 I X="V" D  Q
 . S LRIEN=0 F  S LRIEN=$O(^LAB(64.5,1,1,DA(1),1,LRIEN)) Q:'LRIEN  D  Q:$G(X)=""
 . . I DA'=LRIEN W !,"Only one minor header allowed if vertical." K X Q
 I X="H" D
 . S LRIEN=0 F  S LRIEN=$O(^LAB(64.5,1,1,DA(1),1,LRIEN)) Q:'LRIEN  D  Q:$G(X)=""
 . . I $P(^LAB(64.5,1,1,DA(1),1,LRIEN,0),U,3)="V"&(DA'=LRIEN) D
 . . . W !,"No other minor headers may be defined after a vertical format minor header",!,"is defined." K X Q
 Q
