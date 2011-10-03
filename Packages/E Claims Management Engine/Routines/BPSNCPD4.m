BPSNCPD4 ;OAK/ELZ - Extension of BPSNCPDP ;4/16/08  17:07
 ;;1.0;E CLAIMS MGMT ENGINE;**6,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ; Certification Testing
CERTTEST(BILLNDC,CERTIEN) ;
 N QUIT,RESPONSE,CLMSTAT
 S RESPONSE=1,CLMSTAT=""
 ; If this is Certification Testing - ask questions
 S QUIT=0,CERTIEN=""
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ D  I QUIT S CLMSTAT="User exited from certification questions",RESPONSE=1 Q RESPONSE_U_CLMSTAT
C1 . R !,"ENTER NDC: ",BILLNDC:120 S:BILLNDC="^" QUIT=1 Q:QUIT  I BILLNDC="" G C1
C3 . R !,"CERTIFICATION ENTRY: ",CERTIEN:120 I '$D(^BPS(9002313.31,CERTIEN)) S:CERTIEN="^" QUIT=1 Q:QUIT  W !,"INVALID IEN" G C3
 I WFLG W !!
 Q 0
 ;
 ;== reversal+resubmit for payables
 ;returns:
 ; 0 - Submitted through ECME
 ; or 
 ; RESPONSE code^CLAMSTAT^D(display message)^number of seconds to hang^additional info
 ; see EN^BPSNCPD4 for RESPONSE values
