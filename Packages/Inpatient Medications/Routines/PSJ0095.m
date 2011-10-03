PSJ0095 ;BIR/JCH-Populate Pre-Exchange Report Device in Ward Parameteres ;22 JAN 03 / 4:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**95**;16 DEC 97
 ;
ENNV ;
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="EN^PSJ0095",ZTDESC="Inpatient Ward Parameter Pre-Exchange Report Device (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The population of Inpatient Ward Parameter PRE-EXCHANGE REPORT DEVICE is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
EN ;
 N WARD,PXDEV,CC S (WARD,CC)=0
 F  S WARD=$O(^PS(59.6,WARD)) Q:'WARD  S PXDEV=$P($G(^(WARD,0)),"^",29) D
 . I PXDEV Q:$D(^%ZIS(1,PXDEV))
 . S DA=WARD,DIE="^PS(59.6,",DR="4////HOME" D ^DIE S CC=CC+1
 D SENDMSG
 Q
 ;
DONE ;
 K ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
SENDMSG ;Send mail message when auto-population is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="PSJ*5*95 POPULATION OF INPATIENT WARD PARAMETER PRE-EXCHANGE REPORT DEVICE "
 S XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The population of the Inpatient Ward parameter 'PRE-EXCHANGE REPORT DEVICE'",PSG(2,0)="completed as of "_Y_"."
 S PSG(3,0)="",PSG(4,0)=CC_" Inpatient Wards were updated with this parameter defaulted to 'HOME'."
 S PSG(5,0)="This will continue to print the report to the user's screen until it is changed"
 S PSG(6,0)="to another device, or deleted to disable the report for that ward."
 D ^XMD
 Q
