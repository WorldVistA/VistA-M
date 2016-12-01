BPSPRRX5 ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,10,11,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ;select refill by fill date
SELREFIL(BPSARR,BPSPRMPT,BPSMESS) ;
 N BPSSTR,BPSCNT,DIR,X,Y
 S BPX=""
 S BPSCNT=0
 S DIR("A")=BPSPRMPT
 S DIR("L",1)=$G(BPSMESS)
 S DIR("L",2)=""
 S DIR("L",3)="   Fill   Date"
 S DIR("L",4)="   ====   =========="
 F  S BPX=$O(BPSARR(BPX)) Q:BPX=""  D
 . S BPSCNT=BPSCNT+1
 . S $P(BPSSTR,";",BPSCNT)=BPX_":"_$$FMTE^XLFDT($P($G(BPSARR(BPX)),U,2),"5Z")
 . S DIR("L",BPSCNT+4)="   "_BPX_"      "_$$FMTE^XLFDT($P($G(BPSARR(BPX)),U,2),"5Z")
 S DIR("L")="  "
 S DIR(0)="SO^"_BPSSTR
 D ^DIR
 I X="^" Q "-1^"
 I X="" Q ""
 Q BPSARR(+Y)
 ;
 ;check if there is any e-claim for this RX/refill
 ;BPSRXIEN-ien of file# 52
 ;BPSREF-refill #
 ;BPCOBIND - payer sequence (1 -primary, 2- secondary)
 ;Return value "CODE ^ IEN59  ^ ECME STATUS ^ "
 ;where
 ;CODE is one of the following:
 ;0-not found OR the entry found in BPS TRANSACTION is a non-billable entry
 ;1-payable
 ;2-not payable (rejected/reversed) 
 ;3-in progress (including scheduled requests)
 ;IEN59 is ien of the BPS TRANSACTION 
 ;ECME STATUS is the ECME claims status text like "E PAYABLE"
 ;
