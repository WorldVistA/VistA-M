PSOHLSG4 ;BIR/LC-Purge entries from file 52.51 ;03/20/96
 ;;7.0;OUTPATIENT PHARMACY;**26**;DEC 1997
PURGE ;Purge data from the External Interface file
 I $D(ZTQUEUED) G DQ
 S X1=DT,X2=-7 D C^%DTC S Y=X X ^DD("DD") S DIR("B")=Y
 S DIR(0)="D^:"_X_":EX",DIR("A")="Enter cutoff date for purge",DIR("?")="The cutoff date must be at least seven days before today"
 D ^DIR G Q:$D(DIRUT) S PDT=Y_.999999
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Purge entries that were not successfully processed?  ",DIR("?",1)="Enter 'Yes' to purge entries whose status is 'process failed'."
 S DIR("?",2)="If you have reviewed/resolved the cause of the problem of those entries",DIR("?")="with an 'error' status answer 'Yes'.  Otherwise answer 'No'."
 W ! D ^DIR G Q:$D(DIRUT) K DIR S PERR=Y
 S ZTRTN="DQ^PSOHLSG4",ZTSAVE("PERR")="",ZTSAVE("PDT")="",ZTIO="",ZTSAVE("DA1")="",ZTSAVE("DA")=""
 S ZTDESC="Purge External Interface file entries on or before "_$E(PDT,4,5)_"/"_$E(PDT,6,7)_"/"_$E(PDT,2,3) D ^%ZTLOAD
 ;W !!,"Purge queued to run in background." G Q
 G Q
DQ ;Taskman entry point for running purge of External Interface file
 S:'$D(PERR) PERR=0 I '$D(PDT) S X1=DT,X2=-7 D C^%DTC S PDT=X_.999999
 F PDATE=0:0 S PDATE=$O(^PS(52.51,"AC1",PDATE)) Q:'PDATE!(PDATE>PDT)  D
 .F PSOIN=0:0 S PSOIN=$O(^PS(52.51,"AC1",PDATE,PSOIN)) Q:'PSOIN  D
 ..S PSOTR=$P($G(^PS(52.51,PSOIN,0)),"^",10)
 ..I 'PERR,PSOTR=3 Q
 ..I PSOTR=1!(PSOTR=4) Q
 ..S DIK="^PS(52.51,",DA=PSOIN D ^DIK
 I $D(ZTQUEUED) S ZTREQ="@"
Q K %H,DA,DIR,DIRUT,DIK,PDT,PERR,PTR,X,X1,X2,XMDUZ,XMK,XMZ,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,DELCNT
 ;
 Q
