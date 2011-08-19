LRCAPFDS ;DALOI/FHS - EDIT ACTIVATED WKLD CODES BY WKLD LAB SECTION ;5/1/99
 ;;5.2;LAB SERVICE;**105,119,127,163,274,362**;Sep 27, 1994;Build 11
EN ;
 K ^TMP("LRLAM",DUZ_$J),DIR W !
 S DIR("?")="Select any individual WKLD CODE then edit all fields"
 S DIR("A")="Do you want to edit specific WKLD CODES/ALL fields? "
 S DIR(0)="Y",DIR("B")="N" D ^DIR G:$D(DIRUT) END
 I Y=1 D  G END
 . F  W ! K DIC S DIC=64,DIC(0)="AQEZNM" D ^DIC Q:Y<1  D
 . . N DA,DIE,DR
 . . S DA=+Y,DR="[LR WKLD EDIT ALL]",DIE="^LAM(" D ^DIE
 I '$O(^LAM("AC",1,0)) W !?5,"You have no Activated WKLD CODES ",! G END
 W !?5,"This option will allow you to Edit or Print WKLD CODES"
 K DIR,LRSECT S DIR("A")="Do you want to select a specific WKLD CODE LAB SECTION"
 S DIR(0)="Y",DIR("B")="Y" D ^DIR G:$D(DIRUT) END
 I Y K DIC,DIR S DIC=64.21,DIC(0)="AEQZNM" D ^DIC G:Y<1 END S LRSECT=+Y
 K DIR,DIC S DIR(0)="S^E:EDIT;P:PRINT",DIR("A")="Would you like to"
 D ^DIR G END:$D(DIRUT) G:Y="P" PRINT
EDIT ;
 W !,"EDITING",! K DIR
 S DIR(0)="S,O^1:ALL;.02:DESCRIPT;4:BILLABLE PROCEDURE;7:COST;8:PRICE;9:SORTING GROUP;13:WKLD CODE LAB SECTION;14:DSS Feeder;18:CODE;19:SYNONYM;20:SPECIMEN;21:LOCAL ACC AREA;26:ES DISPLAY ORDER"
 S DIR("A")="Select a field you want to edit ",LRDR=""
ASK D ^DIR G:X=U END I Y=1 S LRDR="[LR WKLD EDIT ALL]" D LRSET G ALL
 I Y S LRDR=LRDR_Y_";" S DIR("A")="Select Another Field " G ASK
 I '$L(LRDR) W !?5,"Nothing Selected ",! G END
 S LRDR=$E(LRDR,1,($L(LRDR)-1))
 D LRSET
ALL I '$D(^TMP("LRLAM",DUZ_$J)) W !!,$$CJ^XLFSTR(" Database scan was negative.",80),!,$$CJ^XLFSTR(" No WKLD CODES assigned to WKLD CODE LAB SECTION you selected.",80),$C(7),! G END
 K DIR S DIR(0)="F^1:60",DIR("A")="Start with what WKLD CODE name",DIR("A",2)="Use mixed case Characters e.g Chloride "
 S DIR("A",1)=""
 D ^DIR G:$D(DIRUT) END
 S LRWKLD=X W !,"STARTING LOOP ",!
LOOP ;
 S LRWKLD=$O(^TMP("LRLAM",DUZ_$J,$E(LRWKLD,1,$L(LRWKLD)-1))),LRNN=DUZ_$J
 I LRWKLD="" W !!?5,"Nothing matches your criteria",! G END
 S LRNODE="^TMP(""LRLAM"","_DUZ_$J_","""_LRWKLD_""",0)",LREND=0 W @IOF
 F  S LRNODE=$Q(@LRNODE) Q:$QS(LRNODE,2)'=LRNN!($G(LREND))  S DA=+$QS(LRNODE,4) I DA D
 . D DIQ S:$G(DIRUT) LREND=1 Q:LREND=1  S S=0,DR=LRDR,DIE=64 D ^DIE S:$D(Y)!(X="^") LREND=1
 G END
 Q
PRINT ;
 K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Would you like only CPT linked WKLD CODES" D ^DIR G:$D(DIRUT) END
 S LRCPT=Y
 W !,"PRINT",! K %ZIS S %ZIS="QN" D ^%ZIS G:POP END
 I IO'=IO(0) D  D ^%ZISC G END
 . S:$G(LRSECT) ZTSAVE("LRSECT")="" S ZTRTN="DQ^LRCAPFDS",ZTSAVE("LRCPT")="",ZTIO=ION
 . K ZTSK D ^%ZTLOAD W:$G(ZTSK) !?5,"Report Queued to "_ION I '$G(ZTSK) W !!?10,"**** Report Not Queued ****",!
DQ ;
 S:$D(ZTQUEUED) ZTREQ="@" D LRSET
 I '$D(^TMP("LRLAM",DUZ_$J)) W !!?10," Database scan was negative.",!," No WKLD CODES assigned to WKLD CODE LAB SECTION you selected.",! G END
 S S=5,LRNODE="^TMP(""LRLAM"","_DUZ_$J_",0)",DIC="^LAM(",DR="0:99",LREND=0
 K DIR S LRNN=DUZ_$J D HEAD
 F  S LRNODE=$Q(@LRNODE) Q:$QS(LRNODE,2)'=LRNN!($G(LREND))  S DA=+$QS(LRNODE,4) I DA D
 . D EN^LRDIQ S:$D(DIRUT) LREND=1 S S=S+2 S:$E(IOST,1,2)'="C-" S=0
 Q
END ;
 W ! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 K DA,DIC,DIE,DIR,DR,DTOUT,DUOUT,DIRUT
 K LRDAT,LREND,LRN,LRNN,LRNODE,LRSECT,LRTIT,LRWKLD,S
 K X,Y,LRDR,ZTSK,%ZIS,DIRUT,LRCPT
 Q
HEAD ;
 W !!,$$CJ^XLFSTR("Activated WKLD Codes",IOM),!
 S LRTIT=" WKLD LAB SECTION [ "_$S($D(^LAB(64.21,+$G(LRSECT),0)):$P(^(0),U),1:"** ALL **")_" ]"
 S LRDAT=$$HTE^XLFDT($H),S=6
 W $$CJ^XLFSTR(LRTIT,IOM),!,$$CJ^XLFSTR(LRDAT,IOM),!
 Q
DIQ ;
 Q:'$G(DA)  W ! S DIC="^LAM(",DR=0 D EN^LRDIQ
 Q
LRSET ;
 S LRN=0 F  S LRN=$O(^LAM(LRN)) Q:LRN<1  I $D(^LAM(LRN,0))#2 S LRNODE=^(0) D
 . I $G(LRSECT),$P(LRNODE,U,15)'=LRSECT Q
 . I $G(LRCPT),'$O(^LAM(LRN,4,0)) Q
 . S ^TMP("LRLAM",DUZ_$J,$P(LRNODE,U),LRN)=$P(LRNODE,U,2)
 Q
