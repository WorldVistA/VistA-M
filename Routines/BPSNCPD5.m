BPSNCPD5 ;ALB/SS - Pharmacy API part 5 ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;schedule a reversal for the future
 ; BPNEWREQ -by ref to return new BPS REQUEST ien
 ; BRXIEN - #52 ien
 ; BFILL -refill no
 ; BFILLDAT - Date of service
 ; BWHERE - see
 ; BILLNDC
 ; REVREAS
 ; DURREC
 ; BPOVRIEN
 ; BPSCLARF
 ; BPSAUTH
 ; IEN59
 ; BPCOBIND
 ; BPREVREQ - ien of the previous BPS REQUEST
 ; BPACTTYP - U - unclaim(reversal request), UC - reversal+resubmit, C - claim request
 ; BPSCLS - BPSCLOSE parameter of EN^BPSNCPDP
 ;returns:
 ; RESPONSE code^CLAMSTAT message^D(display message)^number of seconds to hang^IEN of the new request
 ; RESPONSE code = 0 - Submitted through ECME
 ; see EN^BPSNCPD4 for other RESPONSE values;
SCHREQ(BPNEWREQ,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPREVREQ,BPACTTYP,BPSCLS,BPSRTYPE,BPSPLAN,BPSPRDAT) ;
 N RESP,RESPONSE,MOREDATA,BPRETV
 N BPUSRMSG
 ;populate MOREDATA with basic data
 D BASICMOR^BPSOSRX8(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,.MOREDATA)
 I BPCOBIND=2 D MORE4SEC^BPSPRRX2(.MOREDATA,.BPSPRDAT) S MOREDATA("RTYPE")=$G(BPSRTYPE)
 ; if the user has chosen to close the claim after reversal
 ; BPSCLS contains the value of the BPSCLOSE parameter of EN^BPSNCPDP
 I $G(BPSCLS("CLOSE AFT REV"))=1 M MOREDATA=BPSCLS
 ; 
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Before Submit of Reversal")
 S BPSTART=$$STTM^BPSNCPD4()
 ;schedule a request
 S BPRETV=$$REQST^BPSOSRX(BPACTTYP,BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC),1)
 S BPNEWREQ=+$P(BPRETV,U,2)
 ;if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,4,.MOREDATA)
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 . L -^BPST
 ;if ok
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-BPS REQUEST: "_BPNEWREQ_" has been created")
 ;determine the last request
 I +$$NXTREQST^BPSOSRX6(BPREVREQ,BPNEWREQ)=0 D  Q $$RSPCLMS^BPSOSRX8("C",4,.MOREDATA)
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-Cannot make "_BPNEWREQ_"as a NEXT REQUEST in "_BPREVREQ)
 Q $$RSPCLMS^BPSOSRX8(BPACTTYP,0,.MOREDATA)_U_BPNEWREQ
 ;
 ;====== Schedule a reversal
 ;BPSCLS - BPSCLOSE parameter of EN^BPSNCPDP
REVERSAL(BPNEWREQ,BRXIEN,BFILL,OLDRESP,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPJOBFLG,BPACTTYP,BPSTART,BPREQIEN,BPSCLS,BPSRTYPE,BPSPRDAT) ;
 N RESP,RESPONSE,MOREDATA,BPRETV
 ;populate MOREDATA with basic data
 D BASICMOR^BPSOSRX8(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,.MOREDATA)
 I BPCOBIND=2 D MORE4SEC^BPSPRRX2(.MOREDATA,.BPSPRDAT) S MOREDATA("RTYPE")=$G(BPSRTYPE)
 ; if the user has chosen to close the claim after reversal
 ; BPSCLS contains the value of the BPSCLOSE parameter of EN^BPSNCPDP
 I $G(BPSCLS("CLOSE AFT REV"))=1 M MOREDATA=BPSCLS
 ;
 ; Do a reversal for the appropriate actions
 ; If override flag is set, prompt for override values - TEST ONLY
 ;
 I $$CHECK^BPSTEST D GETOVER^BPSTEST(BRXIEN,BFILL,OLDRESP,BWHERE,"R",BPCOBIND)
 ;
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Before Submit of Reversal")
 S BPSTART=$$STTM^BPSNCPD4()
 ;if background job
 I BPJOBFLG="B" S BPRETV=$$ACTIVATE^BPSNCPD4(BPREQIEN,"U") Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_$P(BPRETV,U,2)
 ;if foreground job then schedule an UNCLAIM request
 S BPRETV=$$REQST^BPSOSRX("U",BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC))
 S BPNEWREQ=+$P(BPRETV,U,2)
 ;if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,4,.MOREDATA)
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 . L -^BPST
 ;if ok
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-BPS REQUEST: "_BPNEWREQ_" has been created")
 ;activate the scheduled request
 S BPRETV=$$ACTIVATE^BPSNCPD4(BPNEWREQ,"U")
 Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_BPNEWREQ
 ;
 ;====== Process a brand new RX/RF, which never was processed by ECME yet
 ;returns:
 ; 0 - Submitted through ECME
 ; or 
 ; RESPONSE code^CLAMSTAT^D(display message)^number of seconds to hang^additional info
 ; see EN^BPSNCPD1 for RESPONSE values
