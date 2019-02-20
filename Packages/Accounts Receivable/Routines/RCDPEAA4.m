RCDPEAA4 ;AITC/CJE - AUTO POST AWAITING RESOLUTION (APAR) - LIST OF UNPOSTED EEOBS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**321**;;Build 48;Build 99
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
BLD(P1,P2,RCPROG) ;EP from RCDPEAA1
 ; Build,SORT and output the EEOB list to be displayed on APAR
 ; screen
 ; Input: P1 - "RCDPE_APAR_EEOB_PASS1"
 ; P2 - "RCDPE_APAR_EEOB_PASS2"
 ; RCPROG - "RCDPE-APAR_EEOB_WL"
 ; ^TMP($J,P1,ERAIEN) - Global array of all the ERA records that
 ; passed the filter criteria
 ; Output: ^TMP($J,P2,A1,A2) - B1^B2^B3^B4^B5^B6^B7^B8^B9
 ; See ERALINES for detail
 ; VALMCNT - Total number of lines in the listman body
 N AMTPST,AUTOPDT,BALANCE,ERAIEN,I34441,I344491,IENS,OSEQ,RCDA1,RCDT,RCPT,RCSEQ,RCT,REASON
 N TOTPOSTD,XX,YY
 S (RCT,TOTPOSTD,BALANCE,VALMCNT)=0
 S ERAIEN=0
 ;
 ; 2nd Pass get the data and sort the lines EEOB data lines to be displayed
 F  D  Q:'ERAIEN
 . S ERAIEN=$O(^TMP($J,P1,ERAIEN))
 . Q:'ERAIEN
 . S RCSEQ=0
 . F  D  Q:'RCSEQ
 . . S RCSEQ=$O(^RCY(344.49,ERAIEN,1,"B",RCSEQ))
 . . Q:'RCSEQ
 . . Q:RCSEQ#1'=0
 . . S RCDA1=+$O(^RCY(344.49,ERAIEN,1,"B",RCSEQ,0))
 . . Q:'RCDA1
 . . S I344491=RCDA1_","_ERAIEN_","                 ; IENS for subfile 344.491
 . . S AMTPST=$$GET1^DIQ(344.491,I344491,.03,"I") ; Amount to post on Receipt
 . . Q:+AMTPST=0  ; Ignore zero value lines
 . . S OSEQ=$$GET1^DIQ(344.491,I344491,.09,"E") ; Original ERA sequence #s
 . . S I34441=+OSEQ_","_ERAIEN_","                  ; IENS for subfile 344.41
 . . S RCPT=$$GET1^DIQ(344.41,I34441,.25,"I") ; Internal Receipt IEN (file 344)
 . . S REASON=$$GET1^DIQ(344.41,I34441,5) ; External Auto-Post Reject Reason
 . . ;
 . . ; If we have a receipt, add the Amount to Post to the total posted amount
 . . S:RCPT'="" TOTPOSTD=TOTPOSTD+AMTPST
 . . ;
 . . ; If we have don't have a receipt, calculate the unposted balance
 . . I RCPT="" D
 . . . S XX=$$GET1^DIQ(344.49,ERAIEN_",",.03,"I") ; Total Payment Received
 . . . S BALANCE=XX-TOTPOSTD
 . . ;
 . . ; Only display EEOBs that do not have a receipt and aren't marked for auto-post
 . . S YY=$$GET1^DIQ(344.41,I34441,6,"I") ; Mark for Auto-Post flag of the ERA detail ln
 . . I RCPT="",'YY D
 . . . S RCT=RCT+1
 . . . S XX=$$GET1^DIQ(344.4,ERAIEN_",",.01,"I") ; ERA Number
 . . . S $P(RCARRY(RCT),"^",1)=XX
 . . . S $P(RCARRY(RCT),"^",2)=+OSEQ                ; Original ERA Detail Sequence Numbers
 . . . S XX=$$GET1^DIQ(344.491,I344491,.02,"E")     ; Claim Number
 . . . S $P(RCARRY(RCT),"^",3)=XX
 . . . S $P(RCARRY(RCT),"^",4)=RCDA1                ; Internal IEN for subfile 344.491
 . . . S $P(RCARRY(RCT),"^",5)=REASON               ; Reason on APAR
 . I $D(RCARRY) D
 . . S RCDT=$$GET1^DIQ(344.4,ERAIEN_",",.07,"I") ; ERA File Date/Time for sort
 . . S AUTOPDT=$$GET1^DIQ(344.4,ERAIEN_",",4.01,"I") ; Internal Auto-Post Date
 . . S XX=$$GET1^DIQ(344.4,ERAIEN_",",.03,"I") ; Payer ID
 . . S YY=$$GET1^DIQ(344.4,ERAIEN_",",.06,"I") ; Payer Name
 . . D ERALINES(ERAIEN,.RCARRY,BALANCE,TOTPOSTD,AUTOPDT,RCDT,XX,YY,P2)
 . . K RCARRY
 . S (BALANCE,TOTPOSTD)=0 ; Reset posted and unposted balances
 ;
 ; Final Pass - build the display lines and load the listman template
 D BOUT(P2,.VALMCNT)
 Q
 ;
