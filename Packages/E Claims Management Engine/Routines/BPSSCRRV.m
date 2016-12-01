BPSSCRRV ;BHAM ISC/SS - ECME SCREEN REVERSE CLAIM ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;IA 4702
 ;
REV ;entry point for "Reverse" menu item
 N BPRET,BPSARR59
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line numbers for the Payable claim(s) to be Reversed."
 S BPRET=$$ASKLINES^BPSSCRU4("Select item(s)","C",.BPSARR59,VALMAR)
 I BPRET="^" S VALMBCK="R" Q
 ;reverse selected lines
 ;update the content of the screen and display it
 ;only if at least one reversal was submitted successfully
 I $$RVLINES(.BPSARR59)>0 D REDRAW^BPSSCRUD("Updating screen for reversed claims...")
 E  S VALMBCK="R"
 Q
 ;/**
 ;Reverse selected lines
 ;input: 
 ; BP59ARR(BP59)="line# in LM array "
 ;output:
 ; REVTOTAL - total number of claims for whose the reversal was submitted successfully  
RVLINES(BP59ARR) ;*/
 N BP59,REVTOTAL,BPRVREAS,BPDFN,BPQ,IBD,BPRXRF
 N BPINPROG S BPINPROG=0
 N BPIFANY S BPIFANY=0
 N BPSTATS
 S REVTOTAL=0,BPQ=""
 S BP59="" F  S BP59=$O(BP59ARR(BP59)) Q:BP59=""  D  Q:BPQ="^"
 . I BPIFANY=0 W @IOF
 . S BPIFANY=1,BPQ=""
 . ;
 . ; don't allow reverse for non-billable entries
 . I $$NB^BPSSCR03(BP59) D  S BPQ=$$PAUSE() Q
 .. W !,"The claim: ",!,$G(@VALMAR@(+$G(BP59ARR(BP59)),0)),!,"Entry is NON BILLABLE.  There is no claim to reverse."
 .. Q
 . ;
 . ; can't reverse a closed claim. The user must reopen first.
 . I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4))  D  S BPQ=$$PAUSE() Q
 . . W !,"The claim: ",!,$G(@VALMAR@(+$G(BP59ARR(BP59)),0)),!,"is Closed and cannot be Reversed. Reopen the claim and try again."
 . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . S BPSTATS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 . I (BPSTATS="IN PROGRESS")!(BPSTATS="SCHEDULED") S BPINPROG=1
 . I BPINPROG=0,'$$PAYABLE^BPSOSRX5(BPSTATS) D  S BPQ=$$PAUSE() Q
 . . W !,"The claim: ",!,$G(@VALMAR@(+$G(BP59ARR(BP59)),0)),!,"is NOT Payable and cannot be Reversed."
 . I BPINPROG=0,$P($G(^BPST(BP59,0)),U,14)<2,$$PAYBLSEC^BPSUTIL2(BP59) D  S BPQ=$$PAUSE() Q
 . . W !,"The claim: ",!,$G(@VALMAR@(+$G(BP59ARR(BP59)),0)),!,"cannot be Reversed if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 . I BPINPROG=1 D  S BPQ=$$YESNO^BPSSCRRS("Do you want to proceed?(Y/N)") I BPQ<1 S BPQ="^" Q
 . . W !,"The claim you've chosen to REVERSE for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 . . W !,$G(@VALMAR@(+$G(BP59ARR(BP59)),0))
 . . W !,"is in progress. The reversal request will be scheduled and processed after"
 . . W !,"the previous request(s) are completed. Please be aware that the result of "
 . . W !,"the reversal depends on the payer's response to the prior incomplete requests."
 . I BPINPROG=0 D
 . . W !,"You've chosen to REVERSE the following prescription for "_$E($$PATNAME^BPSSCRU2(BPDFN),1,13)
 . . W !,$G(@VALMAR@(+$G(BP59ARR(BP59)),0))
 . F  S BPRVREAS=$$COMMENT^BPSSCRCL("Enter REQUIRED REVERSAL REASON",60) Q:BPRVREAS="^"  Q:($L(BPRVREAS)>0)&(BPRVREAS'="^")&('(BPRVREAS?1" "." "))  D
 . . W !,"Please provide the reason or enter ^ to abandon the reversal."
 . I BPRVREAS["^" W !,"The claim: ",!,$G(@VALMAR@(+$G(BP59ARR(BP59)),0)),!,"was NOT reversed!" S BPQ=$$PAUSE() Q
 . S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 . I BPQ=-1 S BPQ="^" Q
 . I BPQ'=1 Q
 . I $$REVERSIT(BP59,BPRVREAS)=0 S REVTOTAL=REVTOTAL+1
 W:BPIFANY=0 !,"No eligible items selected."
 W !,REVTOTAL," claim reversal",$S(REVTOTAL'=1:"s",1:"")," submitted.",!
 D PAUSE^VALM1
 Q REVTOTAL
 ;
 ;
 ;the similar to REVERSE
 ;with some information displayed for the user 
 ;Input:
 ; BP59 ptr in file #9002313.59
 ; BPRVREAS - reversal reason (free text)
 ;Output:
 ;-1 Claim is not Payable
 ;-2 no reversal, it's irreversible
 ;-3 paper claim
 ;>0 - IEN of reversal claim if electronic claim submitted for
 ;   reversal.
REVERSIT(BP59,BPRVREAS) ;
 N BPRET
 N BPRX
 N BPRXRF
 S BPRXRF=$$RXREF^BPSSCRU2(BP59)
 S BPRET=+$$REVERSE(BP59,BPRVREAS,+BPRXRF,+$P(BPRXRF,U,2))
 S BPRX=$$RXNUM^BPSSCRU2(+BPRXRF)
 Q BPRET
 ;
 ;
 ;/**
 ;Reverse the claim 
 ;Input:
 ; BP59 ptr in file #9002313.59
 ; BPRVREAS - reversal reason (free text)
 ; BPRX - RX ien (#52)
 ; BPFIL - refill number
 ;Output:
 ; code^message
 ; where 
 ; code :
 ;  from $$EN^BPSNCPDP
 ;  0 Prescription/Fill successfully submitted to ECME for claims processing
 ;  1 ECME did not submit prescription/fill
 ;  2 IB says prescription/fill is not ECME billable or the data returned from IB is not valid
 ;  3 ECME closed the claim but did not submit it to the payer
 ;  4 Unable to queue the ECME claim
 ;  5 Invalid input
 ;  and additional 
 ;  12 Claim has been deleted in Pharmacy.
 ; message - whatever $$EN^BPSNCPDP returns
 ; for 12 - "Claim has been deleted in Pharmacy."
 ; 
REVERSE(BP59,BPRVREAS,BPRX,BPFIL) ;*/
 N BPDOS,BPNDC,BPRET,BPSARRY,BPSCLOSE,ERROR,BPSTATUS,BPCOBIND,BPQ
 S BPSCLOSE("CLOSE AFT REV")=0
 S BPDOS=$$DOSDATE^BPSSCRRS(BPRX,BPFIL)
 S BPNDC=$$NDC^BPSSCRU2(BPRX,BPFIL)
 I $$RXDEL^BPSOS(BPRX,BPFIL) D  Q 12_U_"Claim has been deleted in Pharmacy."
 . W !,"The claim cannot be reversed since it has been deleted in Pharmacy."
 ;Prompt user to mark claim as non-billable and release patient copay
 ;if selected claim is for the Primary Insurer - Check COB INDICATOR = 1,
 ;or if COB INDICATOR is null for backward compatibility.
 I $P($G(^BPST(BP59,0)),U,14)'>1 D BILLCLM(.BPSCLOSE) I BPQ="-1" Q 1
 ;Submit claim to ECME
 S BPRET=$$EN^BPSNCPDP(BPRX,BPFIL,BPDOS,"EREV",BPNDC,BPRVREAS,"","","","",$$COB59^BPSUTIL2(BP59),"","",.BPSCLOSE)
 ;print return value message
 W !!
 W:+BPRET>0 "Not Processed:",!,"  ",$P(BPRET,U,2)
 I +BPRET=0 S BPSTATUS=$$CLAIMST^BPSSCRU3(BP59) I $P(BPSTATUS,U)="E REVERSAL ACCEPTED" W $P(BPSTATUS,U,3)
 ; 
 ;0 Prescription/Fill successfully submitted to ECME for claims processing
 ;1 ECME did not submit prescription/fill
 ;2 IB says prescription/fill is not ECME billable or the data returned from IB is not valid
 ;3 ECME closed the claim but did not submit it to the payer
 ;4 Unable to queue the ECME claim
 ;5 Invalid input
 N BPSCOB S BPSCOB=$$COB59^BPSUTIL2(BP59) ;get COB for the BPS TRANSACTION IEN
 I +BPRET=0 D ECMEACT^PSOBPSU1(+BPRX,+BPFIL,"Claim reversal sent to 3rd party payer: ECME USER's SCREEN-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59))
 Q BPRET
 ;
 ;
 ;Mark claim billable (YES/NO) question. If yes, ask for CLAIMS TRACKING
 ;NON-BILLABLE REASONS NAME
 ;Output: 
 ;BPSCLOSE("CLOSE AFT REV")=1 or 0 (zero) (1 = YES, 0 = NO)
 ;BPSCLOSE("CLOSE AFT REV REASON")=ptr to #356.8 ^ CLOSE REASON NAME ^ ECME FLAG ^ ECME PAPER FLAG
 ;BPSCLOSE("CLOSE AFT REV COMMENT")=COMMENT TEXT
BILLCLM(BPSCLOSE) ;
 N BPREAZ,BPCMT,BPCLAR
 S BPSCLOSE("CLOSE AFT REV")=0,BPSCLOSE("CLOSE AFT REV REASON")="",BPSCLOSE("CLOSE AFT REV COMMENT")=""
 W !,"Do you want to mark the claim as non-billable in Claims Tracking and release the Patient Copay (if any)"
 S BPQ=$$YESNO^BPSSCRRS("(Yes/No)") I BPQ<1 Q
 S BPSCLOSE("CLOSE AFT REV")=BPQ
 S BPREAZ=$$REASON^BPSSCRCL() I BPREAZ="^" S BPQ="-1" Q
 S BPSCLOSE("CLOSE AFT REV REASON")=+$P(BPREAZ,U)
 S BPCMT=$$COMMENT^BPSSCRCL("Comment ",40) I BPCMT="^" S BPQ="-1" Q
 S BPSCLOSE("CLOSE AFT REV COMMENT")=BPCMT
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ<1 S BPSCLOSE("CLOSE AFT REV")=0,BPSCLOSE("CLOSE AFT REV REASON")="",BPSCLOSE("CLOSE AFT REV COMMENT")="",BPQ="-1" Q
 W !,"If the reversal is approved by the third-party payer, the claim will be marked as non-billable.",!
 Q
 ;
PAUSE() ;
 N X
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q X
 ;
