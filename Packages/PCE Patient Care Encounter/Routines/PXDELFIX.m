PXDELFIX ;BAY/RJV-CLEAN ENCOUNTERS POINTING TO VISITS THAT DON'T EXIST PART 2. ;14-JUN-2005 
 ;;1.0;PCE;**153**;14-JUL-2004
 Q
 ;**********************************************************
 ;Two entry points. FIXALL and FIXIND. Called from PXDELENC.
 ;**********************************************************
FIXALL ; Fix all encounters.
 N DA,DIK,PXPAT,PXSDATE,PXENC,PXSEC,PXCOUNT,PXPATNM,Y
 S PXPAT="",PXSDATE="",PXENC=""
 S PXCOUNT=$G(^XTMP("PXDELENC","PXENC","PXCOUNT"))
 I PXCOUNT=0 D  Q
 .W !!,"There are no build entries to correct!"
 .D WAIT^PXDELENC
 I $G(^XTMP("PXDELENC","END BUILD"))="RUNNING" D  Q
 .W !!,"Build is running, please wait until complete!"
 .D WAIT^PXDELENC
 W !!,"There are "_$G(PXCOUNT)_" entries to correct."
 S DIR("A")="Do you wish to continue? "
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR Q:$D(DIRUT)
 Q:Y=0
 K DIR,DA,DIRUT
 F  S PXPAT=$O(^XTMP("PXDELENC","PXENC",PXPAT)) Q:PXPAT=""  D
 .F  S PXSDATE=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE)) Q:PXSDATE=""  D
 ..F  S PXENC=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC)) Q:PXENC=""  D
 ...S PXSEC=$G(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC))
 ...S PXPATNM=$P($G(^DPT(PXPAT,0)),"^",1)
 ...S $P(^DPT(PXPAT,"S",PXSDATE,0),"^",2)="NT"
 ...S $P(^DPT(PXPAT,"S",PXSDATE,0),"^",20)=""
 ...S DIK="^SCE(",DA=PXENC D ^DIK
 ...I $G(PXSEC)'="" S DIK="^SCE(",DA=PXSEC D ^DIK
 ...S PXCOUNT=PXCOUNT-1
 ...K ^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC)
 ...W !!,?3,"Encounter: ",?12,$G(PXENC)_" - "_$G(PXPATNM),?45," Fixed!",!
 ...S DA=PXPAT D FIXIHS
 S ^XTMP("PXDELENC","PXENC","PXCOUNT")=PXCOUNT
 D WAIT^PXDELENC
 Q
FIXIND ; Fix individual encounters.
 N PXPAT,PXSDATE,PXSDTE,PXENC,PXVISIT,PXPRIM,PXEXIST,PXCOUNT,DIC,PXSEC,Y
 I $G(^XTMP("PXDELENC","END BUILD"))="RUNNING" D  Q
 .W !!,"Build is running, please wait until complete!"
 .D WAIT^PXDELENC
 S DIC(0)="AEMQ"
 D ^DPTLK I Y=-1 Q
 Q:$D(DIRUT)
 S PXPAT=$P(Y,"^")
 S PXSDATE=0,PXENC="",PXPRIM="",PXSEC="",PXEXIST=0
 S PXCOUNT=$G(^XTMP("PXDELENC","PXENC","PXCOUNT"))
 W !!,"Processing...."
 D HEADER
DISPLAY ;
 F  S PXSDATE=$O(^SCE("ADFN",PXPAT,PXSDATE)) Q:PXSDATE=""!($D(DIRUT))  D  Q:$D(DIRUT)
 .F  S PXENC=$O(^SCE("ADFN",PXPAT,PXSDATE,PXENC)) Q:PXENC=""!($D(DIRUT))  D
 ..S PXVISIT=$P($G(^SCE(PXENC,0)),"^",5)
 ..S PXPRIM=$P($G(^SCE(PXENC,0)),"^",6)
 ..I $G(PXVISIT)'="" Q
 ..I $G(PXPRIM)'="" Q
 ..I $G(PXVISIT)="",$G(PXPRIM)="",$D(^DPT(PXPAT,"S",PXSDATE,0)) D
 ...S Y=PXSDATE D DD^%DT S PXSDTE=Y,PXEXIST=1
 ...S PXPATNM=$P($G(^DPT(PXPAT,0)),"^",1)
 ...W ?3,PXPAT_" - "_PXPATNM,?35,PXSDTE,?55,PXENC,!
 ...S ^XTMP("PXDELENC","FIXIND",PXPAT,PXSDATE,PXENC)=""
 I $G(PXEXIST)=0 G NONE
 S DIR("A")="This will fix all entries for this Patient. Continue? "
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR
 G:$D(DIRUT) FIXIND
 K DIR,DA,DIRUT
 I Y=0 G FIXIND
FIX ;
 N PXPAT,PXSDTE,PXENC
 S PXPAT="",PXSDTE="",PXENC=""
 F  S PXPAT=$O(^XTMP("PXDELENC","FIXIND",PXPAT)) Q:PXPAT=""  D
 .F  S PXSDTE=$O(^XTMP("PXDELENC","FIXIND",PXPAT,PXSDTE)) Q:PXSDTE=""  D
 ..F  S PXENC=$O(^XTMP("PXDELENC","FIXIND",PXPAT,PXSDTE,PXENC)) Q:PXENC=""  D
 ...S $P(^DPT(PXPAT,"S",PXSDTE,0),"^",20)=""
 ...S $P(^DPT(PXPAT,"S",PXSDTE,0),"^",2)="NT"
 ...I $P($G(^SCE(PXENC+1,0)),"^",6)=PXENC S PXSEC=PXENC+1
 ...S DIK="^SCE(",DA=PXENC D ^DIK
 ...I $G(PXSEC)'="" S DIK="^SCE(",DA=PXSEC D ^DIK
 ...I $D(^XTMP("PXDELENC","PXENC",PXPAT,PXSDTE,PXENC)) S PXCOUNT=PXCOUNT-1
 ...K ^XTMP("PXDELENC","PXENC",PXPAT,PXSDTE,PXENC)
 ...K ^XTMP("PXDELENC","FIXIND",PXPAT,PXSDTE,PXENC)
 ...W !!,?3,"Encounter: ",?12,$G(PXENC)_" - "_$G(PXPATNM),?45," Fixed!",!
 ...S DA=PXPAT D FIXIHS
 S ^XTMP("PXDELENC","PXENC","PXCOUNT")=PXCOUNT
 Q:$D(DIRUT)
 I PXEXIST=1 D
 .W !!,"No more missing visits to correct for this patient!"
 .D WAIT^PXDELENC
NONE ;
 I PXEXIST=0 D
 .W !!,"No missing visits found for this patient!"
 .D WAIT^PXDELENC
 K ^XTMP("PXDELENC","FIXIND")
 G FIXIND
 Q
HEADER ;
 W !,?3,"Patient IEN - Name",?35,"Appt Date",?55,"Encounter"
 W !,?3,"==================",?35,"=========",?55,"=========",!
 Q
FIXIHS ; Will fix the IHS Patient (9000001) file entries. 
 N PX
 S U="^"
 D CHECK^PXXDPT Q:'$T
 S PX=$P($G(^DPT(DA,0)),U,9)
 D SETSSN^PXXDPT
 K DR,DIE,DA,PXDA
 Q
 ;
