PRCFPR2 ;WISC/LDB-Purge stacked document listing ;7/13/93  3:10 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PURGE ;Allow deletion from file 421.8 by date
 ;
 N DIR,DIC,DIE,DIK,X,Y
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 I '$D(^PRC(421.8,"AD")) W !,"THERE ARE NO PRINTED RECORDS TO PURGE" Q
 S DIR(0)="YO",DIR("B")="NO",DIR("A")="Purge all PRINTED documents from the listing" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT S ALL=Y G:Y DEL
 S DIR("A")="Begin with which date",DIR("?",1)="Time is optional.",DIR("?")=" Enter the date to start range-",DIR("B")=$$DATE($O(^PRC(421.8,"AD",0)))
 S DIR(0)="DO^"_$O(^PRC(421.8,"AD",0))_":"_(DT+.9999)_":EXT" D ^DIR S:'Y DATE1=$O(^PRC(421.8,"AD",0)) G:$D(DTOUT)!$D(DUOUT) EXIT
 S:Y DATE1=Y
 W ! K DIR S DIR("A")="End with which date",DIR("?",1)="Time is optional.",DIR("?")=" Enter the date that will end the range-"
 D NOW^%DTC S %=$E(%,1,12) S DIR(0)="DO^"_DATE1_":"_(DT+.9999)_":EXT",DIR("B")=$$DATE(%) D ^DIR G:$D(DIRUT) EXIT S DATE2=Y,Y=0
 I 'ALL,'DATE1 W !!,"NO RECORDS WERE DELETED" G EXIT
DEL S DAT=$S('ALL:(DATE1-.0001),1:0),DATE2=$S(ALL:9999999.99,'ALL&$P(DATE2,"."):DATE2,'ALL&'$P(DATE2,"."):DATE2_".9999",1:9999999.99)
 F  S DAT=$O(^PRC(421.8,"AD",DAT)) Q:'DAT!(DAT>(DATE2))  D
 .S DA=0 F  S DA=$O(^PRC(421.8,"AD",DAT,DA)) Q:'DA  I $P($G(^PRC(421.8,DA,0)),"^",8)=PRC("SITE") S DIK="^PRC(421.8," D ^DIK
 D EXIT Q
 ;
 ;
DATE(Y) D DD^%DT S DATE=Y
 Q DATE
 ;
EXIT K %,ALL,D,DA,DAT,DATE,DATE1,DATE2,DAYS,DIK,DIR,DIRUT,DTOUT,DUOUT,FTYPE,SITE,X1,X2 Q
 ;
 ;
 ;
QD ;Called from option PRCFA STACK DOCUMENTS PURGE (queued as background job)
 ;DAYS to retain is set in file 411 for PRINTER USE STACK DOCUMENTS
 ;DEFAULT DAYS IS 7
 D DT^DICRW
 S SITE=0 F  S SITE=$O(^PRC(411,SITE)) Q:'SITE  D
 .S PRTDA=0 F  S PRTDA=$O(^PRC(411,SITE,2,PRTDA)) Q:'PRTDA  I $P($G(^(PRTDA,0)),"^")?1"F".E D
 ..S FTYPE=$P(^PRC(411,SITE,2,PRTDA,0),"^") Q:"FR"'[FTYPE  S FTYPE=$S(FTYPE="FR":2,FTYPE="F":"13",1:""),DAYS=$P(^PRC(411,SITE,2,PRTDA,0),"^",4) D
 ...S X2=$S('DAYS:-7,1:-DAYS),X1=DT D C^%DTC S DATE2=(X-1)+.9999
 ...S DAT=0 F  S DAT=$O(^PRC(421.8,"AD",DAT)) Q:'DAT!(DAT>DATE2)  D
 ....S DA=0 F  S DA=$O(^PRC(421.8,"AD",DAT,DA)) Q:'DA  I FTYPE[(+$P($G(^PRC(421.8,DA,0)),"^",2)),$P($G(^(0)),"^",8)=SITE D PRG
 Q
PRG S DIK="^PRC(421.8," D ^DIK Q
