FBAABPG ;AISC/DMK - PURGE BATCH FILE ;11/15/2010
 ;;3.5;FEE BASIS;**117**;JAN 30, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,1:0) W *7,!!,"DUZ and DUZ(0) must be defined as a valid user to run the batch purge.",!! Q
 I DUZ(0)'="@" W *7,!!,"You must have programmer access (DUZ(0)='@') before running the batch purge.",!! Q
 D DT^DICRW S Y=DT D PDF^FBAAUTL S FBPGDT=Y
 I '$D(^FBAA(161.7,"AF")) W !,*7,?7,"There are no batches finalized !!" Q
RD W !,"This option is used to purge Fee Basis batch numbers that were"
 W !,"finalized before a specified date (at least 18 months ago)."
SETDT W ! S %DT="AEP",%DT(0)=("-"_$$FMADD^XLFDT(DT,-549)) ; IA #10103
 S %DT("A")="Purge batch #'s PRIOR to date : "
 D ^%DT G:Y<0 END K %DT S PDAT=Y
 ;
 S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO"
 S DIR("?")="Answer ""Yes"" if you wish to proceed with Fee Basis batch number purging!"
 D ^DIR K DIR I 'Y!$D(DIRUT) G END
 ;
 S VAR="PDAT^FBPGDT",VAL=PDAT_"^"_FBPGDT,PGM="START^FBAABPG" D ZIS^FBAAUTL G:FBPOP END
START U IO W:$E(IOST,1,2)="C-" @IOF W ?15,"*** BEGIN FEE BASIS BATCH NUMBER PURGE ***",!!! S CNT=0
 F PD=0:0 S PD=$O(^FBAA(161.7,"AF",PD)) Q:PD'>0!(PD'<PDAT)  F I=0:0 S I=$O(^FBAA(161.7,"AF",PD,I)) Q:I'>0  I $D(^FBAA(161.7,I,0)) D MORE
 G PRT
MORE S Y(0)=^FBAA(161.7,I,0),B=$P(Y(0),"^",1),FBTYPE=$P(Y(0),"^",3),FBDUZ=$P(Y(0),"^",5) D MEDP:FBTYPE="B3",TRAVP:FBTYPE="B2",RPHP:FBTYPE="B5",CHP:FBTYPE="B9"
 Q
MEDP F J=0:0 S J=$O(^FBAAC("AC",I,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",I,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",I,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",I,J,K,L,M)) Q:M'>0  I $D(^FBAAC(J,1,K,1,L,1,M,0)) S $P(^(0),"^",8)=""
 K ^FBAAC("AC",I) D GOT Q
TRAVP F J=0:0 S J=$O(^FBAAC("AD",I,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AD",I,J,K)) Q:K'>0  I $D(^FBAAC(J,3,K,0)) S $P(^(0),"^",2)=""
 K ^FBAAC("AD",I) D GOT Q
RPHP F J=0:0 S J=$O(^FBAA(162.1,"AE",I,J)) Q:J'>0  F K=0:0 S K=$O(^FBAA(162.1,"AE",I,J,K)) Q:K'>0  I $D(^FBAA(162.1,J,"RX",K,0)) S $P(^(0),"^",17)=""
 K ^FBAA(162.1,"AE",I),^FBAA(162.1,"AJ",I) D GOT Q
GOT S CNT=CNT+1 W "." S DIK="^FBAA(161.7,",DA=I D ^DIK Q
PRT I CNT=0 W !!,?10,"There are no batch numbers to purge for this time frame !! " G END
 W:CNT>0 !!,?10,"This option has purged  ",CNT,"  batch numbers",!!,?16,"finalized prior to  ",$E(PDAT,4,5)_"/"_$E(PDAT,6,7)_"/"_$E(PDAT,2,3)," ."
 S ^FBAA(161.4,1,"PURGE")=DT
 W !!!!,?15,"***  FEE BASIS BATCH NUMBER PURGE FINISHED ***"
 S XMB(1)=$S($D(^VA(200,DUZ,0)):$P(^(0),"^",1),1:"Unknown User"),XMB(2)=FBPGDT,Y=PDAT D PDF^FBAAUTL S XMB(3)=Y,XMB(4)=CNT,XMB="FBAA BATCH PURGE" D ^XMB
END K I,J,K,L,M,Y,DA,D0,D1,CNT,DIC,DIRUT,DIW,DIWL,DIWT,DN,X,DIK,PDAT,VAR,VAL,FBPGDT,FBTYPE,B,PD,PGM,FBDUZ,XM1,XMA,XMDT,XMM,XMB D CLOSE^FBAAUTL Q
CHP F J=0:0 S J=$O(^FBAAI("AC",I,J)) Q:J'>0  I $D(^FBAAI(J,0)),'$D(^("FBREJ")) S $P(^FBAAI(J,0),"^",17)=""
 K ^FBAAI("AC",I),^FBAAI("AE",I) D GOT Q
