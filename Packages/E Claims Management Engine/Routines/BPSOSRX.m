BPSOSRX ;BHAM ISC/FCS/DRS/FLS - callable from RPMS pharm ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; There are three callable entry points:
 ; $$REQST^BPSOSRX     Schedule claim/unclaim request
 ; $$STATUS^BPSOSRX    Inquire about a claim's status
 ; SHOWQ^BPSOSRX       Display queue of claims to be processed
 Q
 ;
 ; Schedule CLAIM or UNCLAIM request
 ; Process both types of requests - CLAIMs and UNCLAIMs
 ;
 ; Input: see MKRQST
 ; Return values:
 ;  1^BPS REQUEST ien = accepted for processing
 ;  0^reason = failure (should never happen)
REQST(BPREQTYP,RXI,RXR,MOREDATA,BPCOBIND,IEN59,BILLNDC,BPSKIP) ;
 N BPRETV,BPIEN77,BPIENS78
 S BPSKIP=+$G(BPSKIP)
 D LOG^BPSOSL(IEN59,$T(+0)_"- Start creating request")
 S BPRETV=$$MKINSUR^BPSOSRX2(RXI,RXR,.MOREDATA,.BPIENS78)
 I +BPRETV=0 Q BPRETV
 ;create BPS REQUEST records for primary insurer only and populate its IBDATA multiple with the iens of BPS INSURER DATA
 S BPRETV=$$MKRQST^BPSOSRX3(BPREQTYP,RXI,RXR,.MOREDATA,.BPIENS78,BPCOBIND,$G(BILLNDC),BPSKIP)
 Q BPRETV
 ;
 ; $$STATUS(RXI,RXR,QUE,BPRQIEN) - Returns the Status of the prescription/fill
 ; Input
 ;   RXI - Prescription IEN (required)
 ;   RXR - Refill Number (required)
 ;   QUE (optional):  0 - Do not check if a RX/fill is on the queue 
 ;         1/null - Check if RX/fill is on the queue
 ;   BPRQIEN (optional) -  the BPS REQUESTS (#9002313.77) IEN
 ;   BPCOB (optional)-the payer sequence (1- Primary, 2 Secondary), if null then 1 (primary) is assumed
 ;
 ; Returns
 ;    RESULT^LAST UPDATE DATE/TIME^DESCRIPTION^STATUS %
 ;    Returns null if there's no ECME record of this RX/fill
 ;
 ;    RESULT is either:
 ;      1. IN PROGRESS for incomplete claims
 ;      2. Final status for complete claims.  See comments for
 ;         BPSOSUC for complete list of possible statuses.
 ;      3. SCHEDULED for scheduled (not ACTIVATED yet) requests
 ;         
 ;    LAST UPDATE DATE/TIME is the Fileman date and time of the
 ;         last update to the status of this claim.
 ;         
 ;    DESCRIPTION is either:
 ;      1. Incomplete claims will be the status (i.e., Waiting to Start,
 ;         Transmitting)
 ;      2. Completed claims will have the reason that the ECME process
 ;         was aborted if the result is  E OTHER.  Otherwise, it will
 ;         be similar to the RESULT
 ;         
 ;    STATUS % is the completion percentage.  Note that 99 is considered
 ;         complete.
 ;         
 ;    
STATUS(RXI,RXR,QUE,BPRQIEN,BPCOB) ;
 ; Setup needed variables
 N IEN59,SDT,SUBDT,BP59REQ,BPTRTYP,BP59ZERO,BP59REQ
 I '$G(RXI) Q ""
 I $G(RXR)="" Q ""
 I $G(QUE)="" S QUE=1
 ;
 ;if BPRQIEN then it is called from BPSNCPD1 to display progress to the user. So we need to check queue anyway
 I $G(BPRQIEN)>0 S QUE=1
 ;
 ;default COB = primary
 I +$G(BPCOB)=0 S BPCOB=1
 ;
 ;get IEN of BPS TRANSACTION
 S IEN59=$$IEN59(RXI,RXR,BPCOB)
 ;
 ;read zeroth node of the BPS TRANSACTION record
 S BP59ZERO=$G(^BPST(IEN59,0))
 ;
 ;if doesn't have BPS TRANSACTION record AND doesn't have any BPS REQUEST records then
 ;this is an old claim OR it is not e-billable - so use the old logic,
 ;which was used before COB patch, so this is for primary claims only.
 I BPCOB=1 I $G(BPRQIEN)="" I BP59ZERO="" I '$D(^BPS(9002313.77,"D",RXI,RXR,BPCOB)) Q $$OLDSTAT^BPSOSRX6(RXI,RXR,$G(QUE))
 ;
 ;if doesn't have BPS TRANSACTION record (not created yet) AND has BPS REQUEST record(s)
 I BP59ZERO="" Q $$QUESTAT(RXI,RXR,BPCOB)
 ;
 ;get transaction type
 S BPTRTYP=$P(BP59ZERO,U,15)
 ;if Transaction type is not defined then this is an OLD claim so use the old logic
 ;which was used before COB patch, so this is for primary claims only.
 I BPCOB=1 I $G(BPRQIEN)="" I BPTRTYP="" Q $$OLDSTAT^BPSOSRX6(RXI,RXR,$G(QUE))
 ;
 ;get the current BPS REQUEST
 I BPTRTYP="C" S BP59REQ=$P(BP59ZERO,U,12)
 I BPTRTYP="U" S BP59REQ=$P($G(^BPST(IEN59,4)),U,5)
 I $G(BP59REQ)="" Q $$QUESTAT(RXI,RXR,BPCOB)
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
 ;   or the RX/fill is still on the queue, then change the response
 ;   to IN PROGRESS^Submit Date^WAITING TO START
 S SUBDT=$$SUBMIT59^BPSOSRX(IEN59)
 I SUBDT="" S SUBDT=T1
 ;
 ;if we need to check the queue
 I $G(QUE),$$QUETIME(RXI,RXR,BPCOB,1)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0)
 I $G(QUE),$$QUETIME(RXI,RXR,BPCOB,0)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0)
 I $G(QUE),$$QUETIME(RXI,RXR,BPCOB,2)>SUBDT S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0) ;To check IN PROCESS
 ;
 ; Return results
 Q A_U_T1_U_$E(C,1,255-$L(A)-$L(T1)-2)_U_S1
 ;
 ;the most current queue status as text
