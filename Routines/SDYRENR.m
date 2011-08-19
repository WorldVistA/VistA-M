SDYRENR ;ALB/ABR - PATIENT FILE ENROLL CLINIC CLEANUP ; SEP 28 1995
 ;;5.3;Scheduling;**32**;Aug 13, 1993
EN ;
 N ZTDESC,ZTRTN,ZTIO,ZTQUEUED,ZTSK,I,X
 W !!,"<<CLEAN-UP OF INCOMPLETE ENROLLMENT CLINICS IN PATIENT FILE>>",!
 I '$G(DUZ)!'$D(DTIME)!'$D(U) W !!,*7,">> USER NOT DEFINED.  CANNOT CONTINUE" Q
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
QUE S ZTRTN="CLN^SDYRENR",ZTDESC="PATIENT FILE ENROLLMENT CLINIC CLEAN-UP",ZTIO=""
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):">>>Task "_ZTSK_" has been queued.",1:">>>    UNABLE TO QUEUE THIS JOB.")
 Q
CLN ;entry point from Queue
 N SDI,SDJ,SDK,SDSTART
 S SDI=0,SDK=0,SDSTART=$$HTE^XLFDT($H)
 F  S SDI=$O(^DPT(SDI)) Q:'SDI  D
 .S SDJ=0
 .F  S SDJ=$O(^DPT(SDI,"DE",SDJ)),SDK=SDK+1 Q:'SDJ  D  W:'(SDK#500)&'$D(ZTQUEUED) "."
 ..Q:$P($G(^DPT(SDI,"DE",SDJ,0)),U,2)]""  I '$O(^(1,0)) D DELETE
 I '$D(ZTQUEUED) W ">> DONE!",!
 D TEMPLATE
 D MAIL
 Q
 ;
DELETE ; delete incomplete enrollment clinic
 N DA,DIE,DR
 S DIE="^DPT("_SDI_",""DE"",",DA(1)=SDI,DA=SDJ,DR=".01///@"
 D ^DIE
 Q
MAIL ;
 N SDTEXT,DIFROM
 S SDTEXT(1)="The Patient file Enrollment Clinic clean-up began on "_SDSTART
 S SDTEXT(2)="and ran to completion on "_$$HTE^XLFDT($H)_"."
 S SDTEXT(3)=" ",SDTEXT(4)="** Please delete the SDYR* routines at this time. **"
 S XMSUB="Patient File Enrollment Clinic Clean-up Complete",XMTEXT="SDTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 Q
TEXT ;display text
 ;;This routine will loop through the PATIENT file, checking to see that 
 ;;Enrollment Clinics are properly set up.
 ;;  
 ;;Any active clinics missing dates will be deleted.
 ;; 
 ;;This will also delete the unused sort template SD-AMB-PROC-LIST.
 ;;
 ;;THIS CLEAN-UP WILL TAKE SOME TIME AND MUST BE QUEUED!!
 ;;
 ;;QUIT
 Q
TEMPLATE ; clean-up of unused template
 N DIC,DIK,DA,X,Y
 S (DIC,DIK)="^DIBT(",DIC(0)="X",X="SD-AMB-PROC-LIST"
 D ^DIC
 I Y>0 S DA=+Y D ^DIK
 Q
