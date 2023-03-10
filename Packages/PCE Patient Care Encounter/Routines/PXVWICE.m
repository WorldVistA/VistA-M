PXVWICE ;ISP/LMT - ICE interface main routine ;Jun 06, 2019@07:59:57
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ; Thanks to George Lilly for developing (and sharing) his prototype of the interface of VistA and ICE;
 ; it was instrumental in the development of this production version.
 ;
 ; TODO:
 ;   - Create national Clinical Reminders and update Build Logic
 ;     in PX ICE MESSAGE entries that call into GETREM^PXVWVMR
 ;     to use national reminders.
 ;   - Add code to SELECT^ORWPC to check if ICE cache has been validated today;
 ;     and if not, task job to validate cache, and if necessary update cache
 ;
 ;
RPC(PXRETURN,DFN,PXCHKCACHE,PXASYNC) ; Entry point for RPC
 ;
 ; Returns ICE recommendations
 ;
 ;Input:
 ;         DFN - Patient (#2) IEN
 ;  PXCHKCACHE - Use cached results, if available? 1=Yes; 0=No (default: 1)
 ;     PXASYNC - Call ICE asynchronously? 1=Yes; 0=No; Handle; (default: 0)
 ;               (See EN tag below for more info on asynchronous functionality).
 ;
 ;Returns:
 ; If Unsuccessful:
 ;   0) = X^Error Message
 ;          Note: X can be one of the following values:
 ;                 0: Cache is in middle of being built; check back later
 ;                -1: Invalid input
 ;                -2: Could not make SOAP call (e.g., URL not populated in 920.75, etc.)
 ;                -3: HTTP call returned unsuccessful status code (i.e., Server returned status code other than 200)
 ;                -4: Unable to process incoming message from ICE
 ;                -5: Error during asynchronous process.
 ;                -6: Interface is down/disabled
 ;   n) = If SOAP call was unsuccessful, this will be the message returned by the ICE server.
 ;
 ; If Successful:
 ;   0) = 1 ^ Number of Lines
 ;   n) = GRP ^ Vaccine Group Name ^ Group/CVX Code Recommended ^ Group/CVX Display Name ^ Earliest Recommended Date ^
 ;        Overdue Date ^ Recommend Code ^ Recommend Display Name ^ Doses Remaining
 ;          1: GRP
 ;          2: Vaccine Group Name - This is the vaccine group for this recommendation
 ;          3: Group/CVX Code Recommended - Vaccine or vaccine group recommended.
 ;             If a specific vaccine is recommended, this will be the CVX code, in the format C:CVX_Code.
 ;             More commonly, this will be populated with the vaccine group, in the format G:Group_Name
 ;          4: Group/CVX Display Name - Display Name for CVX/Group in piece #3.
 ;          5: Recommended Date
 ;          6: Overdue Date
 ;          7: Earliest Date
 ;          8: Recommend Code (currently either RECOMMENDED, FUTURE_RECOMMENDED, CONDITIONALLY_RECOMMENDED, or NOT_RECOMMENDED)
 ;          9: Recommend Display Name
 ;          10: Doses Remaining
 ;   n) = RSN ^ Reason Code ^ Reason Display Name
 ;          Note: This is the reason(s) for the recommendation above.
 ;          1: RSN
 ;          2: Reason Code
 ;          3: Reason Display Name
 ;   n) = HIST ^ V Immunization IEN ^ Immunization Name ^ Administered CVX Code ^ Admin date/time ^ Dose Number ^
 ;        Component CVX Code ^ CVX Display Name ^ Validity Code ^ Validity Display Name
 ;          1: HIST
 ;          2: V Immunization IEN (#9000010.11 IEN)
 ;          3: Immunization Name (#9999999.14, #.01)
 ;          4: Administered CVX Code (#9999999.14, #.03)
 ;          5: Admin date/time
 ;          6: Dose Number
 ;          7: Component CVX Code (for combination vaccines, this can defer from the CVX administered)
 ;          8: CVX Display Name
 ;          9: Validity Code
 ;          10: Validity Display Name
 ;   n) = HISTRSN ^ Reason Code ^ Reason Display Name
 ;          Note: This is the reason(s) why the vaccine is valid, invalid or accepted.
 ;          1: HISTRSN
 ;          2: Reason Code
 ;          3: Reason Display Name
 ;
 N PXCNT,PXI,PXICEWEB,PXJ,PXK
 ;
 S PXRETURN=$NA(^TMP("PXICERPC",$J))
 K ^TMP("PXICERPC",$J)
 ;
 D EN(.PXICEWEB,$G(DFN),$G(PXCHKCACHE),$G(PXASYNC))
 ;
 S PXCNT=0
 ;
 S ^TMP("PXICERPC",$J,0)=$G(^TMP("PXICEWEB",$J,0))
 ;
 ; If Unsuccessful
 I $P(^TMP("PXICERPC",$J,0),U,1)<1 D  Q
 . M ^TMP("PXICERPC",$J)=^TMP("PXICEWEB",$J)
 ;
 ; If Successful, flatten output
 S PXI=0
 F  S PXI=$O(^TMP("PXICEWEB",$J,PXI)) Q:PXI=""  D
 . S PXCNT=PXCNT+1
 . S ^TMP("PXICERPC",$J,PXCNT)="GRP^"_PXI_U_$G(^TMP("PXICEWEB",$J,PXI))
 . ;
 . S PXJ=""
 . F  S PXJ=$O(^TMP("PXICEWEB",$J,PXI,"REASON",PXJ)) Q:PXJ=""  D
 . . S PXCNT=PXCNT+1
 . . S ^TMP("PXICERPC",$J,PXCNT)="RSN^"_$G(^TMP("PXICEWEB",$J,PXI,"REASON",PXJ))
 . ;
 . S PXJ=""
 . F  S PXJ=$O(^TMP("PXICEWEB",$J,PXI,"HISTORY",PXJ)) Q:PXJ=""  D
 . . S PXCNT=PXCNT+1
 . . S ^TMP("PXICERPC",$J,PXCNT)="HIST^"_PXJ_U_$G(^TMP("PXICEWEB",$J,PXI,"HISTORY",PXJ))
 . . ;
 . . S PXK=""
 . . F  S PXK=$O(^TMP("PXICEWEB",$J,PXI,"HISTORY",PXJ,"REASON",PXK)) Q:PXK=""  D
 . . . S PXCNT=PXCNT+1
 . . . S ^TMP("PXICERPC",$J,PXCNT)="HISTRSN^"_$G(^TMP("PXICEWEB",$J,PXI,"HISTORY",PXJ,"REASON",PXK))
 ;
 S $P(^TMP("PXICERPC",$J,0),U,2)=PXCNT
 ;
 K ^TMP("PXICEWEB",$J)
 ;
 Q
 ;
 ;
EN(PXRETURN,DFN,PXCHKCACHE,PXASYNC) ; Entry point for API
 ;
 ; Returns ICE recommendations
 ;
 ;Input:
 ;         DFN - Patient (#2) IEN
 ;  PXCHKCACHE - Use cached results, if available? 1=Yes; 0=No; (default: 1)
 ;     PXASYNC - Call ICE asynchronously? 1=Yes; 0=No; Handle; (default: 0)
 ;               When calling ICE asynchronously, first pass "1" as the PXASYNC argument.
 ;               If cached results are available (AND PXCHKCACHE is set to 1),
 ;               we will return them immediately.
 ;               If cached results are not available (OR PXCHKCACHE is set to 0),
 ;               we will task a job to call ICE, and return a handle to the calling
 ;               process. This handle should be passed in as the PXASYNC paramater
 ;               on future calls. The calling process should keep checking back to see
 ;               if the ICE task completed. On these subsequent calls, the same arguments
 ;               should be passed in as the original call, except that in the subsequent
 ;               calls, the PXASYNC argument should be the "handle" returned in the original
 ;               call.
 ;
 ;
 ;Returns:
 ;
 ; If called asynchronously (i.e., PXASYNC>0) AND a background task was queued (or is still running):
 ;   @PXRETURN@(0)=0^Handle
 ;   This "Handle" is a number >1 and should be passed in on future calls.
 ;
 ; If Unsuccessful:
 ;  @PXRETURN@(0)=X^Error Message
 ;                  Note: X can be one of the following values:
 ;                      -1: Invalid input
 ;                      -2: Could not make SOAP call (e.g., URL not populated in 920.75, etc.)
 ;                      -3: HTTP call returned unsuccessful status code (i.e., Server returned status code other than 200)
 ;                      -4: Unable to process incoming message from ICE
 ;                      -5: Error during asynchronous process.
 ;                      -6: Interface is down/disabled
 ;  @PXRETURN@(n)=If SOAP call was unsuccessful, this will be the message returned by the ICE server.
 ;
 ; If Successful:
 ;  @PXRETURN@(0)=1
 ;  @PXRETURN@(VaccineGroup)=Group/CVX Code Recommended ^ Group/CVX Display Name ^ Recommended Date ^ Overdue Date ^
 ;                           Earliest Date ^ Recommend Code ^ Recommend Display Name ^ Doses Remaining
 ;  @PXRETURN@(VaccineGroup,"REASON",n)=Reason Code ^ Reason Display Name
 ;  @PXRETURN@(VaccineGroup,"HISTORY",V_Imm_IEN)=Immunization Name ^ Administered CVX Code ^ Admin date/time ^
 ;                                               Dose Number ^ Component CVX Code ^ CVX Display Name ^
 ;                                               Validity Code ^ Validity Display Name
 ;  @PXRETURN@(VaccineGroup,"HISTORY",V_Imm_IEN,"REASON",n)=Reason Code ^ Reason Display Name
 ;
 N PXCACHESTAT,PXCNT,PXDESC,PXHANDLE,PXRTN,PXSTALL,PXTASK,PXURL,PXVARS,PXVOTH
 ;
 S PXRETURN=$NA(^TMP("PXICEWEB",$J))
 K ^TMP("PXICEWEB",$J)
 K ^TMP("PXVWMSG",$J)
 S PXCNT=0
 ;
 ; TODO - if ICE is down, should we allow to return from cache if available?
 ;        currently, if disabled, we dont check cache; but if unavailable, we check
 I $$CHKSTAT^PXVWSTAT()=0 D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-6^ICE interface is disabled"
 ;
 I $G(PXCHKCACHE)'?1(1"0",1"1") S PXCHKCACHE=1
 I $G(PXASYNC)="" S PXASYNC=0
 I PXASYNC>1 S PXHANDLE="PXVWICETMP-"_PXASYNC
 ;
 I '$G(DFN) D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-1^Missing DFN parameter"
 S PXURL=$$GETURL()
 I PXURL="" D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-2^Unable to determine default ICE server"
 ;
 ; Check asynchronous background task and quit
 I PXASYNC>1 D  Q
 . D ASYNC(PXHANDLE,DFN,PXASYNC,PXCNT)
 . D LOGSTAT^PXVWSTAT(DFN)
 ;
 ; if synchronous, call ICE in this process
 I 'PXASYNC D CALLICE
 ;
 ; if asynchronous, call ICE in tasked process. Return handle to caller.
 I PXASYNC D
 . ;
 . ; Before tasking background process, check cache. If cache is
 . ; valid, return from cache and no need to task background job.
 . I PXCHKCACHE,$$EXIST^PXVWCCH(DFN) D  Q:$G(PXCACHESTAT)=1
 . . D BLDVMR^PXVWVMR(DFN)
 . . I '$D(^TMP("PXVWMSG",$J)) D  Q
 . . . S ^TMP("PXICEWEB",$J,PXCNT)="-2^Unable to generate outbound VMR message"
 . . . S PXCACHESTAT=1
 . . S PXCACHESTAT=$$CHKCACHE(DFN,0)
 . . K ^TMP("PXVWMSG",$J)
 . ;
 . I '$$CHKSTAT^PXVWSTAT() D  Q
 . . S ^TMP("PXICEWEB",$J,PXCNT)="-6^ICE interface is down"
 . ;
 . ; Task process to call ICE
 . S PXHANDLE=$$HANDLE(DFN)
 . S PXRTN="CALLICE^PXVWICE"
 . S PXDESC="PCE Call ICE Engine (Immunizations)"
 . S PXVARS="PXCHKCACHE;PXURL;DFN;PXHANDLE"
 . S PXVOTH("ZTDTH")=$H
 . S PXTASK=$$NODEV^XUTMDEVQ(PXRTN,PXDESC,PXVARS,.PXVOTH)
 . ;
 . I $G(PXTASK)>0 D
 . . S ^XTMP(PXHANDLE,"STATUS")=0_U_PXTASK
 . . S ^TMP("PXICEWEB",$J,PXCNT)="0^"_$P(PXHANDLE,"-",2)
 . ;
 . I $G(PXTASK)=-1 D
 . . S ^TMP("PXICEWEB",$J,PXCNT)="-5^Error tasking asynchronous process."
 . . K ^XTMP(PXHANDLE)
 ;
 D LOGSTAT^PXVWSTAT(DFN)
 ;
 K ^TMP("PXVWMSG",$J)
 ;
 Q
 ;
 ;
CHKCACHE(DFN,PXSTALL) ;Check Cache for DFN
 ;
 ; Requires vMR to already be created in ^TMP("PXVWMSG",$J)
 ;
 N PXCACHESTAT,PXI
 ;
 S PXCACHESTAT=$$STAT^PXVWCCH(DFN)
 ;
 I $G(PXSTALL),PXCACHESTAT=2 D
 . F PXI=1:1:40 D  Q:PXCACHESTAT'=2
 . . H .5
 . . S PXCACHESTAT=$$STAT^PXVWCCH(DFN)
 ;
 I PXCACHESTAT'=1 Q PXCACHESTAT
 ;
 D LOAD^PXVWCCH(DFN)
 ;
 Q PXCACHESTAT
 ;
 ;
ASYNC(PXHANDLE,DFN,PXASYNC,PXCNT) ;Check asynchronous background task
 ;
 N PXDT
 ;
 I '$D(^XTMP(PXHANDLE)) D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-5^Error during asynchronous process."
 ;
 I $P($G(^XTMP(PXHANDLE,1)),U,1)'=DFN D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-5^Error during asynchronous process. DFN does not match."
 ;
 S PXDT=$P($G(^XTMP(PXHANDLE,"DT")),U,1)
 I 'PXDT D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-5^Error during asynchronous process."
 ; if background task is running for more than 2 min, return error
 I $$HDIFF^XLFDT($H,PXDT,2)>120 D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-5^Error during asynchronous process. Process timed out."
 ;
 ; background task completed.
 I $P($G(^XTMP(PXHANDLE,"STATUS")),U,1)=1 D  Q
 . M ^TMP("PXICEWEB",$J)=^XTMP(PXHANDLE,"ICE")
 . K ^XTMP(PXHANDLE)
 ;
 ; background task is still running
 I $P($G(^XTMP(PXHANDLE,"STATUS")),U,1)=0 D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="0^"_PXASYNC
 ;
 Q
 ;
 ;
CALLICE ;
 ;
 ; ZEXCEPT: PXCHKCACHE,PXURL,DFN,PXHANDLE,ZTQUEUED,ZTREQ
 ;
 N PXCACHESTAT,PXCNT,PXNOW
 ;
 S ZTREQ="@"
 K ^TMP("PXICEWEB",$J)
 K ^TMP("PXVWMSG",$J)
 S PXNOW=$$NOW^XLFDT
 S PXCNT=0
 ;
 D BLDVMR^PXVWVMR(DFN)
 ;
 I '$D(^TMP("PXVWMSG",$J)) D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-2^Unable to generate outbound VMR message"
 . I $G(PXHANDLE)'="" D MOVERES(PXHANDLE)
 ;
 ; check cache
 I PXCHKCACHE D  Q:$G(PXCACHESTAT)=1
 . S PXCACHESTAT=$$CHKCACHE(DFN,1) ;Check Cache for DFN
 . I PXCACHESTAT=1 D
 . . I $G(PXHANDLE)'="" D MOVERES(PXHANDLE)
 . . K ^TMP("PXVWMSG",$J)
 ;
 I '$$CHKSTAT^PXVWSTAT() D  Q
 . S ^TMP("PXICEWEB",$J,PXCNT)="-6^ICE interface is down"
 . I $G(PXHANDLE)'="" D MOVERES(PXHANDLE)
 ;
 ; Set flag that cache is in middle of building
 D BLDNG^PXVWCCH(DFN)
 ;
 D EN^PXVWSOAP(PXURL) ; Call ICE
 ;
 ; if ICE call successfull, save output to cache
 I $P($G(^TMP("PXICEWEB",$J,0)),U,1)=1 D SAVE^PXVWCCH(DFN,PXNOW)
 ;
 ; Clear flag that cache is in middle of building
 D CLRBLDNG^PXVWCCH(DFN)
 ;
 ; if this is a background task, save output to XTMP
 I $G(PXHANDLE)'="" D MOVERES(PXHANDLE)
 ;
 K ^TMP("PXVWMSG",$J)
 ;
 Q
 ;
 ;
MOVERES(PXHANDLE) ;
 M ^XTMP(PXHANDLE,"ICE")=^TMP("PXICEWEB",$J)
 S ^XTMP(PXHANDLE,"STATUS")=1
 K ^TMP("PXICEWEB",$J)
 Q
 ;
 ;
HANDLE(DFN) ;Return a unique handle into ^XTMP
 ;
 N PXHANDLE,PXI,PXSUCCESS
 ;
 S PXI=$R(9999)+2
 S PXHANDLE="PXVWICETMP-"_PXI
 F  D  Q:$G(PXSUCCESS)
 . S PXSUCCESS=$$HANDLE2(PXHANDLE,DFN)
 . I $G(PXSUCCESS) Q
 . S PXI=PXI+1
 . S PXHANDLE="PXVWICETMP-"_PXI
 ;
 Q PXHANDLE
 ;
HANDLE2(PXHANDLE,DFN) ;
 ;
 I $D(^XTMP(PXHANDLE)) Q 0
 ;
 L +^XTMP(PXHANDLE):DILOCKTM
 I '$T Q 0
 ;
 I $D(^XTMP(PXHANDLE)) L -^XTMP(PXHANDLE) Q 0
 ;
 S ^XTMP(PXHANDLE,0)=DT_".24^"_DT
 S ^XTMP(PXHANDLE,1)=DFN
 S ^XTMP(PXHANDLE,"STATUS")=0
 S ^XTMP(PXHANDLE,"DT")=$H
 ;
 L -^XTMP(PXHANDLE)
 ;
 Q 1
 ;
 ;
GETURL() ; Get ICE Server URL
 ;
 N PXIEN,PXTMP
 ;
 S PXIEN=$$GET^XPAR("ALL","PX ICE WEB DEFAULT SERVER")
 ; If the value has not been set, then see if there is only one
 I 'PXIEN D
 . S PXTMP=$O(^PXV(920.75,0))
 . I $O(^PXV(920.75,PXTMP))'>0 S PXIEN=PXTMP
 I 'PXIEN Q ""
 Q $$GET1^DIQ(920.75,PXIEN,8)
 ;
 ;
TESTICE() ; Test ICE Interface
 ; Returns:
 ;    1 - Success
 ;    0 - Fail
 ;
 N PXSUCCESS,PXURL
 ;
 S PXURL=$$GETURL()
 I PXURL="" Q 0
 ;
 K ^TMP("PXICEWEB",$J)
 K ^TMP("PXVWMSG",$J)
 ;
 D TESTVMR^PXVWVMR
 ;
 I '$D(^TMP("PXVWMSG",$J)) Q 0
 ;
 D EN^PXVWSOAP(PXURL) ; Call ICE
 ;
 S PXSUCCESS=0
 I $P($G(^TMP("PXICEWEB",$J,0)),U,1)=1 S PXSUCCESS=1
 ;
 K ^TMP("PXICEWEB",$J)
 K ^TMP("PXVWMSG",$J)
 ;
 Q PXSUCCESS
