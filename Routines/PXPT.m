PXPT ;ISL/MKB,DLT,dee - Patient/IHS maintenance routine ;8/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
EN ; entry point
 D LOC,MASTER,QUE
 Q
 ;
LOC ;POPULATE LOCATION FILE
 D BMES^XPDUTL("Populating the LOCATION File #9999999.06 from the Institution File")
 K DD,DO
 S DIC="^AUTTLOC(",DIC(0)=""
 S PXPTINST=0 F  S PXPTINST=$O(^DIC(4,PXPTINST)) Q:'PXPTINST  S (X,DINUM)=PXPTINST D FILE^DICN
 K PXPTINST
 Q
 ;
MASTER ;Populate the PXPT fields $501 & #502 in PCE PARAMETERS file (#815)
 ;
 N PXPTLOC
 D BMES^XPDUTL("Populating the PXPT fields of the PCE PARAMETERS file (#815)")
 S PXPTLOC=+$G(XPDQUES("POS PXPT LOCATION"))
 D:PXPTLOC'>0 GETLOC
 S:PXPTLOC'>0 PXPTLOC=+$$SITE^VASITE
 I '(+$G(^PX(815,1,"PXPT"))) S $P(^PX(815,1,"PXPT"),"^",1)=PXPTLOC
 I $P($G(^PX(815,1,"PXPT")),"^",2)="" S $P(^PX(815,1,"PXPT"),"^",2)="READY TO POPULATE"
 Q
 ;
QUE ; Queue job to populate IHS Patient File #9000001
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 N PXPTLOC,DINUM
 D GETLOC I 'PXPTLOC W $C(7),!!,"Error in setup, run D MASTER^PXPTPOST" Q 
 S PXPTLAST=$P($G(^PX(815,1,"PXPT")),"^",2)
 I PXPTLAST=0 D  Q:'Y  Q:Y["^"
 .W !!,"The population of the Patient/IHS file has previously completed.",!
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to retask the job to populate the Patient/IHS file"
 .D ^DIR
 I PXPTLAST>0 D
 .W !!,"The population of the Patient/IHS file is partially completed."
 .W !,"Populating will start from the patient last populated from the previous"
 .W !,"tasked job."
Q1 W !!,"Populating the Patient/IHS File #9000001 via the following queued job ... "
 W !!,">> I will queue this job; please specify a start time for it."
 S ZTRTN="LOAD^PXXDPT",ZTDESC="Patient File (#9000001) Population",ZTIO=""
 S ZTSAVE("PXPTLOC")=PXPTLOC
 D ^%ZTLOAD
 I '$D(ZTSK) W $C(7),!!,"You MUST schedule this job at this time!",!,"This is a required task.",! G QUE
 W !,"Task #"_ZTSK
 Q
 ;
 ;
GETLOC S PXPTLOC=$P($G(^PX(815,1,"PXPT")),"^",1)
 Q
 ;
