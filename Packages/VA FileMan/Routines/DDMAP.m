DDMAP ;SFISC/JKS(Helsinki)-GRAPH OF FILEMAN POINTER RELATIONS ;7/1/93  4:14 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;EXPLANATIONS:
 ; N =  normal reference
 ; S =  pointer file not included in the set
 ; C =  cross reference in the pointer file
 ; L =  laygo allowed
 ; * =  reference internally truncated
 ; m =  Multiple field
 ; v =  Variable Pointer
 ;
ST S DDPCK=1 I DUZ(0)'="@",$S($D(^VA(200,DUZ,"FOF",9.4,0)):1,1:$D(^DIC(3,DUZ,"FOF",9.4,0))) G INFO:$P(^(0),U,2),EN1
 I DUZ(0)'="@",$D(^DIC(9.4,0,"DD")) S DDPCK=0 F I=1:1:$L(^("DD")) I DUZ(0)[$E(^("DD"),I) S DDPCK=1 Q
 I 'DDPCK G EN1
INFO W !!,"Prints a graph of pointer relations in a database of FileMan files",!,"named in the Kernel PACKAGE file (9.4) or given separately.",!,"Works best with 132 column output!"
DDPCK D DT^DICRW K ^UTILITY($J),DDTO,DDPCK,DUOUT,DTOUT S DDPCKN="" G GET:'$D(^DD(9.4)) S DIC=9.4,DIC(0)="AEQML" D ^DIC G END:X[U!$D(DTOUT),GET:Y<0 S DDPCK=+Y,DDPCKN=$P(Y,U,2)
 S DDFLE="" F I=1:1 S DDFLE=$O(^DIC(9.4,DDPCK,4,"B",DDFLE)) Q:DDFLE=""  S ^UTILITY($J,"F",DDFLE)=""
 G GET:DDPCKN="" D LIST
REM S DIC=1,DIC(0)="AEMQ",DIC("S")="I $D(^UTILITY($J,""F"",+Y)) Q",DIC("A")="Remove FILE: " D ^DIC G:X[U!$D(DTOUT) END G:Y<0 ADD K ^UTILITY($J,"F",+Y) G REM
GET I DDPCKN="" W !!,"Enter files to be included"
ADD K DIC I DUZ(0)'="@" S DIC("S")="I 1 Q:'$D(^(0,""DD""))  F DC=1:1:$L(^(""DD"")) I DUZ(0)[$E(^(""DD""),DC) Q" D ADD0
 S DIC=1,DIC(0)="QEAM",DIC("A")="Add FILE: " D ^DIC G END:X[U!$D(DTOUT),ADD1:Y<0 S ^UTILITY($J,"F",+Y)="" G ADD
ADD0 I $D(^VA(200,"AFOF")) S DIC("S")="I $D(^VA(200,DUZ,""FOF"",+Y,0)),$P(^(0),U,2) Q"
 I $D(^DIC(3,"AFOF")) S DIC("S")="I $D(^DIC(3,DUZ,""FOF"",+Y,0)),$P(^(0),U,2) Q"
 Q
ADD1 G END:'$D(^UTILITY($J)) D:DDPCKN="" LIST
GO G END:'$D(^UTILITY($J)) W !,"Enter name of file group for optional graph header: " W:DDPCKN]"" DDPCKN,"// " R X:DTIME G:X[U!'$T END I X'[U,X]"",($L(X)<3!($L(X)>20)) W:X'["?" $C(7) G HLP1:X["?",HLP
 S:X="" X=DDPCKN S DDPCKN=X W !
EXIT S %ZIS="Q" D ^%ZIS G:POP EXIT1 S DDFLE=0
 I $D(IO("Q")) S ZTRTN="NXF^DDMAP2" F I="^UTILITY($J,","DDFLE","DDPCKN" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD G EXIT1
 U IO G ^DDMAP2
EN1 W !," Access NOT Permitted for this Routine.",!,"(Must have DD Access to the PACKAGE File)"
END K DIC,DDFLE,DDPCKN,DDPCK,^UTILITY($J) Q
EXIT2 I $D(ZTSK) K ^%ZTSK(ZTSK),ZTSK G KILL
EXIT1 I $D(DD9),IO=IO(0) R !,"Enter '^' to exit or return to continue: ",X:$S($D(DTIME):DTIME,1:300) I $T,X'=U D KILL W @IOF G ST
KILL W:$Y @IOF X $G(^%ZIS("C"))
 K ^UTILITY($J),DDA1,DDA2,DDCR,DIC,DDFL,DDFLD,DDFLE,DDFNMAX,DDFRN,DDFPT,I,DDINC,DDLGO,DDLN,DDMAX,DDOUT,DD5,DD7,DD9,DDP,DDPCK,DDPCKN,DDPP
 K %H,%ZISI,%,DISYS,DDPT,DDPTF,DDTB1,DDTB2,DDTO,DDW,X,Y,%T,%XX,%YY,ZTSK,DDMIOSL,DDMAPC
 Q
LIST W !!,"Files included" S DDFLE=0 F I=1:1 S DDFLE=$O(^UTILITY($J,"F",DDFLE)) Q:DDFLE'>0  W ?27,$J(DDFLE,10),"  ",$O(^DD(DDFLE,0,"NM","")),!
 Q
HLP1 W !,"Type a header that can be used for the print out"
HLP W !,"The Header must be between 3 and 20 characters" G GO
