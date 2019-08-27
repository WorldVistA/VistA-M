RCDPESP6 ;AITC/CJE - ePayment Lockbox Site Parameters - Notify Changes;27 Sept 2018 15:56:10
 ;;4.5;Accounts Receivable;**326,332**;;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ; On entry into parameter edit, save a snapshot of the files
 ; Input: None
 ; Output: ^TMP("RCDPESP6",$J) created by merging in files 344.6, 344.61 and 344.62
 K ^TMP("RCDPESP6",$J)
 M ^TMP("RCDPESP6",$J,344.6)=^RCY(344.6)   ; Save payer exclusions
 M ^TMP("RCDPESP6",$J,344.61)=^RCY(344.61) ; Save parameters
 M ^TMP("RCDPESP6",$J,344.62)=^RCY(344.62) ; Save CARC/RARC auto dec
 Q
EXIT ; On exit from parameter edit, compare snapshot with live files.
 ; Send a mail message if any designated items have changed.
 ; Input: ^TMP("RCDPESP6",$J) created above by merging in files 344.6, 344.61 and 344.62
 ; Output: Mail message (if any parameters have changed)
 ;
 N CHANGES,CHGCNT,LINES,RCMSGTXT,RCSITE,RCSUBJ,XMINSTR,XMTO
 ;
 S CHGCNT=0
 S CHGCNT=$$CHKCHNG(.RCMSGTXT) ; Check for any changes in parameters
 ;
 I 'CHGCNT Q  ; No changes made so don't send message
 ;
 S RCSITE=$$SITE^VASITE()
 S RCSUBJ=$E("ePayments EDI Lockbox Parameters changed "_$P(RCSITE,U,2),1,65)
 D HEADER(.RCMSGTXT,RCSITE)
 ;
 S XMINSTR("FROM")="POSTMASTER"
 ;
 S XMTO(DUZ)="",XMTO("G.RCDPE AUDIT")=""
 ;
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,"RCMSGTXT",.XMTO,.XMINSTR)
 ;
 I $D(^TMP("XMERR",$J)) D
 . N G
 . D MES^XPDUTL("MailMan returned an error.")
 . D MES^XPDUTL("The error text is:")
 . S G=$NA(^TMP("XMERR",$J))
 . F  S G=$Q(@G) Q:G=""  Q:$QS(G,2)'=$J  D MES^XPDUTL("  "_$C(34)_@G_$C(34))
 . D MES^XPDUTL(" * End of Error Text *")
 . K ^TMP("XMERR",$J)
 ;
 K ^TMP("RCDPESP6",$J) ; Clean up saved files
 Q
 ;
HEADER(MSGTXT,RCSITE)  ; Add Header Lines to the mail message text
 ; Input: None
 ; Output: Array MSGTXT passed by reference
 ;
 ; limit subject to 65 chars.
 S MSGTXT(1)=" "
 S MSGTXT(2)="        Site: "_$P(RCSITE,U,2)
 S MSGTXT(3)="    Station # "_$P(RCSITE,U,3)
 S MSGTXT(4)="      Domain: "_$G(^XMB("NETNAME"))
 S MSGTXT(5)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 S MSGTXT(6)="        User: "_$P($G(^VA(200,DUZ,0)),U)
 S MSGTXT(7)=" "
 S MSGTXT(8)=" The following EDI Lockbox Site Parameters were changed: "
 S MSGTXT(9)=" "
 S MSGTXT(10)=$J("",50)_$J("OLD VALUE",10)_"  "_$J("NEW VALUE",10)
 Q
