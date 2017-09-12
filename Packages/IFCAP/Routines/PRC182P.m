PRC182P ;FW/RB-PRE INSTALL PRC*182 TO BACKUP FILE ^PRC(441.2) ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**182**;Oct 20, 2000;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
START ;PRC*5.1*182 Copy file ^PRC(441.2) to temporary work file
 ;            ^XTMP("PRC182P") to be kept for 180 days.
 ;            Preparation for kill of current file ^PRC(441.2)
 ;            and new file 441.2 loaded with new file data.
 ;            Also, save file 441.3 as the group titles have
 ;            been updated for lower case descriptions.
 ;
 K ^XTMP("PRC182P")
 D NOW^%DTC S PRCSTART=%
 S ^XTMP("PRC182P","START BACKUP")=PRCSTART
 S ^XTMP("PRC182P","END SAVE BACKUP")="RUNNING"
 S ^XTMP("PRC182P",0)=$$FMADD^XLFDT(PRCSTART,180)_"^"_PRCSTART
 M ^XTMP("PRC182P",1,441.2)=^PRC(441.2)
 M ^XTMP("PRC182P",2,441.3)=^PRC(441.3)
 S PRCH4412(0)=^PRC(441.2,0),PRCH4413(0)=^PRC(441.3,0)
 S PRCIEN=0,DIK="^PRC(441.2," F  S PRCIEN=$O(^PRC(441.2,PRCIEN)) Q:'PRCIEN  S DA=PRCIEN D ^DIK
 S PRCIEN=0,DIK="^PRC(441.3," F  S PRCIEN=$O(^PRC(441.3,PRCIEN)) Q:'PRCIEN  S DA=PRCIEN D ^DIK
 S ^PRC(441.2,0)=PRCH4412(0),^PRC(441.3,0)=PRCH4413(0)
 F PRCFILE=441.2,441.3 S $P(^PRC(PRCFILE,0),U,3,4)="10000^0"
 D NOW^%DTC S PRCEND=%
 S ^XTMP("PRC182P","END SAVE BACKUP")=PRCEND
 K %,PRCSTART,PRCEND,PRCH4412,PRCH4413,PRCFILE,PRCIEN,DA,DIK
 Q
