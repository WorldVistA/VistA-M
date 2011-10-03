FBNHED ;AISC/GRR-ENTER DISCHARGE FROM NURSING HOME ;30AUG88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
 I '$D(^FBAACNH("AD",DFN)) W !!,*7,"Veteran does NOT have an active admission!" G RD1
RD0 S FBPROG="I $P(^(0),U,3)=7" D GETAUTH^FBAAUTL1 G RD1:FTP']"",RD1:$D(DUOUT),H^XUS:$D(DTOUT) I FBTYPE'=7 D WRONGT^FBAAUTL1 G RD0
 S IFN=+$O(^FBAACNH("AD",DFN,0)),FBTRT="D",FB(0)=$G(^FBAACNH(IFN,0)),FBLAD=$P(FB(0),"^",1),FBLTD=$O(^FBAACNH("AF",DFN,0)) D ^FBNHDEC
RD2 S DIR(0)="DA^::EXR",DIR("A")="Enter Discharge Date/Time:  ",DIR("?")="Enter date of discharge (time is required)" D ^DIR K DIR G:$D(DIRUT)!'Y Q S FBY=+Y D DATCK2^FBAAUTL1 G:'$D(X) RD2
 ;check to see if enough rate info to date of discharge
 D DRIV^FBNHRAT(DFN,IFN,.FB,$P(FBY,".")) I $D(FBUNR) D  D Q G RD1
 .W !!,*7,"Unable to establish rates for the following timeframes:"
 .S J=0 F  S J=$O(FBUNR(J)) Q:'J  W !?5,$$DATX^FBAAUTL(J)," through ",$$DATX^FBAAUTL($O(FBUNR(J,0)))
 .W !!,*7,"You can not discharge this patient without sufficient rate information.",!,"Check your contract!"
 S FBJ=0 F  S FBJ=$O(^FBAACNH("AF",DFN,FBJ)) Q:'FBJ  S FBK=$O(^FBAACNH("AF",DFN,FBJ,0)) I $P($G(^FBAACNH(FBK,0)),"^",5)=IFN D  Q
 .I $P(^FBAACNH(FBK,0),"^",7)=3 S FBASIH=1
 S DIR(0)=$S($G(FBASIH):"S^4:ASIH;5:DEATH WHILE ASIH",1:"S^1:REGULAR;2:DEATH;3:TRANSFER TO OTHER CNH;6:REGULAR - PRIVATE PAY"),DIR("A")="Enter Discharge Type:  " D ^DIR K DIR G:$D(DIRUT) Q S FBZ=+Y
 K DD,DO S X=FBY,DIC="^FBAACNH(",DIE=DIC,DIC(0)="LM",DLAYGO=162.3 D FILE^DICN G RD1:$D(DUOUT)!($D(DTOUT)),RD2:Y<0 S DA=+Y K DIC,DLAYGO
 S DR="8////^S X=FBVEN;1////^S X=DFN;2////^S X=""D"";4////^S X=IFN;7////^S X=FBZ" L +^FBAACNH(DA) D ^DIE L -^FBAACNH(DA) K DIE
 S DIE="^FBAACNH(",DA=IFN,DR="3///@" D ^DIE
 D UPDT
 G RD1
Q K FBTRT,FBTYPE,FBLAD,FTP,FBPROG,CNT,DAT,DIC,FBAUT,F,FBAAOUT,FBDX,FBI,FBRR,FBXX,I,PI,PTYPE,T,X,Y,Z,ZZ,FBY,FB7078,FBAAAD,FBAABDT,FBAAEDT,FBASSOC,FBAT,FBLOC,FBLTD,FBPDT,FBPOV,FBY1,FBNHED,FBUNR,DFN,IFN,FBASIH,FBJ,FBK
 K FBPSA,FBPT,FBTT,FBVEN D Q^FBNHRAT Q
UPDT S DA(1)=DFN,FBY1=$P(FBY,".")
 S DIE="^FBAAA("_DA(1)_",1,",DR=".02////^S X=FBY1",DA=FTP D ^DIE K DIE,DR
 K DA S DIE="^FB7078(",DR="4////^S X=FBY1",DA=FB7078 D ^DIE K DIE,DR
 ;update rate sensitive file since To Date of authorization is changed
 Q:FBY1>FBAAEDT
 S (FBO,FBAA(1))=FBAABDT,FB1=FBAAEDT,FBAA(2)=FBY1
 D UPDATE^FBNHEDA1
 K FBO,FBAA,FB1,FBZ
 Q
