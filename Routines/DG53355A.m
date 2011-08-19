DG53355A ;ALB/TM - NON TREATING PREFERRED FACILITY CLEAN UP ; 1/29/01 2:55pm
 ;;5.3;REGISTRATION;**355**;01/19/01
 ;
 ; This process will find all entries in the PATIENT file (#2) that
 ; have a PREFERRED FACILITY (#27.02) on file that is NOT a valid
 ; treating facility. The $$TF^XUAF4(IEN) API will be used to
 ; determine if a PREFERRED FACILITY is a treating facility.
 ;
 ; The process reads through all entries in the PATIENT file and
 ; excludes any entries that have no PREFERRED FACILITY on file.
 ; Only patient's with a non treating PREFERRED FACILITY will be
 ; included.
 ;
 ; This clean up process will be completed in the steps listed below.
 ;    1) Compiling the report
 ;    2) Printing the results
 ;
 ; A MailMan message will be sent to the user after the job completes.
 ; The purge date for the ^XTMP global is set for 30 days after the
 ; report is processed.
 ;
GBLDOC ;-----------------------------------------------------------------
 ; The report uses the ^XTMP("DG53355A") global to store the results.
 ; The format of the ^XTMP global is described below.
 ;
 ;    XPFAC = IEN from the INSTITUTION file (#4)
 ;    XIEN  = IEN from the PATIENT file (#2)
 ;
 ;    ^XTMP("DG53355A",0)=P1^P2^...
 ;        P1  = Purge Date
 ;        P2  = Date Processed
 ;        P3  = Description
 ;
 ;    ^XTMP("DG53355A",0,0)=P1^P2^...
 ;        P1  = Status (0=Uncompiled,1=Compiling,2=Compile Complete)
 ;        P2  = TaskMan Task #
 ;        P3  = Compile Start Date/Time (FM format)
 ;        P4  = Compile Finish Date/Time (FM format)
 ;        P5  = Last IEN viewed from PATIENT file (#2)
 ;        P6  = Last IEN filed in ^XTMP from PATIENT file (#2)
 ;
 ;    ^XTMP("DG53355A",XPFAC,0)=P1^P2^...
 ;        P1  = Total PATIENT file (#2) records for this NON treating
 ;              Preferred Facility.
 ;
 ;    ^XTMP("DG53355A",XPFAC,XIEN)=""
 ;-----------------------------------------------------------------
EP N DIFROM,XSTAT,XNODE,XDESC
 ;
 S XDESC="NON TREATING PREFERRED FACILITY CLEAN UP REPORT"
 S XNODE=$G(^XTMP("DG53355A",0,0))
 S XSTAT=+$P(XNODE,U)
 ;
 W @IOF ; clearn the screen
 W !!,"         ",XDESC
 W !,$$REPEAT^XLFSTR("*",65)
 ;
 I 'XSTAT D  Q                          ;Not compiled
 . S X="ERROR^DG53355A"                 ;Error Trap
 . Q:'$$USERDESC                        ;Display User Description
 . D TASK Q:'$G(ZTSK)                   ;Task job
 ;
 I XSTAT D ASKPRINT Q                 ;Compiled
 Q
 ;
COMPILE ; Look at all entries in the PATIENT file (#2).
 N XCTR,XIEN,XPFAC
 ;
 K ^XTMP("DG53355A")                  ;Clean up old compile
 S $P(XNODE,U)=1                      ;Status=compiling
 S $P(XNODE,U,2)=$G(ZTSK)             ;TaskMan Task #
 S $P(XNODE,U,3)=$$NOWDTTM()          ;Compile Start Date/Time
 S ^XTMP("DG53355A",0,0)=XNODE
 ;
 ; set up 0 node of ^XTMP to allow the system to purge after 30 days
 S ^XTMP("DG53355A",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_ZTDESC
 ;
 S (XIEN,XCTR,ZTSTOP)=0
 F  S XIEN=$O(^DPT(XIEN)) Q:XIEN<1  D  Q:ZTSTOP
 . S $P(^XTMP("DG53355A",0,0),U,5)=XIEN  ;last XIEN viewed
 . S XCTR=XCTR+1 S:XCTR#1000=0 ZTSTOP=$$S^ZTLOAD("") ;Stop Request
 . S XPFAC=$P($G(^DPT(XIEN,"ENR")),U,2) Q:XPFAC=""
 . Q:$$TF^XUAF4(XPFAC)    ;Quit if valid 'treating' Preferred Facility
 . S ^XTMP("DG53355A",XPFAC,0)=$G(^XTMP("DG53355A",XPFAC,0))+1
 . S ^XTMP("DG53355A",XPFAC,XIEN)=""
 . S $P(^XTMP("DG53355A",0,0),U,6)=XIEN      ;last XIEN filed in ^XTMP
 ;
 S $P(^XTMP("DG53355A",0,0),U,4)=$$NOWDTTM() ;Compile Stop Date/Time
 S:'ZTSTOP $P(^XTMP("DG53355A",0,0),U)=2     ;Set status = compiled
 ;
 D SNDMSG(ZTSTOP)
 S ZTREQ="@"     ; remove job from TaskMan task log
 ;
 ; return to default error trap
 S X="" S:$G(ZTSK)'="" X=^%ZOSF("ERRTN")
 S @^%ZOSF("TRAP")
 Q
 ;
ASKPRINT ; Prompt user to print detail report.
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 W !!,"Compile Start Date/Time: ",$$FMTE^XLFDT($P(XNODE,U,3))
 I XSTAT=1 D  Q
 . W !!,"Report is currently compiling!"
 . W !,"A MailMan message will be sent when the compile is complete."
 . W !
 W !," Compile Stop Date/Time: ",$$FMTE^XLFDT($P(XNODE,U,4))
 W !
 ;
 S DIR(0)="Y",DIR("A")="Print Detail Report",DIR("B")="YES"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!'Y Q
 ;
 ; Prompt user for device and to task job to TaskMan.
 W ! D EN^XUTMDEVQ("PRINT^DG53355A(ZTDESC)",XDESC)
 I $G(ZTQUEUED) W !!,"TaskMan Task: ",$G(ZTSK)
 Q
 ;
PRINT(XDESC) ; Print detail report.
 N XPFAC,XIEN,XNODE,XLNCNT,XPGNUM
 S XPGNUM=0
 D PRNHEAD
 ;
 I $D(^XTMP("DG53355A")) D
 . S XPFAC=0 F  S XPFAC=$O(^XTMP("DG53355A",XPFAC)) Q:XPFAC=""  D
 . . S XIEN=0 F  S XIEN=$O(^XTMP("DG53355A",XPFAC,XIEN)) Q:XIEN=""  D
 . . . S XNODE=$G(^DPT(XIEN,0))
 . . . W !,$P(XNODE,U,9)
 . . . W ?15,$E($P(XNODE,U),1,30)
 . . . W ?47,$E((XPFAC_" ("_$P($G(^DIC(4,XPFAC,0)),U)),1,30)_")"
 . . . S XLNCNT=XLNCNT+1 D:XLNCNT=62 PRNHEAD
 W !!,"*** END OF REPORT ***"
 S ZTREQ="@"     ; remove job from TaskMan task log
 Q
 ;
SNDMSG(STAT) ; send MailMan message
 N MSGDTM,QUIT,XLN,XMDUZ,XMSUB,XMTEXT,XMY,XTXT
 ;
 S STAT=+$G(STAT)
 S MSGDTM=$$HTE^XLFDT($H)   ;Current Date/Time
 S XMTEXT="^TMP(""DG53355A"",$J,"
 S XMSUB="Patch DG*5.3*355 ("_ZTDESC_")"
 S XMDUZ=.5  ;indicate PostMaster is the sender
 S XMY(DUZ)=""    ;Send message to user starting job
 ;
 K ^TMP("DG53355A",$J)
 D MSGADD(XMSUB)
 D MSGADD("")
 D MSGADD($S(STAT=-1:"Errored",STAT=1:"Stopped",1:"Finished")_" @ "_MSGDTM)
 I STAT>-1 D
 . D MSGADD("")
 . D MSGADD("The compile process has completed.  The detail report ")
 . D MSGADD("can be viewed by returning to the original menu option.")
 . D MSGADD("After 30 days the compiled data will be purged and the ")
 . D MSGADD("report will have to be recompiled.")
 . D MSGADD("")
 . D MSGADD("Number of records for each non-treating Preferred Facility:")
 . D MSGADD("")
 . I $O(^XTMP("DG53355A",0))="" D MSGADD("     No Entries Found")
 . S XPFAC=0 F  S XPFAC=$O(^XTMP("DG53355A",XPFAC)) Q:XPFAC=""  D
 . . D MSGADD("     "_$P($G(^DIC(4,XPFAC,0)),U)_": "_+$G(^XTMP("DG53355A",XPFAC,0)))
 D MSGADD("")
 D MSGADD("*** End ***")
 D ^XMD      ;send Mailman message
 K ^TMP("DG53355A",$J)
 Q
 ;
MSGADD(XLINE) N MSGLINE
 S MSGLINE=$O(^TMP("DG53355A",$J,""),-1)+1
 S ^TMP("DG53355A",$J,MSGLINE)=$G(XLINE)
 Q
 ;
TASK ;Task job using TaskMan
 N ZTDESC,ZTIO,ZTRTN
 S ZTIO="",ZTRTN="COMPILE^DG53355A",ZTDESC=XDESC
 W ! D ^%ZTLOAD
 W:$G(ZTSK) !!,"TaskMan Task: ",$G(ZTSK)
 Q
 ;
NOWDTTM() N %,%H,%I,X D NOW^%DTC Q %
 ;
PRNHEAD ; Print report heading
 N X
 S XLNCNT=8,XPGNUM=XPGNUM+1
 W @IOF,!!!,?(80-$L(XDESC)/2),XDESC
 W !!,"Run Date: ",$$HTE^XLFDT($H),?68,"Page: ",XPGNUM
 W !!,"Veteran SSN",?15,"Veteran Name"
 W ?47,"Current Preferred Facility"
 W !,"===========",?15,"============"
 W ?47,"=========================="
 Q
 ;
ERROR ; Record error and send MailMan message
 N X S X=""
 D SNDMSG(-1)
 S:$G(ZTSK)'="" X=^%ZOSF("ERRTN")
 S @^%ZOSF("TRAP")
 D ^%ZTER   ;call Kernel error trap
 Q
 ;
USERDESC() ;Write description to the screen for the user
 W !!,"This process will find all patients that have a non-treating"
 W !,"Preferred Facility on file.  All identified patients will need"
 W !,"to have their Preferred Facility changed to a valid treating"
 W !,"facility.",!
 W !,"The clean up process will perform the following steps in order:"
 W !,"     1) Compile the patient data.  (This step looks at "
 W !,"        every patient in the PATIENT (#2) file.)  A summary"
 W !,"        MailMan message will be sent to the user when the"
 W !,"        compile is complete."
 W !,"     2) The user will need to return to this option to print"
 W !,"        the detail report within 30 days to avoid recompiling."
 W !,"        NOTE: The system will purge the compiled data after 30"
 W !,"        days!"
 W !!,"All compiled data will be stored in the ^XTMP(""DG53355A"") "
 W "global.",!
 ;
 K DIR S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!'Y Q 0
 Q 1
