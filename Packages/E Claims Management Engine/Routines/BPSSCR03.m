BPSSCR03 ;BHAM ISC/SS - ECME USR SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10,11,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;/**
 ;BP59 - ptr to 9002313.59
 ; BPARR to return formatted info via ref
 ; BPMLEM - max len for each line
 ; BPMODE - mode
 ;   R -regular for main screen, will show only latest comment
 ;   C - comment mode - show all comments
ADDINF(BP59,BPARR,BPMLEN,BPMODE) ;to return additional information about the claim*/
 N BPX,BPN,BPTXT1,BPTXT2,BPTXT3,BPTXT4,BPX1,BPN2,BPSTATUS,BPSCOBA,BP59X,I
 S BPN=0,(BPTXT1,BPTXT2,BPTXT3,BPTXT4,BPX1)=""
 I BPMODE="R" D
 . S BPX=$$COMMENT^BPSSCRU3(BP59)
 . I $L(BPX)>0 S BPN=BPN+1,BPARR(BPN)=$P(BPX,U)
 . I $P(BPX,U,2)]"" S BPN=BPN+1,BPARR(BPN)="("_$P(BPX,U,2)_")"
 E  D
 . N BPCMNT,BPX1 S BPCMNT=99999999
 . F  S BPCMNT=$O(^BPST(BP59,11,BPCMNT),-1) Q:+BPCMNT=0  D
 . . S BPX1=$G(^BPST(BP59,11,BPCMNT,0))
 . . I BPX1="" Q
 . . S BPX=$$DATTIM^BPSSCRU3($P(BPX1,U,1)\1)_$S(+$P(BPX1,U,4):" (Pharm)",1:"")_" - "_$P(BPX1,U,3)
 . . I $L(BPX)>0 S BPN=BPN+1,BPARR(BPN)=BPX
 . . I +$P(BPX1,U,2)]"" D
 . . . S BPX=$$USERNAM^BPSCMT01(+$P(BPX1,U,2))
 . . . I BPX'="" S BPX="("_BPX_")",BPN=BPN+1,BPARR(BPN)=BPX
 S BPX=$$CLAIMST^BPSSCRU3(BP59)
 S BPSTATUS=$P(BPX,U)
 ; Show status for this BPS Transaction
 S BPTXT1=$$COBCLST^BPSSCRU6(BP59)
 ; Append status for associated claim, if one exists
 S BPSCOBA=$$ALLCOB59^BPSUTIL2(BP59)
 F I=1:1 S BP59X=$P(BPSCOBA,U,I) Q:BP59X=""  D
 . Q:BP59X=BP59
 . S BPTXT1=BPTXT1_" ("_$$COBCLST^BPSSCRU6(BP59X)_")"
 ;
 ; build the TRI/CVA non-billable reject/reason lines  (bps*1*20)
 I $$NB(BP59) D
 . I $L(BPTXT1)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT1   ; store the current line
 . S BPTXT1=""
 . S BPN=BPN+1,BPARR(BPN)=$$EREJTXT(BP59)         ; store the eT/eC non-billable reject/reason line
 . Q
 ;
 I (BPSTATUS["E REJECTED")!(BPSTATUS["E REVERSAL REJECTED") D
 . I $L(BPTXT1)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT1
 . S BPTXT1=""
 . S BPN2=BPN
 . D GETRJCOD^BPSSCRU3(BP59,.BPARR,.BPN,74,"")
 . D WRAPLN2^BPSSCRU5(.BPN,.BPARR,$$GETMESS^BPSSCRU3(504,BP59),74,"",0)
 . D WRAPLN2^BPSSCRU5(.BPN,.BPARR,$$GETMESS^BPSSCRU3(526,BP59),74,"",0)
 ;
 I (BPSTATUS["E OTHER")!(BPSTATUS["IN PROGRESS")!(BPSTATUS["E UNSTRANDED")!(BPSTATUS["E CAPTURED")!(BPSTATUS["E REVERSAL OTHER")!(BPSTATUS["E REVERSAL UNSTRANDED") D
 . I (BPSTATUS["E OTHER")!(BPSTATUS["E REVERSAL OTHER")!(BPSTATUS["IN PROGRESS") S BPX1=$P(BPX,U,3) I BPTXT1=BPX1 S BPX1=""
 . S:BPX1="" BPX1=$$GETMESS^BPSSCRU3(504,BP59)
 . I $L(BPX1)>0 S BPTXT1=BPTXT1_"- "_$TR(BPX1,"]","")
 ;
 S BPTXT2=$E(BPTXT1,1,BPMLEN)
 S BPTXT3=$E(BPTXT1,BPMLEN+1,2*BPMLEN)
 S BPTXT4=$E(BPTXT1,(2*BPMLEN)+1,3*BPMLEN)
 I $L(BPTXT2)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT2
 I $L(BPTXT3)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT3
 I $L(BPTXT4)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT4
 Q BPN
 ;
CLMINF(BP59) ;ptr to #9002313.59
 W !,"Claim info. Press a key"
 D PAUSE^VALM1
 Q
 ;
EREJTXT(BP59) ; return the eT/eC line for non-billable entry
 N ELIG,BPX2
 S BPX2=""
 S ELIG=$$GET1^DIQ(9002313.59,BP59,901.04)
 I '$F(".T.C.","."_$E(ELIG,1)_".") G EREJTX            ; must be TRI/CVA eligibility for non-billable
 S BPX2="e"_$E(ELIG,1)_":"_ELIG_"-RX NOT BILLABLE ("_$P($G(^BPST(BP59,3)),U,1)_")"   ; build eT / eC line
EREJTX ;
 Q BPX2
 ;
COMM(BP59) ;ptr to #9002313.59
 W !,"the latest comment. Press a key"
 D PAUSE^VALM1
 Q
 ;
RESP(BP59) ;Payer Response Information
 W !,"payer Response Information. Press a key"
 D PAUSE^VALM1
 Q
 ;
 ;/**
 ;Checks if the claim is closed and sets the "/Closed" indicator at the end of the text
 ;BP59 - pointer to file #9002313.59
 ;BPTXT - Current status text to be displayed
 ;return:
 ;if the claim is not closed, BPTXT is returned. If it is closed BPTXT_"/Closed " is returned
CLMCLSTX(BP59,BPTXT) ;*/
 Q $S($$CLOSED02($P($G(^BPST(BP59,0)),U,4)):BPTXT_"/Closed ",1:BPTXT)
 ;
 ;/**
 ;Checks if the CLAIM for specific Transaction is CLOSED?
 ;BPCLAIM - ptr to #9002313.02
 ;see also CLOSED^BPSSCRU1
CLOSED02(BPCLAIM) ;*/
 I +$G(BPCLAIM)=0 Q 0
 ; get closed status
 Q +$P($G(^BPSC(BPCLAIM,900)),U)=1
 ;
 ;return:
 ; 1 - okay. matches criteria
 ; 0-  not okay, doesn't match criteria
FILTER(BP59,BPARR) ;
 N BPST0,BPST1,BPRXREF,BPRX52,BPREFNUM,BPRTBB
 N BPRET
 S BPRET=1 ;1 - okay by default
 S BPST0=$G(^BPST(BP59,0))
 S BPST1=$G(^BPST(BP59,1))
 ; Do not display eligibility verification requests
 I $P(BPST0,U,15)="E" Q 0
 S BPRXREF=$$RXREF^BPSSCRU2(BP59)
 S BPRX52=+$P(BPRXREF,U) ;ptr to #52
 S BPREFNUM=$P(BPRXREF,U,2) ;refill #
 ;
 ;Check for Open Claim
 I '$$NB(BP59),$G(BPARR(2.02))="O",$$CLOSED02(+$P(BPST0,U,4)) Q 0    ; n/a for non-billables
 ;Check for Closed Claim
 I '$$NB(BP59),$G(BPARR(2.02))="C",'$$CLOSED02(+$P(BPST0,U,4)) Q 0   ; n/a for non-billables
 ;
 I $G(BPARR(1.19))="O",$$NBCL(BP59) Q 0     ; non-billable entry - Open entries only
 I $G(BPARR(1.19))="C",$$NBOP(BP59) Q 0     ; non-billable entry - Closed entries only
 ;
 ;Eligibility Indicator
 I '$$FLTELIG^BPSSCR05(BP59,.BPARR) Q 0
 ;
 ;Submission type
 I '$$NB(BP59),'$$FLTSUBTP^BPSSCR05(BP59,.BPARR) Q 0      ; n/a for non-billables
 ;
 ;user
 I $G(BPARR(1.01))="U",$$FLTUSR(BPST0,.BPARR)=0 Q 0
 ;
 ;patient
 I $G(BPARR(1.02))="P",$$FLTPAT(BPST0,.BPARR)=0 Q 0
 ;
 ;RX
 I $G(BPARR(1.03))="R",$$FLTRX(BPST1,.BPARR)=0 Q 0
 ;
 ;only rejected
 I '$$NB(BP59),$G(BPARR(1.06))="R",$$REJECTED^BPSSCR02(BP59)=0 Q 0    ; n/a for non-billables
 ;only payable
 I '$$NB(BP59),$G(BPARR(1.06))="P",$$PAYABLE^BPSSCR02(BP59)=0 Q 0     ; n/a for non-billables
 ;only unstranded
 I '$$NB(BP59),$G(BPARR(1.06))="U",$$UNSTRAND^BPSSCR02(BP59)=0 Q 0    ; n/a for non-billables
 ;
 ;released
 I $G(BPARR(1.07))="R",$$RL^BPSSCRU2(BP59)'="R" Q 0
 ;non released
 I $G(BPARR(1.07))="N",$$RL^BPSSCRU2(BP59)="R" Q 0
 ;
 ;window/cmop/mail
 I $G(BPARR(1.08))'="A",$$ISMWC(BPRX52,BPREFNUM,$G(BPARR(1.08)))=0 Q 0
 ;
 ; filter checks for fill type
 S BPRTBB=$$RTBB^BPSSCRU2(BP59) I BPRTBB="**" S BPRTBB="RT"
 I $G(BPARR(1.09))="B",BPRTBB'="BB" Q 0     ; filter for back billing
 I $G(BPARR(1.09))="P",BPRTBB'="P2" Q 0     ; filter for PRO Option
 I $G(BPARR(1.09))="S",BPRTBB'="RS" Q 0     ; filter for ECME user screen resubmits (BPS*1*20)
 I $G(BPARR(1.09))="R",BPRTBB'="RT" Q 0     ; filter for real time
 ;
 ;if only rejected and only specific rejected codes should be displayed
 I $G(BPARR(1.06))="R",$G(BPARR(1.1))="R",$$FLTREJ(BP59,.BPARR)=0 Q 0
 ;
 ;insurance
 I '$$FLTINS^BPSSCR05(BP59,.BPARR) Q 0
 ;
 ;divisions - ECME pharmacies
 I $G(BPARR(1.13))="D",BPARR("DIVS")'[(";"_$P(BPST1,U,7)_";") Q 0
 Q 1
 ;
 ;check user filter
 ;input:
 ;BPST0 - zero node of #9002313.59
 ;BPARR array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTUSR(BPST0,BPARR) ;
 I $L($G(BPARR(1.16)))=0 Q 0
 I $P(BPST0,U,10)'=$G(BPARR(1.16)) Q 0
 Q 1
 ;check patient filter
 ;input:
 ;BPST0 - zero node of #9002313.59
 ;BPARR array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTPAT(BPST0,BPARR) ;
 I $L($G(BPARR(1.17)))=0 Q 0
 I $P(BPST0,U,6)'=$G(BPARR(1.17)) Q 0
 Q 1
 ;check RX filter
 ;input:
 ;BPST1 - 1st node of #9002313.59
 ;BPARR array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTRX(BPST1,BPARR) ;
 I $L($G(BPARR(1.18)))=0 Q 0
 I $P(BPST1,U,11)'=$G(BPARR(1.18)) Q 0
 Q 1
 ;input:
 ;BP59 - zero node of #9002313.59
 ;BPARR array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTREJ(BP59,BPARR) ;
 N BPRCODES
 N BPRJCD
 S BPRJCD=$P($G(^BPSF(9002313.93,+$G(BPARR(1.15)),0)),U)
 I $L(BPRJCD)=0 Q 0
 D REJCODES^BPSSCRU3(BP59,.BPRCODES,1)    ; bps*1*20 include possible non-billable pseudo-reject codes too
 I $D(BPRCODES(BPRJCD)) Q 1
 Q 0
 ;
 ;check W(indow)/C(mop)/M(ail)
 ;input:
 ;BPRX52 - ptr to #52
 ;BPREFNUM - refill #
 ;BPMWC - given value from CMOP/MAIL/WINDOW instance 1.08 of BPS USRSCR parameters
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
ISMWC(BPRX52,BPREFNUM,BPMWC) ;
 I $$MWCNAME^BPSSCRU2($$MWC^BPSSCRU2(BPRX52,BPREFNUM))=BPMWC Q 1
 Q 0
 ;
FILTRALL(BPTMP1,BPTMP2,BPARR) ;
 N BP59
 S BP59=0
 F  S BP59=+$O(@BPTMP1@(BP59)) Q:+BP59=0  D
 . I $$FILTER(BP59,.BPARR) S @BPTMP2@(BP59)=""
 Q
 ;
 ;go thru all FILE59 entries and run SETTRDFN for each of them
 ;
TRDFNALL(BPTMP) ;
 N BP59
 S BP59=0
 F  S BP59=+$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . D SETTRDFN(BPTMP,BP59)
 Q
 ;
 ;sorting for "TRANSACTION DATE" type is
 ;actually sorting by patients , but patient should be sorted not in alphabetical order:
 ;the first patient is the one which has the most recent transaction and so on
 ;BPTMP - TMP global
 ;BP59 - ptr to #9002313.59
SETTRDFN(BPTMP,BP59) ;
 ;the following stores the latest transaction date of the claims, which
 ;was found for this particular combination of patient and insurance
 ;@BPTMP@("DFN-TRDT",BPDFN,BPINSUR)=BPTRDT
 ;the following stores the latest transaction date BPTRDT,patient BPDFN and
 ;insurance BPINSUR to provide a proper order
 ;@BPTMP@("TRDTDFN",BPTRDT,BPDFN,BPINSUR)=""
 N BPZERO,BPTRDT,BPDFN,BPPREV,BPINSUR
 S BPZERO=$G(^BPST(BP59,0)) ;
 S BPTRDT=-$P(BPZERO,U,8) ;"transaction" date
 S BPDFN=+$P(BPZERO,U,6) ;patient ptr to #2
 S BPINSUR=+$$GETINSUR^BPSSCRU2(BP59) ;insurance ien
 ;in the beginning we don't have any "DFN-TRDT" and "TRDTDFN"
 ;so create them and quit
 I '$D(@BPTMP@("DFN-TRDT",BPDFN,BPINSUR)) D  Q
 . S @BPTMP@("DFN-TRDT",BPDFN,BPINSUR)=BPTRDT
 . S @BPTMP@("TRDTDFN",BPTRDT,BPDFN,BPINSUR)=""
 ;if we already have them then get the latest into BPPREV
 S BPPREV=+$G(@BPTMP@("DFN-TRDT",BPDFN,BPINSUR))
 ;and compare it against the BPTRDT for this BP59
 ;if the BPTRDT is greater then replace the values in "DFN-TRDT"
 ;and "TRDTDFN"
 I BPTRDT<BPPREV D
 . S @BPTMP@("TRDTDFN",BPTRDT,BPDFN,BPINSUR)=""
 . S @BPTMP@("DFN-TRDT",BPDFN,BPINSUR)=BPTRDT
 . K @BPTMP@("TRDTDFN",BPPREV,BPDFN,BPINSUR)
 Q
 ;
NB(BP59) ; Is this BPS Transaction a TRI/CVA non-billable entry?
 I $P($G(^BPST(+$G(BP59),0)),U,15)="N" Q 1    ; yep
 Q 0                                          ; nope
 ;
NBCL(BP59) ; Is this BPS Transaction a Closed TRI/CVA non-billable entry?
 I $$NB(+$G(BP59)),$P($G(^BPST(+$G(BP59),3)),U,2) Q 1    ; yep
 Q 0                                                     ; nope
 ;
NBOP(BP59) ; Is this BPS Transaction an Open TRI/CVA non-billable entry?
 I $$NB(+$G(BP59)),'$P($G(^BPST(+$G(BP59),3)),U,2) Q 1   ; yep
 Q 0                                                     ; nope
 ;
