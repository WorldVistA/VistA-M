RCDPESP6 ;AITC/CJE - ePayment Lockbox Site Parameters - Notify Changes;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**326,332,345,349**;;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; EP from RCDPESP
 ; On entry into parameter edit, save a snapshot of the files
 ; Input: None
 ; Output: ^TMP("RCDPESP6",$J) for files 344.6, 344.61 and 344.62
 K ^TMP("RCDPESP6",$J)
 M ^TMP("RCDPESP6",$J,344.6)=^RCY(344.6)  ; RCDPE AUTO-PAY EXCLUSION
 M ^TMP("RCDPESP6",$J,344.61)=^RCY(344.61)  ; RCDPE PARAMETER
 M ^TMP("RCDPESP6",$J,344.62)=^RCY(344.62)  ; RCDPE CARC-RARC AUTO DEC
 Q
 ;
EXIT ; EP from RCDPESP
 ; On exit compare snapshots with files
 ; sends mail message if any designated items have changed.
 ; Input: ^TMP($T(+0),$J) copies of files 344.6, 344.61 and 344.62
 ; Output: Mail message (if any parameters have changed)
 ;
 N C,CHANGES,CHGCNT,G,LINES,RCMSGTXT,RCSITE,RCSUBJ,TXTLNS,XMINSTR,XMTO
 ;Check for changed parameters, if no changes, don't send message
 S CHGCNT=$$CHKCHNG(.RCMSGTXT)              ; Check for any changes in parameters ;
 Q:'CHGCNT                                  ; No changes made so don't send message
 ;
 S RCSITE=$$SITE^VASITE()
 S RCSUBJ=$E("ePayments EDI Lockbox Parameters changed "_$P(RCSITE,U,2),1,65)
 D HEADER(.RCMSGTXT,RCSITE)
 ;
 S XMINSTR("FROM")="POSTMASTER",XMTO(DUZ)="",XMTO("G.RCDPE AUDIT")=""
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,"RCMSGTXT",.XMTO,.XMINSTR)
 ;
 I $D(^TMP("XMERR",$J)) D
 . D MES^XPDUTL("MailMan returned an error.")
 . D MES^XPDUTL("The error text is:")
 . S G=$NA(^TMP("XMERR",$J))
 . F  S G=$Q(@G) Q:G=""  Q:$QS(G,2)'=$J  D MES^XPDUTL("  "_$C(34)_@G_$C(34))
 . D MES^XPDUTL(" * End of Error Text *")
 . K ^TMP("XMERR",$J)
 ;
 K ^TMP("RCDPESP6",$J)  ; Clean up
 Q
 ;
 ; PRCA*4.5*349 - Re-write subroutine
HEADER(MSGTXT,RCSITE)  ; Add Header Lines to mail message text - PRCA*4.5*349 add RCSITE param
 ; Output:  Array MSGTXT passed by reference
 ; limit subject to 65 chars.
 S MSGTXT(1)=" "
 S MSGTXT(2)=" Site: "_$P(RCSITE,U,2)
 S MSGTXT(3)=" Station # "_$P(RCSITE,U,3)
 S MSGTXT(4)=" Domain: "_$G(^XMB("NETNAME"))
 S MSGTXT(5)=" Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 S MSGTXT(6)=" User: "_$P($G(^VA(200,DUZ,0)),U)
 S MSGTXT(7)=" "
 S MSGTXT(8)=" The following EDI Lockbox Site Parameters were changed: "
 S MSGTXT(9)=" "
 S MSGTXT(10)=$J("",50)_$J("OLD VALUE",10)_" "_$J("NEW VALUE",10)
 Q
 ;
