DGAUDIT ;ISL/DKA,BAL/RLF - VAS - TAKES PAYLOAD AND SENDS TO AUDIT SOLUTION ; 03 Aug 2021  12:58 PM
 ;;5.3;Registration;**964,1097**;Aug 13, 1993;Build 43
 ;;Per VA Directive 6402 this routine should not be modified.
 ;
 ; Reference to ^XMB("NETNAME" in ICR #1131
 ; Reference to ^VA(200 in ICR #1262
 ; Reference to FILE^DID in ICR #2052
 ; Reference to $$GET1^DIQ in ICR #2056
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to $$PROD^XUPROD in ICR #4440
 ; Reference to ENCODE^XLFJSON in ICR #6682
 ; Reference to NOW^%DTC in ICR #10000
 ; Reference to YX^%DTC in ICR #10000
 ; Reference to DD^%DT in ICR #10003
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to ^DIK in ICR #10013
 ; Reference to ^DIE in ICR #10018
 ; Reference to $$S^%ZTLOAD in ICR #10063
 ; Reference to ^XMD in ICR #10070
 ; Reference to ^DIC(4 in ICR #10090
 ; Reference to ^XMB(1 in ICR #10091
 ; Reference to DD^%DT in ICR #10103
 ;
 Q  ; No entry from top
 ;
EXPORT ; Called from TaskMan job
 ; Quit if this subroutine is already running
 N DGLOGN,DGDEBUGON,DGAUDKPX,DGBATSIZE
 S DGDEBUGON=$$GET^XPAR("ALL","DG VAS DEBUGGING FLAG")
 L +^DGAUDIT2(0):2 I '$T D  Q
 . I DGDEBUGON D
 .. S ^XTMP("DGLOCKFAIL",$H,DUZ,$J)=""      ; Checks to see if taskman job is running ; FLS Added lock check to log lock attempts.
 .. S ^XTMP("DGLOCKFAIL",0)=$$FMADD^XLFDT($$DT^XLFDT(),1)_"^"_$$DT^XLFDT()_"^Debug VAS Communication Errors"
 N DGAUDERR,DGAUDOPCNT,DGAUDWRCNT,DGAUDEXPHT,DGAUDOPMAX,DGAUDOPFRQ,DGAUDSTOP,DGAUDSHUT,DGAUDOPTO,DGAUDWRMAX
 N DGAUDMAX,DGAUDTN,DGAUDSRV,DGAUDPORT,DGAUDBEG,DGCONSERR,DGAUDFAIL
 ;
 I '$$FIND1^DIC(18.12,,"B","DG VAS WEB SERVER")!('$$FIND1^DIC(18.02,,"B","DG VAS WEB SERVICE")) Q "0^Web services are not set up"
 ;
 S DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")  ;JPN Adding to get the shutoff from xpar value as changed from 0-1
 S DGAUDSTOP=0,DGAUDBEG=0,DGCONSERR=0,DGAUDFAIL=0
 ;
 I 'DGAUDSTOP&DGAUDSHUT  D
 . S DGAUDMAX=$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")
 . S:$G(DGAUDMAX)'>1 DGAUDMAX=60000
 . S DGBATSIZE=$$GET^XPAR("ALL","DG VAS BATCH SIZE")
 . ;
 . ; Batch size can't be larger than Max number of entries in queue
 . I (DGBATSIZE'>1)!(DGBATSIZE>DGAUDMAX) S DGBATSIZE=100
 . ;
 . S DGAUDSTOP=$$S^%ZTLOAD,DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")
 . S DGAUDKPX=+$$GET^XPAR("ALL","DG VAS DAYS TO KEEP EXCEPTIONS")
 . Q:DGAUDSTOP!'DGAUDSHUT   ;JPN added 'DGAUDSHUT for 0-1 change
 . D EXPORT2
 . I DGDEBUGON D            ; FLS if debug flag on send email
 . . D DBEMAIL^DGAUDIT1("EXPORT^DGAUDIT")
 L -^DGAUDIT2(0)
 I $D(ZTQUEUED) S ZTREQ="@"  ; Kernel Environment variables. If queued, remove task when complete.
 Q
 ;
EXPORT2 ; Main processing loop
 N DGAUDECNT,DGAUDOPEN,DGAUDSC,DGAUDRD,DGDEBUGON,DGAUDTBR,DGABORT
 N DGRESPERR
 S DGDEBUGON=$$GET^XPAR("ALL","DG VAS DEBUGGING FLAG")   ; Changed XPAR names from VSRA to VAS 3/17/21
 ;
 ; Send records already in queue
 D EXPORT3(.DGABORT) Q:$G(DGABORT)
 ;
 ; Don't add records from ^DIA until queue is less than 50% full. 
 I '$$FROZEN(70) D  ; Queue should be empty now - if queue remains more than 70% full, there's a problem.
 . ; If queue less than 70% full, add payload entries for new FileMan patient-related AUDIT entries
 . D NEWAUDEX^DGAUDIT1
 ;
 D EXPORT3
 Q
 ;
EXPORT3(DGABORT) ;JPN ADDED FOR BREAKING UP DIA GLOBAL
 N DGPOST,DGRESP,DGOUT,DGERRARR,DGDONE,DGRESPONSE
 S DGAUDSTOP=$$S^%ZTLOAD,DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")
 S DGAUDWRMAX=+$$GET^XPAR("ALL","DG VAS MAX WRITE ATTEMPTS")
 S:'$G(DGAUDWRMAX) DGAUDWRMAX=5
 S DGDONE=0
 Q:DGAUDSTOP!'DGAUDSHUT!(DGAUDSHUT=2)   ;JPN added 'DGAUDSHUT for 0-1 change
 S DGAUDOPEN=1,DGAUDECNT=0,DGAUDTBR=10,DGAUDWRCNT=0
 ;
 ; Send records ready to send, in batches of DGBATSIZE
 F BATCHID=$$NOW^XLFDT:.00000001 Q:'$$PENDING^DGAUDIT1!$G(DGDONE)!'DGAUDSHUT!(DGAUDSHUT=2)!$G(DGABORT)  D
 . N BATSIZE,PENDING,DGOUT,DGERRARR
 . S PENDING=$$PENDING^DGAUDIT1
 . S DGERRARR="",DGOUT=""
 . I PENDING>DGBATSIZE S BATSIZE=DGBATSIZE
 . E  S BATSIZE=PENDING,DGDONE=1
 . S DGRESP=$$RESTPOST(BATCHID,BATSIZE,.DGERRARR,DGAUDWRCNT,.DGOUT)
 . I DGRESP K DGCONSERR S DGCONSERR=0,DGAUDFAIL=0
 . ; Track consecutive failures, specific exceptions
 . I 'DGRESP S DGAUDFAIL=$G(DGAUDFAIL)+1 I $P($G(DGRESP),"^",2) S DGCONSERR=+$P($G(DGRESP),"^",2)
 . S DGAUDWRCNT=$S($G(DGRESP):1,1:DGAUDWRCNT+1)
 . D PROCRESP(.DGRESP,BATCHID,.DGERRARR,DGAUDWRCNT,DGAUDWRMAX,.DGCONSERR,.DGOUT)
 . I DGAUDFAIL>DGAUDWRMAX S DGABORT=1
 . S DGAUDSTOP=$$S^%ZTLOAD,DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")
 Q
 ;
RESTPOST(BATCHID,BATSIZE,DGERRARR,DGAUDWRCNT,DGOUT) ; Build batch containing BATSIZE JSON records from ^DGAUDIT
 N DGSERVICE,DGHEADER,DGAUDDATA,DGAUDMSG,DGAUDCNT,DGHTTPCHK,DGERR,DTSTAT,DGDATA,DGHTTPRSP,DGOUTJSON
 N DGSERVER,DGSERVICE,DGRESTOBJ,DGERRCD,JSONCNT
 N $ETRAP,$ESTACK
 K ^TMP($J,"DGAUDIT"),^TMP($J,"DGOUT")    ; if exists from previous runs, posting would not execute.
 ;
 K ^TMP($J,"DGOUT")    ; if exists from previous runs, posting would not execute.
 SET DGSERVER="DG VAS WEB SERVER"
 SET DGSERVICE="DG VAS WEB SERVICE"
 ;
 ; get instance of client REST request object
 SET DGRESTOBJ=$$GETREST^XOBWLIB(DGSERVICE,DGSERVER)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S DGOUT(0)="-1^"_^TMP($JOB,"DGOUT","EXCEPTION") K ^TMP($JOB,"DGOUT","EXCEPTION") Q DGOUT
 S DGRESTOBJ.SSLCheckServerIdentity=0
 ;
 ; Insert JSON for one batch of records
 S JSONCNT=0,BATSIZE=$S($G(BATSIZE):BATSIZE,1:100)
 S DGAUDBEG=$S($G(DGAUDFAIL):+$O(^DGAUDIT(+$G(DGAUDBEG))),1:0)
 S DGAUDCNT=DGAUDBEG
 F  S DGAUDCNT=$O(^DGAUDIT(DGAUDCNT)) Q:'DGAUDCNT!(JSONCNT>(BATSIZE-1))  D
 . N DGJSON,FDA,DGDATA,DGDATA1,DGERR,DGERR1
 . S DGJSON=$G(^DGAUDIT(DGAUDCNT,1))
 . D DECODE^XLFJSON("DGJSON","DGDATA","DGERR"),ENCODE^XLFJSON("DGDATA","DGDATA1","DGERR1")
 . I $L($G(DGERR(1)))!$L($G(DGERR1(1)))!'$L($G(DGDATA("id")))!'($L($G(DGDATA1)["""id"":"))!'(DGJSON?1.ANP) D BADJSON^DGAUDIT1(DGAUDCNT,+$G(DGAUDKPX)) Q
 . S ^TMP($J,"DGAUDIT",BATCHID,DGAUDCNT)=DGJSON
 . S DGJSON=$S('JSONCNT:"["_DGJSON,1:","_DGJSON)
 . D DGRESTOBJ.EntityBody.Write(DGJSON)
 . S JSONCNT=$G(JSONCNT)+1
 D DGRESTOBJ.EntityBody.Write("]")
 F DGHEADER="Accept","ContentType" D DGRESTOBJ.SetHeader(DGHEADER,"application/json")
 ;
 Q:'JSONCNT 1  ; Nothing in batch, don't send, don't log error
 ;
 ; Execute HTTP Post method
 ; Get HTTP response 
 S DGRESPONSE=$$POST^XOBWLIB(DGRESTOBJ,"",.DGRESPERR,0)
 I 'DGRESPONSE D  Q DGOUT
 . S DGOUT=DGRESPONSE
 . S DGERRCD=$$ERRSPMSG^DGAUDIT1(DGRESPERR,.DGERRARR)
 . S DGOUT=0_"^"_$S($L(DGERRCD)>1:DGERRCD,1:$P(DGRESP,"^",2))
 ;
 S DGHTTPRSP=DGRESTOBJ.HttpResponse
 S DGOUTJSON=DGHTTPRSP.Data.ReadLine() ; reads json string response from the data stream.
 ;
 ; Decode json string DGOUTJSON and return by reference via DGOUT and quit
 D DECODE^XLFJSON("DGOUTJSON","DGOUT")
 S DGOUT=1
 Q DGRESPONSE
 ; 
PROCRESP(DGRESP,BATCHID,DGERRARR,DGAUDWRCNT,DGAUDWRMAX,DGCONSERR,DGOUT) ; process response
 ; If the entire batch failed, leave entries in ^DGAUDIT and delete failed batch from ^TMP
 N DGAUDERR,DGERRLIN,DGSRVRID,DGSSLPORT
 I '$G(DGRESP) D  Q
 . N %,%H,X,Y
 . S DGAUDERR=1
 . I $G(DGCONSERR) I '$G(DGCONSERR(DGCONSERR)) D  Q
 .. I $$UPPER^VALM1($G(DGERRARR("text",1)))["UNABLE TO PARSE DATA" D
 ... N DGAUDC
 ... ; If JSON format error, save entire batch of JSON, but only for 12 hours
 ... S ^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,0)=$$FMADD^XLFDT($$DT^XLFDT(),,12)_"^"_$$DT^XLFDT()_"^VAS Server JSON Exceptions"
 ... S DGAUDC=0 F  S DGAUDC=$O(^TMP($J,"DGAUDIT",BATCHID,DGAUDC)) Q:'DGAUDC  D
 .... S ^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,DGAUDC)=$G(^TMP($J,"DGAUDIT",BATCHID,DGAUDC)),^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,DGAUDC,1)=$G(^DGAUDIT(DGAUDC,1))
 .... N DIK,DA S DIK="^DGAUDIT(",DA=DGAUDC D ^DIK   ; Remove problem JSON batch from queue
 .. S DGCONSERR(DGCONSERR)=$G(DGCONSERR(DGCONSERR))+1
 .. N DGERRTXT S DGERRTXT=$S($L($P($G(DGERRARR("text",1)),":",2)):$E($TR($P($G(DGERRARR("text",1)),":",2),""""),1,21),$L($G(DGERRARR("statusLine"))):$G(DGERRARR("statusLine")),1:$P($G(DGRESP),"^",2))
 .. S DGERRTXT="<VAS ERROR>"_DGERRTXT D APPERROR^%ZTER(DGERRTXT)
 .. S DGAUDERR(DGAUDERR)="Result of POST command: ",DGAUDERR=DGAUDERR+1
 .. I $L($G(DGERRARR("statusLine"))) S DGAUDERR(DGAUDERR)=$G(DGERRARR("statusLine")),DGAUDERR=$G(DGAUDERR)+1
 .. I $G(DGERRARR("text")) S DGERRLIN="" F  S DGERRLIN=$O(DGERRARR("text",DGERRLIN)) Q:DGERRLIN=""  S DGAUDERR(DGAUDERR)=DGERRARR("text",DGERRLIN),DGAUDERR=DGAUDERR+1
 .. D CHKSIZE^DGAUDIT,GENERR^DGAUDIT1(.DGAUDERR) K DGAUDERR
 . K ^TMP($J,"DGAUDIT",BATCHID)
 ;
 ; Process each record in batch (Exceptions and Successes) then delete batch from ^TMP
 I $G(DGRESP) D
 . ; If exceptions in DGRESP, parse comma delimited exceptions
 . N DGEXCEPT,DGAUDCNT
 . S DGEXCEPT=0 F  S DGEXCEPT=$O(DGOUT("failedIds",DGEXCEPT)) Q:DGEXCEPT=""  D
 .. ;  DGOUT("failedIds",exceptionSequence)=queueSequence.batchId
 .. ;    exceptionSequence = 1-n integer denoting sequence within list of failed id's returned in DGRESP
 .. ;    queueSequence     = IEN from ^DGAUDIT export queue
 .. ;    batchId           = batchId derived from FM date/time
 .. ;  Example: Response containing 2 record exceptions, IEN 10 and 50 from ^DGAUDIT queue, from batch Id 3211117.13122601
 .. ;    DGOUT("failedIds",1)=10.3211117.13122601
 .. ;    DGOUT("failedIds",2)=50.3211117.13122601
 .. S DGAUDCNT=$P(DGOUT("failedIds",DGEXCEPT),".") Q:'DGAUDCNT   ; Need ^DGAUDIT queue IEN to retrieve JSON
 .. S DGAUDERR=1
 .. ;
 .. ; DGAUDKPX = Days to keep exception JSON in ^XTMP : "DG VAS DAYS TO KEEP EXCEPTIONS" parameter
 .. I DGAUDKPX D
 ... I '$D(^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,0)) S ^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,0)=$$FMADD^XLFDT($$DT^XLFDT(),DGAUDKPX)_"^"_$$DT^XLFDT()_"^VAS Server Exceptions"
 ... S ^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,DGAUDCNT)=$G(^TMP($J,"DGAUDIT",BATCHID,DGAUDCNT)),^XTMP("DGAUDIT_EXCEPTION;"_BATCHID,DGAUDCNT,1)=$G(^DGAUDIT(DGAUDCNT,1))
 .. ; 
 .. ; Always send message when one or more id's are rejected?
 .. S DGAUDERR(DGAUDERR)=" One or more records in batch "_BATCHID_" were rejected.",DGAUDERR=DGAUDERR+1
 .. S DGAUDERR(DGAUDERR)=" See ^XTMP(""DGAUDIT_EXCEPTION;"_BATCHID_""" for more information.",DGAUDERR=DGAUDERR+1
 .. I $G(DGERRARR("message")) S DGERRLIN="" F  S DGERRLIN=$O(DGERRARR("message",DGERRLIN)) Q:DGERRLIN=""  S DGAUDERR(DGAUDERR)=DGERRARR("message",DGERRLIN),DGAUDERR=DGAUDERR+1
 .. D CHKSIZE^DGAUDIT,GENERR^DGAUDIT1(.DGAUDERR) S DGAUDWRCNT=0 K DGAUDERR
 .. ; Delete Record Exceptions From ^DGAUDIT
 .. N DIK,DA S DIK="^DGAUDIT(",DA=DGAUDCNT D ^DIK
 . ;
 . ;  Delete Remaining Successful records from ^DGAUDIT
 . S DGAUDCNT=0 F  S DGAUDCNT=$O(^TMP($J,"DGAUDIT",BATCHID,DGAUDCNT)) Q:'DGAUDCNT  D
 .. N DIK,DA S DIK="^DGAUDIT(",DA=DGAUDCNT D ^DIK
 . K ^TMP($J,"DGAUDIT",BATCHID)
 Q 1
 ;
SNDMSG(DGAUDMSG,DGAUDGRP,DGALTSUB) ; Send mail message to mail group
 ;DGAUDMSG is an array of lines to be written in the mail message
 ;DGAUDGRP is mail group receiving error message.
 ;DGALTSUB is alternate message subject
 N DGEND,DGINST,XMDUZ,XMSUB,XMTEXT,XMX,XMY,Y,DGEMAIL     ;JPN ADDED 3/31/21 DGEMAIL
 S DGINST=+$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S DGEND=$$FMTE^XLFDT($$NOW^XLFDT)
 S DGEMAIL=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")        ;JPN ADDED 3/31/21
 S DGEMAIL=$$GET1^DIQ(3.8,+$G(DGEMAIL),.01)
 S DGEMAIL=$S($L(DGEMAIL):"G."_DGEMAIL,1:.5)
 S XMY(DGEMAIL)=""                                    ;JPN ADDED 3/31/21
 S XMDUZ="noreply.domain.ext"
 S XMSUB=$S($L($G(DGALTSUB)):DGALTSUB,1:"VAS AUDIT ERROR MESSAGE FROM STATION ")_DGINST
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMTEXT="DGAUDMSG(" N DIFROM D ^XMD
 Q
 ;
CHKSIZE ; Check the size of the ^DGAUDIT global (based on the number of entries).
 ; If the number of entries is greater than the parameter value for the maximum number of entries,
 ; then repeatedly delete the first entry until the number of entries is back to the maximum.
 N DA,DIK,DGAUDDATA,DGAUDMAX,DGAUDMSG,DGAUDNUM,DGAUDCNT
 S DGAUDCNT=0,DGAUDMAX=+$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")  ; Changed XPAR names from VSRA to VAS 3/17/21
 Q:DGAUDMAX<1  ; Don't do anything if the maximum number of entries has not been set
 S DIK="^DGAUDIT("
 D FILE^DID(46.3,,"ENTRIES","DGAUDDATA","DGAUDMSG")
 S DGAUDNUM=$G(DGAUDDATA("ENTRIES"))
 F  Q:DGAUDNUM'>DGAUDMAX  D
 . S DA=$O(^DGAUDIT(0))
 . D ^DIK
 . S DGAUDCNT=DGAUDCNT+1
 . D FILE^DID(46.3,,"ENTRIES","DGAUDDATA","DGAUDMSG")
 . S DGAUDNUM=$G(DGAUDDATA("ENTRIES"))
 I DGAUDCNT>0 S DGAUDERR=$G(DGAUDERR)+1,DGAUDERR(DGAUDERR)="The first "_$S(DGAUDCNT=1:"entry has",1:DGAUDCNT_" entries have")_" been removed from the ^DGAUDIT global."
 Q
 ;
FROZEN(PCT) ; If there are there greater than PCT% records stuck in queue, send message
 ; Don't add any new records from ^DIA until queue is cleared out. 
 S:$G(PCT)'>25 PCT=50  ; Allow queue to reach 25% full before sending message
 I $$PCTFULL>PCT D  Q 1
 . N DGAUDERR
 . S DGAUDERR(1)="The VAS queue is over "_PCT_"% full after attempting to send all pending records."
 . S DGAUDERR(2)="Please log a Help Desk ticket for assistance."
 . D GENERR^DGAUDIT1(.DGAUDERR,"VAS QUEUE SIZE ERROR FROM STATION ")
 Q 0
 ;
PCTFULL() ;  VAS QUEUE % full
 N DGAUDMAX
 S DGAUDMAX=$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")
 S:$G(DGAUDMAX)'>1 DGAUDMAX=60000      ; If parameter not defined, process defaults to 60000
 Q (($$PENDING^DGAUDIT1/DGAUDMAX)*100)
