XINDX6 ;ISC/REL,GRK - GET SET OF ROUTINES TO INDEX ;07/22/08  13:54
 ;;7.3;TOOLKIT;**20,27,66,110**;Apr 25, 1995;Build 11
 ;INP(1=Print more than warnings, 2= Print routines, 3= Print warnings, 4= Print DDs & Functions & Options, 5= Type of List, 6= Summary only, 7= Save Parameters
 ;INP(8= Index called routines, 9= Include the Compiled template routines, 10 = Build or Package file DA
 ;INP(11= execute to check for version number on second line, 12= Patch number check.
 N %A2,%I,%IN2,%IN3,%N,%QMK,%YN,AC,ANS,C8,CM,CX,DEF,DDOT,DIF,E,EC,ER
 N INDHDR,INP,LI,LL,LN,LV,N,NOA,OP,PG,QUES,RN,T,XCNP,XX1,XX2,Z,Z1,INDXDT
 K ^UTILITY($J),ZTSK,ZTDTH,ZTIO
 S:'$D(DTIME)#2 DTIME=360
 D HOME^%ZIS,HDR^XINDX7
 D ASKRTN,PARAM
 I $D(^DIC(9.4))!$D(^DIC(9.6)) D ^XINDX10 G END:$D(DUOUT) S INDDA=DA I DA>0 D ANS("Include the compiled template routines: N//","NY") G:X="^" END S:"Nn"'[X INP(9)=1
 G END:(NRO'>0)&(INDDA'>0)
 D ANS("Print more than compiled errors and warnings? YES//","YN","Print detailed info") G:X="^" END S INP(1)="Yy"[X G:'INP(1) L7
 D ANS("Print summary only? NO//","NY","Skip detail on each routine") G:X="^" END S INP(6)="Yy"[X G L7:INP(6)
 D ANS("Print routines? YES//","YN","Print routines code also") G:X="^" END S INP(2)="Yy"[X
 I INP(2) D ANS("Print (R)egular,(S)tructured or (B)oth?  R//","RLIST") G:X="^" END S INP(5)=X
 I INDDA>0 D ANS("Print the DDs, Functions, and Options? YES//","YN","Gather other package code.") G:X="^" END S INP(4)="Yy"[X
 D ANS("Print errors and warnings with each routine? YES//","YN") G:X="^" END S INP(3)="Yy"[X
L7 I $D(^DIC(9.8,0)),$D(DUZ) D ANS("Save parameters in ROUTINE file? NO//","NY","Update the ROUTINE file with details") G:X="^" END S INP(7)="Yy"[X
 D ANS("Index all called routines? NO//","NY","Add called routines") G:X="^" END S INP(8)="Yy"[X
DEVICE W:NRO>2 !!,$C(7),"This report could take some time, Remember to QUEUE the report.",! K IOP,%ZIS S %ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP W !,$C(7),"XINDEX terminated.  No device specified." G END
 ;S IOP=ION_";"_IOST_$S($D(IO("DOC")):";"_IO("DOC"),1:";"_IOM_";"_IOSL)
 I IO=IO(0),"C"[$E(IOST),$D(IO("Q"))#2 W !,"Do you really mean queue to this device? NO//" D NY I "Nn"[X W !!,"Ok, tell me again ..." K IO("Q") D ^%ZISC G DEVICE
 I '$D(IO("Q")) G ALIVE^XINDEX ;Do it now
 ;Queue Report
 S ZTRTN="ALIVE^XINDEX",ZTDESC="XINDEX of "_NRO_" routine"_$S(NRO>1:"s.",1:".") F G="INP(","INDDA","^UTILITY($J,","NRO","INDPM" S ZTSAVE(G)=""
 K IO("Q") D ^%ZTLOAD,HOME^%ZIS
 ;
END K ZTSK,%ZIS G CLEAN^XINDX5
 ;
PARAM ;Setup Parameters
 S Q="""",RTN=0
 F I=1:1:10 S INP(I)=0
 S (INP(11),INP(12))=""
 S INP("MAX")=20000 ;Max routine size
 S INP("CMAX")=15000 ;Max Code in routine
 S INDDA=0
 Q
 ;
QUICK(RL) ;Quick Report, Just errors on some routines.
 N %A2,%I,%IN2,%IN3,%N,%QMK,%YN,AC,ANS,C8,CM,CX,DEF,DDOT,DIF,E,EC,ER
 N INDHDR,INDXDT,INP,LI,LL,LN,LV,N,NOA,OP,PG,QUES,RN,T,XCNP,XX1,XX2,Z,Z1
 K ^UTILITY($J),ZTSK,ZTDTH,ZTIO
 D HOME^%ZIS I '$D(IOP) D HDR^XINDX7
 I $D(IOP) S %ZIS="" D ^%ZIS ;Caller can set IOP to send output someplace else
 U IO
 I $D(RL) F %I=1:1 S Z=$P(RL,",",%I) Q:Z=""  S ^UTILITY($J,Z)=""
 D ASKRTN,PARAM
 I $O(^UTILITY($J,"@"))="" W !,"No Routines to process.",! D ^%ZISC Q
 S INP(1)=0,INP(6)=1 ;More then errors,Summary Only
 G ALIVE^XINDEX
 ;
ANS(PR,DEF,HELP) ;Ask question get answer
 N % F  S Y=1 W !!,PR D @DEF Q:Y
 Q
YN S %="Y" D RD Q:"^YyNn"[X  W:$D(HELP) !,HELP W !,"Please enter 'Y' or return for YES, 'N' for NO" S Y=0 Q
 ;
NY S %="N" D RD Q:"^YyNn"[X  W:$D(HELP) !,HELP W !,"Please enter 'N' or return for NO, 'Y' for YES" S Y=0 Q
 ;
RD R X:DTIME S:X["^" X="^" S X=$E($$CASE^XINDX52(X)_%) Q
 ;
RLIST S %="R" D RD Q:"^RSBF"[X  W !,"Please select one of the choices." S Y=0 Q
 Q
ASKRTN ;Collect a list of routines to index.
 I '$D(^UTILITY($J)),$D(^%ZOSF("RSEL")) X ^("RSEL")
 S NRO=0,X=0 F I=0:0 S X=$O(^UTILITY($J,X)) Q:X=""  S NRO=NRO+1
 Q
 W !!,"LIST OF ROUTINES TO BE INDEXED; PRESS RETURN TO TERMINATE LIST",! S NRO=0
R1 R !,"ROUTINE NAME: ",ROU:$S($G(DTIME):DTIME,1:360) Q:ROU=""
 I ROU'?1"%".UN&(ROU'?1U.UN) W "  INVALID ROUTINE NAME" G R1
 I $D(^%ZOSF("TEST")) S X=ROU X ^("TEST") E  W "  INVALID ROUTINE NAME" G R1
 S NRO=NRO+1,^UTILITY($J,ROU)=""
 G R1
