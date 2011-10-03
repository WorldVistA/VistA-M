PRCSECP ;SFISC/KSS,LJP/DAP - COPY A TRANSACTION ; 9/7/2010
V ;;5.1;IFCAP;**81,148**;Oct 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
A I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 W @IOF,!!
B D EN3^PRCSUT ;GO GET STATION AND CONTROL POINT
 I '$D(PRC("SITE"))!('$D(PRC("CP")))!(Y<0)!('$D(X))!($G(X)[U) D END Q
 N GET,GET1 S DIC="^PRCS(410,",DIC(0)="AEQM"
 S DIC("S")="S PRCST=$P(^(0),U,2) I $D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2))) I PRCST=""O""!(PRCST=""CA"")"
 S DIC("A")="Select the Transaction to be copied: "
C W ! D ^PRCSDIC K PRCST
 I (X[U)!(Y<0) D END Q
 S DA=+Y D W1
 S PRCVFT=$P(^PRCS(410,DA,0),"^",4)
 ;*81 Check site parameter to see if Issue Books are allowed
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVZ=1
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVZ=0
 I PRCVZ=1,PRCVFT=5 W !,"All Supply Warehouse requests must be processed in the new Inventory System.",!!,"Please cancel this IFCAP issue book order." D W3 G:%'=1 END W !! K PRCS,PRCS2 G B
 W !!,"Would you like to proceed " S %=1 D YN^DICN G C:%'=1
 S DIC="^PRCS(410," L +^PRCS(410,DA):15 G END:$T=0
 S T1=DA,T2=^PRCS(410,DA,0),T5=$P(T2,U,4),T4=$P(T2,U,2),T2=$P(T2,U),T3=$P(^(3),U)
 K ^TMP($J)
 S ^TMP($J,"OLDDA")=DA,^("OLDTXN")=$P(T2,U,1),^("OLDFCP")=PRC("CP")
 W !!,"Now enter the information for the new transaction number.",!
 ;L -^PRCS(410,DA)
 K DA,DIC,Y D EN1^PRCSUT K DA,DIC
 I ('$D(PRC("SITE")))!('$D(PRC("QTR")))!('$D(PRC("CP"))) G UNLKEND
 I $P($G(^PRCS(410,T1,0)),"^",4)=1,$$Q1358^PRCEN(PRC("SITE"),PRC("CP")) G UNLKEND
 S X1=X,PRCSAPP=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),U,3)
 I PRC("CP")'=T3,PRCSAPP["_" D PRCFY^PRCSUT2 I (PRCSAPP["_") G UNLKEND
 S X=X1 D EN1^PRCSUT3 I 'X G UNLKEND
 S X1=X D EN2^PRCSUT3 I ('$D(X1)) G UNLKEND
 S (X,^TMP($J,"NEWTXN"))=X1
 W !!,"This transaction is assigned transaction number: ",X
 ;L +^PRCS(410,DA):15 G B:$T=0
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),U,11)="Y" PRCS2=1
TYPE ;
 S PRCSX=$P(^PRCS(410,T1,0),"^",4)
 ;*81 Check site parameter to see if issue books should be allowed
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVX="I Y>(.5)&(Y<5)",PRCVY="The Issue Book and NO FORM types are no longer used."
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVX="I Y>(.5)",PRCVY="The NO FORM type is no longer used."
 I PRCSX<1 W !,PRCVY,!,"Please enter another form type.",! S PRCDAA=DA,DIC="^PRCS(410.5,",DIC("S")=PRCVX,DIC("A")="FORM TYPE: ",DIC(0)="AEQZ" D ^DIC S:Y=-1 Y=2 S DA=PRCDAA,PRCSX=+Y
 S (DIE,DIC)="^PRCS(410,"
 K PRCVX,PRCVY
 S $P(^PRCS(410,DA,0),"^",4)=PRCSX
 W !,"The form type for this request is: ",$P($G(^PRCS(410.5,PRCSX,0)),"^"),!
 W !,?10,"Transaction data is being copied...",!
 D @$S(PRCSX=1:"S1^PRCSECP1",1:"S2^PRCSECP1") S DIK="^PRCS(410," D IX^DIK
 S (DIC,DIE)="^PRCS(410,"
 ;P182--removed warning about changed CC/BOC;replaced w/following call
 S X=$$CHGCCBOC^PRCSCK(^TMP($J,"OLDTXN"),^TMP($J,"NEWTXN"),^TMP($J,"OLDFCP"),0)
 S X=PRCSX S:'$D(PRCS2)&(X>2) $P(^PRCS(410,DA,0),"^",4)=2,X=2
 S (PRCSDR,DR)="["_$S(X=1:"PRCE NEW 1358",X=2:"PRCSEN2237B",X=3:"PRCSENPR",X=4:"PRCSENR&NR",X=5:"PRCSENIB",1:"PRCSENCOD")_"]"
