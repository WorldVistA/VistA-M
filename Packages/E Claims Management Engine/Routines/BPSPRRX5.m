BPSPRRX5 ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;0-not found
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
 W !,"Drug name     NDC           Date  RX#           REF#    TYPE        STATUS"
 W !,"==========================================================================="
 W !,$$CLMINFO(BP59)
 Q
 ;
CLMINFO(BP59) ;
 N BPX,BPX1,BPCOB,BPSSTAT,BPPAYBLE
 S BPCOB=$$COB59^BPSUTIL2(BP59)
 S BPX1=$$RXREF^BPSSCRU2(BP59)
 S BPX=$$LJ^BPSSCR02($$DRGNAME^BPSSCRU2(BP59),12)_"  "_$$LJ^BPSSCR02($$NDC^BPSSCRU2(+BPX1,+$P(BPX1,U,2)),13)_" "
 S BPX=BPX_$$LJ^BPSSCR02($$FILLDATE^BPSSCRRS(+BPX1,+$P(BPX1,U,2)),5)_" "
 S BPX=BPX_$$LJ^BPSSCR02($$RXNUM^BPSSCRU2(+BPX1),11)_" "_+$P(BPX1,U,2)_"/"
 S BPX=BPX_$$LJ^BPSSCR02($$ECMENUM^BPSSCRU2(BP59),7)_" "_$$MWCNAME^BPSSCRU2($$GETMWC^BPSSCRU2(BP59))_" "
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
 ;submit secondary claim if no primary bills or e-claim
 ;BPDISPPR - display bill information for
 ; "1" - primary 
 ; "2" - secondary
 ; "1,2" - both
 ;
 ;Submission result (return value of EN^BPSNCPDP)
 ;Or one of the negative error codes:
 ; -100^Action cancelled
 ; -101^Existing e-claim
 ; -102^Claim in progress
 ; -103^Invalid or wrong bill#
 ; -104^Existing rejected/reversed e-claim
 ; -105^The same group plan selected
 ; -106^The primary insurer needs to be billed first.
 ; -107^Existing active bill
SECNOPRM(BPSRX,BPSRF,BPSDOS,BPSDFN,BPDISPPR) ;
 N BPSBINFO,BPSRXCOB,BPSINIEN,BPPAYSEQ,BPSECLM,BP2NDBIL,BPSRET,BPSQ,BPY,BPYDEF
 N BPSPLNSL,BPSECOND,BPRET,BPENGINE,BPSWHERE,BPSPLAN,BPSPL59,BPRTTP59,BPSARR
 N BPRESUBM S BPRESUBM=0 ;default = original submission
 ;check if there is the secondary e-claim
 S BPSECLM=$$FINDECLM^BPSPRRX5(BPSRX,BPSRF,2)
 I +BPSECLM=3 Q "-102^Claim in progress"
 I +BPSECLM=1 Q "-109^Existing PAYABLE e-claim. Please reverse it before resubmitting."
 S BPSQ=0
 I +BPSECLM=2 D  Q:BPSQ=1 "-100^Action cancelled"
 . D DISPECLM^BPSPRRX5(+$P(BPSECLM,U,2))
 . W !!,"There is an existing rejected/reversed secondary e-claim(s) for the RX/refill."
 . I $$YESNO^BPSSCRRS("Do you want to submit a new secondary claim(Y/N)","N")=1 S BPRESUBM=1
 . I BPRESUBM'=1 S BPSQ=1
 ; if not found or if existing rejected/reversed claim then continue , otherwise - quit
 ;I +BPSECLM'=0 Q "-101^Existing e-claim"
 ;prepopulate COB fields if this is a resubmit
 I BPRESUBM=1 I $$RES2NDCL^BPSPRRX6($$IEN59^BPSOSRX(BPSRX,BPSRF,2),.BPSPL59,.BPSECOND,.BPRTTP59)
 ;
 D  Q:+$P(BP2NDBIL,U,2)>0 "-107^Existing active secondary bill"
 . N BPSARR,BPS399,BPSCNT
 . ;check for the existing secondary bill
 . S BP2NDBIL=$$RXBILL^IBNCPUT3(BPSRX,BPSRF,"S",BPSDOS,.BPSARR)
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
 ; check for ePharmacy secondary ins policy
 S BPYDEF="N"
 I '$$SECINSCK^BPSPRRX(BPSDFN,BPSDOS) D
 . S BPYDEF="Y"
 . W !!,"Unable to find a secondary insurance policy which is e-Pharmacy billable."
 . W !,"You must correct this in order to continue.",!
 . Q
 ;
 ;ask the user if he wants to jump to the BCN PATIENT INSURANCE option
 S BPY=$$YESNO^BPSSCRRS("DO YOU WISH TO ADD/EDIT INSURANCE COMPANY DATA FOR THIS PATIENT?(Y/N)",BPYDEF)
 I BPY=1 D EN1^IBNCPDPI(BPSDFN)
 I BPY=-1 Q "-100^Action cancelled"
 ;
 I '$$SECINSCK^BPSPRRX(BPSDFN,BPSDOS) Q "-115^No Secondary e-Pharmacy Insurance Policy."
 ;
 S BPSECOND("PRIMARY BILL")="" ;no primary bill
 ; Note: BPSECOND("PRIMARY BILL") will be populated by the following call
 S BPRET=$$PRIMDATA^BPSPRRX4($$IEN59^BPSOSRX(BPSRX,BPSRF,1),.BPSECOND,1,BPRESUBM)
 I BPRET=0 D GETFR52^BPSPRRX4(BPSRX,BPSRF,.BPSECOND)
 ;
 I $$PROMPTS^BPSPRRX3(.BPSECOND)=-1 Q "-100^Action cancelled"
 I $$YESNO^BPSSCRRS("SUBMIT CLAIM TO "_$G(BPSECOND("INS NAME"))_" ?(Y/N)","Y")=0 Q "-100^Action cancelled"
 I BPRESUBM=0 S BPSWHERE=$S(BPSRF>0:"RF",1:"OF")
 ;set the flag that indicates that we should use new COB data to resubmit the secondary claim , 
 ;i.e. in BPSNCPDP the engine shouldn't use the COB data in BPS TRANSACTION for resubmit
 I BPRESUBM=1 S BPSECOND("NEW COB DATA")=1,BPSWHERE="ERES"
 S BPENGINE=$$SUBMCLM^BPSPRRX2(BPSECOND("PRESCRIPTION"),BPSECOND("FILL NUMBER"),BPSECOND("FILL DATE"),BPSWHERE,BPSECOND("BILLNDC"),2,BPSECOND("PLAN"),.BPSECOND,BPSECOND("RTYPE"))
 I +BPENGINE=4 W !!,$P(BPENGINE,U,2),!
 Q BPENGINE
 ;BPSPRRX5
