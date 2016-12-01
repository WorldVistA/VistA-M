BPSWRKLS ;ALB/SS - SEND CLAIMS TO PHARMACY WORKLIST ;12/26/07
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8,11,15,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; -- main entry point for BPS PRTCL USRSCR PHARM WRKLST protocol (ECME User Screen option)
 ;
EN ;
 ;entry point for WRK Send to Worklist menu option of the main User Screen
 N BPRET,BPSARR59,BPSTATS,BPQ,BP59,BPCNT,BP59SENT,BPCOMZ,BPZ,BPUPD
 S BPCNT=0
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 I '$$CHCKKEY() D  Q
 . W !,"The user doesn't have enough rights to perform this action"
 . D QUIT(1)
 ;
 S BPQ=0
 F  D  Q:BPQ>0
 . K BP59SENT,BPSARR59
 . S BPZ=$$SELCLMS(.BPSARR59,VALMAR)
 . I BPZ=0 S BPQ=1 Q  ;nothing selected or up-arrow entered
 . ; check selected claims
 . S BPCNT=$$CHCKSEL(.BPSARR59,.BP59SENT)
 . I BPCNT>0 S BPQ=1 ; if at least one can be processed then do not prompt the user again (BPQ>1)
 ;
 I BPCNT=0 D QUIT() Q
 ;add comments
 S BPCOMZ=$$COMMENT^BPSSCRCL("Comment for Pharmacy ",40)
 I BPCOMZ="^" D QUIT() Q
 I $L(BPCOMZ)>0 S BPCOMZ="Sent to Pharmacy:"_BPCOMZ
 E  S BPCOMZ="Sent to Pharmacy Worklist"
 W !!,"Eligible claim(s) will be sent to the Pharmacy Worklist...",!
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ<1 D QUIT() Q
 ;send to Pharmacy
 S BP59=0,BPUPD=0
 F  S BP59=$O(BP59SENT(BP59)) Q:+BP59=0  S BPUPD=$$TOPHARM(BP59,BPCOMZ,.BPSARR59)
 D QUIT(1)
 D:BPUPD=1 REDRAW^BPSSCRUD("Updating screen...")
 Q
 ;send the claim to Pharmacy Worklist
 ;BP59 - pointer to the BPS TRANSACTION file
 ;BPCOMM - comment
 ;BPSARR59 - array with selected claims as BPS TRANSACTION pointers
 ;returns:
 ;1- has been successfully sent
 ;0- failed to send
TOPHARM(BP59,BPCOMM,BPSARR59) ;
 N BPRXIEN,BPRXFIL,BPRET,BPX
 S BPX=$$RXREF^BPSSCRU2(BP59)
 S BPRXIEN=+BPX
 S BPRXFIL=$P(BPX,U,2)
 ;use Pharmacy API to send the claim and the comment IA #5063
 S BPRET=$$WRKLST^PSOREJU4(BPRXIEN,BPRXFIL,BPCOMM,DUZ,DT,1,$$COB59^BPSUTIL2(BP59))
 W !,$G(@VALMAR@(+$G(BPSARR59(BP59)),0))
 I +BPRET=2 W !,"was ALREADY sent to the Pharmacy Work List." Q 0
 I +BPRET=0 W !,"cannot be sent: ",$P(BPRET,U,2) Q 0
 ;add the comment to BPS TRANSACTION
 I $$ADDCOMM^BPSBUTL(BPRXIEN,BPRXFIL,BPCOMM) ;COB
 W !,"has been sent to the Pharmacy Work List."
 Q 1
 ;check selected claims 
 ;BPSARR59 - array with the claims selected by the user
 ;BP59SENT - array with the claims that will be sent to the pharmacy
 ;output:
 ;the number of claims that will be sent to the Pharmacy Worklist
CHCKSEL(BPSARR59,BP59SENT) ;
 N BP59,BPCNT,BPREJS,BPALLREJ,BPNOTSNT,BPSDIV59
 S BP59=0,BPCNT=0
 ;check each selected claim
 S BPNOTSNT=0
 W !,"You've chosen to send to Pharmacy Work List the following:"
 F  S BP59=$O(BPSARR59(BP59)) Q:+BP59=0  D
 . W !,$G(@VALMAR@(+$G(BPSARR59(BP59)),0))
 . ;
 . ; check for non-billable entry - cannot be sent to the Pharmacy work list from here
 . I $$NB^BPSSCR03(BP59) W !,"Entry is NON BILLABLE and cannot be sent to the Pharmacy Work List." Q
 . ;
 . I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4)) W !,"is closed and cannot be sent to the Pharmacy Work List." Q
 . ; check status - only rejected cannot be sent to the Pharmacy worklist
 . S BPSTATS=$P($$CLAIMST^BPSSCRU3(BP59),U)
 . I BPSTATS'="E REJECTED" W !,"was not rejected and cannot be sent to the Pharmacy Work List." Q
 . ;check if the claim has an eligible reject code(s)
 . I $$INWRKLST(BP59)=1 W !,"was ALREADY sent to the Pharmacy Work List." Q
 . ;check Pharmacy settings - if all rejects can be sent
 . ;IA 5063
 . S BPSDIV59=$P($G(^BPST(BP59,1)),U,4)
 . D AUTOREJ^PSOREJU4(.BPREJS,BPSDIV59)
 . I $$CHCKREJ(BP59,BPSDIV59)=0 W !,"doesn't have eligible reject code to be sent to the Pharmacy Work List." Q
 . S BPCNT=BPCNT+1 ;count eligible claims
 . S BP59SENT(BP59)="" ;put them in the output array
 . S BP59SENT=BPCNT
 Q BPCNT
 ;
