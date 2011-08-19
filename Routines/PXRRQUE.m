PXRRQUE ;ISL/PKR - PCE reports general queing routine. ;10/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**10,72,155**;Aug 12, 1996
 ;
QUE(DESC,IODEV,ROUTINE,SAVE) ;Queue a task.
 ;
 D @SAVE
 S ZTDESC=DESC
 S ZTIO=IODEV
 S ZTRTN=ROUTINE
 D ^%ZTLOAD
 I $D(ZTSK)=0 W !!,DESC," cancelled"
 E  W !!,DESC," has been queued, task number ",ZTSK
 I $G(IODEV)'="" D HOME^%ZIS
 Q $G(ZTSK)
 ;
 ;=======================================================================
REQUE(DESC,ROUTINE,TASK) ;Reque a task.
 S ZTDESC=DESC
 S ZTRTN=ROUTINE
 S ZTSK=TASK
 D REQ^%ZTLOAD
 Q