NEWCLM(BPNEWREQ,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,BPSTART,BPREQIEN,BPSELIG,BPSRTYPE,BPSPLAN,BPSPRDAT) ;
 N BPSITE,BPECMOFF,BPSARRY,MOREDATA,IB,BPRETV,BPZRET,BPCLMST,CERTIEN,BPRESP
 I BPJOBFLG'="F",BPJOBFLG'="B" D LOG^BPSNCPD6(IEN59,$T(+0)_"-Job Flag missing") Q "5^Job Flag missing"  ;RESPONSE^CLMSTAT
 S BPCLMST=""
 I BPACTTYP'="C" Q "1^Prescription not previously billed through ECME. Cannot Reverse claim.^D^2"
 S BPSITE=+$$GETSITE^BPSOSRX8(BRXIEN,BFILL)
 ;check ECME availability
 S BPECMOFF=$$ECMESITE^BPSOSRX5(BPSITE) I +BPECMOFF=1 Q BPECMOFF
 ;populate MOREDATA with basic data
 D BASICMOR^BPSOSRX8(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,.MOREDATA)
 I BPCOBIND=2 D MORE4SEC^BPSPRRX2(.MOREDATA,.BPSPRDAT) S MOREDATA("RTYPE")=$G(BPSRTYPE)
 I $G(BPSRTYPE)'="" S MOREDATA("RTYPE")=$G(BPSRTYPE)
 ;Certification Testing
 ;sets:
 ; BILLNDC which is used in STARRAY^BPSNCPD1
 ; CERTIEN which is used in BILLABLE
 S BPRESP=$$CERTTEST^BPSNCPD4(.BILLNDC,.CERTIEN) I +BPRESP=1 Q BPRESP
 ;populate BPSARRY
 ;Note:
 ;the following is passed as backdoor parameters
 ; DFN - patient's IEN
 ; BILLNDC - NDC
 ; BFILLDAT - fill date
 D STARRAY^BPSNCPD1(BRXIEN,BFILL,BWHERE,.BPSARRY,BPSITE)
 S BPSARRY("RXCOB")=BPCOBIND
 S BPSARRY("PLAN")=$G(BPSPLAN),BPSARRY("RTYPE")=$G(BPSRTYPE) ;for secondary and Tricare/dual eligibility billing, to be used by RX^IBNCPDP
 ;Billing determination
 S IB=$$BILLABLE^BPSNCPD4(DFN,BWHERE,.MOREDATA,.BPSARRY,CERTIEN,.BPSELIG)
 ;if non-billable or no response from IB
 I +IB'=1 Q $P(IB,U,2,5)_"^D^"
 ;check IB data
 S BPRETV=$$IBDATAOK^BPSOSRX8(.MOREDATA,$G(BPSARRY("NO ECME INSURANCE"))) I BPRETV>0 Q BPRETV
 ; Log message to ECME log
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Before submit of claim")
 S BPSTART=$$STTM^BPSNCPD4()
 ;if background job
 I BPJOBFLG="B",+$G(BPREQIEN)=0 D  Q "5^BPS REQUEST IEN missing"  ;should never happen
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-BPS REQUEST IEN missing for background job. Claim cannot be processed.")
 I BPJOBFLG="B" D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_BPREQIEN
 . ;Update IB data
 . D UPDINSDT^BPSOSRX7(BPREQIEN,.MOREDATA,IEN59) ;
 . S BPRETV=$$ACTIVATE^BPSNCPD4(BPREQIEN,"C")
 ;if foreground job then schedule a CLAIM request
 ;
 ; If override flag is set, prompt for override values - TEST ONLY
 I $$CHECK^BPSTEST D GETOVER^BPSTEST(BRXIEN,BFILL,"",BWHERE,"S",BPCOBIND)
 ;
 S BPRETV=$$REQST^BPSOSRX("C",BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC))
 S BPNEWREQ=+$P(BPRETV,U,2)
 ;if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,4,.MOREDATA,$P(BPRETV,U,2))
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 ;if ok
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-BPS REQUEST: "_BPNEWREQ_" has been created")
 ;activate the scheduled request
 S BPRETV=$$ACTIVATE^BPSNCPD4(BPNEWREQ,"C")
 Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_BPNEWREQ
 ;
 ;Process RX/RF resubmit OR reversal+resubmit for non-payables
 ;returns:
 ; 0 - Submitted through ECME
 ; or 
 ; RESPONSE code^CLAMSTAT^D(display message)^number of seconds to hang^additional info
 ; see EN^BPSNCPDP for RESPONSE values
