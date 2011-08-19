ORVOM11 ; slc/dcm - Creats RTN ending in ONIT1 ;1/22/91  15:53
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S %Y="^UTILITY(U,$J,D,Y,",E=0
 S X="" F D=0:0 S X=$O(^UTILITY(U,$J,X)) Q:X=""  S %X="^UTILITY(U,$J,"_""""_X_"""," D %XY^ORVOM1
 K ^UTILITY(U,$J) D FILE^ORVOM3:DL K ^UTILITY($J)
 G ^ORVOM2 ;cu
VER ;
 N DH
 W !!?5,"Now you must enter the information that goes on the second line",!?5,"of the ONIT routines.",!
 G:DPK<1 V2
 S DIE=9.4,DA=Q,DR=22,DR(2,9.49)=1 D ^DIE I $D(Y) S (DUOUT,DIRUT)=1 Q
 G V2:'$D(D1) S X=^DIC(9.4,DPK,22,D1,0),DPK(1)=$P(X,U,1),DILN2=" ;;"_DPK(1)_";"_$P(^DIC(9.4,DPK,0),U,1)_";;",Y=$P(X,U,2) D DD^%DT S DILN2=DILN2_Y
 W !! Q
V2 K DIR S DIR(0)="F^4:30",DIR("A")="Package Name",DIR("?")="^D PNM^DIFROMH1" D ^DIR Q:$D(DIRUT)  S DILN2=Y
 K DIR S DIR(0)="F^1:9^K:'(X?1.3N.1""."".2N.1A.2N) X",DIR("A")="Version",DIR("?")="^D VER^DIFROMH1" D ^DIR Q:$D(DIRUT)  S DPK(1)=Y,DILN2=" ;;"_Y_";"_DILN2_";;"
 K DIR S DIR(0)="D^::EX",DIR("A")="Date Distributed",DIR("?")="^D VDT^DIFROMH1" D ^DIR Q:$D(DIRUT)  D DD^%DT S DILN2=DILN2_Y
 W !! Q
