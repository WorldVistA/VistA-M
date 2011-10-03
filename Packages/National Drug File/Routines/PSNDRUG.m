PSNDRUG ;BIR/CCH&WRT-Allows user to reset one or several drug matches ; 12/10/98 13:09
 ;;4.0; NATIONAL DRUG FILE;**2,3,33**; 30 Oct 98
 ;Reference to EN1^PSSUTIL supported by DBIA #3107
 ;Reference to ^PSDRUG supported by DBIAs #221 and #2352
 ;Reference to ^PS(59.7 supported by DBIA #2613
 S PSNFL=0 D EXPLN F PSNMM=1:1 D START S:'$D(PSNFL) PSNFL=0 Q:PSNFL
DONE W !!,"Remember, these matches must be verified using the options ""Verify Matches"" or",!,"""Verify Single Match"" and then be merged using the option ""Merge National Drug File",!,"Data Into Local File"".",!
 K PSNMM,PSNFL,X,Y,PSNB,PSNDEA,PSNINACT D KILL Q
EXPLN W !!,"Enter name of drug from your local drug file and a match",!,"with the National Drug File will be attempted. ",!,"Press return at the ""Select DRUG GENERIC NAME: "" prompt to exit.",! Q
START D KILL S DIC="^PSDRUG(",DIC(0)="QEAM" D ^DIC K DIC I Y<0 S PSNFL=1 Q
 S (PSNB,PSNDRG)=+Y,PSNLOC=$P(Y,"^",2) D CR^PSNHELP
DTE S DATE=$G(^PSDRUG(PSNB,"I")) I DATE,DATE>DT S %=0 W !,"This drug has an Inactivation date in the future. Do you want to continue" D YN^DICN G:%=0 DTE0 Q:%=2  Q:%<0
 I DATE,DATE<DT W !!,"This drug is ""Inactive"". Please try again.",! Q
 I $D(^PSDRUG(PSNB,3)),$P(^PSDRUG(PSNB,3),"^",1)=1,'$D(^XUSEC("PSNMGR",DUZ)) W !,"You cannot rematch this entry. It is marked to transmit to CMOP.",!,"You do not have the ""PSNMGR"" key.",! Q
 S PSNSAVEY=$G(Y) I $P(^PS(59.7,1,10),"^",3)=1,'$D(^PSDRUG(PSNB,"ND")) S X="PSSUTIL" X ^%ZOSF("TEST") I  D EN1^PSSUTIL(PSNB,0)
 S Y=$G(PSNSAVEY) K PSNSAVEY
 I $P(^PS(59.7,1,10),"^",3)=1,$D(^PSDRUG(+Y,"ND")) G REMTCH^PSNHELP
MATCH Q:'$D(^PSDRUG(PSNB,0))  Q:$P(^PSDRUG(PSNB,0),"^",1)']""
 I $D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)]"" Q
 I $D(PSNFLB),$D(^PSNTRAN(PSNB,0)) Q
 D KILL^PSNHIT,^PSNDEA Q:$D(PSNINACT)  Q:'$D(PSNDEA)  K PSNDEA
 I $P(^PS(59.7,1,10),"^",3)=1 K:$D(^PSNTRAN(PSNB,0)) ^PSNTRAN(PSNB,0) D NAM^PSNCOMP Q
 Q
KILL K ANS,PSNDA,PSNUNDA,PSNDDA,PSNSTDA,DIC,FF,KK,NBR,PSNANS,PSNCLASS,PSNDRG,PSNSZ,PSNFNM,PSNFORM,PSNLOC,PSNNDF,PSNNEW,PSNOLD,PSNPST,PSNSIZE,PSNSIZE,NDP,PS,PT,DOS,STR,UNT,VV,VV1,PSNTYPE,PSNPD
 K PSNNAM,PSNNAME,PSNTRFL,PSNTYP,PSNVAR,VAR,STOP,PSND,PSNDFM,PSNVC,PSNVCL,JJ,MJL,PSNODE,PSNOU,PSNSZE,PSNTPE,PSNENT,PSNF,PSNM,^TMP($J,"PSNND"),ASC,PSNRAN,PSNV,PSNWR,PSNX,PSNZ,WRT,BB,END,LIST,^TMP($J,"PSNPSPT"),^TMP($J,"PSNDFPK")
 K CODE,DA,DATE,DIR,EEE,FFF,FL,GGG,IEN,J,K,NO31,NOM31,NOMSYN,DUNCE,PP,PSNARY,PSNIEN,PSNP,PTPS,QQ,RR,ST,TT,TTT,WR,XX,XXX,Y,ZXZX,PPQ,PPR,^TMP($J,"PSNND"),^TMP($J,"PSNDF1"),^TMP($J,"PSNPSPS"),PSNUP,PSNINQ Q
DTE0 W !,"Answer yes or no" G DTE
GONE K DUNCE,TT,DIRUT,TTT,PPQ,PSNDRG,PSNLOC,PSNNAM,PSNODE,PSNOU,PSNP,NO31,NOM31,NOMSYN Q
