BPSOSRX ;BHAM ISC/FCS/DRS/FLS - callable from RPMS pharm ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; There are three callable entry points:
 ; $$REQST^BPSOSRX     Schedule request
 ; $$STATUS^BPSOSRX    Inquire about a request's status
 ;
 ; reference to ^%ZTLOAD supported by DBIA 10063
 ; reference to NOW^%DTC supported by DBIA 10000
 ; reference to ^%DT supported by DBIA 10003
 ;
 Q
 ;
 ; Schedule request
 ; Process all requests - Billing requests (CLAIM), Reversal (UNCLAIM)
 ;                        and Eligibility verification requests
 ;
 ; Input: see MKRQST^BPSOSRX3
 ; Return values:
 ;  1^BPS REQUEST ien = accepted for processing
 ;  0^reason = failure (should never happen)
REQST(BPREQTYP,KEY1,KEY2,MOREDATA,BPCOBIND,IEN59,BILLNDC,BPSKIP) ;
 N BPRETV,BPIEN77,BPIENS78
 S BPSKIP=+$G(BPSKIP)
 D LOG^BPSOSL(IEN59,$T(+0)_"- Start creating request")
 S BPRETV=$$MKINSUR^BPSOSRX2(KEY1,KEY2,.MOREDATA,.BPIENS78)
 I +BPRETV=0 Q BPRETV
 ;create BPS REQUEST records for primary insurer only and populate its IBDATA multiple with the iens of BPS INSURER DATA
 S BPRETV=$$MKRQST^BPSOSRX3(BPREQTYP,KEY1,KEY2,.MOREDATA,.BPIENS78,BPCOBIND,$G(BILLNDC),BPSKIP)
 Q BPRETV
 ;
 ; $$STATUS(KEY1,KEY2,QUE,BPRQIEN) - Returns the Status of the request
 ; Input
 ;   KEY1 - First key of the request
 ;   KEY2 - Second key of the request
 ;   QUE (optional):  0 - Do not check if a request is on the queue 
 ;         1/null - Check if a request is on the queue
 ;   BPRQIEN (optional) -  the BPS REQUESTS (#9002313.77) IEN
 ;   BPCOB (optional)-the payer sequence (1- Primary, 2 Secondary), if null then 1 (primary) is assumed
 ;
 ; Returns
 ;    RESULT^LAST UPDATE DATE/TIME^DESCRIPTION^STATUS %
 ;    Returns null if there's no ECME record of this request
 ;
 ;    RESULT is either:
 ;      1. IN PROGRESS for incomplete requests
 ;      2. Final status for complete requests.  See comments for
 ;         BPSOSUC for complete list of possible statuses.
 ;      3. SCHEDULED for scheduled (not ACTIVATED yet) requests
 ;         
 ;    LAST UPDATE DATE/TIME is the Fileman date and time of the
 ;         last update to the status of this request.
 ;         
 ;    DESCRIPTION is either:
 ;      1. Incomplete requests will be the status (i.e., Waiting to Start,
 ;         Transmitting)
 ;      2. Completed requests will have the reason that the ECME process
 ;         was aborted if the result is  E OTHER.  Otherwise, it will
 ;         be similar to the RESULT
 ;         
 ;    STATUS % is the completion percentage.  Note that 99 is considered
 ;         complete.
 ;         
 ;    
STATUS(KEY1,KEY2,QUE,BPRQIEN,BPCOB) ;
 ; Setup needed variables
 N IEN59,SDT,SUBDT,BP59REQ,BPTRTYP,BP59ZERO,BP59REQ
 I '$G(KEY1) Q ""
 I $G(KEY2)="" Q ""
 I $G(QUE)="" S QUE=1
 ;
 ;if BPRQIEN then it is called from BPSNCPD1 to display progress to the user. So we need to check queue anyway
 I $G(BPRQIEN)>0 S QUE=1
 ;
 ;default COB = primary
 I +$G(BPCOB)=0 S BPCOB=1
 ;
 ;get IEN of BPS TRANSACTION
 S IEN59=$$IEN59(KEY1,KEY2,BPCOB)
 ;
 ;read zeroth node of the BPS TRANSACTION record
 S BP59ZERO=$G(^BPST(IEN59,0))
 ;
 ;if doesn't have BPS TRANSACTION record AND doesn't have any BPS REQUEST records then
 ;this is an old request OR it is not e-billable - so use the old logic,
 ;which was used before COB patch, so this is for primary claims only.
 I BPCOB=1 I $G(BPRQIEN)="" I BP59ZERO="" I '$D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB)) Q $$OLDSTAT^BPSOSRX6(KEY1,KEY2,$G(QUE))
 ;
 ;if doesn't have BPS TRANSACTION record (not created yet) AND has BPS REQUEST record(s)
 I BP59ZERO="" Q $$QUESTAT(KEY1,KEY2,BPCOB)
 ;
 ;get transaction type
 S BPTRTYP=$P(BP59ZERO,U,15)
 ;if Transaction type is not defined then this is an OLD request so use the old logic
 ;which was used before COB patch, so this is for primary claims only.
 I BPCOB=1 I $G(BPRQIEN)="" I BPTRTYP="" Q $$OLDSTAT^BPSOSRX6(KEY1,KEY2,$G(QUE))
 ;
 ;get the current BPS REQUEST
 S BP59REQ=$$GETRQST^BPSUTIL2(IEN59)
 I $G(BP59REQ)="" Q $$QUESTAT(KEY1,KEY2,BPCOB)
 ;
 ;get request date/time
 S SDT=$P($G(^BPS(9002313.77,+$G(BP59REQ),6)),U,1) ;REQUEST DATE AND TIME
 ;
 ; Loop: Get data, quit if times and status match (no change during gather)
 N A,C,T1,T2,S1,S2
 F  D  I T1=T2,S1=S2 Q
 . S T1=$$LASTUP59^BPSOSRX(IEN59)
 . S S1=$$STATUS59^BPSOSRX(IEN59)
 . I S1=99 D  ; completed
 . . S A=$$CATEG^BPSOSUC(IEN59)
 . . S C=$$RESTXT59^BPSOSRX(IEN59)
 . I S1'=99 D
 . . S A="IN PROGRESS"
 . . S C=$$STATI^BPSOSU($S(S1="":10,1:S1))
 . S T2=$$LASTUP59^BPSOSRX(IEN59)
 . S S2=$$STATUS59^BPSOSRX(IEN59)
 ;
 ; If the queue parameter is set and the submit date from the queue
 ;   follows the SUBMIT DATE/LAST UPDATE date from BPS TRANSACTION 
 ;   or the request is still on the queue, then change the response
 ;   to IN PROGRESS^Submit Date^WAITING TO START
 S SUBDT=$$SUBMIT59^BPSOSRX(IEN59)
 I SUBDT="" S SUBDT=T1
 ;
 ;if we need to check the queue
 I $G(QUE),$$QUETIME(KEY1,KEY2,BPCOB,1)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0)
 I $G(QUE),$$QUETIME(KEY1,KEY2,BPCOB,0)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0)
 I $G(QUE),$$QUETIME(KEY1,KEY2,BPCOB,2)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0) ;To check IN PROCESS
 ;
 ; Return results
 Q A_U_T1_U_$E(C,1,255-$L(A)-$L(T1)-2)_U_S1
 ;
 ;the most current queue status as text