CHKCHNG(LINE) ;function, check for changes in EDI Lockbox site parameters
 ; PRCA*4.5*345 - Added checks for Auto-Decrease Rx/TRICARE parameters
 ; Input:   
 ; ^TMP($T(+0),$J): Copies of file 344.6, 344.61 and 344.62 taken on entry
 ;Output:  
 ; LINE: Change for mail message, Passed by reference
 ; Returns number of changes
 N COUNT,HEAD,REC0,REC1,REC2,XNEW,XOLD
 S (COUNT,HEAD)=0,HEAD("SIZE")=10
 S HEAD("TXT")="ALL PAYERS",HEAD("DETAIL")=""
 ;
 ; Check parameters in 344.61 that apply to all payers
 ; PRCA*4.5*345 added new subroutines
 D MEDCHNG(.HEAD,.COUNT,.LINE)  ; Medical parameter changes
 D RXCHNG(.HEAD,.COUNT,.LINE)  ; Pharmacy parameter changes
 D TRICHNG(.HEAD,.COUNT,.LINE) ; PRCA*4.5*349 - Check for TRICARE parameter changes
 D PAYEXC(.COUNT,.LINE)  ; Payer exclusions parameter changes
 D CARCHNG(.COUNT,.LINE)  ; CARC-RARC parameter changes
 Q COUNT
 ;