D K DTOUT,DUOUT,Y S COPYDA=DA D ^DIE I $D(Y)!($D(DTOUT)) S DA=COPYDA G END
 S DA=COPYDA D RL^PRCSUT1
 D ^PRCSCK I $D(PRCSERR),PRCSERR G D
 K PRCSERR
 I PRCSDR="[PRCSENCOD]" D W7^PRCSEB0 D:$D(PRCSOB) ENOD1^PRCSEB1 K PRCSOB
 D:PRCSDR'="[PRCSENCOD]" W1 I PRCSDR'="[PRCSENCOD]",$D(PRCS2),+^PRCS(410,DA,0) D W6^PRCSEB
 S DA=COPYDA L -^PRCS(410,DA) D W3 G END:%'=1 W !! K PRCS,PRCS2
 G B
 ;
UNLKEND S DA=^TMP($J,"OLDDA") L -^PRCS(410,DA)
END K %,D0,DA,DIC,DIE,DIK,DR,N,P,PRCSAPP,COPYDA,PRCSDR,PRCSERR,PRCSI,PRCSIP,PRCSJ,PRCSJ,PRCSL,PRCST1,PRCSTMP,PRCSTT,PRCSX,PRCSZ,T1,T2,T3,T4,T5,X,X1,Y,PRCVZ,PRCVFT
 K ^TMP($J)
 Q
W1 W !!,"Would you like to review this request" S %=2 D YN^DICN G W1:%=0 Q:%'=1  S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=PRCSZ K X,PRCSF,PRCSZ Q
W3 W !!,"Would you like to copy another request" S %=1 D YN^DICN G W3:%=0 Q
 ;
GETCCCNT(STA,FCP) ;How many valid Cost Centers for this Control Point
 ;return count and first CC
 N GOODCC,CC,FIRSTCC
 S GOODCC=0,(CC,FIRSTCC)=""
 F  S CC=$O(^PRC(420,+STA,1,+FCP,2,CC)) Q:CC=""  D
 . I $$VALIDCC(STA,FCP,CC) S GOODCC=GOODCC+1 I FIRSTCC="" S FIRSTCC=$E($P(^PRCD(420.1,+CC,0),U,1),1,23)
 Q GOODCC_"^"_FIRSTCC
 ;
VALIDCC(STA,FCP,CC) ;Is this STATION,FCP,COST CENTER combination valid?
 ;To be valid, station/FCP must point to CC, CC must be active,CC must
 ;point to some active BOC
 N X,VALID,BOC,GOODBOC
 S BOC="",GOODBOC=0
 S X=$G(^PRC(420,+STA,1,+FCP,2,+CC,0))  I (+X=+CC) D  ;FCP => CC
 . S X=$G(^PRCD(420.1,CC,0)) I X]"",'$P(X,U,2) D  ;    CC IS ACTIVE
 .. F  S BOC=$O(^PRCD(420.1,+CC,1,BOC)) Q:BOC=""!GOODBOC  D
 ... S X=$G(^PRCD(420.2,+BOC,0)) I X]"",'$P(X,U,2) S GOODBOC=1
 Q GOODBOC
 ;
GETBOCNT(STA,FCP,CC) ;How many valid BOCs for this STATION,FCP,COST CENTER
 ;To be valid, station/FCP must point to CC, CC must be active,CC must
 ;point to some active BOC
 N X,VALID,BOC,GOODBOC,TOTBOCS,FIRSTBOC
 S BOC="",GOODBOC=0,TOTBOCS=0,FIRSTBOC=""
 S X=$G(^PRC(420,+STA,1,+FCP,2,+CC,0))  I (+X=+CC) D  ;FCP => CC
 . S X=$G(^PRCD(420.1,CC,0)) I X]"",'$P(X,U,2) D  ;    CC IS ACTIVE
 .. F  S BOC=$O(^PRCD(420.1,+CC,1,BOC)) Q:BOC=""  D
 ... S X=$G(^PRCD(420.2,+BOC,0)) I X]"",'$P(X,U,2) D
 .... S TOTBOCS=TOTBOCS+1 I FIRSTBOC="" S FIRSTBOC=$E($P(^PRCD(420.2,+BOC,0),U,1),1,23)
 Q TOTBOCS_"^"_FIRSTBOC
 ;
VALIDBOC(STA,FCP,CC,BOC) ;Is this STATION,FCP,COST CENTER,BOC VALID?
 ;To be valid, station/FCP must point to CC, CC must be active,CC must
 ;point to BOC,and BOC must be active
 N X,VALID,GOODBOC
 S GOODBOC=0
 S X=$G(^PRC(420,+STA,1,+FCP,2,+CC,0))
 I (+X=+CC) S X=$G(^PRCD(420.1,+CC,0)) I X]"",'$P(X,U,2) D
 . S X=$G(^PRCD(420.1,+CC,1,+BOC,0))
 . I X]"" S X=$G(^PRCD(420.2,+BOC,0)) I X]"",'$P(X,U,2) S GOODBOC=1
 Q GOODBOC
 ;
