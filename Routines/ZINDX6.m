%INDX6 ;ISC/REL,GRK - GET SET OF ROUTINES TO INDEX ;8/3/93  16:10 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;INP(1=Print more than warnings, 2= Print routines, 3= Print warnings, 4= Print DDs & Functions & Options, 5= Type of List, 6= Summary only, 7= Save Parameters
 ;INP(8= Index called routines, 9= Include the Compiled template routines
 D HOME^%ZIS,HDR S:'$D(DTIME)#2 DTIME=360
 K ^UTILITY($J),ZTSK,ZTDTH,ZTIO D ASKRTN S Q="""",RTN=0 F I=1:1:10 S INP(I)=0
 S INDDA=0 I $D(^DIC(9.4)) D ^%INDX10 G END:$D(DUOUT) S INDDA=DA I DA>0 D ANS("Include the compiled template routines: N//","NY") G:X="^" END S:"Nn"'[X INP(9)=1
 G END:(NRO'>0)&(INDDA'>0)
 D ANS("Print more than compiled errors and warnings? YES//","YN","Print detailed info") G:X="^" END S INP(1)="Yy"[X G:'INP(1) L7
 D ANS("Print summary only? NO//","NY","Skip detail on each routine") G:X="^" END S INP(6)="Yy"[X G L7:INP(6)
 D ANS("Print routines? YES//","YN","Print routines code also") G:X="^" END S INP(2)="Yy"[X
 I INP(2) D ANS("Print (R)egular,(S)tructured or (B)oth?  R//","RLIST") G:X="^" END S INP(5)=X
 I INDDA>0 D ANS("Print the DDs, Functions, and Options? YES//","YN","Gather other package code.") G:X="^" END S INP(4)="Yy"[X
 D ANS("Print errors and warnings with each routine? YES//","YN") G:X="^" END S INP(3)="Yy"[X
L7 I $D(^DIC(9.8,0)) D ANS("Save parameters in ROUTINE file? NO//","NY","Update the ROUTINE file with details") G:X="^" END S INP(7)="Yy"[X
 D ANS("Index all called routines? NO//","NY","Add called routines") G:X="^" END S INP(8)="Yy"[X
DEVICE W:NRO>2 !!,$C(7),"This report could take some time, Remember to QUEUE the report.",! K IOP,%ZIS S %ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP W !,*7,"%INDEX terminated.  No device specified." G END
 ;S IOP=ION_";"_IOST_$S($D(IO("DOC")):";"_IO("DOC"),1:";"_IOM_";"_IOSL)
 I IO=IO(0),"C"[$E(IOST),$D(IO("Q"))#2 W !,"Do you really mean queue to this device? NO//" D NY I "Nn"[X W !!,"Ok, tell me again ..." K IO("Q") D ^%ZISC G DEVICE
 ;I IO'=IO(0),'$D(IO("Q")) W !!,"I am QUEUEING this report for you." S IO("Q")=1
 I '$D(IO("Q")) G ALIVE^%INDEX
 S ZTRTN="ALIVE^%INDEX",ZTDESC="%INDEX of "_NRO_" routine"_$S(NRO>1:"s.",1:".") F G="INP(","INDDA","^UTILITY($J,","NRO","INDPM" S ZTSAVE(G)=""
 K IO("Q") D ^%ZTLOAD,HOME^%ZIS
END K ZTSK,%ZIS G CLEAN^%INDX5
ANS(PR,DEF,HELP) ;Ask question get answer
 N % F  S Y=1 W !!,PR D @DEF Q:Y
 Q
YN S %="Y" D RD Q:"^YyNn"[X  W:$D(HELP) !,HELP W !,"Please enter 'Y' or return for YES, 'N' for NO" S Y=0 Q
NY S %="N" D RD Q:"^YyNn"[X  W:$D(HELP) !,HELP W !,"Please enter 'N' or return for NO, 'Y' for YES" S Y=0 Q
RD R X:DTIME S:X["^" X="^" S X=$E(X_%) Q
RLIST S %="R" D RD Q:"^RSBF"[X  W !,"Please select one of the choices." S Y=0 Q
 Q
ASKRTN ;Collect a list of routines to index.
 I $D(^%ZOSF("RSEL")) X ^("RSEL") S NRO=0,X=0 F I=0:0 S X=$O(^UTILITY($J,X)) Q:X=""  S NRO=NRO+1
 Q
 W !!,"LIST OF ROUTINES TO BE INDEXED; PRESS RETURN TO TERMINATE LIST",! S NRO=0
R1 R !,"ROUTINE NAME: ",ROU:$S($G(DTIME):DTIME,1:360) Q:ROU=""
 I ROU'?1"%".UN&(ROU'?1U.UN) W "  INVALID ROUTINE NAME" G R1
 I $D(^%ZOSF("TEST")) S X=ROU X ^("TEST") E  W "  INVALID ROUTINE NAME" G R1
 S NRO=NRO+1,^UTILITY($J,ROU)="" G R1
SETUP ;Write startup header stuff.
 U IO D HDR
 S Q="""",U="^",INDDS=0,RTN="$",DA=INDDA,IND("TM")=$H I INDDA>0 D START^%INDX10 D:IOSL\2<$Y HDR W !!,"Routines are being processed.",!
 W "Indexed Routines: ",NRO,!!
 Q
HDR D NOW^%DTC S Y=%,DT=$P(Y,".",1) D DD^%DT S INDXDT=Y X ^%ZOSF("UCI") S INDHDR(1)="UCI: "_$P(Y,",")_" CPU: "_^%ZOSF("VOL")_"    "_INDXDT,INDHDR="V. A.  C R O S S  R E F E R E N C E R  "_$P($T(+2),";",3)
 W:$Y>3 @IOF W !!,?IOM-$L(INDHDR)\2,INDHDR,!,?IOM-$L(INDHDR(1))\2,INDHDR(1),!
 Q
