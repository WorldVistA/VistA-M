MAGGA03Q ;WOIFO/GEK/BNT/NST/JSL - TASK IMAGE STATISTICS ; 07 Oct 2010 9:48 PM
 ;;3.0;IMAGING;**117,122**;Mar 19, 2002;Build 92;Aug 02, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;P122 gek Fix the issue of not being able to Re-Run a report that
 ;  was previously canceled while it was still running.
 Q
 ;
 ;***** RETURNS VARIOUS IMAGE STATISTICS DATA
 ; RPC: MAGG IMAGE STATISTICS QUE
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 C  Capture date range. If this flag is provided,
 ;                    then the remote procedure uses values of the
 ;                    FROMDATE and TODATE parameters to select images
 ;                    that were captured in this date range.
 ;
 ;                    Otherwise, values of those parameters are
 ;                    treated as the date range when procedures were
 ;                    performed.
 ;
 ;                 D  Include only deleted images (file #2005.1)
 ;                 E  Include only existing images (file #2005)
 ;
 ;                 S  Return image counts grouped by status
 ;                 U  Return image counts grouped by users and status
 ;
 ;               If neither 'E' nor 'D' flag is provided, then an
 ;               error (-6) is returned.
 ;
 ;               If neither 'S' nor 'U' flag is provided, then an
 ;               error (-6) is returned.
 ;
 ; [FROMDATE]    Date range for image selection. Dates can be in
 ; [TODATE]      internal or external FileMan format. If a date
 ;               parameter is not defined or empty, then the date
 ;               range remains open on the corresponding side.
 ;
 ;               Time parts of parameter values are ignored and both
 ;               ends of the date range are included in the search.
 ;               For example, in order to search images for May 21,
 ;               2008, the inernal value of both parameters should
 ;               be 3080521.
 ;
 ;               If the FROMDATE is after the TODATE, then values of
 ;               the parameters are swapped.
 ; 
 ; [MQUE]        Flags for tasking reports and action on previously
 ;               tasked reports.
 ;               Q  (Default) Queue a new report task or return the status of
 ;                  In Progress for a running report. If previously 
 ;                  ran task is complete, then return report data.
 ;               R  Stop and Requeue a running report with the 
 ;                  same parameters. Existing data collected is removed 
 ;                  from temporary storage.
 ;               D  Stop a running or completed report and delete the data.
 ;
 ; Return Values
 ; =============
 ;     
 ; Zero value of the 1st '^'-piece of the @MAGRESULTS@(0) indicates an
 ; error during execution of the procedure. In this case, the array
 ; is formatted as described in the comments to the RPCERRS^MAGUERR1.
 ;
 ; Otherwise, the array contains the requested data. See description
 ; of the MAGG QUE IMAGE STATISTICS remote procedure for details.
 ;
 ; Notes
 ; =====
 ;
 ; Temporary global nodes ^TMP("MAGGA03Q",$J) and ^XTMP("MAGGA03Q,DUZ")
 ; are used by this procedure.
 ;
STATS(MAGRY,FLAGS,FROMDATE,TODATE,MQUE) ; RPC [MAGG IMAGE STATISTICS QUE]
 N MOTH,MERR,MAGXTN,MAGRES,MTDESC,X,Y,RC
 S MAGRY=$NA(^TMP("MAGGA03Q",$J))
 K @MAGRY
 S (RC,MERR)=0
 D CLEAR^MAGUERR(1)
 ;
 ;--- Validate FLAGS Parameters
 S FLAGS=$G(FLAGS) I $TR(FLAGS,"CDESU")'="" D IPVE^MAGUERR("FLAGS") S MERR=1
 ;--- Missing required flag(s)
 I $TR(FLAGS,"DE")=FLAGS D ERROR^MAGUERR(-6,,"D,E") S MERR=1
 I $TR(FLAGS,"SU")=FLAGS D ERROR^MAGUERR(-6,,"S,U") S MERR=1
 ;
 ;--- Validate Date Range
 S:$$DTRANGE^MAGUTL03(.FROMDATE,.TODATE)<0 MERR=1
 ;
 ;--- Validate TaskMan Queing parameters
 S MQUE=$G(MQUE) I MQUE="" S MQUE="Q"
 I $TR(MQUE,"QRD")'="" D IPVE^MAGUERR("MQUE") S MERR=1
 ;
 ;--- Check if error occurred and quit if so
 I MERR D ERROR^MAGUERR(-30) S RC=$$FIRSTERR^MAGUERR1()
 I RC<0 D RPCERRS^MAGUERR1(.MAGRY,RC) Q
 ;
 ;--- Create unique XTMP node
 S MAGXTN=$$TNODE(FLAGS,FROMDATE,TODATE)
 ;
 ;--- Resolve previously tasked report
 I $D(^XTMP(MAGXTN,0)) D RESOLVE(.RC,MAGXTN,MQUE)
 ;--- If 1 is returned then the report is in progress
 I +RC=1 M @MAGRY@(0)=RC Q
 ;--- If 2 is returned then the report is complete and is returned
 I +RC=2 M @MAGRY@(0)=^XTMP(MAGXTN,"R",0) Q
 ;
 ;--- Create the TaskMan parameters and queue the report
 S MTDESC="Imaging Statistics: "_FLAGS_" "_FROMDATE_" to "_TODATE
 S MOTH("ZTDTH")=$H
 ; p117 T5:  To enable a complete list of reports to be displayed 
 ; in the Client Report list.  If this "I" node isn't set, the report 
 ; will not show up in list until it is run. Could be minutes.  
 ; Added a new status to the Delphi Window : 'Queuing'.  
 ; 'Queuing' status will account for the time between the Task being
 ;  created and the job being run.  The Queuing below isn't used. It
 ;  is replaced with the TaskMan Task number later.
 ;  Delphi uses $p(3) = '' (start time) to determine 'Queuing', and not Running.
 S ^XTMP(MAGXTN,"I",0)="Queuing"_U_$G(DUZ)_U_U
 ;
 S MAGRES=$$NODEV^XUTMDEVQ("TASK^MAGGA03Q",MTDESC,"FLAGS;FROMDATE;TODATE;MAGXTN",.MOTH)
 ;--- Save thru date ^ create date ^ Task Number
 S ^XTMP(MAGXTN,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_MAGRES
 ;--- Save user cross reference node for report lookup by user
 S ^XTMP("MAGGA03Q",DUZ,MAGXTN)=""
 ;--- Return successful queued report notification with Task ID
 S @MAGRY@(0)="1^Report Queued on Task ID: "_MAGRES
 Q
 ;
TASK ;
 N MAGXTN,MAGRES
 S MAGXTN=$$TNODE(FLAGS,FROMDATE,TODATE)
 ;--- Save Internal Data as follows
 ;--- ^XTMP($$TNODE,"I",0)=Task Number^User ID^Start Date/Time^Complete Date/Time
 S ^XTMP(MAGXTN,"I",0)=$G(ZTSK)_U_$G(DUZ)_U_$$NOW^XLFDT_U
 ;--- Collect Report Data from Imaging API
 D IMGQUERY^MAGGA03(.MAGRES,FLAGS,FROMDATE,TODATE) ; GEK BOOKMARK 1
 ;P122 gek 
 ;  If the variable ZSTOP = '1', then the TASK/Report was stopped,
 ;  or if the Report's User Index: ^XTMP("MAGGAO3Q",DUZ,MAGXTN)  
 ;  does not exist, the report was stopped.
 ;  We only save report Data if report was not Stopped.
 ;  This Fixes the issue of not being able to Re-Run a report that
 ;  was previously canceled while it was still running.
 ;  
 I '$G(ZTSTOP),($D(^XTMP("MAGGA03Q",DUZ,MAGXTN))) D
 . ;--- Save Completed date/time of Report
 . S $P(^XTMP(MAGXTN,"I",0),U,4)=$$NOW^XLFDT
 . ;--- Update the Save Through date to midnight
 . S $P(^XTMP(MAGXTN,0),U,1)=$$FMADD^XLFDT($$DT^XLFDT(),1)
 . ;--- Save Report Data in temporary storage
 . M ^XTMP(MAGXTN,"R")=@MAGRES
 . Q
 Q
 ;
 ; Returns status of existing report based on MQUE flag
RESOLVE(RY,MAGXTN,MQUE) ;
 ; if task is finished, then return the data.
 ; Q flag will return a completed report or an In Progress status if still running
 I MQUE="Q" D  Q
 . S X=$P($G(^XTMP(MAGXTN,"I",0)),U,4)
 . ;/p117 T5 gek-  add $G above to stop <undef>. 
 . ; Occurred rarely (pre T5) when report is Re-Run. CodeCR731
 . I X="" S RY="1^In Progress" Q
 . S RY="2^Report Complete"
 . M @MAGRY=^XTMP(MAGXTN,"R")
 . Q
 ; R flag will Stop and Requeue a running report with same parameters
 I MQUE="R" D  Q
 . N MAGSTP,ZTSK
 . S ZTSK=$$GETTASK(MAGXTN)
 . ; Try to stop the task if it's currently running
 . S MAGSTP=$$ASKSTOP^%ZTLOAD(ZTSK)
 . I 'MAGSTP S RY="1^Report cannot be stopped. Try again later" Q
 . ;
 . D STAT^%ZTLOAD
 . I 'ZTSK(0) S RY="0^Task is undefined" D  Q
 . . ;Kill Report Data and Report's User Index
 . . K ^XTMP(MAGXTN),^XTMP("MAGGA03Q",DUZ,MAGXTN)
 . . S RY="0^Okay to retask"
 . . Q
 . I ZTSK(1)<3 S RY="1^Task In Progress : "_ZTSK Q
 . ;I ZTSK(1) is either 4 or 5,  both mean not a running task. Inactive. problem
 . ;Kill Report Data and Report's User Index
 . K ^XTMP(MAGXTN),^XTMP("MAGGA03Q",DUZ,MAGXTN)
 . S RY="0^Okay to retask"
 . Q
 ; D flag will delete a previously ran report and stop a currently running task
 I MQUE="D" D  Q
 . N MAGSTP,ZTSK
 . S ZTSK=$$GETTASK(MAGXTN)
 . S MAGSTP=$$ASKSTOP^%ZTLOAD(ZTSK)
 . I 'MAGSTP S RY="1^Report cannot be stopped. Try again later" Q
 . ;Kill Report Data and Report's User Index
 . K ^XTMP(MAGXTN),^XTMP("MAGGA03Q",DUZ,MAGXTN)
 . S RY="1^Report data deleted"
 Q
 ;
 ;***** RETURNS VARIOUS IMAGE STATISTICS DATA
 ; RPC: MAGG IMAGE STATISTICS BY USER
 ;
 ; Return all statistics reports previously tasked for a user
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ; 
 ; MAGDUZ        Internal ID of a user that has previously queued an Image Statistics 
 ;               Report.
 ;               The default value is the current user DUZ.
 ;
 ; Return Values
 ; =============
 ; 
 ; MAGRY(0) -  ^01: 1 Successful execution of the remote procedure
 ;                  0 An error occurred during the execution of the remote procedure
 ;
 ;             ^02: The number of reports identified for the user
 ;
 ; MAGRY(1..n) ^01: report FLAGS parameter
 ;             ^02: report FROMDATE parameter
 ;             ^03: report TODATE parameter
 ;             ^04: report REPORT START DATE/TIME parameter
 ;             ^05: report REPORT COMPLETE DATE/TIEM parameter
 ; 
 ; e.g.
 ; 0)=1^5 Reports found for user IMAGING,USER
 ; 1)=CDE^2900613^3100503^3100505.09053^3100505.09053
 ;
GETUSRPT(MAGRY,MAGDUZ) ; RPC [MAGG IMAGE STATISTICS BY USER]
 N MAGX,MAGCNT
 N MAGINF ; XTMP node information.
 I MAGDUZ="" S MAGDUZ=DUZ
 ;--- Delete yesterdays temp data in ^XTMP
 D CLEARTMP(MAGDUZ)
 ;
 S MAGRY=$NA(^TMP("MAGGUSRPT",$J)),(MAGX,MAGCNT)=0
 K @MAGRY
 F  S MAGX=$O(^XTMP("MAGGA03Q",MAGDUZ,MAGX)) Q:MAGX=""  D
 . I '$D(^XTMP(MAGX,"I",0)) Q
 . S MAGCNT=MAGCNT+1
 . S MAGINF=$G(^XTMP(MAGX,"I",0))
 . ; Status of 'Queuing' is now set from the Delphi App, if the start time is '' (null).
 . ; Do not change next line. Any change causes list entries to not be displayed.
 . S @MAGRY@(MAGCNT)=$P(MAGX,"-",3)_U_$P(MAGX,"-",4)_U_$P(MAGX,"-",5)_U_$P(MAGINF,U,3)_U_$P(MAGINF,U,4)
 S @MAGRY@(0)="1^"_MAGCNT_$S(MAGCNT>1:" Reports ",1:" Report ")_"found for user "_$$GET1^DIQ(200,MAGDUZ_",",.01)
 Q
 ;
 ; Get unique XTMP node
 ; Namespace + User id + Flags + From Date + To Date
TNODE(FLAG,FROMDT,TODT) ;
 ;/p117 T5 GEK  THIS IS 'maggaO3q' (LETTER 'O') It should be 'magga03q' (Zero) 
 ;Q "MAGGAO3Q"_"-"_DUZ_"-"_FLAG_"-"_FROMDT_"-"_TODT ; this had letter 'o'
 Q "MAGGA03Q"_"-"_DUZ_"-"_FLAG_"-"_FROMDT_"-"_TODT ; this is Zero 
 ;
 ; Returns the Task Number from XTMP global
 ; TNODE = Value created in $$TNODE
GETTASK(TNODE) ;
 Q $S('$D(^XTMP(TNODE,0)):0,1:+$P(^XTMP(TNODE,0),U,3))
 ;
 ; Delete temp data from yesterday
 ; 
CLEARTMP(MAGDUZ) ; Delete temp data from yesterday
 N MAGDAT,MAGXTN
 S MAGXTN=""
 F  S MAGXTN=$O(^XTMP("MAGGA03Q",MAGDUZ,MAGXTN)) Q:MAGXTN=""  D
 . S MAGDAT=$P($G(^XTMP(MAGXTN,0)),U,2)
 . I MAGDAT<DT D  ; delete all data if created date is before today 
 . . N MAGSTP,ZTSK
 . . S ZTSK=$$GETTASK(MAGXTN)
 . . ; Try to stop the task if it's currently running
 . . S MAGSTP=$$ASKSTOP^%ZTLOAD(ZTSK)
 . . I 'MAGSTP Q  ; Report cannot be stopped
 . . K ^XTMP(MAGXTN),^XTMP("MAGGA03Q",$P(MAGXTN,"-",2),MAGXTN)
 . . Q
 . Q
 Q
 ;*****  CLNXTMP  
 ;  Clean XTMP nodes. 
 ;  Due to an error (rare), there may be some orphaned 
 ;  report data in the XTMP global.  This routine will
 ;  clear out any orphaned XTMP nodes for the MAGGA03Q
 ;  and MAGGAO3Q nodes of the QA Statistics Reports.
 ;  It won't hurt valid reports.  Valid reports are pointed 
 ;  to from the XTMP("MAGGA03Q",DUZ,xxxx) cross reference.
CLNXTMP ;
 ; 0 = zero   O = letter O
 ; make a list of the valid XTMP Nodes for Reports. These are referenced by the 
 ; cross ref :    XTMP('MAGGA03Q',duz,xnode)
 N MAGXTN,MAGDUZ,MWIN
 S MAGDUZ=""
 K ^TMP($J,"MAGXTMP")
 ; for all users, save reference to their Report Nodes.
 F  S MAGDUZ=$O(^XTMP("MAGGA03Q",MAGDUZ)) Q:MAGDUZ=""  D
 . S MAGXTN=""
 . F  S MAGXTN=$O(^XTMP("MAGGA03Q",MAGDUZ,MAGXTN)) Q:MAGXTN=""  D
 . . S ^TMP($J,"MAGXTMP",MAGXTN)="" ; save list of valid XTMP Nodes.
 . . Q
 . Q
 ; The orphaned XTMP Node used 'O' (letter),  and '0' (Zero)
 ; We'll delete any nodes that aren't referenced by 
 ; the cross Ref :    XTMP('MAGGA03Q',duz,xnode)
 N XNODE,TNODE,DONE
 S DONE=0
 F XNODE="MAGGAO3Q","MAGGA03Q" D
 . S TNODE=XNODE
 . S DONE=0
 . F  S XNODE=$O(^XTMP(XNODE)) D  Q:DONE
 . . I $E(XNODE,1,8)'=TNODE S DONE=1 Q  ; Quit if node is beyond QA Report Nodes.
 . . I $D(^TMP($J,"MAGXTMP",XNODE)) Q  ; This is Valid, we won't delete.
 . . ; kill the orphaned node.
 . . K ^XTMP(XNODE)
 . . Q
 . Q
 K ^TMP($J,"MAGXTMP") ; clean up 
 Q 
