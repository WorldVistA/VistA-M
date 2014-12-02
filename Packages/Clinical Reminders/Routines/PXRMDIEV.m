PXRMDIEV ;SLC/PKR - Routines for disabling/enabling evaluation. ;06/04/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;=================================
BUILDD(BUILD) ;Disable for a build installation.
 N REASON
 S REASON="install of "_BUILD_" build"
 D BMES^XPDUTL("Disabling reminder evaluation.")
 D SDISXTMP(REASON)
 Q
 ;
 ;=================================
BUILDE(BUILD) ;Enable after a build installation is complete.
 N REASON
 S REASON="install of "_BUILD_" build"
 D BMES^XPDUTL("Enabling reminder evaluation.")
 D KDISXTMP(REASON)
 Q
 ;
 ;=================================
DMSG ;Send a message that reminder evaluation has been disabled.
 N DTIME,NL,RDATA,REASON,TO
 K ^TMP("PXRMXMZ",$J)
 S NL=0
 S DTIME=$$FMTE^XLFDT($P(^XTMP("PXRM_DISEV",0),U,2))
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Reminder evaluation was disabled on "_DTIME_"."
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Because of this, the following TaskMan jobs can produce erroneous results."
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Pending jobs should not be allowed to start until evaluation is enabled."
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="The results of running jobs should be discarded and if possible, running jobs"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="should be stopped."
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 ;
 S REASON=0
 F  S REASON=$O(^XTMP("PXRM_DISEV",REASON)) Q:REASON=""  D
 . I $D(^XTMP("PXRM_DISEV",REASON))=1 D  Q
 .. S TEXT="Reason: "_REASON_"."
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 . S RDATA=""
 . F  S RDATA=$O(^XTMP("PXRM_DISEV",REASON,RDATA)) Q:RDATA=""  D
 .. I REASON["index" S TEXT="Reason: "_REASON_" for file #"_RDATA_"."
 .. I REASON["manager" D
 ... S USER=$P(^VA(200,RDATA,0),U,1)
 ... S TEXT="Reason: "_REASON_" - "_USER_"."
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 ;
 D TSKJOBS(.NL)
 D TOLIST(.TO)
 D SEND^PXRMMSG("PXRMXMZ","REMINDER EVALUATION DISABLED",.TO,.5)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;=================================
EMSG(DTIME) ;Send a message that reminder evaluation has been enabled.
 N ETIME,NL,TO
 K ^TMP("PXRMXMZ",$J)
 S NL=0
 S DTIME=$$FMTE^XLFDT(DTIME)
 S ETIME=$$FMTE^XLFDT($$NOW^XLFDT)
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Reminder evaluation was enabled on "_ETIME_"."
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="It was disabled on "_DTIME_"."
 D TOLIST(.TO)
 D SEND^PXRMMSG("PXRMXMZ","REMINDER EVALUATION ENABLED",.TO,.5)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;=================================
INDEXD(INDEX) ;Disable for index rebuilding.
 N REASON,TASKNUM
 S REASON="index rebuild"
 D SDISXTMP(REASON,INDEX)
 ;Start a TaskMan job to periodically check for completion of the
 ;rebuilding.
 S TASKNUM=$$TINDXCHK(REASON,INDEX)
 I TASKNUM'="" D
 . W !,"Started job ",TASKNUM," to check for completion of the rebuilding"
 . W !,"of the index for file # ",INDEX,"."
 Q
 ;
 ;=================================
INDXCHK(REASON,INDEX) ;If reminder evaluation is disabled for index
 ;rebuilding check to see if the index has been rebuilt.
 I $D(^PXRMINDX(INDEX,"DATE BUILT")) D KDISXTMP(REASON,INDEX)
 Q
 ;
 ;=================================
KDISXTMP(REASON,RDATA) ;Kill ^XTMP nodes for disabling evaluation.
 I $G(RDATA)'="" K ^XTMP("PXRM_DISEV",REASON,RDATA)
 E  K ^XTMP("PXRM_DISEV",REASON)
 I $O(^XTMP("PXRM_DISEV",0))="" D
 . N DTIME
 . S DTIME=$P(^XTMP("PXRM_DISEV",0),U,2)
 . K ^XTMP("PXRM_DISEV")
 .;Enable PXRM options and protocols.
 . D OPTIONS("")
 . D PROTCOLS("")
 .;Send a message that evaluation has been enabled.
 . D EMSG(DTIME)
 Q
 ;
 ;=================================
MGRD ;Code for disabling evaluation by the reminder manager.
 N ANS,REASON
 W !,"Disabling reminder evaluation will stop all evaluation, dialogs,"
 W !,"reminder order checks, and anything using reminder evaluation!"
 W !,"Are you sure you want to proceed?"
 S ANS=$$ASKYN^PXRMEUT("N","Disable reminder evaluation")
 I 'ANS Q
 S REASON="by reminder manager"
 D SDISXTMP(REASON,DUZ)
 Q
 ;
 ;=================================
MGRE ;Code for enabling evaluation by the reminder manager.
 N ANS,DTIME,RDATA,REASON,TEXT
 W !,"Reminder evaluation is currently disabled for the following reason(s):"
 S REASON=0
 F  S REASON=$O(^XTMP("PXRM_DISEV",REASON)) Q:REASON=""  D
 . I $D(^XTMP("PXRM_DISEV",REASON))=1 D  Q
 .. S TEXT="Reason: "_REASON_"."
 .. W !,TEXT
 . S RDATA=""
 . F  S RDATA=$O(^XTMP("PXRM_DISEV",REASON,RDATA)) Q:RDATA=""  D
 .. I REASON["index" S TEXT="Reason: "_REASON_" of file #"_RDATA_"."
 .. I REASON["manager" D
 ... S MNAME=$P(^VA(200,RDATA,0),U,1)
 ... S TEXT="Reason: "_REASON_" - "_MNAME_"."
 .. W !,TEXT
 S ANS=$$ASKYN^PXRMEUT("N","Enable reminder evaluation")
 I 'ANS Q
 S DTIME=$P(^XTMP("PXRM_DISEV",0),U,2)
 D EMSG(DTIME)
 K ^XTMP("PXRM_DISEV")
 D OPTIONS("")
 D PROTCOLS("")
 Q
 ;
 ;=================================
MGRO ;Called by the option PXRM DISABLE/ENABLE EVALUATION.
 I '$D(^XUSEC("PXRM MANAGER",DUZ)) D  Q
 . W !,"You must have the reminder managers key to use this option."
 I $D(^XTMP("PXRM_DISEV",0)) D MGRE Q
 D MGRD
 Q
 ;
 ;=================================
OPTIONS(TEXT) ;Disable/enable critical PXRM options.
 ;;PXRM DEF INTEGRITY CHECK ALL
 ;;PXRM DEF INTEGRITY CHECK ONE
 ;;PXRM ORDER CHECK TESTER
 ;;PXRM REMINDERS DUE
 ;;PXRM REMINDERS DUE (USER)
 ;;END
 N IND,DONE,OPTION
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S OPTION=$P($T(OPTIONS+IND),";",3,99)
 . I OPTION="END" S DONE=1 Q
 . D OUT^XPDMENU(OPTION,TEXT)
 Q
 ;
 ;=================================
PINDXCHK ;If reminder evaluation is disabled for index
 ;rebuilding periodically check to see if the index has been rebuilt.
 ;This is run as a TaskMan job INDEX and REASON are passed through
 ;ZTSAVE.
 N DONE
 S ZTREQ="@"
 S DONE=0
 F  Q:DONE  D
 . I $D(^PXRMINDX(INDEX,"DATE BUILT")) D
 .. S DONE=1
 .. I $D(^XTMP("PXRM_DISEV",REASON)) D KDISXTMP^PXRMDIEV(REASON,INDEX)
 . I 'DONE H 60
 Q
 ;
 ;=================================
PROTCOLS(TEXT) ;Disable/enable critical PXRM protocols.
 ;;PXRM PATIENT LIST CREATE
 ;;PXRM EXTRACT MANUAL TRANSMISSION
 ;;END
 N IND,DONE,PROTOCOL
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S PROTOCOL=$P($T(PROTCOLS+IND),";",3,99)
 . I PROTOCOL="END" S DONE=1 Q
 . D OUT^XPDPROT(PROTOCOL,TEXT)
 Q
 ;
 ;=================================
SDISXTMP(REASON,RDATA) ;Set ^XTMP nodes for disabling evaluation.
 N CDATE,PUDATE
 I '$D(^XTMP("PXRM_DISEV",0)) D
 . S CDATE=$$NOW^XLFDT
 . S PUDATE=$$FMADD^XLFDT(CDATE,0,12,0,0)
 . S ^XTMP("PXRM_DISEV",0)=PUDATE_U_CDATE_U_"Temporarily disable reminder evaluation"
 I $G(RDATA)="" S ^XTMP("PXRM_DISEV",REASON)=""
 E  S ^XTMP("PXRM_DISEV",REASON,RDATA)=""
 ;Disable some PXRM options and protocols.
 D OPTIONS(REASON)
 D PROTCOLS(REASON)
 ;Send a message that evaluation is disabled.
 D DMSG
 Q
 ;
 ;=================================
TINDXCHK(REASON,INDEX) ;If reminder evaluation is disabled for index
 ;rebuilding start a TaskMan job to periodically check to see
 ;if the index has been rebuilt.
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTSAVE("INDEX")=""
 S ZTSAVE("RDATA")=""
 S ZTSAVE("REASON")=""
 S ZTRTN="PINDXCHK^PXRMDIEV"
 S ZTDESC="Clinical Reminders Index building check, file #"_INDEX
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK
 ;
 ;=================================
TOLIST(TO) ;Return the list of who to send the message to.
 N MGIEN,MGROUP
 S TO(DUZ)=""
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 Q
 ;
 ;=================================
TSKJOBS(NL) ;Search for TaskMan jobs that may be affected by disabled reminder
 ;evaluation. For any that are found add information to the MailMan
 ;message.
 N TDESC
 S TDESC="Reminder Due Report"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Reminders Due Report Jobs"
 D TSKLIST(TDESC,.NL)
 ;
 S TDESC="Build Reminder Patient List"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Reminder Patient List Jobs"
 D TSKLIST(TDESC,.NL)
 ;
 S TDESC="Run Reminder Extract"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Reminder Extract Jobs"
 D TSKLIST(TDESC,.NL)
 Q
 ;
 ;=================================
TSKLIST(TDESC,NL) ;Search for tasks with the description TDESC. For any
 ;that are found add their information to the message text.
 N DTIME,STATUS,TIME,TLIST,TASKNUM,USER,ZTSK
 D DESC^%ZTLOAD(TDESC,"TLIST")
 S TASKNUM=""
 F  S TASKNUM=$O(TLIST(TASKNUM)) Q:TASKNUM=""  D
 . K ZTSK
 . S ZTSK=TASKNUM
 . D STAT^%ZTLOAD
 . I ZTSK(0)=0 Q
 .;Only tasks that are pending or running.
 . I ZTSK(2)'["Active" Q
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Task number - "_TASKNUM
 . S STATUS=ZTSK(2)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Status - "_STATUS
 . D ISQED^%ZTLOAD
 . I $D(ZTSK("D")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Time - "_$$HTE^XLFDT(ZTSK("D"))
 . I $D(ZTSK("DUZ")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="User - "_$P(^VA(200,ZTSK("DUZ"),0),U,1)
 Q
 ;