REVRESNP(BPNEWREQ,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,BPSTART,BPREQIEN,OLDRESP,BPSELIG,BPSRTYPE,BPSPLAN,BPSPRDAT) ;
 N BPSITE,BPECMOFF,BPSARRY,MOREDATA,IB,BPRETV,BPZRET,BPCLMST,CERTIEN,BPRESP
 I BPJOBFLG'="F",BPJOBFLG'="B" D LOG^BPSNCPD6(IEN59,$T(+0)_"-Job Flag missing") Q "5^Job Flag missing"  ;RESPONSE^CLMSTAT
 S BPCLMST=""
 I BPACTTYP="U" Q "1^Prescription is not payable. Cannot Reverse claim.^D^2"
 S BPSITE=+$$GETSITE^BPSOSRX8(BRXIEN,BFILL)
 ;check ECME availability
 S BPECMOFF=$$ECMESITE^BPSOSRX5(BPSITE) I +BPECMOFF=1 Q BPECMOFF
 ;
 ;populate MOREDATA with basic data
 D BASICMOR^BPSOSRX8(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,.MOREDATA)
 I BPCOBIND=2 D MORE4SEC^BPSPRRX2(.MOREDATA,.BPSPRDAT) S MOREDATA("RTYPE")=$G(BPSRTYPE)
 I $G(BPSRTYPE)'="" S MOREDATA("RTYPE")=$G(BPSRTYPE)
 ;Certification Testing
 ;sets:
 ; BILLNDC which is used in STARRAY^BPSNCPD1
 ; CERTIEN which is used in BILLABLE
 S BPRESP=$$CERTTEST^BPSNCPD4(.BILLNDC,.CERTIEN) I +BPRESP=1 Q BPRESP
 ;populate BPSARRY
 ;Note:
 ;the following is passed as backdoor parameters
 ; DFN - patient's IEN
 ; BILLNDC - NDC
 ; BFILLDAT - fill date
 D STARRAY^BPSNCPD1(BRXIEN,BFILL,BWHERE,.BPSARRY,BPSITE)
 S BPSARRY("RXCOB")=BPCOBIND
 S BPSARRY("PLAN")=$G(BPSPLAN),BPSARRY("RTYPE")=$G(BPSRTYPE) ;for secondary and Tricare/dual eligibility billing, to be used by RX^IBNCPDP
 ;set BPSARRY("SC/EI OVR") flag for scheduled requests
 I $G(BPJOBFLG)="B",$G(BPREQIEN) S BPSARRY("SC/EI OVR")=$P($G(^BPS(9002313.77,+$G(BPREQIEN),2)),U,9)
 ;Billing determination
 S IB=$$BILLABLE^BPSNCPD4(DFN,BWHERE,.MOREDATA,.BPSARRY,CERTIEN,.BPSELIG)
 ;if non-billable or no response from IB
 I +IB'=1 Q $P(IB,U,2,5)_"^D^"
 ;check IB data
 S BPRETV=$$IBDATAOK^BPSOSRX8(.MOREDATA,$G(BPSARRY("NO ECME INSURANCE"))) I BPRETV>0 Q BPRETV
 ; Log message to ECME log
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-Before submit of claim")
 S BPSTART=$$STTM^BPSNCPD4()
 ;if background job
 I BPJOBFLG="B" D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_$P(BPRETV,U,2)
 . ;Update IB data
 . D UPDINSDT^BPSOSRX7(BPREQIEN,.MOREDATA,IEN59) ;
 . S BPRETV=$$ACTIVATE^BPSNCPD4(BPREQIEN,"C")
 ;if foreground job then schedule a CLAIM request
 ;
 ; If override flag is set, prompt for override values - TEST ONLY
 I $$CHECK^BPSTEST D GETOVER^BPSTEST(BRXIEN,BFILL,OLDRESP,BWHERE,"S",BPCOBIND)
 ;
 S BPRETV=$$REQST^BPSOSRX("C",BRXIEN,BFILL,.MOREDATA,BPCOBIND,IEN59,$G(BILLNDC))
 S BPNEWREQ=+$P(BPRETV,U,2)
 ;if error
 I +BPRETV=0 D  Q $$RSPCLMS^BPSOSRX8(BPACTTYP,4,.MOREDATA,$P(BPRETV,U,2))
 . D LOG^BPSNCPD6(IEN59,$T(+0)_"-Create request error: "_$P(BPRETV,U,2)_". Claim Will Not Be submitted.")
 ;if ok
 D LOG^BPSNCPD6(IEN59,$T(+0)_"-BPS REQUEST: "_BPNEWREQ_" has been created")
 ;activate the scheduled request
 S BPRETV=$$ACTIVATE^BPSNCPD4(BPNEWREQ,"C")
 Q $$RSPCLMS^BPSOSRX8(BPACTTYP,+BPRETV,.MOREDATA)_U_BPNEWREQ
 ;