QUESTAT(KEY1,KEY2,BPCOB) ;
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,2)) Q "IN PROGRESS"_U_$$QUETIME(KEY1,KEY2,BPCOB,2)_U_$$STATI^BPSOSU(-96)_U_-1
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,1)) Q "IN PROGRESS"_U_$$QUETIME(KEY1,KEY2,BPCOB,1)_U_$$STATI^BPSOSU(0)_U_-1
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,0)) Q "IN PROGRESS"_U_$$QUETIME(KEY1,KEY2,BPCOB,0)_U_$$STATI^BPSOSU(-99)_U_-1
 ;if PROCESS FLAG=3,4,5 return null
 Q ""
 ;
 ;the most current queue status as process flag
QUECUR(KEY1,KEY2,BPCOB) ;
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,3)) Q 3
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,2)) Q 2
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,1)) Q 1
 I $D(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,0)) Q 0
 ;if PROCESS FLAG=3,4,5 return null
 Q ""
 ;
 ;the most current queue status as process flag
QUETIME(KEY1,KEY2,BPCOB,BPROCFL) ;
 N BP77
 S BP77=$O(^BPS(9002313.77,"D",KEY1,KEY2,BPCOB,BPROCFL,0))
 I BP77>0 Q $P($G(^BPS(9002313.77,+BP77,6)),U,1) ;REQUEST DATE AND TIME
 Q ""
 ;
