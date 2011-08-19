BPSSCR03 ;BHAM ISC/SS - ECME USR SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;/**
 ;BP59 - ptr to 9002313.59
 ; BPARR to return formatted info via ref
 ; BPMLEM - max len for each line
 ; BPMODE - mode
 ;   R -regular for main screen, will show only latest comment
 ;   C - comment mode - show all comments
ADDINF(BP59,BPARR,BPMLEN,BPMODE) ;to return additional information about the claim*/
 N BPX,BPN,BPTXT1,BPTXT2,BPTXT3,BPTXT4,BPX1,BPN2,BPSTATUS,BPSCOBA,BP59X
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
 . . S BPX=$$DATTIM^BPSSCRU3($P(BPX1,U,1)\1)_" - "_$P(BPX1,U,3)
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
 I (BPSTATUS["E REJECTED")!(BPSTATUS["E REVERSAL REJECTED") D
 . I $L(BPTXT1)>0 S BPN=BPN+1,BPARR(BPN)=BPTXT1
 . S BPTXT1=""
 . S BPN2=BPN
 . D GETRJCOD^BPSSCRU3(BP59,.BPARR,.BPN,74,"")
 . D WRAPLN2^BPSSCRU5(.BPN,.BPARR,$$GETMESS^BPSSCRU3(1000,504,BP59),74,"",0)
 . D WRAPLN2^BPSSCRU5(.BPN,.BPARR,$$GETMESS^BPSSCRU3(1000,526,BP59),74,"",0)
 . D WRAPLN2^BPSSCRU5(.BPN,.BPARR,$$GETMESS^BPSSCRU3(504,0,BP59),74,"",0)
 . I BPN>BPN2 Q  ;reject codes are enough
 . ;S BPX1=$P($P(BPX,U,3),"[") I BPTXT1=BPX1 S BPX1=""
 . S:BPX1="" BPX1=$$GETMESS^BPSSCRU3(504,0,BP59)
 . I $L(BPX1)>0 S BPTXT1=BPTXT1_"- "_$TR(BPX1,"]","")
 ;
 I (BPSTATUS["E OTHER")!(BPSTATUS["IN PROGRESS")!(BPSTATUS["E UNSTRANDED")!(BPSTATUS["E CAPTURED")!(BPSTATUS["E REVERSAL UNSTRANDED") D
 . I (BPSTATUS["E OTHER")!(BPSTATUS["IN PROGRESS") S BPX1=$P(BPX,U,3) I BPTXT1=BPX1 S BPX1=""
 . S:BPX1="" BPX1=$$GETMESS^BPSSCRU3(504,0,BP59)
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
 N BPST0,BPST1,BPRXREF,BPRX52,BPREFNUM
 N BPRET
 S BPRET=1 ;1 - okay by default
 S BPST0=$G(^BPST(BP59,0))
 S BPST1=$G(^BPST(BP59,1))
 S BPRXREF=$$RXREF^BPSSCRU2(BP59)
 S BPRX52=+$P(BPRXREF,U) ;ptr to #52
 S BPREFNUM=$P(BPRXREF,U,2) ;refill #
 ;Check for Open Claim
 I $G(BPARR(2.02))="O",$$CLOSED02(+$P(BPST0,U,4)) Q 0
 ;Check for Closed Claim
 I $G(BPARR(2.02))="C",'$$CLOSED02(+$P(BPST0,U,4)) Q 0
 ;Eligibility Indicator
 I '$$FLTELIG^BPSSCR05(BP59,.BPARR) Q 0
 ;Submission type
 I '$$FLTSUBTP^BPSSCR05(BP59,.BPARR) Q 0
 ;user
 I $G(BPARR(1.01))="U",$$FLTUSR(BPST0,.BPARR)=0 Q 0
 ;patient
 I $G(BPARR(1.02))="P",$$FLTPAT(BPST0,.BPARR)=0 Q 0
 ;RX
 I $G(BPARR(1.03))="R",$$FLTRX(BPST1,.BPARR)=0 Q 0
 ;only rejected
 I $G(BPARR(1.06))="R",$$REJECTED^BPSSCR02(BP59)=0 Q 0
 ;only payable
 I $G(BPARR(1.06))="P",$$PAYABLE^BPSSCR02(BP59)=0 Q 0
 ;released
 I $G(BPARR(1.07))="R",$$RL^BPSSCRU2(BP59)'="RL" Q 0
 ;non released
 I $G(BPARR(1.07))="N",$$RL^BPSSCRU2(BP59)="RL" Q 0
 ;window/cmop/mail
 I $G(BPARR(1.08))'="A",$$ISMWC(BPRX52,BPREFNUM,$G(BPARR(1.08)))=0 Q 0
 ;Back billing
 I $G(BPARR(1.09))="B",$$RTBB^BPSSCRU2(BP59)'="BB" Q 0
 ;real time
 I $G(BPARR(1.09))="R",$$RTBB^BPSSCRU2(BP59)="BB" Q 0
 ;if only rejected and only specific rejected codes should be displayed
 I $G(BPARR(1.06))="R",$G(BPARR(1.1))="R",$$FLTREJ(BP59,.BPARR)=0 Q 0
 ;insurance
 I '$$FLTINS^BPSSCR05(BP59,.BPARR) Q 0
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
 D REJCODES^BPSSCRU3(BP59,.BPRCODES)
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
