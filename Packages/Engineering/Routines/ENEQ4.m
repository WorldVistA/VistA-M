ENEQ4 ;WIRMFO/SAB-PURGE EQUIPMENT INV FILE ;12/28/07  13:54
 ;;7.0;ENGINEERING;**40,87**;Aug 17, 1993;Build 16
 ;
DEL ;Delete Equipment Record entry
 S ENEDNX=$D(^XUSEC("ENEDNX",DUZ))
 W !!,"This option completely deletes a specific equipment record. If"
 W !,"you would rather move equipment records to an archive media, then"
 W !,"exit this option and use the Engineering Archive Module instead."
DELSEQ ; select equipment record for deletion
 W !
 D GETEQ^ENUTL G:Y'>0 DELX
 S ENDA=+Y
 F ENI=0,1,2,3 S ENY(ENI)=$G(^ENG(6914,ENDA,ENI))
 ;
 ; display equipment data
 W @IOF
 W !,"ENTRY #: ",ENDA
 W !!,?2,"MFGR EQUIP NAME: ",$P(ENY(0),U,2)
 W !,?2,"EQUIP CATEGORY: ",$$GET1^DIQ(6914,ENDA,6)
 W !,?2,"CSN: ",$$GET1^DIQ(6914,ENDA,18)
 S ENX=$$GET1^DIQ(6914,ENDA,"18:2") I ENX]"" W " (",ENX,")"
 W !!,?2,"MANUFACTURER: ",$$GET1^DIQ(6914,ENDA,1)
 W !,?2,"MODEL: ",$P(ENY(1),U,2),?42,"SERIAL #: ",$P(ENY(1),U,3)
 W !!,?2,"CMR: ",$$GET1^DIQ(6914,ENDA,19)
 W ?42,"USE STATUS: ",$$GET1^DIQ(6914,ENDA,20)
 W !,?2,"ACQUISITION DATE: ",$$FMTE^XLFDT($P(ENY(2),U,4))
 W ?34,"LE: ",$P(ENY(2),U,6)
 W ?42,"DISPOSITION DATE: ",$$FMTE^XLFDT($P(ENY(3),U,11)),!
 ;
 ; validate selection
 K ENV
 S ENX=$$CHKFA^ENFAUTL(ENDA)
 I +ENX S ENV(1)="It is currently reported to Fixed Assets in Austin."
 E  I $P(ENX,U,2)]"" S ENV(2)="It was previously reported to Fixed Assets in Austin."
 I $P(ENY(0),U,4)="NX",'ENEDNX S ENV(3)="Security key ENEDNX is required to delete NX equipment."
 I $P(ENY(3),U,1)=1 S ENV(4)="USE STATUS is IN USE."
 I $P(ENY(3),U,11)="" S ENV(5)="DISPOSITION DATE is blank."
 I $D(^ENG(6916.3,"B",ENDA)) S ENV(6)="It is linked to an IT Assignment record."
 I $D(ENV) D  G DELSEQ
 . W $C(7),!,"This equipment entry can not be deleted because:"
 . S ENI=0 F  S ENI=$O(ENV(ENI)) Q:'ENI  W !,?2,ENV(ENI)
 ;
 ; confirm deletion
 S DIR(0)="Y",DIR("A")="Delete this entry"
 D ^DIR K DIR G:$D(DIRUT) DELX I 'Y G DELSEQ
 ;
 ; first close any open work orders
 S ENTXT(1)="Automatically closed when equipment record was deleted."
 S DA=0 F  S DA=$O(^ENG(6920,"G",ENDA,DA)) Q:'DA  I $P($G(^ENG(6920,DA,5)),U,2)="" D
 . D WP^DIE(6920,DA_",",40,"A","ENTXT")
 . S DIE="^ENG(6920,",DR="36///T;32///^S X=""COMPLETED"""
 . D ^DIE
 K DIE,DR,ENTXT
 ; then delete equipment
 S DIK="^ENG(6914,",DA=ENDA D ^DIK K DIK
 W !,"Equipment entry # ",ENDA," was deleted."
 ;
 G DELSEQ
 ;
DELX ; delete equipment record exit
 K DA,DIC,DIE,DIK,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K END,ENDA,ENEDNX,ENI,ENV,ENWO,ENX,ENY
 Q
 ;
 ;ENEQ4