NOW() N %,%H,%I,X D NOW^%DTC Q %
 ;
 ; RESTXT59 - Return first semi-colon piece of the Result Text (202) field
 ;    from BPS Transaction
RESTXT59(IEN59) ;
 I '$G(IEN59) Q ""
 Q $P($P($G(^BPST(IEN59,2)),U,2,99),";",1)
 ;
 ; LASTUP59 - Return last update date/time from BPS Transactions
LASTUP59(IEN59) ;
 I '$G(IEN59) Q ""
 Q $P($G(^BPST(IEN59,0)),U,8)
 ;
 ; STATUS59 returns STATUS field from BPS Transaction
 ; Note: 99 means complete
STATUS59(IEN59) ;
 I '$G(IEN59) Q ""
 Q $P($G(^BPST(IEN59,0)),U,2)
 ;
 ; SUBMIT59 - Return Submit date/time from BPS Transactions (#6) SUBMIT DATE/TIME
SUBMIT59(IEN59) ;
 I '$G(IEN59) Q ""
 Q $P($G(^BPST(IEN59,0)),U,7)
 ;
 ; Utilities
 ;
 ;  LOCKING:  Just one user of this routine at a time.
 ;  X = "SUBMIT" to interlock the request submission
 ;  X = "BACKGROUND" to interlock the background job
LOCK(X,TIMEOUT) ;EP - BPSOSRB
 I $G(TIMEOUT)="" S TIMEOUT=0
 L +^XTMP("BPS-PROC",X):TIMEOUT
 Q $T
 ;
LOCKNOW(X) ;EP - BPSOSRB
 L +^XTMP("BPS-PROC",X):0
 Q $T
 ;
UNLOCK(X) ;EP - BPSOSRB
 L -^XTMP("BPS-PROC",X)
 Q
 ;
RUNNING() ;
 I '$$LOCKNOW("BACKGROUND") Q  ; it is running; don't start another
 D UNLOCK("BACKGROUND") ; it's not running; release our probing lock
 D TASK
 Q
 ;
 ;KEY1 - Either Prescription IEN (#52) or PATIENT IEN (#2)
 ;KEY2 - Either Fill # or Policy Number
 ;       For Policy Number, the value passed in should be 9000 plus
 ;       the policy number
 ;BPCOBIND - COB indicator
IEN59(KEY1,KEY2,BPCOBIND) ;EP - from BPSOS, BPSOSRB
 I '$G(KEY1) Q ""
 I '$G(KEY2) S KEY2=0 ;If no KEY2, assume RX/Fill and default to Original Fill
 I +$G(BPCOBIND)=0 S BPCOBIND=1 ;default is primary
 I BPCOBIND>3!(BPCOBIND<1) Q ""
 Q KEY1_"."_$TR($J(KEY2,4)," ","0")_+BPCOBIND
 ;
 ;
 ; The background job
TASK N X,Y,%DT
 S X="N",%DT="ST"
 D ^%DT,TASKAT(Y)
 Q
 ;
TASKAT(ZTDTH) ;
 N ZTIO S ZTIO="" ; no device
 N ZTRTN S ZTRTN="BACKGR^BPSOSRB"
 D ^%ZTLOAD
 Q
 ;
 ;Lock key pair  - So two (or more) requests cannot be processed simultaneously
LOCKRF(KEY1,KEY2,BPTIMOUT,IEN59,BPSRC) ;EP - BPSOSRB
 N BPRET
 L +^XTMP("BPSOSRX-RX/REF",KEY1,KEY2):+$G(BPTIMOUT)
 S BPRET=$T
 Q BPRET
 ;
 ;UnLock key pair
UNLCKRF(KEY1,KEY2,IEN59,BPSRC) ;EP - BPSOSRB
 L -^XTMP("BPSOSRX-RX/REF",KEY1,KEY2)
 ;I $G(IEN59)>0 D LOG^BPSOSL(IEN59,$G(BPSRC)_"-Unlock keys: "_KEY1_"/"_KEY2)
 Q
 ;BPSOSRX