QUESTAT(RXI,RXR,BPCOB) ;
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,2)) Q "IN PROGRESS"_U_$$QUETIME(RXI,RXR,BPCOB,2)_U_$$STATI^BPSOSU(-96)_U_-1
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,1)) Q "IN PROGRESS"_U_$$QUETIME(RXI,RXR,BPCOB,1)_U_$$STATI^BPSOSU(0)_U_-1
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,0)) Q "IN PROGRESS"_U_$$QUETIME(RXI,RXR,BPCOB,0)_U_$$STATI^BPSOSU(-99)_U_-1
 ;if PROCESS FLAG=3,4,5 return null
 Q ""
 ;
 ;the most current queue status as process flag
QUECUR(RXI,RXR,BPCOB) ;
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,3)) Q 3
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,2)) Q 2
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,1)) Q 1
 I $D(^BPS(9002313.77,"D",RXI,RXR,BPCOB,0)) Q 0
 ;if PROCESS FLAG=3,4,5 return null
 Q ""
 ;
 ;the most current queue status as process flag
QUETIME(RXI,RXR,BPCOB,BPROCFL) ;
 N BP77
 S BP77=$O(^BPS(9002313.77,"D",RXI,RXR,BPCOB,BPROCFL,0))
 I BP77>0 Q $P($G(^BPS(9002313.77,+BP77,6)),U,1) ;REQUEST DATE AND TIME
 Q ""
 ;
 ; SHOWQ - Show RX/Fill on the Queue.  Since claims are generally processed
 ;   immediately, this report will generally have no output.
SHOWQ G SHOWQ^BPSOSR2
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
 ; RXRDEF - Get last refill
RXRDEF(RXI) ;
 I '$G(RXI) Q ""
 K ^TMP($J)
 N BPSPT S BPSPT=$$RXAPI1^BPSUTIL1(RXI,2,"I")
 I BPSPT="" Q ""
 D RX^PSO52API(BPSPT,"BPSREF",RXI,,"R")
 Q +$O(^TMP($J,"BPSREF",BPSPT,RXI,"RF",""),-1)
 ;
 ; Utilities
 ;
 ;  LOCKING:  Just one user of this routine at a time.
 ;  X = "SUBMIT" to interlock the claim submission
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
 ;RXI - #52 ien
 ;RXR - refill #
 ;BPCOBIND - COB indicator
IEN59(RXI,RXR,BPCOBIND) ;EP - from BPSOS, BPSOSRB
 I '$G(RXI) Q ""
 I '$G(RXR) S RXR=0
 I +$G(BPCOBIND)=0 S BPCOBIND=1 ;default is primary
 I BPCOBIND>3!(BPCOBIND<1) Q ""
 Q RXI_"."_$TR($J(RXR,4)," ","0")_+BPCOBIND
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
 ;Lock <Rx ien + refill#> pair  - So two (or more) requests for the same RX/refill (like payment and reverse) 
 ; cannot be processed simultaneously
LOCKRF(RXIEN,REFIL,BPTIMOUT,IEN59,BPSRC) ;EP - BPSOSRB
 N BPRET
 L +^XTMP("BPSOSRX-RX/REF",RXIEN,REFIL):+$G(BPTIMOUT)
 S BPRET=$T
 ;I $G(IEN59)>0 D LOG^BPSOSL(IEN59,$G(BPSRC)_$S(BPRET=1:"-Lock",1:"-Failed to Lock")_" RX/RF: "_RXIEN_"/"_REFIL)
 Q BPRET
 ;
 ;UnLock <Rx ien + refill#> pair
UNLCKRF(RXIEN,REFIL,IEN59,BPSRC) ;EP - BPSOSRB
 L -^XTMP("BPSOSRX-RX/REF",RXIEN,REFIL)
 ;I $G(IEN59)>0 D LOG^BPSOSL(IEN59,$G(BPSRC)_"-Unlock RX/RF: "_RXIEN_"/"_REFIL)
 Q
 ;BPSOSRX
