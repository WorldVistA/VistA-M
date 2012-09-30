BPSPRRX ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,9,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Entry point for the menu option [BPS COB PROCESS SECONDARY AND TRICARE CLAIMS]
 ;
EN1 ;
 N BPSRXN,BPS399,BPSZ,BPSQLOOP,BPPAYSEQ,BPSRET,BPS52,BPSRF,BPSDOS,BPSDFN
 N BPQLOOP2,BPSELIG,BPSPCLS,BP59,BPSEQ,BPSINS
 S BPSQLOOP=0
 S BPSRET=""
 F  D  Q:BPSQLOOP=1
 . ; Prompt for RX#
 . S BPSZ=$$PROMPTRX()
 . I +BPSZ=0 Q
 . I +BPSZ<0 S BPSQLOOP=1 Q
 . S BPSDFN=$P(BPSZ,U,4),BPSRXN=$P(BPSZ,U,3),BPS52=$P(BPSZ,U,2)
 . ;select refill
 . S BPSZ=$$RXREFIL^BPSPRRX6(BPS52,BPSDFN,BPSRXN)
 . I +BPSZ=-1 S BPSQLOOP=1 Q
 . S BPSRF=+BPSZ
 . S BPSDOS=$$DOSDATE^BPSSCRRS(BPS52,BPSRF)
 . ;
 . ;Verify that the patient has valid ePharmacy coverage for the DOS
 . I '$$INSUR^IBBAPI(BPSDFN,BPSDOS,"E",.BPSINS,"1,7,8") D  S BPSQLOOP=1 Q
 . . W !!,"Unable to find an ECME billable insurance policy within the"
 . . W !,"date of service for this RX/Fill. The patient insurance policy"
 . . W !,"must have a valid ePharmacy Group Plan associated with it."
 . . W !!,"You must correct this in order to continue.",!
 . . Q
 . ;
 . S BPQLOOP2=0
 . ;select payer sequence
 . F  D  Q:BPQLOOP2=1
 . . S BPPAYSEQ=$$SELCOB^BPSPRRX5("SELECT PAYER SEQUENCE","Select payer sequence for billing:")
 . . I +BPPAYSEQ=-1 S BPQLOOP2=1,BPSQLOOP=1 Q
 . . I +BPPAYSEQ'=1,(+BPPAYSEQ'=2) Q
 . . ;
 . . W !
 . . ;Make sure claim isn't closed
 . . S BP59=$$IEN59^BPSOSRX(BPS52,BPSRF,BPPAYSEQ)
 . . I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4)) D  Q
 . . . S BPSEQ=$S(BPPAYSEQ=1:"primary",1:"secondary")
 . . . W !!,"A ",BPSEQ," claim exists that is closed and cannot be Resubmitted.",!,"Please reopen the closed ",BPSEQ," claim to resubmit."
 . . . S BPQLOOP2=1 Q
 . . ;
 . . ;create primary claim for entered RX/refill
 . . I BPPAYSEQ=1 S BPSRET=$$PRI4RXRF(BPS52,BPSRF,BPSDOS,BPSDFN) D DISPLMES(BPSRET,1) S:(+BPSRET'<0)!(+BPSRET=-100) BPQLOOP2=1,BPSQLOOP=1 Q
 . . ;
 . . ;create secondary claim for entered RX/refill
 . . ;cannot bill non-released RX
 . . I BPPAYSEQ=2 I $$RELDATE^BPSBCKJ(BPS52,BPSRF)']"" D DISPLMES("-108^RX/refill not released") S BPQLOOP2=1 S:+BPSRET=-100 BPSQLOOP=1 Q
 . . I BPPAYSEQ=2 D  Q:BPQLOOP2=1
 . . . ;If this is a secondary, make sure Primary is either Payable or Closed.
 . . . ;Get Primary claim status 
 . . . S BPSPCLS=$$FINDECLM^BPSPRRX5(BPS52,BPSRF,1)
 . . . I $P(BPSPCLS,U)>1 D  Q:BPQLOOP2=1
 . . . . Q:$$CLOSED02^BPSSCR03($P($G(^BPST($P(BPSPCLS,U,2),0)),U,4))
 . . . . W !,"The secondary claim cannot be Submitted unless the primary is either payable",!,"or closed. Please resubmit or close the primary claim first."
 . . . . S BPQLOOP2=1 Q
 . . . S BPSRET=$$SEC4RXRF(BPS52,BPSRF,BPSDOS,$G(BPSDFN)) D DISPLMES(BPSRET,2) S:(+BPSRET'<0)!(+BPSRET=-100) BPQLOOP2=1,BPSQLOOP=1 Q
 ;
 Q
 ;
 ;create primary claim for entered RX/refill
PRI4RXRF(BPS52,BPSRF,BPSDOS,BPSDFN) ;
 N BPSECLM,BPNEWCLM,BPSARR,BPSQ,BPRESUBM
 ;check if there is a primary e-claim
 S BPSECLM=$$FINDECLM^BPSPRRX5(BPS52,BPSRF,1)
 I +BPSECLM=3 Q "-102^Claim in progress"
 I +BPSECLM=1 Q "-109^Existing PAYABLE e-claim. Please reverse it before resubmitting."
 S BPNEWCLM=0
 I +BPSECLM=2 D  I BPNEWCLM'=1 Q "-100^Action cancelled"
 . D DISPECLM^BPSPRRX5(+$P(BPSECLM,U,2))
 . W !!,"There is an existing rejected/reversed e-claim for the RX/refill."
 . S BPNEWCLM=$$YESNO^BPSSCRRS("Do you want to submit a new primary claim(Y/N)","N")
 ;
 ; if not found or if existing rejected/reversed claim then continue , otherwise - quit
 ;
 S BPSQ=0
 ;check for primary bill
 S BPSZ=$$RXBILL^IBNCPUT3(BPS52,BPSRF,"P","",.BPSARR)
 I +BPSZ>0,+$P(BPSZ,U,2)>0 Q "-107^Existing active primary bill #"_$P($G(BPSARR(+$P(BPSZ,U,2))),U,1)
 I +BPSZ>0,+$P(BPSZ,U,2)=0 D  I +BPSQ'=0 Q BPSQ
 . N BPS399,BPSCNT
 . S (BPSCNT,BPS399)=0
 . F  S BPS399=$O(BPSARR(BPS399)) Q:+BPS399=0  D
 . . N BPPSEQ,BPSRET
 . . S BPSCNT=BPSCNT+1
 . . S BPSRET=$P(BPSARR(BPS399),U,5)
 . . S BPPSEQ=$S(BPSRET="S":"Secondary",BPSRET="T":"Tertiary",BPSRET="P":"Primary",1:"Unknown")
 . . W:BPSCNT=1 !!,"Non-active primary bill(s) found:"
 . . D DISPBILL^BPSPRRX2(BPPSEQ,$P(BPSARR(BPS399),U,4),$P(BPSARR(BPS399),U,1),$P(BPSARR(BPS399),U,2),BPS52,BPSRF,$P(BPSARR(BPS399),U,3),(BPSCNT=1))
 . W !
 . I $$YESNO^BPSSCRRS("DO YOU WISH TO CREATE A NEW PRIMARY BILL ?(Y/N)","N")'=1 S BPSQ="-100^Action cancelled"
 Q $$PRIMARY^BPSPRRX4(BPS52,BPSRF,BPSDFN,BPSDOS,BPSECLM,BPNEWCLM)
 ;
 ;create secondary claim for entered RX/refill
SEC4RXRF(BPS52,BPSRF,BPSDOS,BPSDFN) ;
 N BPSARR,BPSRET,BPS399
 ;
 ; Try to find the primary bill
 S BPSRET=$$RXBILL^IBNCPUT3(BPS52,BPSRF,"P","",.BPSARR)
 ;
 ; SECNOPRM creates a secondary claim when there is no primary bill
 I +BPSRET=0 Q $$SECNOPRM^BPSPRRX5(BPS52,BPSRF,BPSDOS,$G(BPSDFN),"1,2")
 ;
 ; Get the active claim
 S BPS399=+$P(BPSRET,U,2)
 ;
 ; If no active claim, then get the most recent claim
 I BPS399'>0 S BPS399=+$O(BPSARR(999999999),-1)
 ;
 ; Check if there any secondary bills
 K BPSARR
 S BPSRET=$$RXBILL^IBNCPUT3(BPS52,BPSRF,"S","",.BPSARR)
 I +BPSRET>0,+$P(BPSRET,U,2)>0 Q "-107^Existing active secondary bill #"_$P($G(BPSARR(+$P(BPSRET,U,2))),U,1)
 ;
 ; Submit secondary claim when there is a primary bill
 Q $$SECONDRY(BPS52,BPSRF,BPSDOS,BPS399,"1,2")
 ;
DISPLMES(BPSZ,BPSPSEQ) ;
 ;Display messages
 ; -100^Action cancelled
 ; -101^Existing e-claim
 ; -102^Claim in progress
 ; -103^Invalid or wrong bill#
 ; -104^Existing rejected/reversed e-claim
 ; -105^The same group plan selected
 ; -107^Existing active bill
 ; -108^RX not released
 ; -109^Existing PAYABLE e-claim. Please reverse it before resubmitting.
 ; -110^No valid group insurance plans
 ;
 I BPSZ'<0 Q
 I +BPSZ=-100 W !!,$P(BPSZ,U,2),! Q
 I +$G(BPSPSEQ)=0 W !!,"Cannot submit e-claim:",!," ",$P(BPSZ,U,2),!
 I $G(BPSPSEQ)=2 D
 . I +BPSZ=-105 W !,"Select another plan - the plan selected has been used for primary billing",!! Q
 . W !,"Cannot submit secondary claim:",!," ",$P(BPSZ,U,2),!
 I $G(BPSPSEQ)=1 D
 . W !,"Cannot submit primary claim:",!," ",$P(BPSZ,U,2),!
 Q
 ;
SECONDRY(BPSRX,BPSRF,BPSDOS,BPS399,BPDISPPR) ;
 ;Submit a secondary claim if there is a primary bill
 ;Input:
 ;  BPSRX - Prescription IEN
 ;  BPSRF - Fill Number
 ;  BPSDOS - Date of Service
 ;  BPS399 - primary bill (ien of file #399)
 ;  BPDISPPR - display bill information for
 ;    "1" - primary 
 ;    "2" - secondary
 ;    "1,2" - both
 ;
 ;Submission result:
 ;  Return value of EN^BPSNCPDP or an error code/text
 ;    -100^Action cancelled
 ;    -101^Existing e-claim
 ;    -102^Claim in progress
 ;    -103^Invalid or wrong bill#
 ;    -104^Existing rejected/reversed e-claim
 ;    -105^The same group plan selected
 ;    -106^The primary insurer needs to be billed first.
 ;    -107^Existing active bill
 ;
 N BPSBINFO,BPSRXCOB,BPSINIEN,BPPAYSEQ,BPSECLM,BP2NDBIL,BPSDFN,BPSRET,BPRATTYP,BPSQ,BPY
 N BPSPLNSL,BPSECOND,BPSWHERE,BPSPLAN,BPSPL59,BPRTTP59,BPSARR,BPYDEF,BPRESUBM
 ;
 ;Default = original submission
 S BPRESUBM=0
 ;
 ;Get primary bill data
 S BPSRET=$$BILINF^IBNCPUT3(BPS399,.BPSBINFO)
 I +BPSRET=-1 Q "-103"_U_$P(BPSRET,U,2)
 ;
 S BPSDFN=+$P(BPSRET,U,2)
 S BPPAYSEQ=$S($P(BPSRET,U)="S":"Secondary",$P(BPSRET,U)="T":"Tertiary",$P(BPSRET,U)="P":"Primary",1:"Unknown")
 S BPSRXCOB=$S($P(BPSRET,U)="S":2,$P(BPSRET,U)="T":3,1:1)
 S BPSINIEN=BPSBINFO("INS IEN")
 ;
 ;Display primary bill data
 I $G(BPDISPPR)[1 D
 . W !,"Primary bill:"
 . D DISPBILL^BPSPRRX2(BPPAYSEQ,BPSBINFO("INS NAME"),BPSBINFO("BILL #"),BPSBINFO("AR STATUS"),BPSRX,BPSRF,"",1)
 . W !
 ;
 ;Check if there is the secondary ePharmacy claim
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
 ; Check for an existing secondary bill(s)
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
 I '$$SECINSCK(BPSDFN,BPSDOS) D
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
 ; If still no ePharmacy secondary ins policy, quit with error
 I '$$SECINSCK(BPSDFN,BPSDOS) Q "-115^No Secondary e-Pharmacy Insurance Policy."
 ;
 ; Get data from the primary claim, if it exists
 S BPSRET=$$PRIMDATA^BPSPRRX6(BPSRX,BPSRF,.BPSECOND)
 ;
 ; If the primary claim data is missing and this is a resubmit, get data from the most recent
 ;   secondary claim
 I 'BPSRET,BPRESUBM=1,$$SECDATA^BPSPRRX6(BPSRX,BPSRF,.BPSPL59,.BPSECOND,.BPRTTP59)
 ;
 ; Set the PRIMARY BILL array element with the bill selected by this procedure
 S BPSECOND("PRIMARY BILL")=BPS399
 ;
 ; Display the data and allow the user to edit
 I $$PROMPTS^BPSPRRX3(BPSRX,BPSRF,BPSDOS,.BPSECOND)=-1 Q "-100^Action cancelled"
 ;
 ; Continue?
 W !
 I $$YESNO^BPSSCRRS("SUBMIT CLAIM TO "_$G(BPSECOND("INS NAME"))_" ?(Y/N)","Y")'=1 Q "-100^Action cancelled"
 ;
 ; NEW COB DATA will indicate to BPSNCPDP that it should NOT rebuild the data from the BPS Transaction and
 ;   the previous secondary claim
 S BPSECOND("NEW COB DATA")=1
 ;
 ; Set BWHERE dependent on whether this is an original submission or a resubmit
 I BPRESUBM=0 S BPSWHERE="P2"
 I BPRESUBM=1 S BPSWHERE="P2S"
 ;
 ; Submit the claim
 S BPSRET=$$SUBMCLM^BPSPRRX2(BPSRX,BPSRF,BPSDOS,BPSWHERE,2,BPSECOND("PLAN"),.BPSECOND,BPSECOND("RTYPE"))
 I +BPSRET=4 W !!,$P(BPSRET,U,2),!
 Q BPSRET
 ;
PROMPTRX() ;
 ; Prompts for RX# and gets confirmation
 ;returns:
 ; 1^RXIEN^RX#^DFN - Successful
 ; 0 - Timeout or Quit by user
 ; -1 = User entered "^"
 N BPRET,BPSRX,BPSDFN,BPSPTNM,BPSRXN,BPSRXST,BPSDRUG,BPSDIC,BPSRXD
 N X,Y,DIQ,DR,DA,DIC,DTOUT,DUOUT
 S BPRET=0,(BPSDIC,DIC)=52,X=""
 S BPSDIC(0)="AENQ"
 W ! D DIC^PSODI(52,.BPSDIC,X) ;DBIA 4858
 I (Y=-1)!$D(DUOUT)!$D(DTOUT) Q +Y
 S (DA,BPSRX)=+Y,BPSRXN=$P(Y,U,2),DIQ="BPSRXD",DIQ(0)="IE",DR=".01;2;6;100"
 D DIQ^PSODI(52,DIC,DR,DA,.DIQ) ;DBIA 4858
 S BPSDFN=BPSRXD(52,DA,2,"I")
 S BPSPTNM=BPSRXD(52,DA,2,"E")
 S BPSDRUG=BPSRXD(52,DA,6,"E")
 S BPSRXST=BPSRXD(52,DA,100,"E")
 W !!,?1,"Patient",?25,"RX#",?37,"Drug Name",?63,"RX Status"
 W !,?1,$E(BPSPTNM,1,23),?25,$E(BPSRXN,1,11),?37,$E(BPSDRUG,1,25),?63,$E(BPSRXST,1,16),!
 Q $S($$YESNO^BPSSCRRS("DO YOU WANT TO CONTINUE?(Y/N)","Y")=1:1,1:0)_U_BPSRX_U_BPSRXN_U_BPSDFN
 ;
SECINSCK(DFN,DOS) ;
 ; secondary insurance check
 ; check to see if patient has at least one ePharmacy secondary insurance policy
 ; function value = 1 if there is one, 0 otherwise
 ;
 N OK,BPSRET,BPSINS,BPX
 S OK=0
 I '$G(DFN)!'$G(DOS) G SECINX
 S BPSRET=$$INSUR^IBBAPI(DFN,DOS,"E",.BPSINS,"1,7,8")
 I '$D(BPSINS) G SECINX
 S BPX=0 F  S BPX=$O(BPSINS("IBBAPI","INSUR",BPX)) Q:'BPX  D  Q:OK
 . I $P($G(BPSINS("IBBAPI","INSUR",BPX,7)),U,1)=2 S OK=1 Q
 . Q
SECINX ;
 Q OK
 ;
