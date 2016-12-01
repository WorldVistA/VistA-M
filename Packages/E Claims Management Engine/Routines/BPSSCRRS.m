BPSSCRRS ;BHAM ISC/SS - ECME SCREEN RESUBMIT ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8,10,11,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;IA 4702
 ;IA 5355 for call to $$RXBILL^IBNCPUT3
 ;
RES ;
 N BPRET,BPSARR59
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line numbers for the claim(s) to be resubmitted."
 S BPRET=$$ASKLINES^BPSSCRU4("Select item(s)","C",.BPSARR59,VALMAR)
 I BPRET="^" S VALMBCK="R" Q
 ;go thru all selected claims and try to resubmit them separately
 ;update the content of the screen and display it
 ;only if at least one claim was submitted successfully
 I $$RESUBMIT(.BPSARR59) D REDRAW^BPSSCRUD("Updating screen for resubmitted claims...")
 E  S VALMBCK="R"
 Q
 ;
RESNRV ; entry point for action protocol for Resubmit Claim Without Reversal (BPS*1*20)
 ; special variable BPRSNRV=1 when doing a resubmit w/o reversal.  The Resubmit will be done without
 ; regard to current claim status
 ;
 N BPRET,BPSARR59,BPRSNRV
 S BPRSNRV=1
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W "Resubmit Claim w/o Reversal"
 W !!?4,"Note: This action will resubmit claims without performing a reversal."
 W !!?10,"This action should be used in instances where the payer shows the"
 W !?10,"claim was reversed and VistA shows a payable claim. This action will"
 W !?10,"NOT submit a reversal regardless of the current VistA claim status."
 W !!,"Enter the line numbers for the claim(s) to be resubmitted w/o reversal."
 S BPRET=$$ASKLINES^BPSSCRU4("Select item(s)","C",.BPSARR59,VALMAR)
 I BPRET="^" S VALMBCK="R" Q
 ;go thru all selected claims and try to resubmit them separately
 ;update the content of the screen and display it
 ;only if at least one claim was submitted successfully
 I $$RESUBMIT(.BPSARR59,BPRSNRV) D REDRAW^BPSSCRUD("Updating screen for resubmitted claims...")
 E  S VALMBCK="R"
 Q
 ;
 ;/**
 ;go thru all selected claims and try to resubmit them separately
 ;input:
 ; RXI - array with ptrs to BPS TRANSACTION file (see ASKLINES^BPSSCRU4)
 ; BPRSNRV - optional flag indicating if resubmit action is a normal resubmit (default) or a resubmit w/o reversal
 ;         - BPRSNRV=0  for normal resubmit (default)
 ;         - BPRSNRV=1  for resubmit without a reversal
 ;returns 
 ; 0 - if no claims were resubmitted 
 ; 1 - if at least one claim was resubmitted 
RESUBMIT(RXI,BPRSNRV) ;*/
 N BPRVRSED ;was successfully reversed
 N BPRVNEED ;needs reversal
 N BPRVWAIT ;cycles of waiting 
 N BPRVRSNT ;reversal has been sent
 N WHERE,DOSDATE,BILLNUM,RXIEN,RXR,BPDFN
 N BP59
 N UPDATFLG,BPCLTOT,BPCLTOTR,BPSRSWHR,BPSRSRRS
 N BPQ,BPSCONT
 N BPSTATUS,BPSCOB,BPSPCLS,BPPRIOPN
 N REVCOUNT S REVCOUNT=0
 N BPIFANY S BPIFANY=0
 N BPINPROG S BPINPROG=0
 S BPCLTOT=0 ;total for resubmitted
 S BPCLTOTR=0 ;total for reversed, not resubmitted
 S UPDATFLG=0
 S BPRSNRV=+$G(BPRSNRV)     ; resubmit without reversal flag
 S BP59="",BPQ=""
 F  S BP59=$O(RXI(BP59)) Q:BP59=""  D  Q:BPQ="^"
 . I BPIFANY=0 W @IOF
 . S BPIFANY=1,BPQ=""
 . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . I 'BPRSNRV W !,"You've chosen to RESUBMIT the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 . I BPRSNRV W !,"You've chosen to RESUBMIT W/O REVERSAL the following Rx for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 . W !,@VALMAR@(+$G(RXI(BP59)),0)
 . S (BPRVNEED,BPRVRSED,BPRVWAIT,BPRVRSNT)=0
 . S BPQ=$$YESNO("Are you sure?(Y/N)")
 . I BPQ=-1 S BPQ="^" Q
 . I BPQ'=1 Q
 . ;
 . ; check for non-billable entry with the RER action (not allowed.  need to use regular RES)
 . I $$NB^BPSSCR03(BP59),BPRSNRV D  Q
 .. W !!,">> Cannot Resubmit w/o Reversal ",!,$G(@VALMAR@(+$G(RXI(BP59)),0))
 .. W !," because this is a NON BILLABLE entry. Please use the RES action instead.",!
 .. Q
 . ;
 . S RXIEN=$P(BP59,".")
 . S RXR=+$E($P(BP59,".",2),1,4)
 . I BPRVNEED=1&(BPRVRSED'=1) Q  ;cannot be resubmitted
 . ;
 . I $$RXDEL^BPSOS(+RXIEN,RXR) W !!,">> Cannot Reverse or Resubmit ",!,@VALMAR@(+$G(RXI(BP59)),0),!," because it has been deleted in Pharmacy.",! Q
 . ;
 . ;can't resubmit a closed claim. The user must reopen first.
 . I $$CLOSED^BPSSCRU1(BP59) D  Q
 . . W !!,">> Cannot Resubmit ",!,$G(@VALMAR@(+$G(RXI(BP59)),0)),!," because the claim is Closed. Reopen the claim and try again.",! Q
 . ;
 . S BPSTATUS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 . S BPSCOB=$$COB59^BPSUTIL2(BP59) ;get COB for the BPS TRANSACTION IEN
 . ;
 . ; check to see if any non-cancelled K# bills exist when doing a Resubmit w/o Reversal - BPS*1*20
 . I BPRSNRV D  I 'BPSCONT Q
 .. S BPSCONT=1                ; continue flag
 .. N BPG,BPSIB,IBIFN,IB
 .. S BPG=$$RXBILL^IBNCPUT3(RXIEN,RXR,$S(BPSCOB=1:"P",BPSCOB=2:"S",1:"T"),"",.BPSIB)     ; DBIA# 5355
 .. S IBIFN=0 F  S IBIFN=$O(BPSIB(IBIFN)) Q:'IBIFN  D
 ... S IB=$G(BPSIB(IBIFN))
 ... I $P(IB,U,2)="CB"!($P(IB,U,2)="CN") Q    ; cancelled bill in AR, these are OK so quit here
 ... S BPSCONT=0                              ; can't continue any longer, report on bill(s) found
 ... W !!?4,"Rx# ",$$RXNUM^BPSSCRU2(RXIEN)," was previously billed."
 ... W !?4,"Please review bill# ",$P(IB,U,1)," to determine if it should be cancelled."
 ... W !?4,"The claim cannot be resubmitted without a reversal to ECME unless the"
 ... W !?4,"existing bill is cancelled."
 ... W !!?4,"Cannot submit to ECME using Resubmit Claim w/o Reversal.",!
 ... Q
 .. Q
 . ;
 . I BPSCOB<2,$$PAYABLE^BPSOSRX5(BPSTATUS),BPINPROG=0,$$PAYBLSEC^BPSUTIL2(BP59) D  S BPQ=$$PAUSE^BPSSCRRV() Q
 . . W !,"The claim: ",!,$G(@VALMAR@(+$G(RXI(BP59)),0)),!,"cannot be Resubmitted if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 . ;
 . ;If this is a secondary, make sure Primary is either Payable or Closed.
 . S BPPRIOPN=0 I BPSCOB=2 D  Q:BPPRIOPN=1
 . . ;Get Primary claim status
 . . S BPSPCLS=$$FINDECLM^BPSPRRX5(RXIEN,RXR,1)
 . . I $P(BPSPCLS,U)>1 D
 . . . Q:$$CLOSED^BPSSCRU1($P(BPSPCLS,U,2))
 . . . W !,"The secondary claim cannot be Resubmitted unless the primary is either payable",!,"or closed. Please resubmit or close the primary claim first."
 . . . S BPPRIOPN=1
 . ;
 . I (BPSTATUS="IN PROGRESS")!(BPSTATUS="SCHEDULED") S BPINPROG=1
 . I BPINPROG=1 D  I $$YESNO^BPSSCRRS("Do you want to proceed?(Y/N)")=0 S BPQ="^" Q
 . . W !,"The claim is in progress. The request will be scheduled and processed after"
 . . W !,"the previous request(s) are completed. Please be aware that the result of "
 . . W !,"the resubmit depends on the payer's response to the prior incomplete requests."
 . ;
 . S DOSDATE=$$DOSDATE(RXIEN,RXR)
 . ;
 . ; set the ECME BWHERE value and the correct reversal reason value
 . I BPRSNRV S BPSRSWHR="ERWV",BPSRSRRS=""
 . I 'BPRSNRV,$$NB^BPSSCR03(BP59) S BPSRSWHR="ERNB",BPSRSRRS=""
 . I 'BPRSNRV,'$$NB^BPSSCR03(BP59) S BPSRSWHR="ERES",BPSRSRRS="ECME RESUBMIT"
 . ;
 . S BILLNUM=$$EN^BPSNCPDP(RXIEN,RXR,DOSDATE,BPSRSWHR,"",BPSRSRRS,,,,,BPSCOB)
 . ;
 . ;print return value message
 . W !!
 . W:+BILLNUM>0 $S(+BILLNUM=10:"Reversal but no Resubmit:",1:"Not Processed:"),!,"  "
 . ;Change Return Message for SC/EI
 . S:$P(BILLNUM,U,2)="NEEDS SC DETERMINATION" $P(BILLNUM,U,2)="NEEDS SC/EI DETERMINATION"
 . W $P(BILLNUM,U,2)
 . ;0 Prescription/Fill successfully submitted to ECME for claims processing
 . ;1 ECME did not submit prescription/fill
 . ;2 IB says prescription/fill is not ECME billable or the data returned from IB is not valid
 . ;3 ECME closed the claim but did not submit it to the payer
 . ;4 Unable to queue the ECME claim
 . ;5 Invalid input
 . ;10 Reversal but no resubmit
 . I +BILLNUM=0 D 
 . . D ECMEACT^PSOBPSU1(+RXIEN,+RXR,"Claim resubmitted to 3rd party payer: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 . . S UPDATFLG=1,BPCLTOT=BPCLTOT+1
 . I +BILLNUM=10 D 
 . . D ECMEACT^PSOBPSU1(+RXIEN,+RXR,"Claim reversed but not resubmitted: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 . . S UPDATFLG=1,BPCLTOTR=BPCLTOTR+1
 . ;
 . I +BILLNUM=2 S UPDATFLG=1    ; bps*1*20. Update the screen in the event of non-billable result.
 . Q
 ;
 W:BPIFANY=0 !,"No eligible items selected."
 W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been resubmitted.",!
 W:BPCLTOTR>0 !,BPCLTOTR," claim",$S(BPCLTOTR'=1:"s have",1:" has")," been reversed but not resubmitted.",!
 D PAUSE^VALM1
 Q UPDATFLG
 ;
 ; Ask
 ; Input:
 ;  BPQSTR - question
 ;  BPDFL - default answer
 ; Output: 
 ; 1 YES
 ; 0 NO
 ; -1 if cancelled
YESNO(BPQSTR,BPDFL) ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y"
 S DIR("A")=BPQSTR
 S:$L($G(BPDFL)) DIR("B")=BPDFL
 D ^DIR
 Q $S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 ;
DOSDATE(RXIEN,RXR) ;
 ; Function that returns the date of service
 ; Input
 ;   RXIEN - IEN in file #52
 ;   RXR - refill number
 ; Returns:
 ;   Date of Service
 N BPDOS,BPDT,TODAY
 ;
 ; Try release date
 S BPDOS=$$RXRLDT^PSOBPSUT($G(RXIEN),$G(RXR))
 ;
 ; If there is no release date, use the current day 
 S TODAY=$$DT^XLFDT
 I BPDOS=""!(BPDOS>TODAY) S BPDOS=TODAY
 Q BPDOS\1
 ;
 ;Function to get the Date of Service formatted for display
 ;  note: functionality replaces FILLDATE() which has been retired.
 ;input:
 ;  RXIEN - IEN in file #52
 ;  RXR   - refill number
 ;returns:
 ;  date of service or empty date if failure
DOSDT(RXIEN,RXR) ;
 N DOSDT
 S DOSDT=$$DOSDATE(RXIEN,RXR)
 I $L(DOSDT)'=7 Q "  /  "
 Q $E(DOSDT,4,5)_"/"_$E(DOSDT,6,7)
 ;