FINDECLM(BPSRXIEN,BPSREF,BPCOBIND) ;
 N BPS59,BPSSTAT,BPPAYBLE
 S BPS59=+$$IEN59^BPSOSRX(BPSRXIEN,BPSREF,BPCOBIND)
 I +$G(^BPST(BPS59,0))=0 Q 0
 I $$NB^BPSSCR03(BPS59) Q 0_U_BPS59_U     ; BPS*1*20 - non-billable entries return code 0 here
 S BPSSTAT=$P($$STATUS^BPSOSRX(BPSRXIEN,BPSREF,,,BPCOBIND),U)
 S BPPAYBLE=$$PAYABLE^BPSOSRX5(BPSSTAT)
 I BPSSTAT["IN PROGRESS" Q 3_U_BPS59_U_BPSSTAT
 I BPPAYBLE=1 Q 1_U_BPS59_U_BPSSTAT
 I BPPAYBLE=0 Q 2_U_BPS59_U_BPSSTAT
 Q 0
 ;
 ;Display e-claim details
 ;BPSIEN59-ien of the #9002313.59 BPS TRANSACTION file
DISPECLM(BP59) ;
 W !,"Drug name     NDC           DOS   RX#         FILL/ECME#     TYPE      STATUS"
 W !,"==============================================================================="
 W !,$$CLMINFO(BP59)
 Q
 ;
CLMINFO(BP59) ;
 N BPX,BPX1,BPCOB,BPSSTAT,BPPAYBLE,DOSDT
 S BPCOB=$$COB59^BPSUTIL2(BP59)
 S BPX1=$$RXREF^BPSSCRU2(BP59)
 S BPX=$$LJ^BPSSCR02($$DRGNAME^BPSSCRU2(BP59),12)_"  "_$$LJ^BPSSCR02($$NDC^BPSSCRU2(+BPX1,+$P(BPX1,U,2)),13)_" "
 ;
 ;SLT - BPS*1.0*11
 S DOSDT=$$LASTDOS^BPSUTIL2(BP59,0)
 ;
 S BPX=BPX_$$LJ^BPSSCR02(DOSDT,5)_" "
 S BPX=BPX_$$LJ^BPSSCR02($$RXNUM^BPSSCRU2(+BPX1),11)_" "_+$P(BPX1,U,2)_"/"
 S BPX=BPX_$$LJ^BPSSCR02($$ECMENUM^BPSSCRU2(BP59),12)_" "_$$MWCNAME^BPSSCRU2($$GETMWC^BPSSCRU2(BP59))_" "
 S BPX=BPX_$$RTBB^BPSSCRU2(BP59)_" "_$$RXST^BPSSCRU2(BP59)_"/"_$$RL^BPSSCRU2(BP59)
 S BPSSTAT=$P($$STATUS^BPSOSRX(+BPX1,+$P(BPX1,U,2),,,BPCOB),U)
 S BPPAYBLE=$$PAYABLE^BPSOSRX5(BPSSTAT)
 I BPPAYBLE Q BPX_" PAYABLE"
 I BPSSTAT["IN PROGRESS" Q BPX_" IN PROGRESS"
 I BPSSTAT["E REVERSAL ACCEPTED" Q BPX_" REVERSED"
 I BPSSTAT["E REJECTED" Q BPX_" REJECTED"
 Q BPX_" OTHER"
 ;
 ;get the plan (#355.3) from the BPS TRANSACTION file record
GETPL59(BP59) ;
 Q $P($G(^BPST(BP59,10,+$P($G(^BPST(BP59,9)),U,1),0)),U)
 ;
 ;get the RATE TYPE (#399.3) from the BPS TRANSACTION file record
GETRTP59(BP59) ;
 Q $P($G(^BPST(BP59,10,+$P($G(^BPST(BP59,9)),U,1),0)),U,8)
 ;
 ;get the primary bill (#399) from the BPS TRANSACTION file record
GETBIL59(BP59) ;
 Q $P($G(^BPST(BP59,10,+$P($G(^BPST(BP59,9)),U,1),2)),U,8)
 ;
SELCOB(BPSPRMPT,BPSMESS) ;
 N DIR,X,Y
 S DIR("A")=BPSPRMPT
 S DIR(0)="SO^1:PRIMARY;2:SECONDARY"
 S DIR("L",1)=BPSMESS
 S DIR("L",2)=""
 S DIR("L",3)="   1  PRIMARY"
 S DIR("L",4)="   2  SECONDARY"
 S DIR("L")=" "
 D ^DIR
 I X="^" Q "-1^"
 Q +Y
 ;
SECNOPRM(BPSRX,BPSRF,BPSDOS,BPSDFN,BPDISPPR) ;
 ;Submit a secondary claim if there is no primary claim
 ;Input:
 ;  BPSRX - Prescription IEN
 ;  BPSRF - Fill Number
 ;  BPSDOS - Date of Service
 ;  BPSDRN - Patient IEN
 ;  BPDISPPR - display bill information for
 ;    "1"   - primary 
 ;    "2"   - secondary
 ;    "1,2" - both
 ;
 ;Return Value:
 ;  Either the response from EN^BPSNCPDP or an error condition listed below
 ;     -100^Action cancelled
 ;     -101^Existing e-claim
 ;     -102^Claim in progress
 ;     -103^Invalid or wrong bill#
 ;     -104^Existing rejected/reversed e-claim
 ;     -105^The same group plan selected
 ;     -106^The primary insurer needs to be billed first.
 ;     -107^Existing active bill
 ;
 N BPSBINFO,BPSRXCOB,BPSINIEN,BPPAYSEQ,BPSECLM,BP2NDBIL,BPSRET,BPSQ,BPY,BPYDEF
 N BPSPLNSL,BPSECOND,BPSWHERE,BPSPLAN,BPSPL59,BPRTTP59,BPSARR,BPRESUBM
 ; 
 ;Default = original submission
 S BPRESUBM=0
 ;
 ; Check if there is the secondary claim
 S BPSECLM=$$FINDECLM^BPSPRRX5(BPSRX,BPSRF,2)
 I +BPSECLM=3 Q "-102^Claim in progress"
 I +BPSECLM=1 Q "-109^Existing PAYABLE e-claim. Please reverse it before resubmitting."
 S BPSQ=0
 I +BPSECLM=2 D  Q:BPSQ=1 "-100^Action cancelled"
 . D DISPECLM^BPSPRRX5(+$P(BPSECLM,U,2))
 . W !!,"There is an existing rejected/reversed secondary e-claim(s) for the RX/refill."
 . I $$YESNO^BPSSCRRS("Do you want to submit a new secondary claim(Y/N)","N")=1 S BPRESUBM=1
 . I BPRESUBM'=1 S BPSQ=1
 ;
 ; Check for active secondary bill(s)
 D  Q:+$P(BP2NDBIL,U,2)>0 "-107^Existing active secondary bill"
 . N BPSARR,BPS399,BPSCNT
 . ;check for the existing secondary bill
 . S BP2NDBIL=$$RXBILL^IBNCPUT3(BPSRX,BPSRF,"S","",.BPSARR)
 . I +BP2NDBIL=0 Q  ;not found
 . S BPS399=0
 . S BPSCNT=0
 . F  S BPS399=$O(BPSARR(BPS399)) Q:+BPS399=0  D
 . . N BPPSEQ
 . . S BPSCNT=BPSCNT+1
 . . I $G(BPDISPPR)[2 D
 . . . W:BPSCNT=1 !!,"Secondary bill(s) found:"
 . . . S BPSRET=$P(BPSARR(BPS399),U,5)
 . . . S BPPSEQ=$S($P(BPSRET,U)="S":"Secondary",$P(BPSRET,U)="T":"Tertiary",$P(BPSRET,U)="P":"Primary",1:"Unknown")
 . . . D DISPBILL^BPSPRRX2(BPPSEQ,$P(BPSARR(BPS399),U,4),$P(BPSARR(BPS399),U,1),$P(BPSARR(BPS399),U,2),BPSRX,BPSRF,$P(BPSARR(BPS399),U,3),(BPSCNT=1))
 . W !
 ;
 ; Check for ePharmacy secondary ins policy
 S BPYDEF="N"
 I '$$SECINSCK^BPSPRRX(BPSDFN,BPSDOS) D
 . S BPYDEF="Y"
 . W !!,"Unable to find a secondary insurance policy which is e-Pharmacy billable."
 . W !,"You must correct this in order to continue.",!
 . Q
 ;
 ; Ask the user if he wants to jump to the BCN PATIENT INSURANCE option
 S BPY=$$YESNO^BPSSCRRS("DO YOU WISH TO ADD/EDIT INSURANCE COMPANY DATA FOR THIS PATIENT?(Y/N)",BPYDEF)
 I BPY=1 D EN1^IBNCPDPI(BPSDFN)
 I BPY=-1 Q "-100^Action cancelled"
 ;
 ; Check for ePharmacy secondary ins policy (after possible edit)
 I '$$SECINSCK^BPSPRRX(BPSDFN,BPSDOS) Q "-115^No Secondary e-Pharmacy Insurance Policy."
 ;
 ; Get data from the primary claim, if it exists
 S BPSRET=$$PRIMDATA^BPSPRRX6(BPSRX,BPSRF,.BPSECOND)
 ;
 ; If the primary claim data is missing and this is a resubmit, get data from the most recent
 ;   secondary claim
 I 'BPSRET,BPRESUBM=1,$$SECDATA^BPSPRRX6(BPSRX,BPSRF,.BPSPL59,.BPSECOND,.BPRTTP59)
 ;
 ; No primary bill
 S BPSECOND("PRIMARY BILL")=""
 ;
 ; Display the data and allow the user to edit
 I $$PROMPTS^BPSPRRX3(BPSRX,BPSRF,BPSDOS,.BPSECOND)=-1 Q "-100^Action cancelled"
 ;
 ; Continue?
 W !
 I $$YESNO^BPSSCRRS("SUBMIT CLAIM TO "_$G(BPSECOND("INS NAME"))_" ?(Y/N)","Y")'=1 Q "-100^Action cancelled"
 ;
 ; Set the flag that indicates to BPSNCPDP that it should not recompile the data from BPS Transactions
 S BPSECOND("NEW COB DATA")=1
 ;
 ; Set BWHERE dependent on resubmit or not
 I BPRESUBM=0 S BPSWHERE="P2"
 I BPRESUBM=1 S BPSWHERE="P2S"
 ;
 ; Submit the claim
 S BPSRET=$$SUBMCLM^BPSPRRX2(BPSRX,BPSRF,BPSDOS,BPSWHERE,2,BPSECOND("PLAN"),.BPSECOND,BPSECOND("RTYPE"))
 I +BPSRET=4 W !!,$P(BPSRET,U,2),!
 Q BPSRET
 ;
GETOPPRA(BPSRESP,BPARR) ; get the Other Payer-Patient Responsibility Amount/Qualifier pairs from the Primary payer response
 ; BPS*1*20
 ;  Input:  BPSRESP - response file ien
 ; Output:  array BPARR (pass by reference)
 ;          BPARR = count of amount/qualifier pairs
 ;          BPARR(#) = AMOUNT ^ QUALIFIER
 ;
 ; This subroutine will gather specific dollar amounts from the response file and build the appropriate
 ; amount/qualifier pairs.
 ;   352-NQ   Other Payer-Patient Responsibility Amount
 ;   351-NP   Other Payer-Patient Responsibility Amount Qualifier (see the ECL for valid qualifiers)
 ;
 N AMT
 K BPARR
 S BPARR=0
 I '$G(BPSRESP) G GETPPX
 I '$D(^BPSR(BPSRESP,1000)) G GETPPX
 ;
 ; First check for patient pay amount (505-F5)  Qualifier 06.
 ; Per NCPDP implementation standard, when this exists, this is the only Other Payer-Pt Resp Amount pair. Count=1.
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,5))
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"06" G GETPPX     ; get out here if 505-F5 Qualifier 06 exists, we're done.
 ;
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,17))   ; 517-FH   Qualifier 01
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"01"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,130)),U,4))    ; 134-UK   Qualifier 02
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"02"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,23))   ; 523-FN   Qualifier 03
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"03"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,20))   ; 520-FK   Qualifier 04
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"04"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,18))   ; 518-FI   Qualifier 05
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"05"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,570)),U,2))    ; 572-4U   Qualifier 07
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"07"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,130)),U,5))    ; 135-UM   Qualifier 08
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"08"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,120)),U,9))    ; 129-UD   Qualifier 09
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"09"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,130)),U,3))    ; 133-UJ   Qualifier 10
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"10"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,130)),U,6))    ; 136-UN   Qualifier 11
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"11"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,130)),U,7))    ; 137-UP   Qualifier 12
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"12"
 S AMT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,570)),U,1))    ; 571-NZ   Qualifier 13
 I AMT S BPARR=BPARR+1,BPARR(BPARR)=AMT_U_"13"
 ;
GETPPX ;
 Q
 ;
 ;BPSPRRX5