ERALINES(RCDA,RCARRY,BALANCE,TOTPOSTD,POSTDT,FILEDT,PAYID,PAYNM,P2) ; Build sorted list
 ; Input: RCDA - Top file ien for files 344.4 and 344.49
 ; RCARRY(CTR) - A1^A2^A3^A4 Where:
 ; A1 - ERA Number
 ; A2 - Original Sequence Numbers
 ; A3 - Claim Number
 ; A4 - Internal IEN for subfile 344.491
 ; A5 - Reason on APAR
 ; BALANCE - Amount that is left to be posted 
 ; TOTPOSTD - Total amount posted thus far against the ERA
 ; POSTDT - Latest auto-posted date
 ; FILEDT - Date/Time the ERA was filed
 ; PAYID - Payer id
 ; PAYNM - Payer name
 ; P2 - "RCDPE_APAR_EEOB_PASS2"
 ; REASON - External Auto-Post Reject Reason
 ; Output: ^TMP($J,P2,A1,A2) = B1^B2^B3^B4^B5^B6^B7^B8^B9 Where:
 ; A1 - Uppercased value of the selected sort field
 ; A2 - Internal IEN of the ERA record
 ; B1 - Line Number
 ; B2 - ERA #.Sequence # (max 19 10+"."+8 characters)
 ; B3 - Claim # (max 15 characters)
 ; B4 - Posted Amount (max 15 characters)
 ; B5 - External Post Date (8 characters)
 ; B6 - Unposted Balance (max 15 characters)
 ; B7 - Payer Name/Payer ID (max 76 characters)
 ; B8 - Internal IEN for subfile 344.491
 ; B9 - Auto-Post Reject Reason
 ; B10 - Date ERA Filed
 N A1,DLINE,RCT,REASON,X,XX
 S RCT=""
 F  D  Q:RCT=""
 . S RCT=$O(RCARRY(RCT))
 . Q:RCT=""
 . S REASON=$P(RCARRY(RCT),"^",5)
 . S A1=$$SORTP(BALANCE,TOTPOSTD,PAYNM,REASON,FILEDT) ; Get Sort Value
 . I A1="" S A1=" " ; Set null sort value to space to avoid subscript error 
 . S DLINE=RCT                                      ; Line Number
 . S XX=$P(RCARRY(RCT),U,1)_"."_$P(RCARRY(RCT),U,2) ; ERA #.Sequence #
 . S $P(DLINE,"^",2)=XX
 . S $P(DLINE,"^",3)=$P(RCARRY(RCT),U,3)            ; Claim #
 . S $P(DLINE,"^",4)=TOTPOSTD                       ; Posted Amount
 . S $P(DLINE,"^",5)=$$FMTE^XLFDT(POSTDT,"2ZD")     ; External Post Date
 . S $P(DLINE,"^",6)=BALANCE                        ; Unposted Balance
 . S $P(DLINE,"^",7)=PAYNM_"/"_PAYID                ; Payer Name/ID
 . S $P(DLINE,"^",8)=$P(RCARRY(RCT),"^",4)          ; Internal IEN for subfile 344.491
 . S $P(DLINE,"^",9)=REASON                         ; Auto-Post Reject Reason
 . S $P(DLINE,"^",10)=$$FMTE^XLFDT($P(FILEDT,".",1),"2ZD") ; External Date ERA Filed
 . S ^TMP($J,P2,A1,RCDA,RCT)=DLINE
 Q
 ;
