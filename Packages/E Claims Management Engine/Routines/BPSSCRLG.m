BPSSCRLG ;BHAM ISC/SS - ECME LOGINFO ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10,11,15,18,20,22**;JUN 2004;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; -- main entry point for BPS LSTMN LOG
 D EN^VALM("BPS LSTMN LOG")
 Q 
 ;
HDR ; -- header code
 S VALMHDR(1)="Claim Log information"
 S VALMHDR(2)=""
 Q
 ;
INIT ; -- init variables and list array
 N BPSELCLM,LINE
 S BPSELCLM=$G(@VALMAR@("SELLN"))
 ;  piece 2: patient ien #2
 ;  piece 3: insurance ien #36
 ;  piece 4: ptr to #9002313.59
 S LINE=1
 S VALMCNT=$$PREPINFO(.LINE,$P(BPSELCLM,U,2),$P(BPSELCLM,U,3),$P(BPSELCLM,U,4))
 S:VALMCNT>1 VALMCNT=VALMCNT-1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 K X
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
 ;
LOG ;entry point for LOG menu option
 N BPRET,BPSEL,BP59,BPVLM
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line number for which you wish to print claim logs."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE Rx Line.")
 I BPSEL<1 S VALMBCK="R" Q
 ;
 S BP59=$P(BPSEL,U,4)
 S BPVLM=+$P(BPSEL,U,5)    ; 1st line for indexes in the LM display array
 ;
 ; check for non-billable entry for claim LOG display
 I $$NB^BPSSCR03(BP59) D  S VALMBCK="R" Q
 . W !!,$G(@VALMAR@(BPVLM,0))       ; LM display array
 . W !?6,$$EREJTXT^BPSSCR03(BP59)   ; eT/eC non-billable reason line
 . W !,"Entry is NON BILLABLE.  There is no Claim Log to display."
 . D PAUSE^VALM1
 . Q
 ;
 D SAVESEL(BPSEL,VALMAR)
 D EN
 S VALMBCK="R"
 Q
 ;
 ;save for ListManager
 ;BPSEL - selected line
 ;BPVALMR - parent VALMAR 
SAVESEL(BPSEL,BPVALMR) ;
 D CLEANIT
 S ^TMP("BPSLOG",$J,"VALM","SELLN")=BPSEL
 S ^TMP("BPSLOG",$J,"VALM","PARENT")=BPVALMR
 M ^TMP("BPSLOG",$J,"VALM","VIEWPARAMS")=@BPVALMR@("VIEWPARAMS")
 Q
 ;
CLEANIT ;
 K ^TMP("BPSLOG",$J,"VALM")
 Q
 ;
PREPINFO(BPLN,BPDFN,BP36,BP59) ;
 ;input:
 ; BPDFN: patient ien #2
 ; BP36: insurance ien #36
 ; BP59: ptr to #9002313.59
 ; returns # of lines
 ;
 ; Moved to ^BPSSCRL1 for sake of space
 ;
 Q $$PREPINFO^BPSSCRL1(BPLN,BPDFN,BP36,BP59)
 ;
 ;increments BPLINE
SETLINE(BPLINE,BPSTR) ;
 D SET^VALM10(BPLINE,BPSTR)
 S BPLINE=BPLINE+1
 Q
 ;
 ;display claim record
DISPCLM(BPLN,BP59,BPIEN02,BP57,BPSTYPE,BPSDTALT) ;
 ;
 ; Moved to ^BPSSCRL1 for sake of space
 ;
 D DISPCLM^BPSSCRL1
 Q
 ;
 ;Submitted By User
SUBMTBY(BP57) ;
 N BPIEN,BPUSR
 S BPIEN=$P($G(^BPSTL(BP57,0)),U,10)
 S BPUSR=$$GETUSRNM^BPSSCRU1(BPIEN)
 Q $S(BPUSR']"":"UNKNOWN",1:BPUSR)
 ;
 ;Date of service
DOSCLM(BPIEN02) ;
 N BPDT
 S BPDT=$P($G(^BPSC(BPIEN02,401)),U,1)\1
 Q $E(BPDT,5,6)_"/"_$E(BPDT,7,8)_"/"_$E(BPDT,1,4)
 ;
 ;Create date 
CREATEDT(BPIEN02,BPSDTALT) ;
 N BPSDT
 S BPSDT=+$P($G(^BPSC(BPIEN02,0)),U,6)
 Q $$DATETIME^BPSSCRU5($S(BPSDT>0:BPSDT,1:BPSDTALT))
 ;
 ;Plan ID
PLANID(BP57) ;
 Q $P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),0)),U,1)
 ;
