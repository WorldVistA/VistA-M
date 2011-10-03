IVMUTQ ;ALB/ESD - Device Handling and Queueing Utility ; 03-FEB-93
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is a generic interface to the device handler (^%ZIS)
 ; and task manager (^%ZTLOAD).  It will handle device opening and
 ; closing and variable clean-up.
 ;
 ;  Input (to be defined by the caller of the routine):
 ;
 ;       IVMRTN - application routine entry point for output (required).
 ;       %ZIS   - device call variable (set to "QMP" if not defined).
 ;       ZTDESC - description of task (set if not defined).
 ;       ZTSAVE - input parameters to be saved (set to IVMRTN).
 ;
 ; NOTE: Other optional input variables for %ZIS and %ZTLOAD calls
 ;       may be defined as described in KERNEL documentation.
 ;
 ;
EN I $G(IVMRTN)="" W !!,"Routine aborted...entry point not defined." G ENQ
 I $D(%ZIS)#2=0 S %ZIS="QMP"
 D ^%ZIS K %ZIS G:POP ENQ
 I '$D(IO("Q")) U IO D @IVMRTN,^%ZISC,ENQ Q
 ;
 ; task job
 S ZTRTN=@"IVMRTN",ZTSAVE("IVMRTN")=""
 I '$D(ZTDESC) S ZTDESC="IVM UNKNOWN OPTION"
 D ^%ZTLOAD
 W !,$S($D(ZTSK):"Job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 D HOME^%ZIS
 ;
ENQ ; clean-up
 K IO("Q"),IVMRTN,POP,ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTUCI,ZTSK
 Q
