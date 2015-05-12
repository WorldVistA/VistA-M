DG53P893 ;ALB/LLS - Rebuild AEAR index ; 7/18/14 8:24am
 ;;5.3;REGISTRATION;**893**;08/13/93;Build 8
 ;
 ;
 Q 
 ; This process will find all entries in the PATIENT file (#2) that
 ; have field APPOINTMENT REQUEST ON 1010EZ (#1010.159) set to Y
 ; and do not have an AEAR index for that field. The process will
 ; set the index.
 ;
 ; This clean up process will be completed in the steps listed below.
 ;    1) Searching and updating the PATIENT file (#2)
 ;    2) Printing the log
 ;
 ; A MailMan message will be sent to the user after the job completes.
 ; The purge date for the log in the ^XTMP global is set for 90 days 
 ; after the report is processed.
 ;
GBLDOC ;-----------------------------------------------------------------
 ; The report uses the ^XTMP("DG53P893") global to store the results.
 ; The format of the ^XTMP global is described below.
 ;
 ;    DGIEN  = IEN from the PATIENT file (#2)
 ;
 ;    ^XTMP("DG53P893",0)=P1^P2^...
 ;        P1  = Rebuild Date
 ;        P2  = Date Processed
 ;        P3  = Description
 ;
 ;    ^XTMP("DG53P893",0,0)=P1^P2^...
 ;        P1  = Status (0=Unprocessed,1=Compiling,2=Process Complete)
 ;        P2  = TaskMan Task #
 ;        P3  = Process Start Date/Time (FM format)
 ;        P4  = Process Finish Date/Time (FM format)
 ;        P5  = Number of patients examined
 ;        P6  = Number of AEAR indices rebuilt
 ;
 ;    ^XTMP("DG53P893",DGIEN)="" <-- DFNs OF PATIENTS WHO HAD 
 ;                                   AEAR INDEX REBUILT
 ;-----------------------------------------------------------------
EP N DIFROM,DGSTAT,DGNODE,DGDESC,ZTREQ ;This section can be called to run the index 
 ;                                      rebuild process independently of the patch or to
 ;                                      view the report of a previously run rebuild procesS
 S DGDESC="AEAR INDEX REBUILD"
 S DGNODE=$G(^XTMP("DG53P893",0,0))
 S DGSTAT=+$P(DGNODE,U)
 ;
 W @IOF ; clear the screen
 W !!,"         ",DGDESC
 W !,$$REPEAT^XLFSTR("*",65)
 ;
 I 'DGSTAT D USERDESC D TASK           ;Task the job if it has not been started
 ;
 I DGSTAT D ASKPRINT Q                 ;Job has completed
 Q
 ;
EP2 N DIFROM,DGSTAT,DGNODE,DGDESC,ZTREQ ;This section is run as  post install
 ;                                       routine by patch DG*5.3*893
 S DGDESC="AEAR INDEX REBUILD"
 S DGNODE=$G(^XTMP("DG53P893",0,0))
 S DGSTAT=+$P(DGNODE,U)
 ;
 W @IOF ; clear the screen
 W !!,"         ",DGDESC
 W !,$$REPEAT^XLFSTR("*",65)
 ;
 I 'DGSTAT D USERDESC D TASK           ;Task the job if it has not been started
 ;
 I DGSTAT D  D SNDMSG Q              ;Process was run previously
 . W !,"AEAR index was previously rebuilt on ",$$FMTE^XLFDT($P(DGNODE,U,3))
 . W !,"You can run D EP^DG53P893 from a programmer prompt to see the report.",!!
 Q
 ;
PROCESS ; Look at all entries in the PATIENT file (#2).
 N DGCTR,DGCTR2,DGIEN,DGPFAC
 ;
 K ^XTMP("DG53P893")                  ;Clean up old process
 S $P(DGNODE,U)=1                      ;Status=compiling
 S $P(DGNODE,U,2)=$G(ZTSK)             ;TaskMan Task #
 S $P(DGNODE,U,3)=$$NOW^XLFDT()          ;Process Start Date/Time
 S $P(DGNODE,U,4)=+$H
 S ^XTMP("DG53P893",0,0)=DGNODE
 ;
 ; set up 0 node of ^XTMP to allow the system to purge after 90 days
 S ^XTMP("DG53P893",0)=$$FMADD^XLFDT(DT,90)_U_DT_U_ZTDESC
 ;
 S (DGIEN,DGCTR,DGCTR2)=0
 F  S DGIEN=$O(^DPT(DGIEN)) Q:DGIEN<1  D
 . S DGCTR=DGCTR+1
 . Q:$P($G(^DPT(DGIEN,1010.15)),U,9)'=1  ;APPOINTMENT REQUEST ON 1010EZ is not Y
 . Q:$D(^DPT("AEAR",1,DGIEN))  ;index already exists
 . D REIND(DGIEN) S DGCTR2=DGCTR2+1
 . S ^XTMP("DG53P893",DGIEN)=""
 ;
 S $P(^XTMP("DG53P893",0,0),U,5,6)=DGCTR_U_DGCTR2
 S $P(^XTMP("DG53P893",0,0),U,4)=$$NOW^XLFDT() ;Process Stop Date/Time
 S $P(^XTMP("DG53P893",0,0),U)=2     ;Set status = processed
 ;
 D SNDMSG
 ;
 Q
 ;
REIND(DG) ;re-index "AEAR" cross-reference.
 N DIK,DA
 S DIK="^DPT(",DIK(1)="1010.159^AEAR",DA=DG
 D EN1^DIK ;Re-create "AEAR" cross-reference
 Q
 ;
ASKPRINT ; Prompt user to print detail report.
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,DGH,DGTSK,ZTSK,DGII,POP,Y
 W !!,"Process Start Date/Time: ",$$FMTE^XLFDT($P(DGNODE,U,3))
 I DGSTAT=1 D  Q
 . S DGH=$P(DGNODE,U,4)
 . S DGTSK=$P(DGNODE,U,2)
 . S DGII="" F  S DGII=$O(^%ZTER(1,DGH,1,DGII)) Q:DGII=""  I $G(^%ZTER(1,DGH,1,DGII,"J"))[("Task "_DGTSK) D  S DGH=1 Q
 . . W !!,"Task ",DGTSK," has stopped and logged error #",DGII
 . . W " on ",$$FMTE^XLFDT($$HTFM^XLFDT(DGH))
 . Q:DGH=1
 . W !!,"The process [task #",DGTSK,"] is currently running!"
 . W !,"A MailMan message will be sent when the process is complete."
 . W !
 W !," Process Stop Date/Time: ",$$FMTE^XLFDT($P(DGNODE,U,4))
 W !
 W !,"Number of patient records processed: ",$P(DGNODE,U,5)
 W !,"Number of AEAR indexes rebuilt: "
 W $S($P(DGNODE,U,6)'="":$P(DGNODE,U,6),1:"None")
 W !
 ;
 W !,"Please choose a device for the printing of"
 W !,"the detailed report or enter '^' to quit:"
 ;
 ; Prompt user for device and to task job to TaskMan if 'Q' is chosen.
 K IOP,%ZIS
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 . N ZTRTN,ZTDESC,ZTDTH
 . S ZTDESC="AEAR INDEX REBULD REPORT",ZTRTN="PRINT^DG53P893(ZTDESC)",ZTDTH=$H
 . D ^%ZTLOAD
 . D ^%ZISC,HOME^%ZIS
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK: "_$G(ZTSK),1:"REQUEST CANCELLED!")
 U IO D PRINT("AEAR INDEX REBULD REPORT") G EXIT
 Q
 ;
EXIT ;
 D ^%ZISC,HOME^%ZIS
 Q
 ;
PRINT(DGDESC) ; Print detail report.
 N DGPFAC,DGIEN,DGNODE,DGLNCNT,DGPGNUM
 S DGPGNUM=0
 D PRNHEAD
 ;
 S DGIEN=0 F  S DGIEN=$O(^XTMP("DG53P893",DGIEN)) Q:DGIEN=""  D
 . S DGNODE=$G(^DPT(DGIEN,0))
 . W !,DGIEN
 . W ?15,$E($P(DGNODE,U),1,30)
 . S DGLNCNT=DGLNCNT+1 D:DGLNCNT=62 PRNHEAD
 D:DGLNCNT>55 PRNHEAD
 S DGNODE=$G(^XTMP("DG53P893",0,0))
 I DGNODE]"" D
 . W !!,"Process was run from ",$$FMTE^XLFDT($P(DGNODE,U,3))," to ",$$FMTE^XLFDT($P(DGNODE,U,4))
 . W !,"Number of patient records processed: ",$P(DGNODE,U,5)
 . W !,"Number of AEAR indexes rebuilt: "
 . W $S($P(DGNODE,U,6)'="":$P(DGNODE,U,6),1:"None")
 W !!,"*** END OF REPORT ***"
 Q
 ;
SNDMSG ; send MailMan message
 N DGLN,XMDUZ,XMSUB,XMTEXT,XMY,DGTXT
 ;
 S XMTEXT="^TMP(""DG53P893"",$J,"
 S XMSUB="Patch DG*5.3*893 (AEAR INDEX REBULD)"
 S XMDUZ=.5     ;indicate PostMaster is the sender
 S XMY(DUZ)=""  ;Send message to user starting job
 ;
 K ^TMP("DG53P893",$J)
 D MSGADD(XMSUB)
 D MSGADD("")
 D MSGADD("Started @ "_$$FMTE^XLFDT($P($G(^XTMP("DG53P893",0,0)),U,3)))
 D MSGADD("Finished @ "_$$FMTE^XLFDT($P($G(^XTMP("DG53P893",0,0)),U,4)))
 D MSGADD("")
 D MSGADD("The search/update process has completed.  The detailed ")
 D MSGADD("report can be viewed by running D EP^DG53P893 from the ")
 D MSGADD("programmer prompt. On "_$$FMTE^XLFDT(+$G(^XTMP("DG53P893",0)))_" the data will be purged. ")
 D MSGADD("")
 D MSGADD("Number of patient records processed: ")
 D MSGADD("")
 D MSGADD("     "_$P($G(^XTMP("DG53P893",0,0)),U,5))
 D MSGADD("Number of AEAR indexes rebuilt:")
 D MSGADD("")
 I $P($G(^XTMP("DG53P893",0,0)),U,6)="" D MSGADD("     None") Q
 D MSGADD("     "_$P(^XTMP("DG53P893",0,0),U,6))
 D MSGADD("")
 D MSGADD("*** End ***")
 D ^XMD      ;send Mailman message
 K ^TMP("DG53P893",$J)
 Q
 ;
MSGADD(DGLINE) N MSGLINE
 S MSGLINE=$O(^TMP("DG53P893",$J,""),-1)+1
 S ^TMP("DG53P893",$J,MSGLINE)=$G(DGLINE)
 Q
 ;
TASK ;Task the job using TaskMan
 N ZTDESC,ZTIO,ZTRTN
 S ZTIO="",ZTRTN="PROCESS^DG53P893",ZTDESC=DGDESC
 S ZTDTH=$$NOW^XLFDT()
 W ! D ^%ZTLOAD
 W:$G(ZTSK) "TaskMan Task: ",$G(ZTSK)
 Q
 ;
PRNHEAD ; Print report heading
 S DGLNCNT=8,DGPGNUM=DGPGNUM+1
 W @IOF,!!!,?(80-$L(DGDESC)/2),DGDESC
 W !!,"Run Date: ",$$HTE^XLFDT($H),?68,"Page: ",DGPGNUM
 W !!,"Patient IEN",?15,"Patient Name"
 W !,"===========",?15,"============"
 Q
 ;
USERDESC ;Write description to the screen for the user
 W !!,"This process will find all entries in the PATIENT file (#2) that"
 W !,"have field APPOINTMENT REQUEST ON 1010EZ (#1010.159) set to Y"
 W !,"and do not have an AEAR index for that field. The process will"
 W !,"set the index."
 W !!,"The clean up process will perform the following steps in order:"
 W !,"     1) Search/update the patient data.  (This step looks at "
 W !,"        every patient in the PATIENT (#2) file.)  A summary"
 W !,"        MailMan message will be sent to the user when the"
 W !,"        search/update is complete."
 W !,"     2) The user will need run D EP^DG53P893 from the programmer"
 W !,"        prompt to view the detailed report within 90 days."
 W !,"        NOTE: The system will purge the process log after 90"
 W !,"        days!"
 W !!,"Log data will be stored in the ^XTMP(""DG53P893"") global.",!
 ;
 Q
