XUSNPIXI ;OAK_BP/BEE - NPI EXTRACT REPORT INTERFACE ROUTINE ;01-OCT-06
 ;;8.0;KERNEL;**481**;Jul 10, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Process incoming HL7 NPI Crosswalk Extract Schedule/Cancel Message
 ;
 ; Incoming Variables (Defined in HL7 Message Handler)
 ; 
 ; HLNEXT   -> Executable code to step through message
 ; HLMTIENS -> IEN of entry in Message Text file for subscriber application
 ; HLNODE   -> Array containing current segment information
 ; HLQUIT   -> Variable signifying last segment has been reached
 ;
EN ; Entry Point - Place message into a TMP global.
 ;
 N ACK,CNT,%DT,EVENT,FS,FSHLI,IDT,ORDCTL,PROCID,SEGCNT,SEGMSH,SEGORC,STS,X,XDT,Y
 ;
 ; Load message into ^TMP global
 ; 
 K ^TMP($J,"XUSNPIXI")
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0,^TMP($J,"XUSNPIXI",SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 .. S ^TMP($J,"XUSNPIXI",SEGCNT,CNT)=HLNODE(CNT)
 ;
 ; Check MSH Segment
 ; 
 S SEGMSH=$G(^TMP($J,"XUSNPIXI",1,0))
 S (FS,FSHLI)=$E(SEGMSH,4)
 ;
 ;Make sure first message is MSH and check Process ID
 S PROCID=$P(SEGMSH,FSHLI,11)
 I ($E(SEGMSH,1,3)'="MSH")!(",T,P,"'[(","_PROCID_",")) D  G ACK
 . S STS="AE^Invalid Message Header - First segment found is not MSH or PROCESS ID is not 'T' or 'P'"
 ;
 ;Verify Correct Message Type
 S EVENT=$P(SEGMSH,FSHLI,9)
 I EVENT'="ORM^O01^ORM_O01" D  G ACK
 . S STS="AE^Invalid Message Type ("_EVENT_") - Expecting ORM^O01^ORM_O01"
 ;
 ;Save needed parameter
 S HL("HLMTIENS")=$G(HLMTIENS)
 ;
 ; Process ORC Segment
 ; 
 ;Pull next segment (should be an ORC)
 S SEGORC=$G(^TMP($J,"XUSNPIXI",2,0))
 ;
 ;Check for ORC segment
 I $E(SEGORC,1,3)'="ORC" D  G ACK
 . S STS="AE^Invalid Segment ("_$E(SEGORC,1,3)_") - Second segment should be an ORC segment"
 ;
 ;Pull Order Control Field
 S ORDCTL=$P(SEGORC,FSHLI,2)
 I ORDCTL'="NW",ORDCTL'="CA" D  G ACK
 . S STS="AE^Invalid Order Control Field Value ("_ORDCTL_") - Expected 'NW' or 'CA'"
 ;
 ;Check Date and Time
 S X=$E($P(SEGORC,FSHLI,10),1,12)
 S:X?8N X=X_"2100"  ;Default to 9:00PM if no time
 S:X?10N X=X_"00"   ;Default minutes if not sent
 S:X'?12N X=-1      ;Invalid date
 S:X'=-1 X=$E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4)_"@"_$E(X,9,12)
 S %DT="R" D ^%DT I Y=-1 D  G ACK
 . S STS="AE^Invalid Run Date/Time - ("_$P(SEGORC,FSHLI,10)_")"
 S IDT=Y,XDT=X
 ;
 ;Call Schedule (NW) or Cancel (CA) Tags
 I ORDCTL="NW" D
 . S STS=$$NW(IDT,XDT)
 I ORDCTL="CA" D
 . S STS=$$CA(IDT,XDT)
 ;
 ; Kick Off Application Acknowledgment
 ; 
ACK S ACK("MSA",1)=$P(STS,U)
 S ACK("MSA",2)=$G(HL("MID"))  ;Message ID
 S ACK("MSA",3)=$P(STS,U,2)    ;Message Text
 D APPACK(.HL,.ACK)
 ;
 ; Exit the process
 ; 
EXIT K ACK,CNT,%DT,EVENT,FS,FSHLI,IDT,PROCID,SEGCNT,SEGMSH,SEGORC,STS,X,XDT,Y
 K ^TMP($J,"XUSNPIXI"),HL,HLNEXT,HLNODE,HLQUIT
 Q
 ;
 ; Schedule a New Run
 ;
NW(IDT,XDT) N TSK
 ;
 ;Check if task already scheduled for date/time
 S TSK=$$GETTASK(IDT)
 I TSK Q "AE^Task (#"_TSK_") already scheduled to run on "_XDT
 ;
 ;Schedule the task
 S TSK=$$SCHED(IDT)
 ;
 ;Check for scheduling problem
 I 'TSK Q "AE^Task Could Not Be Scheduled"
 ;
 ;Send successful schedule message
 D MSG("CROSSWALK EXTRACT REPORT Scheduled "_XDT)
 Q "AA^"
 ;
 ; Cancel a Scheduled Run
 ;
CA(IDT,XDT) N ZTSK
 ;
 ;Check if task has been scheduled for date/time
 S ZTSK=$$GETTASK(IDT)
 I 'ZTSK Q "AE^Task was not scheduled to run on "_XDT_"."
 ;
 ;Delete Task
 D KILL^%ZTLOAD
 ;
 ;Check for problem with cancel request
 I '$G(ZTSK(0)) Q "AE^Task (#"_ZTSK_") could not be killed."
 ;
 ;Send successful run cancel message
 D MSG("CROSSWALK EXTRACT REPORT Cancelled "_XDT)
 ;
 Q "AA^"
 ;
 ;Check To See If Task Is Scheduled for Date and Time/Locate Task
 ;
GETTASK(IDT) N TASK,TASKNO,TDT,XUSUCI,Y,ZTSK0
 ;
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 ;       
 S TASK=0,TASKNO=""
 F  S TASK=$O(^%ZTSK(TASK)) Q:'TASK  D  Q:TASKNO
 .I $G(^%ZTSK(TASK,.03))["XUS NPI EXTRACT" D
 ..S ZTSK0=$G(^%ZTSK(TASK,0))
 ..;
 ..;Exclude tasks scheduled by TaskMan
 ..Q:ZTSK0["ZTSK^XQ1"
 ..;
 ..;Exclude tasks in other ucis
 ..Q:(($P(ZTSK0,U,11)_","_$P(ZTSK0,U,12))'=XUSUCI)
 ..;
 ..;Check for correct date and time
 ..S TDT=$$HTFM^XLFDT($P(ZTSK0,"^",6))
 ..I TDT=IDT S TASKNO=TASK
 Q TASKNO
 ;
 ;Schedule Task
 ;
SCHED(ZTDTH) N ZTRTN,ZTDESC,ZTIO,ZTSK
 S ZTRTN="TASKMAN^XUSNPIX1"
 S ZTDESC="XUS NPI EXTRACT"
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK
 ;
 ;Send Application Acknowledgment
 ;
APPACK(HL,XUSACK) ;
 N FS,HLA,XUSGENR
 S FS=$G(HL("FS")) I FS="" S FS="|"
 ;
 ;Set up HL7
 D INIT^HLFNC2("XUS NPI EXTRACT INPUT",.HL)
 ;
 ;MSA Segment
 S HLA("HLA",1)="MSA"_FS_$G(XUSACK("MSA",1))_FS_$G(XUSACK("MSA",2))_FS_$G(XUSACK("MSA",3))
 ;
 ;Kick off Application Acknowledgment
 D GENACK^HLMA1($G(HL("EID")),$G(HL("HLMTIENS")),$G(HL("EIDS")),"LM",1,.XUSGENR)
 ;
 Q
 ;
 ;Send MailMan Status Message
 ;
MSG(XUSSUB) N XMSUB,XMTEXT,XMY,XUDT,XUSNPIMM,XMDUZ,XMZ,XMMG,DIFROM
 ;
 ;Set subject and text
 S XMTEXT="XUSNPIMM("
 S XUDT=$P($P(XUSSUB,"@")," ",$L(XUSSUB," "))
 S XUSSUB=$P(XUSSUB," ",1,$L(XUSSUB," ")-1)_" "
 S XUSSUB=XUSSUB_$E(XUDT,7,10)_$E(XUDT,1,2)_$E(XUDT,4,5)
 S XMSUB=$$SUBJ()_XUSSUB
 S XMDUZ="XUS NPI CROSSWALK EXTRACT SCHEDULER"
 ;
 ;Put subject in body as well so message will transmit
 S XUSNPIMM(.0001)=XMSUB
 ;
 ;Set recipient
 S XMY("G.NPI EXTRACT VERIFICATION")=""
 ;
 ;Send
 D ^XMD
 ;
 Q
 ;
 ; Define First Part of Message Subject
 ; 
SUBJ() N PROD,SINFO,SITE,SUBJ
 ;
 ;Pull site info
 S SINFO=$$SITE^VASITE
 ;
 ; Station Number
 S SITE=$P(SINFO,U,3)
 ;
 ;Determine whether production or test
 S PROD=$S($$PROD^XUPROD(1):"PROD",1:"TEST")
 ;
 Q "Station "_SITE_"("_PROD_") NPI "
