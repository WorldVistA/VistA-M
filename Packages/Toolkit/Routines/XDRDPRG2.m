XDRDPRG2 ;SF-IRMFO/REM - PURGE MERGE PROCESS FILE; 9/26/96
 ;;7.3;TOOLKIT;**23**;Apr 25, 1995
 ;;
 ;;
EN ;
 N Y
 Q:$$CHK(15.2)
 ;W ! K DIR S DIR(0)="Y",DIR("A")="Do you wish to Queue this purging (Y/N)"
 ;D ^DIR K DIR I $D(DIRUT) Q
 ;I Y D QUEUE Q
 D ASK
 Q
 ;
QUEUE ;Queues the process.
 S ZTRTN="START^XDRDPRG2",ZTIO="",ZTDESC="Merge Process File Purge"
 D ^%ZTLOAD
QUEUEX Q
 ;
CHK(XDRFL) ;Checks if data in file.
 N XDRGL
 S XDRGL=^DIC(XDRFL,0,"GL")
 I $D(@(XDRGL_"""B"""_")")) Q 0
 W *7,!!,"THERE IS NO DATA IN FILE!",!!
 Q 1
 ;
ASK ;Ask user for entries to purge then purge.
 N Y,DA,DIC,DIR,DIK,NAME
 F  D  Q:Y<0
 .W ! S DIC=15.2,DIC(0)="AEMZ",DIC("A")="Select Merge Process to Purge: "
 .S DIC("S")="I $P(^(0),U,4)=""C""" ;Scrn for only Completed ones.
 .D ^DIC Q:+Y<0  S NAME=Y(0,0),DA=+Y
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to delete """_NAME_""""
 .D ^DIR Q:$D(DIRUT)!('Y)
 .S DIK="^VA(15.2," D ^DIK
 .W !!,*7,?3,""""_NAME_"""","  DELETED!",!
 Q