NOTSNDMS ;
 W "cannot be sent - "
 Q
 ;
 ;BPSARR59 (by reference)- to store BPS TRANSACTION pointers selected by the user
 ;BPTMP - temporary global (like VALMAR)
SELCLMS(BPSARR59,BPTMP) ;
 W !!,"Enter the line numbers for the claim(s) to send to the Pharmacy Worklist."
 S BPRET=$$ASKLINES^BPSSCRU4("Select item(s)","C",.BPSARR59,BPTMP)
 I BPRET="^" Q 0
 Q 1
 ;
CHCKKEY() ;
 ;check if the user does have BPS MANAGER key
 I $D(^XUSEC("BPS MANAGER",DUZ)) Q 1
 Q 0
 ;BPPAUSE 1- make pause
QUIT(BPPAUSE) ;
 I $G(BPPAUSE)>0 D
 . I $$PAUSE^BPSSCRRV()
 S VALMBCK="R"
 Q
 ;check if the claim can be sent to the pharmacy because its reject code is eligible for this
 ;BP59 - pointer to the BPS TRANSACTION file
 ;BPSDIV59 - pointer to file #59 (PHARMACY DIVISION)
 ;return value:
 ;1- can be sent
 ;0- cannot be sent
CHCKREJ(BP59,BPSDIV59) ;
 N BPREJS,BPRJCODE,BPRJS,BPFLG
 ;get reject codes for the claim
 D REJCODES^BPSSCRU3(BP59,.BPREJS) ;
 ;if no reject codes then return 0
 I $O(BPREJS(""))="" Q 0
 D CONVERT(.BPREJS,.BPRJS)
 ;call Pharmacy API to read site parameters and check if the claim with these reject codes can be sent to the Pharmacy Worklist
 ;IA 5063
 D AUTOREJ^PSOREJU4(.BPRJS,BPSDIV59)
 ;check result
 S BPRJCODE="",BPFLG=0
 F  S BPRJCODE=$O(BPRJS(1,BPRJCODE)) Q:BPRJCODE=""  I BPRJS(1,BPRJCODE)=1 S BPFLG=1 Q
 ;return 1 if the claim has at least one reject code that matches site parameter reject codes
 ;return 0 if not
 Q BPFLG
 ;
 ;check if the claim is already in the Pharmacy Worklist
 ;BP59 - pointer to the BPS TRANSACTION file
 ;return: 
 ;1 - in list
 ;0 - not in list
INWRKLST(BP59) ;
 N BPRXIEN,BPRXFIL,BPX
 S BPX=$$RXREF^BPSSCRU2(BP59)
 S BPRXIEN=+BPX
 S BPRXFIL=$P(BPX,U,2)
 ;IA #5063
 Q $$INLIST^PSOREJU4(BPRXIEN,BPRXFIL,$$COB59^BPSUTIL2(BP59))
 ;
 ;Converts external values of the BPS NCPDP REJECT CODES file #9002313.93
 ;stored in the local array BPSARRJ1 to IENs and save them in the local 
 ;array BPSARRJ2 under "1" subscript - in the form suitable for the AUTOREJ^PSOREJU4
CONVERT(BPSARRJ1,BPSARRJ2) ;
 N BPREJ1,BPREJ2
 S BPREJ1=""
 F  S BPREJ1=$O(BPSARRJ1(BPREJ1)) Q:BPREJ1=""  D
 . S BPREJ2=+$O(^BPSF(9002313.93,"B",BPREJ1,0))
 . I BPREJ2>0 S BPSARRJ2(1,BPREJ2)=""
 Q
 ;send the rejected claims with 79 and 88 codes to Pharmacy Worklist 
 ;Input: 
 ; BPRXI - RX ien
 ; BPRXR - refill
 ; BPIEN59 - ien of BPS TRANSACTION file
 ; BPPAYSEQ - payer sequence
 ;Returns: 
 ; 1 sent succesfully
 ; 2 was ALREADY sent to the Pharmacy Work List
 ; 0 cannot be sent
SENDREJ(BPRXI,BPRXR,BPIEN59,BPPAYSEQ) ;
 N BPZ,BPALLREJ,BPREJ,BPRET
 S BPRET=0
 D DUR1^BPSNCPD3(BPRXI,BPRXR,.BPREJ,"",BPPAYSEQ)
 S BPZ=","_BPREJ(BPPAYSEQ,"REJ CODE LST")_","
 I BPZ[",79,"!(BPZ[",88,") S BPRET=$$WRKLST^PSOREJU4(BPRXI,BPRXR,"Sent by ECME engine",DUZ,DT,1,BPPAYSEQ)
 Q +BPRET
 ;
 ;BPSWRKLS
