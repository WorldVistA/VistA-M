BPSOSRX6 ;ALB/SS - ECME REQUESTS ;02-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;to change the PROCESS FLAG status of the request
 ; BPIEN77 - BPS REQUEST ien
 ; BPSTAT - new PROCESS FLAG value
 ; returns
 ; 1^the BPIEN77
 ; or 
 ; 0^error message
CHNGPRFL(BPIEN77,BPSTAT) ;
 N BPNODES,RXI,RXR
 S BPNODES(0)=$G(^BPS(9002313.77,BPIEN77,0))
 S RXI=+$P(BPNODES(0),U)
 S RXR=+$P(BPNODES(0),U,2)
 I '$G(RXI) Q "0^RX null error"
 I '$G(RXR) S RXR=0
 I $$FILLFLDS^BPSUTIL2(9002313.77,".04",BPIEN77,BPSTAT)<1 Q "0^Cannot update field #.04 (PROCESS FLAG) in BPS REQUEST"
 ;update user and time
 Q $$UPUSRTIM(BPIEN77,+$G(MOREDATA("USER")))
 ;
 ;to set NEXT REQUEST field
 ; BPIEN77 - BPS REQUEST ien
 ; BPNXTREQ - the NEXT REQUEST ien 
 ; returns
 ; 1^the BPIEN77
 ; or 
 ; 0^error message
NXTREQST(BPIEN77,BPNXTREQ) ;
 N BPNODES,RXI,RXR
 S BPNODES(0)=$G(^BPS(9002313.77,BPIEN77,0))
 S RXI=+$P(BPNODES(0),U)
 S RXR=+$P(BPNODES(0),U,2)
 I '$G(RXI) Q "0^RX null error"
 I '$G(RXR) S RXR=0
 I BPIEN77=BPNXTREQ Q "0^Next and current requests cannot be the same"
 I $$FILLFLDS^BPSUTIL2(9002313.77,".05",BPIEN77,BPNXTREQ)<1 Q "0^Cannot update field #.05 (NEXT REQUEST) in BPS REQUEST"
 ;update user and time and quit (return 1^ien77 if success)
 Q $$UPUSRTIM(BPIEN77,+$G(MOREDATA("USER")))
 ;
 ;any active requests for the RX/refill? = scheduled,activated,in process,comleted but not activated yet
 ;BPSRX - ien #52
 ;BPSRF - refill no
 ;BPCOB - COB (payer sequence)
 ;returns
 ;1 - yes
 ;0 -no
ACTREQS(BPSRX,BPSRF,BPCOB) ;
 N BPZZ,BPACTRQ
 S BPACTRQ=0
 F BPZZ=0,1,2,3 I $G(^BPS(9002313.77,"AC",BPZZ,BPSRX,BPSRF))=BPCOB S BPACTRQ=1 Q:BPACTRQ=1
 Q BPACTRQ
 ;update time and user id
 ;BPIEN77 - BPS REQUEST ien
 ;BPUSER - user's DUZ
 ;returns 1^BPIEN77
 ;or 0^error message
UPUSRTIM(BPIEN77,BPUSER) ;
 I $$FILLFLDS^BPSUTIL2(9002313.77,"6.05",BPIEN77,+$$NOW^BPSOSRX())<1 Q "0^Cannot update the field #6.05 in BPS REQUEST"  ;S SUBMITDT=$$NOW
 I $$FILLFLDS^BPSUTIL2(9002313.77,"6.06",BPIEN77,+BPUSER)<1 Q "0^Cannot update the field #6.06 in BPS REQUEST"  ;USER
 Q "1^"_BPIEN77
 ;remove all active requests for the RX/refill
DELACTRQ(BPSRX,BPSRF) ;
 N BP77
 F BPZZ=0,1,2,3 D
 . S BP77=0 F  S BP77=$O(^BPS(9002313.77,"AC",BPZZ,BPSRX,BPSRF,BP77)) Q:+BP77=0  D
 . . D DELREQST^BPSOSRX4(BP77)
 Q
 ;Old status logic - to process claims that were submitted before Processing queue mods