REVRESUB(BPREVREQ,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,DFN,BPSTART,BPREQIEN,OLDRESP,BPSELIG,BPSRTYPE,BPSPLAN,BPSPRDAT) ;
 N BPSITE,BPECMOFF,BPSARRY,MOREDATA,IB,BPRETV,BPZRET,BPCLMST,BPONLREV,BPRETVAL,BPUSRMSG,CERTIEN,BPRESP,BPRETUNC
 I BPJOBFLG'="F",BPJOBFLG'="B" D LOG(IEN59,"Job Flag missing") Q "5^Job Flag missing"  ;RESPONSE^CLMSTAT
 I BPJOBFLG="B" D LOG(IEN59,"Reversal+Resubmit cannot be done in background") Q "5^Reversal+Resubmit cannot be done in background"  ;RESPONSE^CLMSTAT
 S BPCLMST="",BPONLREV=0,BPRESP=""
 ;
 S BPSITE=+$$GETSITE^BPSOSRX8(BRXIEN,BFILL)
 ;
 ;populate MOREDATA with basic data
 D BASICMOR^BPSOSRX8(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,.MOREDATA)
 I BPCOBIND=2 D MORE4SEC^BPSPRRX2(.MOREDATA,.BPSPRDAT) S MOREDATA("RTYPE")=$G(BPSRTYPE)
 ;
 ;Certification Testing
 ;sets:
 ; BILLNDC which is used in STARRAY^BPSNCPD1
 ; CERTIEN which is used in BILLABLE
 S BPRESP=$$CERTTEST(.BILLNDC,.CERTIEN) I +BPRESP=1 Q BPRESP
 ;populate BPSARRY
 ;Note:
 ;the following is passed as backdoor parameters
 ; DFN - patient's IEN
 ; BILLNDC - NDC
 ; BFILLDAT - fill date
 D STARRAY^BPSNCPD1(BRXIEN,BFILL,BWHERE,.BPSARRY,BPSITE)
 S BPSARRY("RXCOB")=BPCOBIND
 I BPCOBIND=2 S BPSARRY("PLAN")=$G(BPSPLAN),BPSARRY("RTYPE")=$G(BPSRTYPE) ;for secondary billing, to be used by RX^IBNCPDP
 ;Billing determination
 S IB=$$BILLABLE(DFN,BWHERE,.MOREDATA,.BPSARRY,CERTIEN,.BPSELIG)
 ;if no response from IB
 I +IB=0 Q $P(IB,U,2,5)
 ;if non-billable
 I +IB=2 S BPONLREV=1 ;set "ONLY REVERSAL IS POSSIBLE" flag
 ;Set the User message if necessary
 S BPUSRMSG=$S(BPONLREV=1:"Claim Will Be Reversed But Will Not Be Resubmitted",1:"")
 I BPONLREV=1 D LOG(IEN59,$P($G(MOREDATA("BILL")),"^",2)_" - "_BPUSRMSG)
 ;check IB data if it is billable
 I BPONLREV'=1 S BPRETV=$$IBDATAOK^BPSOSRX8(.MOREDATA,$G(BPSARRY("NO ECME INSURANCE"))) I BPRETV>0 Q BPRETV
 ;
 ;schedule request(s)
 ;
 ; If override flag is set, prompt for override values - TEST ONLY
 I $$CHECK^BPSTEST D
 . I BPONLREV=1 D GETOVER^BPSTEST(BRXIEN,BFILL,OLDRESP,BWHERE,"R",BPCOBIND) Q
 . ;if it is billable and we will doing resubmit
 . D GETOVER^BPSTEST(BRXIEN,BFILL,OLDRESP,BWHERE,"S",BPCOBIND)
 ;
 ;.... Step 1, Schedule a Reversal
 ; Log message to ECME log
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG(IEN59,"Before Submit of Reversal")
 S BPSTART=$$STTM()
 ;
 ;schedule an UNCLAIM request
 S BPRETV=$$REQST^BPSOSRX("U",BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC))
 S BPREVREQ=+$P(BPRETV,U,2) ;BPS REQUEST ien of  the reversal
 ;if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8("UC",4,.MOREDATA,$P(BPRETV,U,2))
 . D LOG(IEN59,"Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 . L -^BPST
 ;if ok
 D LOG(IEN59,"The request "_BPREVREQ_" has been created")
 ;if "Reversal only not resubmit" return appropriate RESPONSE and CLMSTAT, 
 ;store MOREDATA("BILL" for the "final CLMSTAT"
 ;and quit
 I BPONLREV=1 D  Q $$RSPCLMS^BPSOSRX8("UC",10,.MOREDATA)_U_$P($G(MOREDATA("BILL")),U,2)
 . ;activate the scheduled UNCLAIM request
 . S BPRETUNC=$$ACTIVATE(BPREVREQ,"U")
 ;
 ;.... Step 2, Schedule a Resubmit
 ; Log message to ECME log
 D LOG(IEN59,"Before submit of claim")
 S BPRETV=$$REQST^BPSOSRX("C",BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC))
 ; if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8("C",4,.MOREDATA)_U_BPUSRMSG
 . ;activate the scheduled UNCLAIM request
 . S BPRETUNC=$$ACTIVATE(BPREVREQ,"U")
 . D LOG(IEN59,"Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 . ;Set the User message if necessary
 . I +BPRETUNC=0 S BPUSRMSG="Cannot schedule resubmit: Claim Will Be Reversed But Will Not Be Resubmitted "
 ;if ok
 D LOG(IEN59,"BPS REQUEST: "_+$P(BPRETV,U,2)_" has been created")
 ;
 I +$$NXTREQST^BPSOSRX6(BPREVREQ,+$P(BPRETV,U,2))=0 D  Q $$RSPCLMS^BPSOSRX8("C",4,.MOREDATA)_U_BPUSRMSG
 . ;activate the scheduled UNCLAIM request
 . S BPRETUNC=$$ACTIVATE(BPREVREQ,"U")
 . D LOG(IEN59,"Cannot make "_+$P(BPRETV,U,2)_"as a NEXT REQUEST in "_BPREVREQ)
 . I +BPRETUNC=0 S BPUSRMSG="Cannot schedule resubmit: Claim Will Be Reversed But Will Not Be Resubmitted "
 ;
 ;activate the scheduled UNCLAIM request
 S BPRETUNC=$$ACTIVATE(BPREVREQ,"U")
 ; save RETVAL for the 2st step
 S BPRETVAL=$$RSPCLMS^BPSOSRX8("UC",+BPRETUNC,.MOREDATA)_U_$P(BPRETUNC,U,2)
 Q BPRETVAL_U_BPUSRMSG
 ;
 ;
 ;
 ;display submission results
 ;BPRETVAL - RESPONSE ^ CLAIMSTAT ^ flag:D-display on the screen ^ Hang time
DISPL(WFLG,BPRETVAL,BPELIGIB) ;
 N BPHANG
 ;if Tricare then shall print messages to the screen
 I $G(BPELIGIB)="T" S WFLG=1
 I WFLG=0 Q
 I $P(BPRETVAL,U,3)'="D" Q
 W !!,$P(BPRETVAL,U,2)
 W:+BPRETVAL'=0 !
 S BPHANG=+$P(BPRETVAL,U,4)
 I BPHANG>0 H BPHANG
 Q
 ;IB (billing) determination
 ;input:
 ;DFN - PATIENT file #2 ien
 ;BWHERE - shows where the code is called from and what needs to be done
 ;the following should be passed by reference:
 ;MOREDATA - Initialized by BPSNCPDP and more data is added here
 ;BPSARRY  - Created by STARRAY^BPSNCPD1 and used for IB Determination
 ;CERTIEN - BPS Certification IEN - Not passed but newed/set in BPSNCPDP, is used by EN^BPSNCPD2 as a backdoor parameter
 ;BPSELIG - to return eligibility, by ref
 ;output: 
 ;if billable :1
 ;no response : 0^RESPONSE code=2 or 6^CLMSTAT message^D(display message)^seconds to hang 
 ;non billable : 2^RESPONSE code=2 or 6^CLMSTAT message 
BILLABLE(DFN,BWHERE,MOREDATA,BPSARRY,CERTIEN,BPSELIG) ;
 N IB S IB=0
 D EN^BPSNCPD2(DFN,BWHERE,.MOREDATA,.BPSARRY,.IB)
 S BPSELIG=$G(MOREDATA("ELIG"))
 I IB=2 Q $S($G(BPSARRY("NO ECME INSURANCE")):"2^6^",1:"2^2^")_$P(MOREDATA("BILL"),"^",2)
 I (IB=0)!('$G(MOREDATA("BILL"))) Q $S($G(BPSARRY("NO ECME INSURANCE")):"0^6^",1:"0^2^")_"Flagged by IB to not 3rd Party Insurance bill through ECME.^D^2"
 Q 1
 ;activate the request
 ;returns:
 ; 0 - Submitted through ECME
 ; or 
 ; RESPONSE code^message^D(display message)^seconds to hang
 ; see EN^BPSNCPD4 for RESPONSE values
ACTIVATE(BPIEN77,BPACTYP) ;
 I +$G(BPIEN77)=0 Q "4^There is no request to activate"
 S BPACTYP=$S($G(BPACTYP)="C":"CLAIM",$G(BPACTYP)="U":"UNCLAIM",1:"")
 ;if there is no existing requests for the RX/RF then simply activate the new request
 I +$$ACTIVATE^BPSOSRX4(BPIEN77)=0 D INACTIVE^BPSOSRX4(BPIEN77) D  Q "4^Cannot ACTIVATE the scheduled """_BPACTYP_""" request^D^2"
 . D LOG(IEN59,"BPS REQUEST: "_+BPIEN77_" Cannot ACTIVATE the scheduled """_BPACTYP_""" request, it has been inactivated")
 Q "0"
 ;
 ;======== end of API
LOG(IEN59,MSG,BPDTFLG) ;
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_MSG,$G(BPDTFLG))
 Q
STTM() ;
 Q $$NOW^XLFDT
 ;