CERTMOD(BP57) ;
 Q $P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),0)),U,5)
 ;
 ;Software Vendor/Cert ID
CERTIEN(BP57) ;
 Q $P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),0)),U,6)
 ;
 ;Division
DIV(BP57) ;
 Q $$GET1^DIQ(9002313.57,BP57_",",11)
 ;
 ;NPI
NPI(BPIEN02) ;
 Q $$GET1^DIQ(9002313.02,BPIEN02_",",201)
 ;
 ;Group ID
GRPID(BPIEN02) ;
 Q $E($P($G(^BPSC(BPIEN02,300)),U,1),3,99)
 ;
 ;Group Name
GRPNM(BPSIEN02) ;
 N BPSGPN
 S BPSGPN=$P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),3)),U,1)
 Q BPSGPN
 ;
 ;Cardholder ID
CRDHLDID(BPIEN02) ;
 Q $E($P($G(^BPSC(BPIEN02,300)),U,2),3,99)
 ;
 ;Cardholder First name
CRDHLDFN(BPIEN02,BP57) ;
 N Y
 S Y=$E($P($G(^BPSC(BPIEN02,300)),U,12),3,99)
 I $L(Y)=0 S Y=$P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),1)),U,6)
 Q Y
 ;
 ;Cardholder Last Name
CRDHLDLN(BPIEN02,BP57) ;
 N Y
 S Y=$E($P($G(^BPSC(BPIEN02,300)),U,13),3,99)
 I $L(Y)=0 S Y=$P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),1)),U,7)
 Q Y
 ;
 ;Facility ID Qualifier - BPS*1*22
FACIDQ(BPEIN02) ;
 Q $P($G(^BPSC(BPIEN02,400,1,"B90")),U,5)
 ;
 ;Patient Relationship Code
PATRELSH(BPIEN02) ;
 N Y
 S Y=$E($P($G(^BPSC(BPIEN02,300)),U,6),3,99)
 Q $S(Y=0:"NOT SPECIFIED",Y=1:"CARDHOLDER",Y=2:"SPOUSE",Y=3:"CHILD",Y=4:"OTHER",1:Y)
 ;
PCN(BPIEN02) ;
 Q $P($G(^BPSC(BPIEN02,100)),U,4)
 ;
 ; Get the Payer Sheet Version Number.
GETVER(BPIEN02) ;
 N BPSVER
 S BPSVER=$P($G(^BPSC(BPIEN02,100)),U,2)
 I $G(BPSVER)]"" S BPSVER=$E(BPSVER,1)_"."_$E(BPSVER,2,99)
 Q BPSVER
 ;
BIN(BPIEN02) ;
 Q $P($G(^BPSC(BPIEN02,100)),U,1)
 ;
 ;insurance name by 9002313.57 pointer
INSUR57(BPIEN57) ;
 N BPINSN
 S BPINSN=+$G(^BPSTL(BPIEN57,9))
 Q $P($G(^BPSTL(BPIEN57,10,BPINSN,0)),U,7)
 ;
PHPLANID(BPIEN57) ; Get the Pharmacy Plan ID from the BPS Log of Transactions file
 ; Input - BPSIEN57: IEN from the BPS Log of Transactions file.
 I '$G(BPIEN57) Q ""
 N BPINSN
 S BPINSN=+$G(^BPSTL(BPIEN57,9))
 Q $P($G(^BPSTL(BPIEN57,10,BPINSN,3)),U,3)
 ;
QTY(BPIEN02) ;
 Q $E($P($G(^BPSC(BPIEN02,400,1,440)),U,2),3,99)/1000
 ;
 ;NCPDP Units
UNITS(BPIEN02) ;
 I $G(BPIEN02)="" Q "(  )"
 N X
 S X=$E($P($G(^BPSC(BPIEN02,400,1,600)),U,1),3,99)
 Q $S(X="":"(  )",1:"("_X_")")
 ;
UNTPRICE(BPIEN57) ;
 I $G(BPIEN57)="" Q ""
 Q +$P($G(^BPSTL(BPIEN57,5)),U,2)
 ;
TOTPRICE(BPIEN02) ;
 I $G(BPIEN02)="" Q ""
 N X
 S X=$E($P($G(^BPSC(BPIEN02,400,1,400)),U,30),3,99)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
BILLQTY(BPIEN57) ;
 Q $P($G(^BPSTL(BPIEN57,5)),U,9)
 ;
BILLUNT(BPIEN57) ;
 I $G(BPIEN57)="" Q "(  )"
 N X
 S X=$P($G(^BPSTL(BPIEN57,5)),U,10)
 Q $S(X="":"(  )",1:"("_X_")")
 ;
 ;Ingredient Cost