MEDCHNG(HEAD,COUNT,LINE)  ; Check for Medical site parameter changes - PRCA*4.5*345
 ;these parameters passed by reference:
 ; HEAD: See LNOUT for details
 ; COUNT: count of parameter changes
 ; LINE: Array of site parameter changes
 N MEDND,XNEW,XOLD
 S MEDND=^TMP($T(+0),$J,344.61,1,0)
 ; Auto-post med claims enabled
 S XOLD=$P(MEDND,U,2),XNEW=$$GET1^DIQ(344.61,"1,",.02,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"AUTO-POST MED CLAIMS ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease med enabled
 S XOLD=$P(MEDND,U,3),XNEW=$$GET1^DIQ(344.61,"1,",.03,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE MED ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease med days
 S XOLD=$P(MEDND,U,4),XNEW=$$GET1^DIQ(344.61,"1,",.04,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Auto-decrease no-pay med enabled
 S XOLD=$P(MEDND,U,11),XNEW=$$GET1^DIQ(344.61,"1,",.11,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY MED ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease no-pay med days
 S XOLD=$P(MEDND,U,12),XNEW=$$GET1^DIQ(344.61,"1,",.12,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Maximum dollar amount to Auto-Decrease medical claims
 S XOLD=$P(MEDND,U,5),XNEW=$$GET1^DIQ(344.61,"1,",.05,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE MED MAX AMT",XOLD,XNEW,"$",.COUNT)
 Q
 ;
RXCHNG(HEAD,COUNT,LINE)  ; Check for Rx site parameter changes PRCA*4.5*345
 ;these parameters passed by reference:
 ; HEAD: See LNOUT for details
 ; COUNT: count of parameter changes
 ; LINE: Array of site parameter changes
 N RXND,XNEW,XOLD
 S RXND=$G(^TMP($T(+0),$J,344.61,1,1))
 ; Auto-Post Rx
 S XOLD=$P(RXND,U,1),XNEW=$$GET1^DIQ(344.61,"1,",1.01,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-POST RX CLAIMS ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-Decrease Rx enabled
 S XOLD=$P(RXND,U,2),XNEW=$$GET1^DIQ(344.61,"1,",1.02,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE RX ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease Rx days
 S XOLD=$P(RXND,U,3),XNEW=$$GET1^DIQ(344.61,"1,",1.03,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE RX DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Maximum dollar amount to Auto-Decrease Rx claims
 S XOLD=$P(RXND,U,4),XNEW=$$GET1^DIQ(344.61,"1,",1.04,"I")
 I XNEW'=XOLD D LNOUT(.HEAD,.LINE,"AUTO-DECREASE RX MAX AMT",XOLD,XNEW,"$",.COUNT)
 Q
 ;
 ; PRCA*4.5*349 - Subroutine re-written
TRICHNG(HEAD,COUNT,LINE) ; Check for TRICARE site parameter changes
 ; Input:  HEAD - See subroutine LNOUT for details
 ;         COUNT - Current # of parameter changes
 ;         LINE - Array of current site parameter changes
 ; Output: COUNT - Updated # of parameter changes
 ;         LINE - Array of updated site parameter changes
 ;
 N REC0,REC1,XNEW,XOLD
 S REC0=^TMP("RCDPESP6",$J,344.61,1,0) ; Original Site parameters
 S REC1=^TMP("RCDPESP6",$J,344.61,1,1)
 ; Auto-post TRICARE claims enabled
 S XOLD=$P(REC1,U,5)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.05,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"AUTO-POST TRI CLAIMS ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease TRICARE enabled
 S XOLD=$P(REC1,U,6)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.06,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE TRI ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease TRICARE days
 S XOLD=$P(REC1,U,8)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.08,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE TRI DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Auto-decrease no-pay TRICARE enabled
 S XOLD=$P(REC1,U,9)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.09,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY TRI ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease no-pay TRICARE days
 S XOLD=$P(REC1,U,10)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.1,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY TRI DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Maximum dollar amount to Auto-Decrease TRICARE claims
 S XOLD=$P(REC1,U,7)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.07,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE TRI MAX AMT",XOLD,XNEW,"$",.COUNT)
 ;
 ; TRICARE EFT POST PREVENT DAYS - PRCA*4.5*332
 S XOLD=$P(REC0,U,13)
 S XNEW=$$GET1^DIQ(344.61,"1,",.13,"I")
 I XNEW'=XOLD D
 . D LNOUT(.HEAD,.LINE,"TRICARE EFT POST PREVENT DAYS",XOLD,XNEW,"D",.COUNT)
 Q
 ;
PAYEXC(COUNT,LINE)  ; Check for Payer Auto-Post and Auto-Decrease exclusions PRCA*4.5*345
 ;Input:
 ; COUNT: count of parameter changes
 ; LINE: Array of site parameter changes
 ; ^TMP($T(+0),$J,344.6): Original Payer exclusions
 ;Output:
 ; COUNT: Updated # of parameter changes
 ; LINE: Array of updated site parameter changes
 N IEN,REC0,XNEW,XOLD
 ;
 ; Check each payer in 344.6 for changes
 S IEN=0 F  S IEN=$O(^RCY(344.6,IEN)) Q:'IEN  D
 . S REC0=$G(^TMP($T(+0),$J,344.6,IEN,0))
 . S HEAD=0
 . S HEAD("DETAIL")=$$GET1^DIQ(344.6,IEN_",",.01,"E"),HEAD("TXT")="PAYER: "_HEAD("DETAIL")  ; PRCA*4.5*332
 . ; Exclude med claims posting
 . S XOLD=$P(REC0,U,6),XNEW=$$GET1^DIQ(344.6,IEN_",",.06,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE MED CLAIMS POSTING",XOLD,XNEW,"B",.COUNT)
 . ;
 . ; Exclude med claims decrease
 . S XOLD=$P(REC0,U,7),XNEW=$$GET1^DIQ(344.6,IEN_",",.07,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE MED CLAIMS DECREASE",XOLD,XNEW,"B",.COUNT)
 . ;
 . ; Exclude Rx claim posting
 . S XOLD=$P(REC0,U,8),XNEW=$$GET1^DIQ(344.6,IEN_",",.08,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE RX CLAIM POSTING",XOLD,XNEW,"B",.COUNT)
 . ;
 . ; Exclude Rx claims decrease
 . S XOLD=$P(REC0,U,12),XNEW=$$GET1^DIQ(344.6,IEN_",",.12,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE RX CLAIMS DECREASE",XOLD,XNEW,"B",.COUNT)
 . ;
 . ; PRCA*4.5*349 - Begin modified block
 . ; Exclude TRICARE claims posting
 . S XOLD=$P(REC0,U,13),XNEW=$$GET1^DIQ(344.6,IEN_",",.13,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE TRICARE CLAIMS POSTING",XOLD,XNEW,"B",.COUNT)
 . ;
 . ; Exclude TRICARE claims decrease
 . S XOLD=$P(REC0,U,14),XNEW=$$GET1^DIQ(344.6,IEN_",",.14,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"EXCLUDE TRICARE CLAIMS DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; PRCA*4.5*349 - End modified block
 Q
 ;
CARCHNG(COUNT,LINE)  ; Check for CARC-RARC parameter changes
 ; PRCA*4.5*345 - New method
 ;Input, passed by reference:
 ; COUNT: # of parameter changes
 ; LINE: array of site parameter changes
 ; ^TMP($T(+0),$J,344.62): Original CARC-RARC values
 ;Output:
 ; COUNT: updated # of parameter changes
 ; LINE: updated array
 N IEN,REC,XNEW,XOLD
 ;
 ; Check entries in 344.62 for changes
 S IEN=0 F  S IEN=$O(^RCY(344.62,IEN)) Q:'IEN  D
 . S REC(0)=$G(^TMP($T(+0),$J,344.62,IEN,0))
 . S REC(1)=$G(^TMP($T(+0),$J,344.62,IEN,1))
 . S REC(2)=$G(^TMP($T(+0),$J,344.62,IEN,2))
 . S REC(3)=$G(^TMP($T(+0),$J,344.62,IEN,3)) ; PRCA*3.4*349 TRICARE Auto-Decrease
 . S HEAD=0
 . S HEAD("DETAIL")=$$GET1^DIQ(344.62,IEN_",",.01,"E") ; PRCA*4.5*332
 . S HEAD("TXT")="CARC/RARC CODE: "_HEAD("DETAIL")
 . ;
 . ; PRCA*4.5*345 - Changed descriptions below
 . ; CARC Medical Claims w/Payments Auto-Decrease
 . S XOLD=$P(REC(0),U,2),XNEW=$$GET1^DIQ(344.62,IEN_",",.02,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC MED PAY AUTO-DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; CARC Medical Claims w/Payments Auto-Decrease amount
 . S XOLD=$P(REC(0),U,6),XNEW=$$GET1^DIQ(344.62,IEN_",",.06,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC MED PAY DECREASE AMOUNT",XOLD,XNEW,"$",.COUNT)
 . ; CARC Medical Claims w/No Payments Auto-Decrease
 . S XOLD=$P(REC(1),U,1),XNEW=$$GET1^DIQ(344.62,IEN_",",.08,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC AUTO-DECREASE MED NO-PAY",XOLD,XNEW,"B",.COUNT)
 . ; CARC Medical Claims w/No Payments Auto-Decrease amount
 . S XOLD=$P(REC(1),U,5),XNEW=$$GET1^DIQ(344.62,IEN_",",.12,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC DECREASE AMOUNT MED NO-PAY",XOLD,XNEW,"$",.COUNT)
 . ; CARC Rx w/Payments Auto-Decrease
 . S XOLD=$P(REC(2),U,1),XNEW=$$GET1^DIQ(344.62,IEN_",",2.01,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC RX PAY AUTO-DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; CARC Rx w/Payments Auto-Decrease amount
 . S XOLD=$P(REC(2),U,5),XNEW=$$GET1^DIQ(344.62,IEN_",",2.05,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC RX PAY DECREASE AMOUNT",XOLD,XNEW,"$",.COUNT)
 . ; PRCA*4.5*349 - Begin Modified Block
 . ; CARC TRICARE w/Payments Auto-Decrease
 . S XOLD=$P(REC(3),U,1),XNEW=$$GET1^DIQ(344.62,IEN_",",3.01,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC TRICARE PAY AUTO-DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; CARC TRICARE w/Payments Auto-Decrease amount
 . S XOLD=$P(REC(3),U,5),XNEW=$$GET1^DIQ(344.62,IEN_",",3.05,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC TRICARE PAY DECREASE AMOUNT",XOLD,XNEW,"$",.COUNT)
  . ; CARC TRICARE w/No Payments Auto-Decrease
 . S XOLD=$P(REC(3),U,7),XNEW=$$GET1^DIQ(344.62,IEN_",",3.07,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC TRICARE AUTO-DECREASE NO-PAY",XOLD,XNEW,"B",.COUNT)
 . ; CARC TRICARE w/No Payments Auto-Decrease amount
 . S XOLD=$P(REC(3),U,11),XNEW=$$GET1^DIQ(344.62,IEN_",",3.11,"I")
 . I XOLD'=XNEW D LNOUT(.HEAD,.LINE,"CARC TRICARE DECREASE AMOUNT NO-PAY",XOLD,XNEW,"$",.COUNT)
 . ; PRCA*4.5*349 - End Modified Block
 Q
 ;
LNOUT(HEAD,LINE,TXT,XOLD,XNEW,TYPE,COUNT)   ; Format a line for the message
 ; PRCA*4.5*345 - Added parameter documentation
 ;Input:  HEAD: 0 if header not output into the line array for this section yet, 1 otherwise
 ;        HEAD("SIZE"): 10
 ;        LINE: array with parameter changes for the current section
 ;        TXT: Description of the changed field
 ;        XOLD: Old Value (Internal format)
 ;        XNEW: New Value (Internal Format)
 ;        TYPE: "B" - Boolean, "$" - Dollar amount, "D" - Days, "T" - Text
 ;        COUNT: count of changes
 ;Output:  HEAD: 1 if it came in as 0
 ;         LINE: Updated array of lines detail parameter changes for the current section
 ;         COUNT: Updated # of changes
 ;
 N DOTS,RCFDA,RCIENS,Y
 S DOTS=$TR($J(" ",50)," ",".")
 ;
 ; Output header for this section if not done 
 I 'HEAD S COUNT=COUNT+1,LINE(COUNT+HEAD("SIZE"))=HEAD("TXT"),HEAD=1
 ;
 S Y=$E(" "_TXT_" "_DOTS,1,50)_$J($$FRMT(XOLD,TYPE),10)_" "_$J($$FRMT(XNEW,TYPE),10)
 S COUNT=COUNT+1,LINE(COUNT+HEAD("SIZE"))=Y
 ;
 ;PRCA*4.5*332 save changes into multiple 344.611 for history report
 S RCIENS="+1,1,"
 S RCFDA(344.611,RCIENS,.01)=$$NOW^XLFDT
 S RCFDA(344.611,RCIENS,.02)=DUZ
 S RCFDA(344.611,RCIENS,1)=TXT
 S RCFDA(344.611,RCIENS,2)=HEAD("DETAIL")
 S RCFDA(344.611,RCIENS,3)=$$FRMT(XOLD,TYPE)
 S RCFDA(344.611,RCIENS,4)=$$FRMT(XNEW,TYPE)
 D UPDATE^DIE("","RCFDA","RCIENS")
 Q
 ;
FRMT(VAL,TP) ;function, format value, added PRCA*4.5*332
 ; Input: VAL - Value to be formatted
 ; TP - "$" - Dollar amount, B - Boolean, D - Days
 ; Returns formatted value
 N RTRN S RTRN=VAL
 S:TP="B" RTRN=$S(VAL:"Yes",1:"No")
 S:TP="$" RTRN="$"_$FN(VAL,",")
 Q RTRN
 ;
PAYEN ; save snapshot of file 344.6, added PRCA*4.5*332
 ; Input: None
 ; Output: ^TMP($T(+0),$J) created by merging in files 344.6, 344.61 and 344.62
 K ^TMP($T(+0),$J)
 M ^TMP($T(+0),$J,344.6)=^RCY(344.6)  ; Save payer exclusions
 Q
 ;
PAYEX ; (EN) On exit from identify payers option, compare snapshot with live files. - Added for PRCA*4.5*332
 ; Save changes to the parameter audit multiple 344.611
 ; Input: ^TMP($T(+0),$J) created above by merging in file 344.6
 ; Output: Enties in multiple 344.611 to keep history of payer flag changes
 ;
 N COUNT,HEAD,IEN,LINE,REC0,XNEW,XOLD
 ;
 S HEAD=0,HEAD("SIZE")=10,COUNT=0
 ; Check each payer in 344.6 for changes
 S IEN=0
 F  S IEN=$O(^RCY(344.6,IEN)) Q:'IEN  D  ;
 . S REC0=$G(^TMP($T(+0),$J,344.6,IEN,0))
 . S HEAD("DETAIL")=$$GET1^DIQ(344.6,IEN_",",.01,"E"),HEAD("TXT")="PAYER: "_HEAD("DETAIL")
 . ; Pharmacy Flag
 . S XOLD=$P(REC0,U,9),XNEW=$$GET1^DIQ(344.6,IEN_",",.09,"I")
 . I (+XOLD)'=(+XNEW) D LNOUT(.HEAD,.LINE,"PHARMACY FLAG",XOLD,XNEW,"B",.COUNT)
 . ; Tricare flag
 . S XOLD=$P(REC0,U,10),XNEW=$$GET1^DIQ(344.6,IEN_",",.1,"I")
 . I (+XOLD)'=(+XNEW) D LNOUT(.HEAD,.LINE,"TRICARE FLAG",XOLD,XNEW,"B",.COUNT)
 Q
 ;
