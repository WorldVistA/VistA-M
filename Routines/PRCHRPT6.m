PRCHRPT6 ;BOISE/TKW-SUPPLEMENT TO PRCHRPT5--BUILD PRINT LOG OF REQUESTS/P.O.'S AND REPRINT ;4/27/89  9:59 AM ;2/19/92  3:50 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN1 ; REPRINT REQUESTS PRINTED IN A&MM (2237'S)
 D ST Q:'$D(PRC("SITE"))  S M1="Requests",M2="A&MM (2237's)",M5="R1"
 G SELLST
 ;
EN2 ; REPRINT REQUESTS PRINTED IN FISCAL (1358'S)
 D ST Q:'$D(PRC("SITE"))  S M1="Requests",M2="Fiscal (1358's)",M5="R2"
 G SELLST
 ;
EN3 ; REPRINT PURCHASE ORDERS PRINTED IN FISCAL
 D ST Q:'$D(PRC("SITE"))  S M1="Purchase Orders",M2="Fiscal",M5="P1"
 G SELLST
 ;
EN4 ; REPRINT PURCHASE ORDERS PRINTED IN A&MM AFTER OBLIGATION
 D ST Q:'$D(PRC("SITE"))  S M1="Purchase Orders",M2="A&MM after Obligation",M5="P2"
 G SELLST
 ;
EN5 ; REPRINT RECEIVING REPORTS PRINTED IN FISCAL
 D ST Q:'$D(PRC("SITE"))  S M1="Receiving Reports",M2="Fiscal",M5="P3"
 G SELLST
 ;
SELLST ; SELECT LIST TO BE REPRINTED
 S PRCHPGM="PRCHRPT6" W !! S DIC="^PRC(443.5,",DIC(0)="AEQMOZ",DIC("S")="I $P(^(0),U,2)=M5",DIC("A")="Select "_M1_" Print List Number: " D ^DIC K DIC G:Y=-1 EXIT^PRCHRPT5
 S PRCHREC=+Y,Y=+$P(Y(0),U,3) D DD^%DT S M3=Y,Y=+$P(Y(0),U,4) D DD^%DT S M4=Y
 W ! S %A="Display list ",%B="",%=2 D ^PRCFYN G:%=-1 EXIT^PRCHRPT5 G:%=0 SELLST I %=1 D HOME^%ZIS D PR1^PRCHRPT8
 S PRCHALL="N" W !!,"Do you want to * REPRINT ALL * "_M1_" previously printed in "_M2,!,"  between "_M3_" and "_M4 S %B="",%=2 D ^PRCFYN G:%=-1 EXIT^PRCHRPT5 G:%=0 SELLST S:%=1 PRCHALL="Y"
 I PRCHALL="N" W !!,"Do you want to * REPRINT ANY * "_M1_" previously printed in "_M2,!,"  between "_M3_" and "_M4 S %B="",%=2 D ^PRCFYN G:%=-1 EXIT^PRCHRPT5 G:%'=1 DELLST W !!
 W:M5="P3" "P.O.# - Partial #",!
 S PRCHTRX="" F PRCHI5=0:0 S PRCHTRX=$O(^PRC(443.5,PRCHREC,1,"B",PRCHTRX)) Q:PRCHTRX=""  S I=$O(^(PRCHTRX,0)) I I,$D(^PRC(443.5,PRCHREC,1,I,0)) S Y=$P(^(0),U,3),DA=+$P(^(0),U,2) D DD^%DT W !,PRCHTRX,?23,Y D PRT Q:PRCHEX="^"
 G:PRCHEX="^" EXIT^PRCHRPT5
 G DELLST
 ;
PRT S PRCHEX="" I PRCHALL'="Y" W ?45,"Reprint " S %B="",%=2 D ^PRCFYN S:%=-1 PRCHEX="^" Q:%'=1
 S PRCHREPR=1
 D:M1="Requests" P11 D:M5="P3" P14 I M1="Purchase Orders" D:M5="P1" P12 D:M5="P2" P13
 Q
 ;
DELLST W !!,"Do you want to * DELETE THE LIST * of "_M1_" previously printed",!,"in "_M2,!,"  between "_M3_" and "_M4 S %B="",%=2 D ^PRCFYN G:%=0 W G:%'=1 EXIT^PRCHRPT5
 S DIK="^PRC(443.5,",DA=PRCHREC D ^DIK K DIK W !!!,$C(7),"  *** LIST DELETED ***"
 G EXIT^PRCHRPT5
 ;
P11 ; REPRINT REQUESTS (2237'S OR 1138'S) IN FISCAL OR A&MM
 N PPMFLG S PPMFLG=1
 Q:'$D(^PRCS(410,DA,0))  S D0=DA,PRCHQ=$P(^(0),U,4),PRCHQ=$S(PRCHQ=1:"QUE^PRCSP11",1:"QUE^PRCSP12"),PRCHQ("DEST")=$S(PRCHQ="QUE^PRCSP11":"F",1:"S") D ^PRCHQUE
 Q
 ;
P12 ; REPRINT P.O.'S IN FISCAL
 Q:'$D(^PRC(442,DA,0))  S D0=DA,PRCHQ="^PRCHFPNT" S:$D(^PRC(411,PRC("SITE"),2,"AC","F")) PRCHQ("DEST")="F" D ^PRCHQUE K ZTSK
 Q
 ;
P13 ; REPRINT P.O.'S FROM FISCAL TO A&MM AFTER OBLIGATION
 Q:'$D(^PRC(442,DA,0))  S D0=DA,X=$P(^PRC(411,PRC("SITE"),0),U,11),PRCHQ=$S(X=1:"^PRCHPNT",1:"^PRCHFPNT"),PRCHQ("DEST")="S8" D ^PRCHQUE
 Q
 ;
P14 ; REPRINT RECEIVING REPORTS IN FISCAL
 Q:'$D(^PRC(442,DA,0))  S D0=DA,PRCHFPT=$P(PRCHTRX,"-",3),PRCHQ="^PRCHFPNT",PRCHQ("DEST")="R",PRCHQ("DEST2")="FR" D ^PRCHQUE K ZTSK
 Q
 ;
W W !!,"This will not delete any of the "_M1_", it will only delete the",!,"list of those "_M1_" that were previously printed in "_M2_",",!,"between "_M3_" and "_M4_"."
 G DELLST
 ;
ST S PRCF("X")="SP" D ^PRCFSITE
 Q