OLDSTAT(RXI,RXR,QUE) ;
 ;
 ; Setup needed variables
 N IEN59,SDT,A,SUBDT
 I '$G(RXI) Q ""
 I $G(RXR)="" Q ""
 I $G(QUE)="" S QUE=1
 S IEN59=$$IEN59^BPSOSRX(RXI,RXR)
 S SDT=$G(^XTMP("BPSOSRX",RXI,RXR))
 ;
 ; ECME record not created
 I '$D(^BPST(IEN59)) D  Q A
 . I QUE,SDT S A="IN PROGRESS"_U_SDT_U_$$STATI^BPSOSU(0)_U_-1 Q
 . I QUE,$D(^XTMP("BPS-PROC","CLAIM",RXI,RXR)) S A="IN PROGRESS"_U_SDT_U_$$STATI^BPSOSU(0)_U_-1 Q
 . S A=""
 ;
 ; Loop: Get data, quit if times and status match (no change during gather)
 N C,T1,T2,S1,S2 F  D  I T1=T2,S1=S2 Q
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
 I $G(QUE),SDT>SUBDT!($D(^XTMP("BPS-PROC","CLAIM",RXI,RXR)))!($D(^XTMP("BPS-PROC","UNCLAIM",RXI,RXR))) S A="IN PROGRESS",T1=SDT,S1=-1,C=$$STATI^BPSOSU(0)
 ;
 ; When finishing the reversal of a Reversal/Resubmit, display IN PROGRESS
 I $P($G(^BPST(IEN59,1)),"^",12)=1,S1=99 S A="IN PROGRESS",S1=98,C=$$STATI^BPSOSU(S1)
 ;
 ; Return results
 Q A_U_T1_U_$E(C,1,255-$L(A)-$L(T1)-2)_U_S1
 ;
 ;check for duplicates and determine the NEXT REQUEST
 ;BP77 - the current request (ien of #9002313.77)
 ;BPDEL=1 - delete duplicates
 ;BPUPDNXT=1 - update the NEXT REQUEST field of the current request after skipping (deleting) duplicates
 ;(Note - if BPDEL=1 then BPUPDNXT will be set to 1 to avoid "hanging" requests
 ;BP59 - (optional) the ien of BPS TRANSACTION file
 ;Returns the next request or NULL (if there is no next request)
GETNXREQ(BP77,BPDEL,BPUPDNXT,BP59) ;
 N BPCUR,BPCURTYP,BPARRDEL
 N BPNXT77,BPTYPNXT,BP77DEL
 S BPCUR=BP77,BPCURTYP=$P($G(^BPS(9002313.77,BP77,1)),U,4)
 F  D  Q:BPNXT77=0  Q:BPCURTYP'=BPTYPNXT  S BPCUR=BPNXT77,BPCURTYP=BPTYPNXT,BPARRDEL(BPNXT77)=""
 . S BPNXT77=+$P($G(^BPS(9002313.77,BPCUR,0)),U,5)
 . Q:BPNXT77=0
 . S BPTYPNXT=$P($G(^BPS(9002313.77,BPNXT77,1)),U,4)
 ;if nothing to skip then quit now
 I '$O(BPARRDEL("")) Q BPNXT77
 ; delete duplicates
 I $G(BPDEL)=1 S BP77DEL=0 F  S BP77DEL=$O(BPARRDEL(BP77DEL)) Q:+BP77DEL=0  D
 . I $G(BP59)>0 D LOG^BPSOSL(BP59,$T(+0)_"-Delete the duplicate request "_BP77DEL)
 . D DELREQST^BPSOSRX4(BP77DEL)
 I $G(BPDEL)=1 S BPUPDNXT=1
 I $G(BPUPDNXT)=1 D
 . I $$FILLFLDS^BPSUTIL2(9002313.77,".05",BP77,BPNXT77)<1 D
 . . I $G(BP59)>0 D LOG^BPSOSL(BP59,$T(+0)_"-Cannot update field #.05 (NEXT REQUEST) in BPS REQUEST")
 . I $G(BP59)>0 D LOG^BPSOSL(BP59,$T(+0)_"-Update field #.05 (NEXT REQUEST) to "_BPNXT77_" in the request #"_BP77)
 ;return the NEXT request
 Q BPNXT77
 ;BPSOSRX6
 ;