INGRCST(BPIEN02) ;
 I $G(BPIEN02)="" Q ""
 N X
 S X=$E($P($G(^BPSC(BPIEN02,400,1,400)),U,9),3,99)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
 ;Dispensing Fee Submitted
DISPFEE(BPIEN02) ;
 I $G(BPIEN02)="" Q ""
 N X
 S X=$E($P($G(^BPSC(BPIEN02,400,1,400)),U,12),3,99)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
 ;U&C Charge
UCCHRG(BPIEN02) ;
 I $G(BPIEN02)="" Q ""
 N X
 S X=$E($P($G(^BPSC(BPIEN02,400,1,400)),U,26),3,99)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
 ;Admin Fee
ADMNFEE(BPIEN02) ;
 I $G(BPIEN02)="" Q ""
 N CNT,X,AF
 S AF="",CNT=0 F  S CNT=$O(^BPSC(BPIEN02,400,1,478.01,CNT)) Q:'CNT  D
 . S X=$G(^BPSC(BPIEN02,400,1,478.01,CNT,0))
 . I +$E($P(X,U,2),3,4)=4 S AF=AF+$$DFF2EXT^BPSECFM($E($P(X,U,3),3,10))
 Q $S(AF="":AF,1:$J(AF,0,2))
 ;
 ;get ECME pharmacy division ptr for LOG
LDIV(BPIEN57) ;
 Q +$P($G(^BPSTL(BPIEN57,1)),U,7)
 ;
 ;transaction code
TRCODE(BPIEN02) ;
 Q $P($G(^BPSC(BPIEN02,100)),U,3)
 ;
 ;days supply
DAYSSUPL(BPIEN02) ;
 ;format D5NNN -> NNN
 Q +$E($P($G(^BPSC(BPIEN02,400,1,400)),U,5),3,99)
 ;
 ;display response record
DISPRSP(BPLN,BP59,BPIEN03,BP57,BPSTYPE,BPSDTALT) ;
 ;
 ; Moved to ^BPSSCRL1 for sake of space
 ;
 D DISPRSP^BPSSCRL1
 Q
 ;
RESPREC(BPIEN03,BPSDTALT) ;
 N BPSDT
 S BPSDT=+$P($G(^BPSR(BPIEN03,0)),U,2)
 Q $$DATETIME^BPSSCRU5($S(BPSDT>0:BPSDT,1:BPSDTALT))
 ;
DOSRSP(BPIEN03) ;
 N BPDT
 S BPDT=$P($G(^BPSR(BPIEN03,400)),U,1)\1
 Q $E(BPDT,5,6)_"/"_$E(BPDT,7,8)_"/"_$E(BPDT,1,4)
 ;
TOTAMNT(BPIEN03) ;
 I $G(BPIEN03)="" Q ""
 N X
 S X=$P($G(^BPSR(BPIEN03,1000,1,500)),U,9)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
ICPAID(BPIEN03) ;Ingredient Cost Paid
 I $G(BPIEN03)="" Q ""
 N X
 S X=$P($G(^BPSR(BPIEN03,1000,1,500)),U,6)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
 ; BPS*1*22 - Reconciliation ID
RECONID(BPEIN03) ;
 Q $P($G(^BPSR(BPIEN03,1000,1,"B98")),U,1)
 ;
DFPAID(BPIEN03) ;Dispensing Fee Paid
 I $G(BPIEN03)="" Q ""
 N X
 S X=$P($G(^BPSR(BPIEN03,1000,1,500)),U,7)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
PTRESP(BPIEN03) ;Patient Responsibility
 I $G(BPIEN03)="" Q ""
 N X
 S X=$P($G(^BPSR(BPIEN03,1000,1,500)),U,5)
 Q $S(X="":X,1:$$DFF2EXT^BPSECFM(X))
 ;
MESSAGE(BPIEN03) ;
 Q $P($G(^BPSR(BPIEN03,504)),U)
 ;
