SDB ;FLA/RF,BSN/GRR - SET UP A CLINIC ;JAN 15, 2016
 ;;5.3;Scheduling;**20,63,167,455,568,586,627**;Aug 13, 1993;Build 249
 ;
 ; ICDFMT Added for Patch SD*5.3*586 - ICD10 remediation
 N ICDFMT
 S SDTOP=1,SDZQ=1 K SDREACT
C Q:$D(SDREACT)!('$D(SDTOP))  W !! D DT^DICRW S (DLAYGO,DIC)=44,DIC(0)="MAQEZL",DIC("A")="Select CLINIC NAME: ",DIC("DR")="2////C",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))" K SDREACT
 D TURNON^DIAUTL(44,".01;8;2502;2503;2505;2506")
 D ^DIC K DIC("A"),DIC("S") G:Y<0 END S DIE=44,DA=+Y S:$P(Y,U,3)=1 DIE("NO^")=""
 K SDIN,SDINH,SDRE,SDRE1 I $D(^SC(DA,"I")),+^("I")>0 S SDIN=+^("I"),SDINH=SDIN,SDRE=+$P(^("I"),"^",2)
 S DR="[SDB]",ICDFMT=4 S:'$D(^SC(DA,"ST",0)) ^SC(DA,"ST",0)="^44.005" D ^DIE K DIE("NO^")
EN ;Q:$D(SDONE)&('$D(SDTOP))  SD*5.3*455 added 2nd Go on next line
 D:$P(^SC(DA,0),U,3)="C" SDRES^SDECUTL2(DA)   ;alb/sat 627
 G C:'$D(^SC(DA,"SL")) G C:'+$G(^SC(DA,"SL")) S SL=^("SL"),STARTDAY=8,X=$P(SL,U,3),D=$P(SL,U,6),SI=$S(D:D,1:4),DIC(0)="MAQEZL",(DIC,DIE)="^SC("_DA_",""T"",",DIC("W")=$P($T(DOW),";",3) S:'$D(^("T",0)) ^(0)="^44.002D" S:$L(X) STARTDAY=X
 ;K SDREACT
G1 D:$D(SDREACT)&('$D(SDTOP)) E1 S SI=$P(SL,"^",6) K Y,HY S SDFSW="" S:$D(SDINH) SDIN=SDINH D PRINT
 S (SDREB,SDEL)=0,(SDSAV,SDPAT)="" R !!,"AVAILABILITY DATE: ",X:DTIME Q:U[X&$D(SDREACT)  G C:U[X S %DT="EFX" K Y D ^%DT G HLPD^SDB1:X["?" S POP=0 I $D(SDIN),$S(SDIN>Y!(SDIN=0):0,(SDRE'>Y&(SDRE'=0))!(SDRE=0&(SDIN=0)):0,1:1) D INACT G:POP G1
 G EN:$D(SDONE)&(Y<0)&('$D(SDTOP)),EN:$D(SDREACT)&(Y<0),C:Y<0&('$D(SDREACT)) S SD=Y,X=Y D DOW^SDM0 S DOW=Y
 D EN1^SDB0 Q:$D(SDREACT)
END K %,%DT,%H,C,CCXN,CNT,COLLAT,CTR,D0,DA,DFN,DG,DGO,DH,DI,DIC,DIE,DIFLD,DIK,DK,DL,DLAYGO,DM,DOW,DR,ENDATE,H1,H2,HSI,I,J,LT,M1,M2,MAX,NSL,POP,S,SB,SC,SD,SDAV,SDCL,SDDIF,SDEL,SDFSW,SDHX,SDIN,SDINA,SDINH,SDREACT,SDSDL,SDL,SDLA,SDMAX,SDMM,SDPAT
 K SDRE,SDREB,SDRVE,SDSAV,SDSOH,SDT,SDTOP,SDW,SDZQ,SDA1,SI,SL,SLT,SM,SS,SDSTRTDT,STARTDAY,STIME,STR,T1,T2,WY,X,Y,Y1,ZDX,DIRUT
 Q
INACT Q:Y<0  S POP=1,Y=SDIN D DTS^SDUTL S Y1=Y,Y=SDRE D:Y DTS^SDUTL W !,*7,"Clinic is inactive",$S('SDRE:" as of ",1:" from "),Y1,$S('SDRE:"",1:" to "_Y) Q
 ;
E1 S:'$D(^SC(DA,"T"_DOW,9999999,1))&($O(^SC(DA,"T"_DOW,0))>0) ^SC(DA,"T"_DOW,9999999,1)="",^(0)=9999999 D TX^SDB1 S:'$D(SDRE) SDRE=D0 Q
DOW ;;S %=$E(^(0),1,3),I=$E(^(0),4,5),I=I>2&'(%#4)+$E("144025036146",I) X "F %=%:-1:281 S I=%#4=1+1+I" W "  ",$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR",U,$E(^(0),6,7)+I#7+1),"DAY"
 Q
PRINT ;Print cancelled days
 N Y I '$D(^TMP("SDAVAIL",$J)) G PRINTQ
 W !,"Availability has been cancelled previously.  The day(s) has been overwritten",!,"with the new availability.  Would you like to see the day(s) that has been affected"
 S %=1 D YN^DICN G:%=-1!(%=2) PRINTQ I %=0 D HELP G PRINT
 S %ZIS="PMQ" D ^%ZIS I POP G PRINTQ
 I '$D(IO("Q")) G PRINT1
 S Y=$$QUE(0) G PRINTQ
 ;
PRINT1 N SDAVAIL,SDLINE S SDAVAIL=0,$P(SDLINE,"=",80)=""
 U IO W !,"Dates of Availability Previously Cancelled for "_$E($P($G(^SC(DA,0)),U),1,25),?70,$$FDATE^VALM1(DT),!,SDLINE
 F  S SDAVAIL=$O(^TMP("SDAVAIL",$J,SDAVAIL)) Q:'SDAVAIL  D
 .W !,$$FDATE^VALM1(SDAVAIL)_" "_$G(^TMP("SDAVAIL",$J,SDAVAIL))
 ;
PRINTQ K ^TMP("SDAVAIL",$J)
 D:'$D(ZTQUEUED) ^%ZISC
 Q
HELP ;
 W !,"Answer 'Y'es or 'N'o."
 Q
QUE(X) ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Previously Cancelled Availability Dates",ZTRTN="PRINT1^SDB"
 F  S X=$O(^TMP("SDAVAIL",$J,X)) Q:'X  D
 .S ZTSAVE("^TMP(""SDAVAIL"",$J,")=^TMP("SDAVAIL",$J,X)
 S ZTSAVE("DA")=DA
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
