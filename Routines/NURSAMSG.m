NURSAMSG ;HIRMFO/RM,FPT-QUEUED MESSAGES TO THE CENT. NURS. OFFICE ;6/18/96  16:27
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; CALLED BY THE NURSAWCK AND NURSCPL ROUTINES IF A PATIENT IS NOT 
 ; ADMITTED INTO THE NURSING SERVICE, BUT IS ADMITTED IN MAS
 G BADPARAM:'$D(^DIC(213.9,1,0)),BADPARAM:$P(^DIC(213.9,1,0),"^",2)=""
 S NURSX=X,IOP=$P(^DIC(213.9,1,0),"^",2)
 S %ZIS="NQ" D ^%ZIS K IOP S ZTRTN="NOADM^NURSAMSG",ZTIO=ION,ZTDTH=$H,ZTNOP=1,ZTDESC="Patient not entered into Nursing database" F G="DA","IOF","NURSX" S ZTSAVE(G)=""
 D ^%ZTLOAD,CLOSE^NURSUT1 ;,^NURSKILL
 K %ZIS,NUROUT,POP,ZTDTH,ZTIO,ZTNOP,ZTRTN,ZTSK
 Q
NOADM ; THIS MESSAGE SENT TO CNO IF PATIENT NOT ADMITTED AND VALID 
 ; SITE PARAMETERS EXIST
 S DFN=DA D DEM^VADPT W @IOF,!!,VADM(1)," has not been admitted into the NURSING SYSTEM by MAS, because ",!,NURSX," (MAS ward) does not have a corresponding NURSING",!,"Unit."
 W !!,"To admit the patient: ",!,"     1.  Validate ",NURSX," the MAS Ward by giving it a",!,"         NURSING Unit by running option Nursing Location File, Edit",!,"         (NURSFL-LOC), by choosing the appropriate NURSING Unit,"
 W !,"         and adding the appropriate MAS Location.",!!,"     2.  Then run the option NURS PATIENT File Update (Admit patient)",!,"         (NURSPT-ACT) to admit the patient into the NURSING SERVICE.",@IOF
 Q
BADPARAM ; ERROR IF NURSING SITE PARAMETERS HAVE NOT BEEN ADDED
 W !!,*7,*7,"Notify NURSING ADP Coordinator and Site Manager that this patient was not",!,"admitted into the NURSING Service because NURSING Site parameters were not",!,"updated."
 Q