CHKCHNG(LINE) ; Check for changes in EDI Lockbox site parameters
 ; Input: ^TMP("RCDPESP6",$J) - Copy of file 344.6, 344.61 and 344.62 taken on entry
 ; Output: LINE - Change lines to add to the mail message. Passed by reference.
 ; Return: COUNT of the number of changes. 0 if no changes were made.
 N COUNT,DOTS,HEAD,IEN,J,RCDET,REC0,REC1,XNEW,XOLD
 ;
 S (COUNT,HEAD)=0,HEAD("SIZE")=10
 S HEAD("TXT")="ALL PAYERS"
 S HEAD("DETAIL")=""
 S DOTS=$TR($J(" ",40)," ",".")
 ; Check parameters in 344.61 that apply to all payers
 S REC0=$G(^TMP("RCDPESP6",$J,344.61,1,0))
 ;
 ; Auto-post med claims enabled
 S XOLD=$P(REC0,U,2)
 S XNEW=$$GET1^DIQ(344.61,"1,",.02,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-POST MED CLAIMS ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease med enabled
 S XOLD=$P(REC0,U,3)
 S XNEW=$$GET1^DIQ(344.61,"1,",.03,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE MED ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease med days
 S XOLD=$P(REC0,U,4)
 S XNEW=$$GET1^DIQ(344.61,"1,",.04,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Auto-decrease no-pay med enabled
 S XOLD=$P(REC0,U,11)
 S XNEW=$$GET1^DIQ(344.61,"1,",.11,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY MED ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease no-pay med days
 S XOLD=$P(REC0,U,12)
 S XNEW=$$GET1^DIQ(344.61,"1,",.12,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE NO-PAY DAYS DEFAULT",XOLD,XNEW,"D",.COUNT)
 ;
 ; Auto-decrease med amount
 S XOLD=$P(REC0,U,5)
 S XNEW=$$GET1^DIQ(344.61,"1,",.05,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE AMT DEFAULT",XOLD,XNEW,"$",.COUNT)
 ;
 ; TRICARE EFT POST PREVENT DAYS - PRCA*4.5*332
 S XOLD=$P(REC0,U,13)
 S XNEW=$$GET1^DIQ(344.61,"1,",.13,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"TRICARE EFT POST PREVENT DAYS",XOLD,XNEW,"D",.COUNT)
 ;
 S REC1=$G(^TMP("RCDPESP6",$J,344.61,1,1))
 ; Auto-post Rx
 S XOLD=$P(REC1,U,1)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.01,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-POST RX CLAIMS ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Auto-decrease Rx
 S XOLD=$P(REC1,U,2)
 S XNEW=$$GET1^DIQ(344.61,"1,",1.02,"I")
 I XNEW'=XOLD D  ;
 . D LNOUT(.HEAD,.LINE,"AUTO-DECREASE RX ENABLED",XOLD,XNEW,"B",.COUNT)
 ;
 ; Check each payer in 344.6 for changes
 S IEN=0
 F  S IEN=$O(^RCY(344.6,IEN)) Q:'IEN  D  ;
 . S REC0=$G(^TMP("RCDPESP6",$J,344.6,IEN,0))
 . S HEAD=0
 . S HEAD("DETAIL")=$$GET1^DIQ(344.6,IEN_",",.01,"E") ; PRCA*4.5*332
 . S HEAD("TXT")="PAYER: "_HEAD("DETAIL") ; PRCA*4.5*332
 . ; Exclude med claims posting
 . S XOLD=$P(REC0,U,6)
 . S XNEW=$$GET1^DIQ(344.6,IEN_",",.06,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"EXCLUDE MED CLAIMS POSTING",XOLD,XNEW,"B",.COUNT)
 . ; Exclude med claims decrease
 . S XOLD=$P(REC0,U,7)
 . S XNEW=$$GET1^DIQ(344.6,IEN_",",.07,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"EXCLUDE MED CLAIMS DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; Exclude Rx claim posting
 . S XOLD=$P(REC0,U,8)
 . S XNEW=$$GET1^DIQ(344.6,IEN_",",.08,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"EXCLUDE RX CLAIM POSTING",XOLD,XNEW,"B",.COUNT)
 ;
 ; Check each CARC-RARC in 344.62 for changes
 S IEN=0
 F  S IEN=$O(^RCY(344.62,IEN)) Q:'IEN  D  ;
 . S REC0=$G(^TMP("RCDPESP6",$J,344.62,IEN,0))
 . S REC1=$G(^TMP("RCDPESP6",$J,344.62,IEN,1))
 . S HEAD=0
 . S HEAD("DETAIL")=$$GET1^DIQ(344.62,IEN_",",.01,"E") ; PRCA*4.5*332
 . S HEAD("TXT")="CARC/RARK CODE: "_HEAD("DETAIL")
 . S REC0=$G(^TMP("RCDPESP6",$J,344.62,IEN,0))
 . ; CARC auto decrease
 . S XOLD=$P(REC0,U,2)
 . S XNEW=$$GET1^DIQ(344.62,IEN_",",.02,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"CARC AUTO DECREASE",XOLD,XNEW,"B",.COUNT)
 . ; CARC decrease amount
 . S XOLD=$P(REC0,U,6)
 . S XNEW=$$GET1^DIQ(344.62,IEN_",",.06,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"CARC DECREASE AMOUNT",XOLD,XNEW,"$",.COUNT)
 . ;
 . ; CARC auto decrease no-pay
 . S XOLD=$P(REC1,U,1)
 . S XNEW=$$GET1^DIQ(344.62,IEN_",",.08,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"CARC AUTO DECREASE NO-PAY",XOLD,XNEW,"B",.COUNT)
 . ; CARC decrease amount no pay
 . S XOLD=$P(REC1,U,5)
 . S XNEW=$$GET1^DIQ(344.62,IEN_",",.12,"I")
 . I XOLD'=XNEW D  ;
 . . D LNOUT(.HEAD,.LINE,"CARC DECREASE AMOUNT NO-PAY",XOLD,XNEW,"$",.COUNT)
 ;
 Q COUNT
 ;
LNOUT(HEAD,LINE,TXT,XOLD,XNEW,TYPE,COUNT)   ; Format a line for the message
 ; Input: TXT - Description of the changed field
 ;        XOLD - Old Value (Internal format)
 ;        XNEW - New Value (Internal Format)
 ;        Type - "B" - Boolean 1-Yes, 0 - N
 ;               "$" - Dollar amount
 ;               "D" - Days
 ;               "T" - Text
 ; Output: COUNT passed by reference
 ;         HEAD passed by reference
 ;         LINE passed by reference
 ;               
 N RCFDA,RCIENS,RETURN
 ; Output header for this section if not already done 
 I 'HEAD D  ;
 . S COUNT=COUNT+1
 . S LINE(COUNT+HEAD("SIZE"))=HEAD("TXT")
 . S HEAD=1
 ;
 S COUNT=COUNT+1
 S LINE(COUNT+HEAD("SIZE"))=$E(" "_TXT_DOTS,1,50)
 S LINE(COUNT+HEAD("SIZE"))=LINE(COUNT+HEAD("SIZE"))_$J($$FORMAT(XOLD,TYPE),10)_" "_$J($$FORMAT(XNEW,TYPE),10)
 ;
 ;PRCA*4.5*332 - Save changes into multiple 344.611 for history report
 S RCIENS="+1,1,"
 S RCFDA(344.611,RCIENS,.01)=$$NOW^XLFDT()
 S RCFDA(344.611,RCIENS,.02)=DUZ
 S RCFDA(344.611,RCIENS,1)=TXT
 S RCFDA(344.611,RCIENS,2)=HEAD("DETAIL")
 S RCFDA(344.611,RCIENS,3)=$$FORMAT(XOLD,TYPE)
 S RCFDA(344.611,RCIENS,4)=$$FORMAT(XNEW,TYPE)
 D UPDATE^DIE("","RCFDA","RCIENS")
 Q
 ;
FORMAT(VALUE,TYPE) ; Format a value for output - Added for PRCA*4.5*332
 ; Input: VALUE - Value to be formated
 ; TYPE - "$" - Dollar amount, B - Boolean
 ; Return: Formated value
 ;
 S RETURN=VALUE
 I TYPE="B" D  ;
 . S RETURN=$S(VALUE:"YES",1:"NO")
 I TYPE="$" D  ;
 . S RETURN=$FN(VALUE,",",2)
 Q RETURN
 ;
PAYEN ; (EN) On entry into identify payers option, save a snapshot of file 344.6 - Added for PRCA*4.5*332
 ; Input: None
 ; Output: ^TMP("RCDPESP6",$J) created by merging in files 344.6, 344.61 and 344.62
 K ^TMP("RCDPESP6",$J)
 M ^TMP("RCDPESP6",$J,344.6)=^RCY(344.6) ; Save payer exclusions
 Q
PAYEX ; (EN) On exit from identify payers option, compare snapshot with live files. - Added for PRCA*4.5*332
 ; Save changes to the parameter audit multiple 344.611
 ; Input: ^TMP("RCDPESP6",$J) created above by merging in file 344.6
 ; Output: Enties in multiple 344.611 to keep history of payer flag changes
 ;
 N COUNT,DOTS,IEN,REC0,HEAD,LINE,XOLD,XNEW
 ;
 S HEAD=0,HEAD("SIZE")=10
 S DOTS="" F J=1:1:40 S DOTS=DOTS_"."
 ;
 S COUNT=0
 ; Check each payer in 344.6 for changes
 S IEN=0
 F  S IEN=$O(^RCY(344.6,IEN)) Q:'IEN  D  ;
 . S REC0=$G(^TMP("RCDPESP6",$J,344.6,IEN,0))
 . S HEAD("DETAIL")=$$GET1^DIQ(344.6,IEN_",",.01,"E")
 . S HEAD("TXT")="PAYER: "_HEAD("DETAIL")
 . ; Pharmacy Flag
 . S XOLD=$P(REC0,U,9)
 . S XNEW=$$GET1^DIQ(344.6,IEN_",",.09,"I")
 . I (+XOLD)'=(+XNEW) D  ;
 . . D LNOUT(.HEAD,.LINE,"PHARMACY FLAG",XOLD,XNEW,"B",.COUNT)
 . ; Tricare flag
 . S XOLD=$P(REC0,U,10)
 . S XNEW=$$GET1^DIQ(344.6,IEN_",",.1,"I")
 . I (+XOLD)'=(+XNEW) D  ;
 . . D LNOUT(.HEAD,.LINE,"TRICARE FLAG",XOLD,XNEW,"B",.COUNT)
 Q
 ;
