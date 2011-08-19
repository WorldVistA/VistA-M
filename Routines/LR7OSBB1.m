LR7OSBB1 ;slc/dcm - BB PT INFO for OE/RR pt lists ;8/11/97
 ;;5.2;LAB SERVICE;**121,230**;Sep 27, 1994
 ;Formerly known as LRBLPD1 which came from LRBLPD
OERR ;
 N LRDFN
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 I 'LRDFN W !,"No Lab Data for: "_$P(^DPT(DFN,0),"^") Q
 S LRDPF="2^DPT(",LRQ=1
 D INI
 S DIWL=5,DIWR=IOM-5,DIWF="W",C(1.7)="RBC Antibody present:",C(1)="RBC Antigen present :",C(1.5)="RBC Antigen absent  :"
 D S^LRU I $A(IOST)=80 S A(1)=0 D L^LRU,H
 I $A(IOST)'=80 W @IOF,!,LRP," ",SSN,?46,$J(LRPABO,2),?49,LRPRH S A(1)=$Y+(IOSL-3)
 D S F B=0:1 S A=$O(^LR(LRDFN,3,A)) Q:'A  S X=^(A,0) D:$Y>A(1)!'$Y MORE Q:A(2)?1P  D ^DIWP
 D:B ^DIWW D S F C=1.7,1,1.5 Q:A(2)?1P  W ! S A=0 F B=0:1 S A=$O(^LR(LRDFN,C,A)) Q:'A!(A(2)?1P)  W:'B C(C) W:B ! W ?21,$P(^LAB(61.3,A,0),"^") D:$Y>A(1)!'$Y MORE Q:A(2)?1P
 D S F B=1:1 S A=$O(^LR(LRDFN,1.6,A)) Q:'A!(A(2)?1P)  S X=^LR(LRDFN,1.6,A,0),Y=+X D D^LRU,N Q:A(2)?1P  D:$Y>A(1)!'$Y MORE Q:A(2)?1P
 I B=1,A(2)'?1P W !,"No transfused units on record",!
 Q
 ;
N W:B=1 !!?34,"TRANSFUSIONS",?64,"Transfusion",!?6,"Unit",?18,"Component",?36,"(# of units/ml )",?60,"Date/time completed"
 S X(1)=$P(X,"^",2),X(7)=$P(X,"^",7),X(10)=$P(X,"^",10),M=$S(X(1):$E($P(^LAB(66,X(1),0),"^"),1,30),1:"component not entered")
 W !,$J(B,3),")",?6,$P(X,"^",3),?18,$E($P(M,"^"),1,30) I X(7)!(X(10)) W ?45,"(",X(7),"/",X(10),")"
 W ?54,$P(X,"^",5)_" "_$P(X,"^",6),?60,Y
 F F=1,2 F E=0:0 S E=$O(^LR(LRDFN,1.6,A,F,E)) Q:'E!(A(2)?1P)  W !?6,^(E,0) D:$Y>A(1)!'$Y MORE Q:A(2)?1P
 Q
 ;
MORE G:$A(IOST)=80 H R !,"^ TO STOP: ",A(2):DTIME I A(2)?1P S A=0 Q
 S A(1)=A(1)+21 W $C(13),$J("",15),$C(13) Q
S S (A,A(2))=0 Q
 ;
H S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU W @IOF,!,Y,?22,LRQ(1),?(IOM-10),"Pg: ",LRQ
 W !,"LABORATORY SERVICE"
 W !,LRP," ",SSN,?46,$J(LRPABO,2),?49,LRPRH S A(1)=A(1)+(IOSL-4) Q
SET ;
 D V^LRU S X="BLOOD BANK" D ^LRUTL
 I Y=-1 S OREND=1 Q
 I LRSS'="BB" W $C(7),!!,"MUST BE BLOOD BANK" S OREND=1 Q
 Q
CLEAN ;
 K A,AGE,B,C,DFN,DOB,I,LR,LRAA,LRABV,LRAD,LRADM,LRADX,LRAWRD,LRAX,LRCAPLOC,LRDFN,LRDPAF,LRDPF,LRFNAM,LRH,LRMD,LROLLOC,LRP,LRPABO,LRPARAM,LRPF,LRPFN,LRPRH,LRQ,LRS,LRSF,LRSS,LRSVC,LRU,LRWHO,N,P,R,SEX,SSN,X,Y
 Q
INI ;
 K LREXP S (LRS,LRS(1),LRSVC,DOB,LRAWRD,LRMD,LRMD(1),LRADX,LRADM)="",LRPF="^"_$P(LRDPF,"^",2),LRPFN=+LRDPF,LRFNAM=$P(^DIC(LRPFN,0),"^")
 S Y=@(LRPF_DFN_",0)"),LRP=$P(Y,"^"),SEX=$P(Y,"^",2),DOB=$P(Y,"^",3),SSN=$P(Y,"^",9),LRLLOC=$S($D(^(.1)):^(.1),1:""),X=$S($D(^(.104)):+^(.104),1:"") D SSN^LRU I 'X S X=$S($D(^LR(LRDFN,.2)):+^(.2),1:"")
 S:LRLLOC="" LRLLOC="OUTPATIENT"
 I X,$D(^VA(200,X,0)) S LRMD=$P(^(0),"^"),LRMD(1)=X
 S X=^LR(LRDFN,0),LRPABO=$P(X,"^",5),LRPRH=$P(X,"^",6)
 S LRSVC=$S($D(@(LRPF_DFN_",.103)")):^(.103),1:"") I LRSVC S LRS=$S($D(^DIC(45.7,LRSVC,0)):$P(^(0),"^"),1:"") S:LRS]"" LRS(1)=LRSVC
 S (X2,Y)=DOB,AGE="" I Y>1630000 D D^LRU S DOB=Y,X1=DT D ^%DTC S AGE=X\365.25
 I $D(@(LRPF_DFN_",.35)")),$P(@(LRPF_DFN_",.35)"),"^") S (LREXP,Y)=+^(.35) D D^LRU S (LRLLOC,^LR(LRDFN,.1))="DIED "_Y W $C(7),!!,?34,"",LRLLOC,"",! Q
 Q
