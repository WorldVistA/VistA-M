PRCFUOM ;WISC/SJG/PL-850 UNDELIVERED ORDERS RECONCILIATION ; 11/6/97  1510
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BEG ;
 S DIR(0)="Y",DIR("A")="Are you sure that you want to manually run this option"
 S DIR("A",1)=" ",DIR("A",2)="This option generates the 850 Undelivered Orders Reconciliation Report."
 S DIR("A",3)="This report is very resource intensive and should be scheduled to run"
 S DIR("A",4)="in off-hours.",DIR("A",5)=" "
 S DIR("A",6)="This report is restricted to purchase orders from a single station, and"
 S DIR("A",7)="can be limited to a date range.  The default date range is from T-90 days",DIR("A",8)="to T.",DIR("A",9)=" "
 S DIR("T")=120,DIR("B")="NO" D ^DIR K DIR G:'Y!($D(DIRUT)) EXIT
SITE S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT S PRCFSITE=PRC("SITE") W !
DATE K PRCFBEG,PRCFBEGX,PRCFEND,PRCFENDX
 S X="T-90" D ^%DT S PRCFBEG=Y,PRCFBEGZ=Y D DD^%DT S PRCFBEGX=Y
 S X="T" D ^%DT S PRCFEND=Y D DD^%DT S PRCFENDX=Y
 S %DT="AE",%DT("A")="Select BEGINNING DATE: ",%DT("B")=PRCFBEGX D ^%DT K %DT G:Y<1 EXIT
 I Y>PRCFEND W !!,$C(7),"Beginning date can't be greater than Today's date.  Please reenter !",! G DATE
 I Y'=PRCFBEG S PRCFBEG=Y,PRCFBEGZ=Y D DD^%DT S PRCFBEGX=Y
 W ! S %DT="AE",%DT("A")="Select ENDING DATE: ",%DT("B")=PRCFENDX D ^%DT K %DT G:Y<1 EXIT
 I Y<PRCFBEGZ W !!,$C(7),"Ending date can't be less than Beginning date. Please reenter !",! G DATE
 I Y>PRCFEND W !!,$C(7),"Ending date can't be greater than Today's date. Please reenter !",! G DATE
 I Y'=PRCFEND S PRCFEND=Y D DD^%DT S PRCFENDX=Y
RPT D DEV G:POP EXIT I '$D(IO("Q")) D WAIT^DICD
 I $D(IO("Q")) S ZTDTH="",ZTDESC="Running 850 Undelivered Orders Reconciliation Report",ZTRTN="DQ^PRCFUOM",ZTSAVE("PRC*")="" D ^%ZTLOAD,^%ZISC,AGN G EXIT:%'=1 W !! G SITE
 D DQ,^%ZISC,AGN G EXIT:%'=1 W !! G SITE
DQ ;
 S (PRCFAT,PRCFCT,PRCFOT,PRCFCS,PRCFOS,PRCFAS)=0,L=0
 S DIC="^PRC(442,",FLDS="[PRCFUO]",BY="[PRCFUO MAN]" S:$D(ION) IOP=ION
 S FR=",,"_PRCFBEG,TO=",,"_PRCFEND,DIOEND="D B^PRCFUO"
 S PRCFI=";30;31;33;37;38;40;41;45;48;49;",PRCFMOP=";1;8;"
 S DIS(0)="I $D(^PRC(442,D0,0)),$O(^PRC(442,D0,22,0))>0 I $P(^PRC(442,D0,0),U,17)'=$P(^(0),U,16) I +$P(^(0),U,1)=PRCFSITE I $G(^PRC(442,D0,7)),PRCFI'[("";""_$P($G(^PRC(442,D0,7)),""^"",2)_"";"")"
 S DIS(1)="I $D(^PRC(442,D0,0)),$P(^(0),U,2),PRCFMOP[("";""_$P(^(0),U,2)_"";"") D C^PRCFUO I PRCFU>.01"
 S DHD="850 UNDELIVERED ORDERS RECONCILIATION FOR STATION "_PRCFSITE_" FROM "_PRCFBEGX_" TO "_PRCFENDX
 D EN1^DIP,EXIT
 Q
EXIT ;
 KILL %,%DT,%ZIS,BY,DHD,DIC,DIOEND,DIR,DIRUT,DIS,FLDS,FR,L,PRC
 KILL PRCF,PRCFAS,PRCFAT,PRCFBEG,PRCFBEGX,PRCFBEGZ,PRCFCS,PRCFCT,PRCFEND,PRCFENDX
 KILL PRCFI,PRCFMOP,PRCFOS,PRCFOT,PRCFSITE,TO,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 QUIT
DEV W ! K IO("Q") S %ZIS("B")="HOME",%ZIS="QM" D ^%ZIS Q
AGN W !!,"Would you like to run another reconciliation report" S %=2 D YN^DICN G AGN:%=0 Q
