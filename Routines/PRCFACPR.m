PRCFACPR ;WISC@ALTOONA/CTB-PURGE CODE SHEETS SYSTEM ;11-27-92/08:17
V ;;5.1;IFCAP;**116**;Oct 20, 2000;Build 8
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCFASYS="FEE^FEN^RR^IRS^CLI^ISM^PRC"
EN I $D(ZTQUEUED) G SCHEDULE
A S U="^" F I=1:1 Q:$P($T(A+I),";",3)=""  W !,$P($T(A+I),";",3,99)
 ;;This routine will delete LOG Code Sheets from the Code Sheet file
 ;;and Batch and Transmission records from the LOG Transmission Record File.
 ;;It will delete all reference to these code sheets, batches and transmission
 ;;records, except references maintained in the Code Sheet History section of
 ;;the Purchase Order file.  Deletion is base on the transmission date of
 ;;the code sheet and date created for batch and transmission records.
 ;;
 S PRCF("X")="AS" D ^PRCFSITE G:'% OUT G B
A1 ;
B S %DT("A")="Enter the date from which you wish to retain LOG Code Sheets: ",%DT="AEPX" D ^%DT G:Y<0 OUT
 S X1=Y,PRCFA("KDATE")=Y
 D NOW^PRCFQ S X2=X S Y=X D D^PRCFQ S Y1=Y S Y=X1,X=X1 D D^PRCFQ S PRCFA("DATE")=Y
 S X3=$E(X2,1,3)-$E(X1,1,3) I X3<9 W !!,?9,"*** WARNING:PURGE DATE ENTERED IS ONLY "_X3_" YEARS AGO ***"
 W ! S %A="I will now delete all LOG code sheets and associated records which were"
 S %A(1)="transmitted before "_Y_" for station "_PRC("SITE")_".",%A(2)="OK to continue",%B="" S %=1 D ^PRCFYN G:%'=1 OUT
 W $C(7) S %A="ARE YOU SURE",%B="With a response of 'YES', I will begin deleting the code sheets and transmission records NOW." S %=2 D ^PRCFYN G:%'=1 OUT
 D NOW^PRCFQ S PRCFA("QTIME")=%X
 S PRCFQ("FORCEQ")="",PRCFA("QION")=ION,ZTSAVE("PRCFASYS")="",ZTDESC="PURGE CODE SHEET AND TRANSMISSION RECORDS",ZTRTN="DQ^PRCFACPS",ZTSAVE("PRCFA*")="",ZTSAVE("PRC*")="" D ^PRCFQ
OUT K %,%DT,%H,%I,D,DA,DIC,DIK,I,J,JX,K,PRCFA,TRANS,X,X1,X2,X3,Y,Y1,Z,ZERO Q
SCHEDULE ;ENTRY POINT AS SCHEDULED OPTION
 S PRCFA("QTIME")="Recurring",PRCFA("QION")="N/A"
 S PRC("SITE")=0 F I=1:1 S PRC("SITE")=$O(^PRC(411,PRC("SITE"))) Q:'PRC("SITE")  I $D(^(PRC("SITE"),0)) S X=$P(^(0),"^",14) I X D C,DQ^PRCFACPS
 Q
C S X2=-(X) D NOW^PRCFQ S X1=X D C^%DTC S Y1=Y,(Y,PRCFA("KDATE"))=X D D^PRCFQ S PRCFA("DATE")=Y Q