BOUT(P2,VALMCNT) ; Build the display lines and load into the listman template
 ; Input: P2 - "RCDPE_APAR_EEOB_PASS2"
 ; ^TMP($J,P2,A1,A2) - B1^B2^B3^B4^B5^B6^B7^B8
 ; See ERALINES for detail
 ; Output: VALMCNT - Total # of body lines
 ; ^TMP("RCDPE-APAR_EEOB_WL",$J,VALMCNT,0) - Listman Body line
 ; ^TMP("RCDPE-APAR_EEOB_WL",$J,"IDX",VALMCNT,RCSEQ) - Line selection index
 ; ^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ) - A1^A2^A3^...An Where
 ; A1 - Line selection #
 ; A2 - Internal IEN for 344.4
 ; A3 - Internal IEN for 344.491
 ; A4 - Unposted Balance
 ; A5 - Posted Amount
 N A1,BALANCE,COUNT,DLINE,ERAIEN,RCT,TOTPOSTDX,XX
 S A1="",COUNT=0
 F  D  Q:A1=""
 . S A1=$O(^TMP($J,P2,A1))
 . Q:A1=""
 . S ERAIEN=""
 . F  D  Q:ERAIEN=""
 . . S ERAIEN=$O(^TMP($J,P2,A1,ERAIEN))
 . . Q:ERAIEN=""
 . . S RCT=""
 . . F  D  Q:RCT=""
 . . . S RCT=$O(^TMP($J,P2,A1,ERAIEN,RCT))
 . . . Q:RCT=""
 . . . S XX=^TMP($J,P2,A1,ERAIEN,RCT)
 . . . S COUNT=COUNT+1 ; Selection #
 . . . S DLINE=$J(COUNT,3)
 . . . S DLINE=DLINE_$J("",7)_$$LJ^XLFSTR($P(XX,"^",2),17) ; ERA #.Sequence #
 . . . S DLINE=DLINE_$$LJ^XLFSTR($P(XX,"^",3),14)          ; Claim #
 . . . S TOTPOSTD=$P(XX,"^",4)
 . . . S DLINE=DLINE_$J(TOTPOSTD,13,2)_" "                 ; Posted Amount
 . . . ; S DLINE=DLINE_$P(XX,"^",5)_"   "                    ; Posted Date
 . . . S DLINE=DLINE_$P(XX,"^",10)_"   "                   ; Date ERA filed
 . . . S BALANCE=$P(XX,"^",6)
 . . . S DLINE=DLINE_$J(BALANCE,13,2)_" "                  ; Unpaid Balance
 . . . ; S DLINE=DLINE_$P(XX,"^",10)                         ; Date ERA filed
 . . . S DLINE=DLINE_$P(XX,"^",5)                          ; Posted Date
 . . . ;
 . . . ; Line 1 of displayed EEOB item
 . . . D SET(DLINE,COUNT,ERAIEN,$P(XX,"^",8),BALANCE,TOTPOSTD,.VALMCNT)
 . . . ;
 . . . ; Line 2 of displayed EEOB item: payer name/payer id
 . . . S DLINE=$J("",5)_$$PAYTIN^RCDPRU2($P(XX,"^",7),75)
 . . . D SET(DLINE,COUNT,ERAIEN,$P(XX,"^",8),BALANCE,TOTPOSTD,.VALMCNT)
 . . . ;
 . . . ; Line 3 of displayed EEOB item: Auto-Post Reject Reason
 . . . S DLINE=$J("",5)_$P(XX,"^",9)
 . . . D SET(DLINE,COUNT,ERAIEN,$P(XX,"^",8),BALANCE,TOTPOSTD,.VALMCNT)
 Q
 ;
SORTP(BALANCE,TOTPOSTD,PAYNM,REASON,FILEDT) ; Get the value for the selected sort
 ; Input: BALANCE - Unpaid Balance
 ; TOTPOSTD - Posted Amount
 ; POSTDT - Internal Posted Datge
 ; PAYNM - Payer Name
 ; REASON - External Auto-Post Reject Reason
 ; FILEDT - Internal Date/Time the ERA was filed
 ; ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")- Selected sort (P/D/A/T)
 ; Returns: External value for the selected sort type
 N VALUE,XX,YY
 S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")
 S YY=$P(XX,"^",2),XX=$P(XX,"^",1)
 S YY=$S(YY="H":-1,1:1)
 I XX="N" Q $$UP^XLFSTR(PAYNM)  ; Sort by Payer Name
 I XX="R" Q $$UP^XLFSTR(REASON) ; Sort by Auto-post Reject Reason
 I XX="D" Q FILEDT*YY           ; Sort by Date/Time ERA filed
 I XX="U" Q BALANCE*YY          ; Sort by Unposted Balance
 Q TOTPOSTD*YY                  ; Sort by Posted Amount
 ;
SET(DLINE,RCSEQ,ERAIEN,RCDA1,BALANCE,TOTPOSTD,VALMCNT) ; Set ListManager arrays
 ; Input: DLINE - Line to be displayed in the listman body
 ; RCSEQ - Line Selection number
 ; ERAIEN - Internal IEN for 344.4 or 344.49
 ; RCDA1 - Inernal IEN for subfile 344.491
 ; BALANCE - Unposted Balance
 ; TOTPOSTD - Posted Amount
 ; VALMCNT - Current listman body line count
 ; Output: VALMCNT - Updated listman body line count
 ; ^TMP("RCDPE-APAR_EEOB_WL",$J,VALMCNT,0) - Listman Body line
 ; ^TMP("RCDPE-APAR_EEOB_WL",$J,"IDX",VALMCNT,RCSEQ) - Line selection index
 ; ^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ) - A1^A2^A3^...An Where
 ; A1 - Line selection #
 ; A2 - Internal IEN for 344.4
 ; A3 - Internal IEN for 344.491
 ; A4 - Unposted Balance
 ; A5 - Posted Amount
 S VALMCNT=VALMCNT+1
 S ^TMP("RCDPE-APAR_EEOB_WL",$J,VALMCNT,0)=DLINE
 S ^TMP("RCDPE-APAR_EEOB_WL",$J,"IDX",VALMCNT,RCSEQ)=ERAIEN
 S ^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ)=VALMCNT_U_ERAIEN_U_RCDA1_U_$G(BALANCE)_U_$G(TOTPOSTD)
 Q
 ;