ADDMESS(BPIEN03,POS,BPADDMSG) ;
 N ADM,X,QUA,TXT,CON,BPMTMP,L,NEXT
 K BPMTMP,BPADDMSG
 I '$G(BPIEN03) Q
 I '$G(POS) S POS=1
 S (ADM,L)=0 F  S ADM=$O(^BPSR(BPIEN03,1000,POS,130.01,ADM)) Q:'ADM  D
 . S X=$G(^BPSR(BPIEN03,1000,POS,130.01,ADM,0))
 . S TXT=$P($G(^BPSR(BPIEN03,1000,POS,130.01,ADM,1)),U,1)
 . S QUA=$P(X,U,3),CON=$P(X,U,2)
 . ; This should not happen, but if the qualifier is null, set it 
 . ;  to "Z"_concatenated with a unique number so that it follows the
 . ;  other qualifiers.  Per the D0 standard, qualifiers can be 1-9 and
 . ;  A-Z.  ECL limits this to 1-9 but an future ECL may extend this.
 . I QUA="" S L=L+1,QUA="Z"_L
 . S BPMTMP(QUA)=CON_U_TXT
 I '$D(BPMTMP) Q
 S L=0,(QUA,NEXT)="" F  S QUA=$O(BPMTMP(QUA)) Q:QUA=""  D
 . S CON=$P(BPMTMP(QUA),U,1),TXT=$P(BPMTMP(QUA),U,2)
 . I NEXT="+" S BPADDMSG(L)=BPADDMSG(L)_TXT,NEXT=CON Q
 . S L=L+1,BPADDMSG(L)=TXT,NEXT=CON
 Q
 ;
DURTEXT(BPIEN03) ;
 ; DUR FREE TEXT MESSAGE from first instance of DUR PPS RESPONSE
 Q $P($G(^BPSR(BPIEN03,1000,1,567.01,1,0)),U,9)
 ;
DURREAS(BPIEN03) ;
 ; REASON FOR SERVICE CODE from first instance of DUR PPS RESPONSE
 Q $$GET1^DIQ(9002313.1101,"1,1,"_BPIEN03_",",439)
 ;
DURADD(BPIEN03) ;
 ; DUR ADDITIONAL TEXT from first instance of DUR PPS RESPONSE
 Q $P($G(^BPSR(BPIEN03,1000,1,567.01,1,1)),U)
 ;
 ;Payer HPID from response  ***BPS*1*18 IB ICR #6061
HPID(BPIEN03,BP57) ;
 N BPHPD
 Q:$P($G(^BPSR(BPIEN03,560)),U,8)'="01" ""
 S BPHPD=$P($G(^BPSR(BPIEN03,560)),U,9)
 ; 6/25/14 no validation of HPID for this screen
 ;S:BPHPD'="" BPHPD=BPHPD_$P($$HOD^IBCNHUT1(BPHPD,BP57),U,3)
 Q BPHPD
 ;
RXCOB57(BPIEN57) ;
 N BPCOB
 S BPCOB=+$P($G(^BPSTL(BPIEN57,0)),U,14)
 Q $S(BPCOB=2:"SECONDARY",BPCOB=3:"TERTIARY",1:"PRIMARY")
 ;
 ;Display other payer(s)
DISPPYR(BPLN,BPIEN03) ;
 N PYR,PYRDATA,BPSTR1
 S PYR=0 F  S PYR=$O(^BPSR(BPIEN03,1000,1,355.01,PYR)) Q:'PYR  D
 . S PYRDATA=^BPSR(BPIEN03,1000,1,355.01,PYR,1)
 . S BPSTR1="Other Payer Information ("_PYR_")(#"_BPIEN03_")"
 . D SETLINE(.BPLN,BPSTR1_$$LINE^BPSSCRU3(79-$L(BPSTR1),"-"))
 . D SETLINE(.BPLN,"Other Payer ID Count: "_$$PYRIDCNT(BPIEN03,PYR))
 . D SETLINE(.BPLN,"Other Payer ID: "_$P(PYRDATA,U,3))
 . D SETLINE(.BPLN,"Other Payer Coverage Type: "_$P(PYRDATA,U,1))
 . D SETLINE(.BPLN,"Other Payer ID Qualifier: "_$P(PYRDATA,U,2))
 . D SETLINE(.BPLN,"Other Payer Help Desk Phone Number: "_$P(PYRDATA,U,8))
 . D SETLINE(.BPLN,"Other Payer Processor Control Number: "_$P(PYRDATA,U,4))
 . D SETLINE(.BPLN,"Other Payer Effective Date: "_$P(PYRDATA,U,10))
 . D SETLINE(.BPLN,"Other Payer Termination Date: "_$P(PYRDATA,U,11))
 . D SETLINE(.BPLN,"Other Payer Person Code: "_$P(PYRDATA,U,7))
 . D SETLINE(.BPLN,"Other Payer Patient Relationship Code: "_$P(PYRDATA,U,9))
 . D SETLINE(.BPLN,"Other Payer Cardholder ID: "_$P(PYRDATA,U,5))
 . D SETLINE(.BPLN,"Other Payer Group ID: "_$P(PYRDATA,U,6))
 Q
 ;
PYRIDCNT(BPIEN03,PYR) ;
 Q $P($G(^BPSR(BPIEN03,1000,1,355.01,PYR,0)),U)
