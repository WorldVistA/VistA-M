DDMAP2 ;SFISC/JKS(Helsinki)-GRAPH OF FILEMAN PTRS ;2/4/91  3:38 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
NXF ;Loop thru file selected and get to/from pointers
 F DDFLE=0:0 S DDFLE=$O(^UTILITY($J,"F",DDFLE)) G:DDFLE'>0 ST D GETTO,GETFR
GETTO ;Look down "PT" X-ref to find files that point to me.
 F DDPT=0:0 S DDPT=$O(^DD(DDFLE,0,"PT",DDPT)) Q:DDPT'>0  F DDPTF=0:0 S DDPTF=$O(^DD(DDFLE,0,"PT",DDPT,DDPTF)) Q:DDPTF'>0  D NOT I DDW D NOT1
 Q
NOT1 S DDTO(DDFLE)=$S('$D(DDTO(DDFLE)):1,1:DDTO(DDFLE)+1) S ^UTILITY($J,"FD",DDFLE,"TO",DDTO(DDFLE),DDPT,DDPTF)=DDA1
 Q
NOT S DDW=0 I $D(^DD(DDPT,DDPTF,0)) S DDA1=$P(^(0),U,1,2),X=$P(DDA1,U,2) S:(X[("P"_DDFLE))!(X["V") DDW=1 Q
 Q
GETFR S DDPTF=DDFLE ;Look at all fields (and subs) to find pointers to others.
NXTF F DDPCK=0:0 S DDPCK=$O(^DD(DDPTF,DDPCK)) G:DDPCK'>0 SUB S DDA1=$P(^DD(DDPTF,DDPCK,0),U,1,2),DDA2=$P(DDA1,U,2) D SETF:DDA2?.E1"P"1N.E,SETV:DDA2["V"
 Q
SUB F DDMAPC=0:0 S DDPTF=$O(^DD(DDPTF)) Q:'$D(^DD(DDPTF,0,"UP"))!(DDPTF'[DDFLE)  D NXFLD
 Q
NXFLD F DDPCK=0:0 S DDPCK=$O(^DD(DDPTF,DDPCK)) Q:DDPCK'>0  S DDA1=$P(^(DDPCK,0),U,1,2),DDA2=$P(DDA1,U,2) D SETF:DDA2?.E1"P"1N.E,SETV:DDA2["V"
 Q
SETF S DDPT=+$P(DDA2,"P",2) S:DDPT ^UTILITY($J,"FD",DDFLE,"FR",DDPTF,DDPCK,DDPT)=DDA1
 Q
SETV F X=0:0 S X=$O(^DD(DDPTF,DDPCK,"V",X)) Q:X'>0  S DDPT=$P(^(X,0),U),^UTILITY($J,"FD",DDFLE,"FR",DDPTF,DDPCK,DDPT)=$P(DDA1,U,1)_U_"V"_DDPT
 Q
ST S DD9=0,DDFLE="",DDTB1=IOM\2,DDTB2=$S(IOM/4>30:30,1:IOM\4)+DDTB1,DDFNMAX=DDTB2-DDTB1-5,DDMIOSL=IOSL-4 D HDR G KILL^DDMAP:$D(DTOUT),^DDMAP1
VIIVA S DD5=$S($X<DDTB1:1,1:0) W:DD5 ?DDTB1,"-" W:'DD5 " " S DD5=$S(DD5:DDTB1,1:$X-1) F I=1:1:(DDTB2-DD5-1) W "-"
 W "-",! Q
HDR I "C"[$E(IOST) R !,"Enter ""^"" to exit or return to continue: ",X:$S($D(DTIME):DTIME,1:300) I X="^"!'$T S DTOUT=1 Q
 S Y=DT X ^DD("DD") W:$Y @IOF W !,"    File/Package: ",DDPCKN,?DDTB1+3,"Date: ",Y,!!
 W "  FILE (#)",?DDTB1-12,"POINTER","           (#) FILE",!,"   POINTER FIELD",?DDTB1-12," TYPE" W "           POINTER FIELD",?DDTB2+1,"FILE POINTED TO",! F I=1:1:IOM W "-"
 W !,"          L=Laygo      S=File not in set      N=Normal Ref.      C=Xref.",!,"          *=Truncated      m=Multiple           v=Variable Pointer",!!
 Q
