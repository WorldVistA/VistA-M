BPSSCRRS ;BHAM ISC/SS - ECME SCREEN RESUBMIT ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;IA 4702
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
 ;/**
 ;go thru all selected claims and try to resubmit them separately
 ;input:
 ; RXI - array with ptrs to BPS TRANSACTION file (see ASKLINES^BPSSCRU4)
 ;returns 
 ; 0 - if no claims were resubmitted 
 ; 1 - if at least one claim was resubmitted 
RESUBMIT(RXI) ;*/
 N BPRVRSED ;was successfully reversed
 N BPRVNEED ;needs reversal
 N BPRVWAIT ;cycles of waiting 
 N BPRVRSNT ;reversal has been sent
 N WHERE,DOSDATE,BILLNUM,RXIEN,RXR,BPDFN
 N BP59
 N UPDATFLG,BPCLTOT,BPCLTOTR
 N BPQ,BPBILL
 N BPSTATUS
 N REVCOUNT S REVCOUNT=0
 N BPIFANY S BPIFANY=0
 N BPINPROG S BPINPROG=0
 S BPCLTOT=0 ;total for resubmitted
 S BPCLTOTR=0 ;total for reversed, not resubmitted
 S UPDATFLG=0
 S BP59="",BPQ=""
 F  S BP59=$O(RXI(BP59)) Q:BP59=""  D  Q:BPQ="^"
 . I BPIFANY=0 W @IOF
 . S BPIFANY=1,BPQ=""
 . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . W !,"You've chosen to RESUBMIT the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 . W !,@VALMAR@(+$G(RXI(BP59)),0)
 . S (BPRVNEED,BPRVRSED,BPRVWAIT,BPRVRSNT)=0
 . S BPQ=$$YESNO("Are you sure?(Y/N)")
 . I BPQ=-1 S BPQ="^" Q
 . I BPQ'=1 Q
 . S RXIEN=$P(BP59,".")
 . S RXR=+$E($P(BP59,".",2),1,4)
 . I BPRVNEED=1&(BPRVRSED'=1) Q  ;cannot be resubmitted
 . I $$RXDEL^BPSOS(+RXIEN,RXR) W !!,">> Cannot Reverse or Resubmit ",!,@VALMAR@(+$G(RXI(BP59)),0),!," because it has been deleted in Pharmacy.",! Q
 . ;can't resubmit a closed claim. The user must reopen first.
 . I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4))  D  Q
 . . W !!,">> Cannot Resubmit ",!,$G(@VALMAR@(+$G(RXI(BP59)),0)),!," because the claim is Closed. Reopen the claim and try again.",! Q
 . S BPSTATUS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 . I $P($G(^BPST(BP59,0)),U,14)<2,$$PAYABLE^BPSOSRX5(BPSTATUS),BPINPROG=0,$$PAYBLSEC^BPSUTIL2(BP59) D  S BPQ=$$PAUSE^BPSSCRRV() Q
 . . W !,"The claim: ",!,$G(@VALMAR@(+$G(RXI(BP59)),0)),!,"cannot be Resubmitted if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 . S BPBILL=0
 . ;I $P($G(^BPST(BP59,0)),U,14)=2 S BPBILL=$$PAYBLPRI^BPSUTIL2(BP59) I BPBILL=0 D  S BPQ=$$PAUSE^BPSSCRRV() Q
 . ;. W !,"The claim: ",!,$G(@VALMAR@(+$G(RXI(BP59)),0)),!,"cannot be Resubmitted if the primary is NOT payable.",!,"Please resubmit the primary claim first."
 . I (BPSTATUS="IN PROGRESS")!(BPSTATUS="SCHEDULED") S BPINPROG=1
 . I BPINPROG=1 D  I $$YESNO^BPSSCRRS("Do you want to proceed?(Y/N)")=0 S BPQ="^" Q
 . . W !,"The claim is in progress. The request will be scheduled and processed after"
 . . W !,"the previous request(s) are completed. Please be aware that the result of "
 . . W !,"the resubmit depends on the payer's response to the prior incomplete requests."
 . ;delete this I BPSTATUS["IN PROGRESS" W !!,">> Cannot Resubmit ",!,@VALMAR@(+$G(RXI(BP59)),0),!," because there is no response from the payer yet.",! Q
 . I $P($G(^BPST(BP59,9)),U,4)'="T" I BPINPROG=0,BPSTATUS["E REVERSAL REJECTED" W !!,">> Cannot Resubmit ",!,@VALMAR@(+$G(RXI(BP59)),0),!," because the REVERSAL was rejected.",! Q
 . I $P($G(^BPST(BP59,9)),U,4)'="T" I BPINPROG=0,BPSTATUS["E REVERSAL UNSTRANDED" W !!,">> Cannot Resubmit ",!,@VALMAR@(+$G(RXI(BP59)),0),!," because there is no response for reversal yet.",! Q
 . S DOSDATE=$$DOSDATE(RXIEN,RXR)
 . S BILLNUM=$$EN^BPSNCPDP(RXIEN,RXR,DOSDATE,"ERES","","ECME RESUBMIT",,,,,$$COB59^BPSUTIL2(BP59))
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
 . N BPSCOB S BPSCOB=$$COB59^BPSUTIL2(BP59) ;get COB for the BPS TRANSACTION IEN
 . I +BILLNUM=0 D 
 . . D ECMEACT^PSOBPSU1(+RXIEN,+RXR,"Claim resubmitted to 3rd party payer: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 . . S UPDATFLG=1,BPCLTOT=BPCLTOT+1
 . I +BILLNUM=10 D 
 . . D ECMEACT^PSOBPSU1(+RXIEN,+RXR,"Claim reversed but not resubmitted: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 . . S UPDATFLG=1,BPCLTOTR=BPCLTOTR+1
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
 ;Date of service
 ;RXIEN - IEN in file #52
 ;RXR - refill number
 ;returns:
 ; date of service
DOSDATE(RXIEN,RXR) ;
 N BPDOS,BPDT
 ;try release date
 S BPDOS=$$RXRLDT^PSOBPSUT(RXIEN,RXR)\1
 Q:+BPDOS>0 BPDOS
 ;try fill date
 S BPDOS=$$RXFLDT^PSOBPSUT(RXIEN,RXR)\1
 I '$G(DT) Q BPDOS
 I BPDOS>0,BPDOS'>DT Q BPDOS
 ;use current date (today)
 Q DT\1
 ;
 ;To display the FILL date on the screen
 ; use Date Of Service date , later on it might be changed
 ;input:
 ;RXIEN - IEN in file #52
 ;RXR - refill number
 ;returns:
 ; date of service
 ; or empty date if failure
FILLDATE(RXIEN,RXR) ;
 N DOSDT
 S DOSDT=$$DOSDATE(RXIEN,RXR)
 I $L(DOSDT)'=7 Q "  /  "
 Q $E(DOSDT,4,5)_"/"_$E(DOSDT,6,7)
 ;
