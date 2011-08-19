BPSNCPDP ;BHAM ISC/LJE/SS - API to submit a claim to ECME ;11/7/07  16:58
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,4,2,5,6,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; For comments regarding this API, see routine BPSNCPD3.
 ;
EN(BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,BPREQIEN,BPSCLOSE,BPSPLAN,BPSPRDAT,BPSRTYPE) ;
 N BPRETV,CLMSTAT,BRX,RESPONSE,BPSCOB,IEN59,DFN,PNAME,WFLG,BPLCK,BPACTTYP,BPRET,BPSQUIT
 N BPNEWCLM,OLDRESP,BPPAYABL,BPSTART,BPRESLT,BPSELIG,BP77NEW,BPTODAY,BPPREVRQ,BPSSTAT
 ; test not ecme active
 I '$$PROD^XUPROD,'$P($G(^BPS(9002313.99,1,0)),"^",3) Q "1^ECME switch is not on for the site"
 ;== Set default values and other required vars
 ; default is foreground ("F")
 S BPJOBFLG=$S($G(BPJOBFLG)="":"F",1:$G(BPJOBFLG))
 S RESPONSE="",CLMSTAT="",BP77NEW=0
 S BPLCK=0 ;0 - default for "B" jobs
 S REVREAS=$G(REVREAS),DURREC=$G(DURREC),BPSCLARF=$G(BPSCLARF),BPSAUTH=$G(BPSAUTH),BPOVRIEN=$G(BPOVRIEN)
 ; BPCOBIND will be used as a flag to indicate the following
 ;    If BPCOBIND>0 then the API is called for the particular COB claim
 ;    if BPCOBIND=0 then the API is called for a whole RX/RF - Outpatient Pharmacy doesn't care about COB
 ;         when the pharmacy user enters, deletes or edits RX/refills
 S BPCOBIND=+$G(BPCOBIND)
 ;
 ; BPSCOB variable will be used to store COB value (default is PRIMARY) in this function only
 S BPSCOB=$S(BPCOBIND>0:BPCOBIND,1:1)
 ; default is original fill
 I '$G(BFILL) S BFILL=0
 ; Get prescription number
 S BRX=$$RXAPI1^BPSUTIL1(BRXIEN,.01,"I")
 ; Make sure fill date is not in the future or empty
 S BPTODAY=$$TODAY^BPSOSRX5() I '$G(BFILLDAT)!($G(BFILLDAT)>BPTODAY) S BFILLDAT=BPTODAY
 ; Get the NDC if it was not passed in
 I $G(BILLNDC)="" S BILLNDC=$$GETNDC^PSONDCUT(BRXIEN,BFILL)
 ; Patient Info
 S DFN=$$RXAPI1^BPSUTIL1(BRXIEN,2,"I"),PNAME=$$GET1^DIQ(2,DFN,.01)
 ;
 ;== Check parameters and vars
 S BPRETV=$$CHCKPAR^BPSOSRX8($G(BRXIEN),$G(BRX),$G(BWHERE),$G(DFN),$G(PNAME),$G(BILLNDC)) I +BPRETV=0 S CLMSTAT=$P(BPRETV,U,2),RESPONSE=5 G END
 ;
 ; Calculate IEN59
 S IEN59=$$IEN59^BPSOSRX(BRXIEN,BFILL,BPSCOB) I IEN59="" S CLMSTAT="BPS Transaction IEN could not be calculated",RESPONSE=1 G END
 ;
 ;populate COB fields from BPS TRANSACTION to resubmit secondary claims from the User Screen
 ;if $G(BPSPRDAT("NEW COB DATA"))=1 then the resubmit requested from the BPS COB PROCESS SECOND TRICARE and the user can change the data
 I BPSCOB=2,$$ACTTYPE^BPSOSRX5(BWHERE)="UC",'$G(BPSPRDAT("NEW COB DATA")) N:$D(BPSRTYPE)=0 BPSRTYPE N:$D(BPSPLAN)=0 BPSPLAN N:$D(BPSPRDAT)=0 BPSPRDAT I $$RES2NDCL^BPSPRRX6(IEN59,.BPSPLAN,.BPSPRDAT,.BPSRTYPE)=0 D  G END
 . S CLMSTAT="Insufficient data to resubmit the secondary claim, use Process Secondary/Tricare Rx to ECME option.",RESPONSE=5
 ;
 ; Initialize log
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Start of claim","DT")
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Job flag = "_BPJOBFLG_$S(BPJOBFLG="B":" BPS REQUEST ien = "_$G(BPREQIEN),1:""))
 ;
 ; Check if we need to print the messages to the screen (WFLG=1 : YES)
 S WFLG=0
 S:BPJOBFLG="F" WFLG=$$PRINTSCR^BPSOSRX8(BWHERE)
 ;
 ;== LOCK RX/RF - only one action can be scheduled for the RX/RF at a time
 ;ONLY if BPJOBFLG="F" job! "B" jobs are called from REQST99^BPSOSRX5 and RX/RF should be already locked by this point
 ; get the lock for the RX/RF - so the STATUS99 cannot complete the request without activaing NEXT REQUEST
 I BPJOBFLG="F" S BPLCK=$$LOCKRF^BPSOSRX(BRXIEN,BFILL,10,$G(IEN59),$T(+0))
 I BPJOBFLG="F" I 'BPLCK S RESPONSE=4,CLMSTAT="BRXIEN,BFILL Locked" G END  ;two (or more) requests for the same RX/refill (like payment and reverse)
 ;
 ;== Determine the action type
 ;if foreground job then can be C,U and UC actions types
 S BPACTTYP=""
 I BPJOBFLG="F" S BPACTTYP=$$ACTTYPE^BPSOSRX5(BWHERE)
 ;if background/unqueueing job then only two action types are allowed - C and U
 I BPJOBFLG="B" D  I RESPONSE=5 G END
 . S BPACTTYP=$P($G(^BPS(9002313.77,+$G(BPREQIEN),1)),U,4)
 . I BPACTTYP="" S RESPONSE=5,CLMSTAT="Unknown Action type in BPS REQUEST ien="_BPREQIEN
 ;
 ;code to handle "general" submit/reversal as opposed to processing a claim for a specific payer sequence (primary, secondary)
 ;ECME and IB always know the payer sequence and always should set the proper BPCOBIND parameter
 ;thus if BPCOBIND=0 then the API is called by Pharmacy. If so then the CLAIM action (not reversal) should be done for primary only.
 S BPSQUIT=0
 I BPCOBIND=0 D  I BPSQUIT=1 S CLMSTAT="The secondary claim needs to be reversed first.",RESPONSE=5 G END
 . I BPACTTYP=""!(BPACTTYP="C") S BPCOBIND=1 Q
 . ;code to handle "general" reversal
 . N BPSECLM
 . ;check if there is the secondary e-claim
 . S BPSECLM=$$FINDECLM^BPSPRRX5(BRXIEN,BFILL,2)
 . ;quit if we have secondary claim and it is payable or in progress - it needs to be reversed first
 . I BPSECLM=1!(BPSECLM=3) S BPSQUIT=1
 . S BPCOBIND=1
 ;
 ;== IF BPJOBFLG="F" THEN determine if there are any scheduled/active/in process requests for the RX/RF 
 ;CHKREQST^BPSOSRX7 returns
 ; negative number^message : cannot be accepted for some reason 
 ; 0 : can be accepted because there are NO requests for this RX/RF, 
 ;      we will create a new record in BPS REQUEST for it and ACTIVATE it.
 ; 1 : there are ACTIVATED/IN PROCESS requests already for this RX/RF
 S BPPREVRQ="-10^Background queuing." ;default
 I BPJOBFLG="F" D  I BPPREVRQ'=0 G STATUS:RESPONSE=0,END:RESPONSE>0
 . S BPPREVRQ=$$CHKREQST^BPSOSRX7(BRXIEN,BFILL,.BPRESLT)
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-CHKREQ^BPSOSRX7 result: "_BPPREVRQ)
 . ;if error
 . I BPPREVRQ<0 S RESPONSE=4,CLMSTAT=$P(BPPREVRQ,U,2) D LOG^BPSNCPD6(IEN59,$T(+0)_"- - Cannot be accepted because of issues with already scheduled requests")
 . ;if there are prior requests for the RX/RF in the queue already then schedule additional request(s) 
 . ;for the future and quit since we do not know the result of prior requests 
 . I BPPREVRQ>0 D
 . . D LOG^BPSNCPD6(IEN59,$T(+0)_"-There are requests in the queue, do not process - schedule additional request(s)")
 . . I BPACTTYP="U" S BPRET=$$SCHREQ^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPPREVRQ,"U",.BPSCLOSE,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 . . I BPACTTYP="UC" D
 . . . S BPRET=$$SCHREQ^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPPREVRQ,"U",$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 . . . I +BPRET=0 S BPRET=$$SCHREQ^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BP77NEW,"C",$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 . . I BPACTTYP="C" S BPRET=$$SCHREQ^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPPREVRQ,"C",$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 . . I +BPRET=0 S RESPONSE=0,CLMSTAT=$P(BPRET,U,2) D LOG^BPSNCPD6(IEN59,$T(+0)_"-The new request(s) scheduled. The last one for the RX/RF now is: "_(BP77NEW)) Q
 . . I +BPRET>0 S RESPONSE=+BPRET,CLMSTAT=$P(BPRET,U,2) D LOG^BPSNCPD6(IEN59,$T(+0)_"-Cannot create request(s)")
 ;
 ;== So we can continue only if either 
 ;  BPJOBFLG="B" 
 ;  or 
 ;  BPJOBFLG="F" and BPPREVRQ=0
 ;
 ; If a new RX/RF - i.e. RX/RF was never processed thru ECME - process and quit
 S BPNEWCLM=$S(+$G(^BPST(IEN59,0)):0,1:1)
 ; get pre-existing RX/RFs status
 ;S OLDRESP=$P($$STATUS^BPSOSRX(BRXIEN,BFILL,0),U,1)
 S OLDRESP=$P($$STATUS^BPSOSRX(BRXIEN,BFILL,0,,BPSCOB),U,1)
 ; check if the payer IS going to PAY according the last response
 S BPPAYABL=$$PAYABLE^BPSOSRX5(OLDRESP)
 ; set starttime
 S BPSTART=$$STTM^BPSNCPD4()
 ;  
 ; if this is a new RX/RF
 I BPNEWCLM D NEWCLAIM^BPSNCPD6 G STATUS:RESPONSE=0,END:RESPONSE>0
 ;
 ; if we do not have a status for the previous claim AND this is not a reversal request - treat it as a new claim 
 I (OLDRESP=""),(BPACTTYP'="U") D NEWCLAIM^BPSNCPD6 G STATUS:RESPONSE=0,END:RESPONSE>0
 ;
 ; if we do not have a status for the pre-existing claim AND this is a reversal request - DO NOT reverse
 I (OLDRESP=""),(BPACTTYP="U") D RVNEW^BPSNCPD6 G END
 ;
 ;== Further below - all claims with some response (i.e. OLDRESP]""=1)
 ;
 ; if Back Billing - impossible
 I BWHERE="BB" D BB^BPSNCPD6 G END
 ;
 ; If returning to stock or deleting and the previous claim was not paid, then no reversal is needed
 ;   so close the prescription and quit
 ; Note: this is inherited "fuzzy logic" - 
 ; it checks only two statuses to determine that the claim "was not paid"
 I OLDRESP'["E PAYABLE",OLDRESP'["E REVERSAL REJECTED",(",RS,DE,"[(","_BWHERE_",")) D  G END
 . D CLOSE2^BPSBUTL(BRXIEN,BFILL,BWHERE)
 . S RESPONSE=3
 . S CLMSTAT="Claim was not payable so it has been closed.  No ECME claim created."
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-"_CLMSTAT)
 ;
 ; Reversals for Payable claims 
 ; (Note: BPSCLOSE can be used in this case only)
 I BPPAYABL,BPACTTYP="U" D RVPAID^BPSNCPD6 G STATUS:RESPONSE=0,END:RESPONSE>0
 ;
 ; Reversals+Resubmits for Payable claims
 I BPPAYABL,BPACTTYP="UC" D RVRSPAID^BPSNCPD6 G STATUS:((RESPONSE=0)!(RESPONSE=10)),END:RESPONSE>0
 ;
 ; Resubmits for Payable claims - DO NOT resubmit
 I BPPAYABL,BPACTTYP="C" D RSPAID^BPSNCPD6 G END
 ;
 ; Reversals for Non-Payable claims - DO NOT reverse
 I 'BPPAYABL,BPACTTYP="U" D RVNPAID^BPSNCPD6 G END
 ;
 ; Resubmits AND Reversals+Resubmits for Non-Payable claims
 I 'BPPAYABL,((BPACTTYP="C")!(BPACTTYP="UC")) D RVRSNPD^BPSNCPD6 G STATUS:RESPONSE=0,END:RESPONSE>0
 ;
 S RESPONSE=5,CLMSTAT="Unknown error"
 G END
 ;
 ;== Display status
STATUS ;
 ;if successful scheduling or/and activation of the request then make sure the background job is running
 I BPJOBFLG="F",BPLCK D UNLCKRF^BPSOSRX(BRXIEN,BFILL,$G(IEN59),$T(+0)) S BPLCK=0 ;to prevent unlocking in END
 I (RESPONSE=0)!(RESPONSE=10) D LOG^BPSNCPD6(IEN59,$T(+0)_"-Call RUNNING^BPSOSRX") D RUNNING^BPSOSRX()
 ;if Tricare then shall print messages to the screen
 I $G(BPSELIG)="T" S WFLG=1
 W:WFLG !!,"Processing ",$S(BPSCOB=1:"Primary claim...",BPSCOB=2:"Secondary claim...",1:"claim with Unknown Payer Sequence...") ;this can be deleted after testing
 I BPJOBFLG="F" D
 . I 'WFLG H 1
 . E  D STATUS^BPSNCPD1(BRXIEN,BFILL,+$G(BPPAYABL),$S(BPACTTYP="U":1,1:0),BPSTART,BWHERE,$G(BP77NEW),BPSCOB)
 ;
 ;== Clean up and quit
END ;
 I BPJOBFLG="F",BPLCK D UNLCKRF^BPSOSRX(BRXIEN,BFILL,$G(IEN59),$T(+0)) S BPLCK=0
 ;if foreground AND we can't schedule request for any reason AND this is not OP - send bulletin
 D:BPJOBFLG="F" SENDBUL^BPSOSRX8(RESPONSE,BWHERE,BRXIEN,BFILL,$G(SITE),$G(DFN),$G(PNAME),$G(CLMSTAT),$G(RESPONSE))
 I $G(BPSELIG)="" S BPSELIG=""
 ;I $G(BPSELIG)="" S BPSELIG=$$ELIG^BPSOSRX7(+$G(DFN))
 ; need to look up current status and return (mm if tricare in progress)
 S BPSSTAT=$S($G(BRXIEN):$P($$STATUS^BPSOSRX(BRXIEN,BFILL,,,BPSCOB),U),1:"")
 I BPSELIG="T",BPSSTAT="IN PROGRESS",$G(DURREC)'="RX RELEASE-NDC CHANGE" D BULL^BPSNCPD1(BRXIEN,BFILL,$G(SITE),$G(DFN),$G(PNAME),1)
 ;
 S:'$D(RESPONSE) RESPONSE=1
 K BRXIEN,BFILL,BFILLDAT,BWHERE,MOREDATA
 I $G(IEN59) D
 . N MSG
 . S MSG="Foreground Process Complete-RESPONSE="_$G(RESPONSE)
 . I $G(RESPONSE)'=0 S MSG=MSG_", CLMSTAT="_$G(CLMSTAT)
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-"_MSG)
 Q RESPONSE_U_$G(CLMSTAT)_U_BPSELIG_U_BPSSTAT_U_$$CLMINFO^BPSUTIL2(+$G(IEN59))
 ;
 ;BPSNCPDP
