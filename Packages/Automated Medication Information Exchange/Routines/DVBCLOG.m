DVBCLOG ;ALB/GTS-557/THM-LOG A 2507 REQUEST ; 9/21/91  9:26 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 I '$D(DUZ(2)) W *7,!!,"Your division number is missing.",!! H 3 G EXIT
 I $D(DUZ)#2=0 W !!,*7,"Your user number is invalid." H 3 G EXIT
 I +DUZ(2)<1 W !!,*7,"Invalid division",!! H 3 G EXIT
 ;
SETUP K ^TMP($J) D HOME^%ZIS S FF=IOF,HD="C & P Request Entry for",HD1="C & P Request Veteran Selection",HD2="Exam selection"
 ;
EN D KILL W @FF,?(IOM-$L(HD1)\2),HD1,!!! D ^DVBCPATA I $D(OUT) K OUT G EXIT
 S %DT="TS",X="NOW" D ^%DT S CTIM=Y K X,Y,%DT
 I $D(EDIT) K EDIT W @IOF,!,HD1," continued ---",!!!!!!
 ;
WARD S WARD=$S($D(^DPT(DFN,.1)):$P(^(.1),U,1),1:"") I WARD]"" W *7,"Vet is an INPATIENT, on ward "_WARD,!,"Want to continue" S %=2 D YN^DICN I $D(DTOUT) G EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y to proceed with the request or N to go",!,"back and re-select.",!! G WARD
 I $D(%),%'=1 G EN
 K DVBCNEW,DA,DD,DO,X,Y W !!
 S DIC="^DVB(396.3,",DIE=DIC,DIC(0)="EQLM",X=DFN,DLAYGO=396.3
 K OUT D HDR,^DVBCEEXM,DDIS^DVBCUTL2 K DIC("W") S X=DFN D DR,FILE^DICN K DLAYGO I $D(DTOUT) W *7,"   ... Timed out!  " H 1 W *7 S REQDA=+Y D DEL G EN
 I +Y<0 H 2 G EN ;deletions via ^ in file^dicn
 S (DA,REQDA)=+Y
 D:$P(^DVB(396.3,REQDA,0),"^",10)="E" INSUF^DVBCLOG2
 I $D(DVBAOUT) D DEL G EN
 ;
EDIT1 K ANS W !!,"Select action:",!!," Press [RETURN] to continue, or enter E to edit or X to cancel:  Continue// " R ANS:DTIME I '$T D DEL G EXIT
 I ANS[U W *7,!!,"""^"" NOT allowed here" G EDIT1
 I ANS["?" W !!,"[RETURN] will continue to exam selection, E will allow",!,"editing of what you have entered and X will DELETE",!,"the entire request" G EDIT1
 I ANS="E" K DVBAINRQ S:$P(^DVB(396.3,REQDA,0),"^",10)="E" DVBAINRQ="" W !?20,"(Edit) " H 1 S DA=REQDA,DIE="^DVB(396.3,",DR="9;10:10.2;29;21;24" D HDR,^DIE D:$P(^DVB(396.3,REQDA,0),"^",10)'="E"&($D(DVBAINRQ)) CLINSF^DVBCLOG2
 I ANS="E"&($D(DVBAINRQ)&($P(^DVB(396.3,REQDA,0),"^",10)="E")) DO
 .S DIR(0)="Y^AO",DIR("A")="Do you want to change the request this insufficient is linked to? "
 .S DIR("?")="Enter Yes to change the link and No to keep the current link",DIR("B")="NO" D ^DIR
 .I +Y=1 K DIR,Y D CLINSF^DVBCLOG2 S DA=REQDA D INSUF^DVBCLOG2
 I ANS="E"&('$D(DVBAINRQ)&($P(^DVB(396.3,REQDA,0),"^",10)="E")) D INSUF^DVBCLOG2
 I ANS="E",($D(DVBAOUT)) D DEL G EN
 I ANS="E" K DVBAINRQ G EDIT1
 I ANS="X" W !?20,"(Cancel) " D DEL K ANS G EN
 I ANS'?1"E"&(ANS'?1"X")&(ANS'?1"") W !!,*7,"Must be the RETURN key, X, or E " G EDIT1
 K DIC,DIE,ANS D ^DVBCLOGE I $D(OUT) K OUT D DEL
 I $D(DVBCLCKD) D DEL
 H 1 D KILL G EN
 ;
EXIT G KILL^DVBCUTIL
 ;
HDR W @FF,?(IOM-$L(HD)\2),HD,!!,"Veteran name: ",$P(PNAM,",",2,99)," ",$P(PNAM,",",1),?55,"SSN: ",SSN,!?53,"C-NUM: ",CNUM,!
 F LINE=1:1:IOM W "="
 W ! Q
 ;
DEL S DIK="^DVB(396.3,",DA=REQDA D ^DIK W !!,*7,"Request DELETED.",! K DIK,REQDA,DA S OUT=1 D CONTMES^DVBCUTL4 Q
 ;
KILL K %DT,CNUM,DFN,DIK,DR,DTA,DXCOD,DXNUM,EDIT,EX,ROUTLOC,EXMNM,EXMPT,PNAM,SSN,PCT,SC,REQDA,VX,JJ,X,%,^TMP($J),DA,DO,DD
 K Y,DVBCNEW,DIC,DIE,Y,DA,%Y,ADD1,ADD2,CITY,CNTY,CTIM,D0,DX,ELIG,INCMP,PRDSV,STATE,WARD,ZIP,DUOUT,DTOUT,DVBCLCKD,DVBAOUT,DVBADTOT
 Q
 ;
DR S DIC("DR")="1////"_CTIM_";17////N"_";2////^S X=DUZ(2);3////^S X=DUZ;9;10;10.1;10.2;S %DT(0)=-DT;29;21;24" Q
