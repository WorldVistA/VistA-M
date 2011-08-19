PSJ0091 ;BIR/LDT-Check for Frequency ;19 DEC 02 / 12:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**91**;16 DEC 97
 ;
 ; Reference to ^XPD is supported by DBIA# 2197.
 ; Reference to ^XLFDT is supported by DBIA# 10103.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
ENNV ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJ0091",ZTDESC="Inpatient Orders Frequency Cleanup (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The cleanup of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN ; Check of existing Pharmacy orders.
 N PSJBEG,PSJPDFN,PSJORD,PSJLORD,CREAT,EXPR,CCNT,ND0,ND2,PSJSTART,PSJSTOP,PSJPRIO,PSJFREQ,NDPT2,PSJSCH
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0),OCNT=0,PSJLORD=0,CCNT=0
 K ^XTMP("PSJ","FREQ")
 N XPDIEN58 S XPDIEN58=$O(^XPD(9.7,"B","PSJ*5.0*58",""))
 S PSJBEG=$S($G(XPDIEN58):$P($G(^XPD(9.7,XPDIEN58,0)),"^",3),1:0)
 F  S PSJBEG=$O(^PS(55,"AUD",PSJBEG)) Q:PSJBEG=""  S PSJPDFN=0 F  S PSJPDFN=$O(^PS(55,"AUD",PSJBEG,PSJPDFN)) Q:'PSJPDFN  D
 . S PSJORD=0 F  S PSJORD=$O(^PS(55,"AUD",PSJBEG,PSJPDFN,PSJORD)) Q:'PSJORD  D
 .. S ND0=$G(^PS(55,PSJPDFN,5,PSJORD,0)),NDPT2=$G(^(.2)),ND2=$G(^(2))
 .. S PSJFREQ=$P(ND2,U,6) Q:PSJFREQ'=0
 .. S PSJSTART=$P(ND2,U,2),PSJSTOP=$P(ND2,U,4) Q:'PSJSTART!(PSJSTART'=PSJSTOP)
 .. S PSJPRIO=$P(NDPT2,U,4) Q:(PSJPRIO'="D")
 .. S PSJSCH=$P(ND2,U) Q:",STAT,NOW,"'[(","_PSJSCH_",")
 .. S CCNT=$G(CCNT)+1
 .. S ^XTMP("PSJ","FREQ",PSJPDFN,PSJORD)=ND2
 S:$D(^XTMP("PSJ","FREQ")) ^XTMP("PSJ","FREQ",0)=EXPR_"^"_CREAT
 D CLEAN
DONE ;
 K DAYS,MINS,HOURS,PSG,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="PSJ*5*91 INPATIENT MEDS FREQUENCY ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(3,0)=" ",PSG(4,0)="This process checked orders for patients in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1),PSG(5,0)="and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S PSG(6,0)=CCNT_" pharmacy orders were found with a frequency of zero"
 D ^XMD
 Q
 ;
CLEAN ;
 N PSJPDFN,PSJORD,PSJDRG,PSJOI,DRG,PSSTART,PSSTOP,PSSTATUS,ORSTART,ORSTOP,ORSTATUS,CHK,CHK3
 S PSJPDFN=0 F  S PSJPDFN=$O(^XTMP("PSJ","FREQ",PSJPDFN)) Q:'PSJPDFN  D
 . S PSJORD=0 F  S PSJORD=$O(^XTMP("PSJ","FREQ",PSJPDFN,PSJORD)) Q:'PSJORD  D
 .. I '$D(^PS(55,PSJPDFN,5,PSJORD)) Q
 .. S $P(^PS(55,PSJPDFN,5,PSJORD,2),"^",6)="O"
 .. ;S DIE="^PS(55,"_PSJPDFN_",5,"
 .. ;S DA(1)=PSJPDFN,DA=PSJORD,DR="42////O"
 .. ;D ^DIE
 I 'CCNT K ^XTMP("PSJ","FREQ")
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="PSJ*5*91 INPATIENT MEDS FREQUENCY ORDER CLEANUP COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The cleanup of Inpatient Medication orders with a frequency of zero ",PSG(2,0)="completed as of "_Y_"."
 S PSG(3,0)=""
 S PSG(4,0)=CCNT_" pharmacy orders with a frequency of zero were corrected."
 D ^XMD
