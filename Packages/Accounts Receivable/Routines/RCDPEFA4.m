RCDPEFA4 ;AITC/CJE - 1ST PARTY AUTO VS MANUAL DECREASE REPORT CONT.;Jun 06, 2014@19:11:19 ; 6/27/19 10:06am
 ;;4.5;Accounts Receivable;**345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
LMOUT(INPUT,RCVAUTD,IO) ; Compile and output report to List Manager
 ; Input:   INPUT   - see REPORT for description
 ;          RCVAUTD - Array of selected Divisions
 ;          IO      - Device array
 ; Output:  ^TMP("RCDPE_LAR",$J,nn) - Array of display lines (no headers)
 N DISP,HDR,HDRINFO,Z0
 D REPORT^RCDPEFA3(INPUT,.RCVAUTD,.IO)           ; Get lines to be displayed
 S DISP=$P(INPUT,"^",2)
 D HINFO(INPUT,.HDRINFO)
 S HDR("TITLE")="First Party Manual vs Auto"
 S HDR(1)=$J("Run Date: ",34)_HDRINFO("RUNDATE")
 S Z0="DIVISIONS: "_HDRINFO("DIVISIONS")
 S HDR(2)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S HDR(3)="               Date Range: "_HDRINFO("START")_" - "_HDRINFO("END")_" (Date of Latest Decrease)"
 S HDR(4)=$J("",80-$L(HDRINFO("SORT"))\2)_HDRINFO("SORT")
 S HDR(5)=" "
 I DISP="D" S HDR(6)="              3rd Party             Copay   Auto-Decr  Man Decr  Total Decr  Rel"
 E  S HDR(6)="                                    Copay   Auto-Decr  Man Decr  Total Decr  Rel"
 I DISP="D" S HDR(7)="COPAY Bill #    Bill#      Date      Amt      Amt        Amt         Amt    Hold"
 E  S HDR(7)="                                     Amt      Amt        Amt         Amt    Hold"
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP("RCDPE_ADP3",$J))) ; Generate ListMan display
 K ^TMP("RCDPEFADP3",$J),^TMP($J,"RCDPEFADP3"),^TMP("RCDPE_ADP3",$J)
 Q
 ;
HINFO(INPUTS,HDRINFO) ; Get header information
 ; Input:   INPUTS  - See REPORT for description
 ;          HDRINFO - Header array for ListMan, passed by ref.
 N XX
 S XX=$P(INPUTS,U,4)                        ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 S XX=$P(INPUTS,U,2)                        ; Sort Type
 S HDRINFO("SORT")="Sorted By: Claim - "_$S($P(INPUTS,U,3)="L":"Last to First",1:"First to Last")
 S HDRINFO("SORT")=HDRINFO("SORT")_"  Display: "_$S($P(INPUTS,U,2)="S":"Summary",1:"Detail")
 ;
 ; Format Division filter
 S XX=$P(INPUTS,U,1)                        ; 1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE^RCDPEFA3(.RCVAUTD),1:"ALL")
 Q
 ;
BULL(TYPE) ; Produce bulletin for weekly summary report
 ; Input: TYPE = W - Weekly, M - Monthly
 ; Output: MailMan bulletin with one week summary report all divisions
 N DT,GLB,HDR,HDRINFO,INPUTS,J,LCNT,RCNT,X,XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR,Y,Z0
 S GLB=$NA(^TMP("RCDPEFA4",$J,"XMTEXT"))
 K @GLB
 S INPUTS="1^S^F^" ; All divisions^SUMMARY^Sort Claims First to Last
 S DT=$$DT^XLFDT()
 I TYPE="W" S INPUTS=INPUTS_$$FMADD^XLFDT(DT,-7)_"|"_DT_"^" ; Date Range last 7 days
 I TYPE="M" D                                               ; Date Range previous Month
 . S X=$E(DT,1,5)_"01"
 . S Y=$$FMADD^XLFDT(X,-1)
 . S INPUTS=INPUTS_$E(Y,1,5)_"01"_"|"_Y_"^"
 S INPUTS=INPUTS_"1" ; Use ListMan format to get data in arrays
 ;
 K ^TMP("RCDPEFADP3",$J),^TMP("RCDPE_ADP3",$J) ; Clear ^TMP global
 D REPORT^RCDPEFA3(INPUTS,.RCVAUTD,.IO)
 D HINFO(INPUTS,.HDRINFO)
 S HDR("TITLE")="First Party Manual vs Auto"
 S RCNT=1
 S @GLB@(RCNT)=$J("",80-$L(HDR("TITLE"))\2)_HDR("TITLE")
 S RCNT=RCNT+1
 S Z0="Run Date: "_HDRINFO("RUNDATE")
 S @GLB@(RCNT)=$J("",80-$L(Z0)\2)_Z0
 S RCNT=RCNT+1
 S @GLB@(RCNT)="               Date Range: "_HDRINFO("START")_" - "_HDRINFO("END")_" (Date of Latest Decrease)"
 S RCNT=RCNT+1
 S @GLB@(RCNT)=$J("",80-$L(HDRINFO("SORT"))\2)_HDRINFO("SORT")
 S RCNT=RCNT+1
 S @GLB@(RCNT)=" "
 S RCNT=RCNT+1
 S @GLB@(RCNT)="                                    Copay   Auto-Decr   Man Decr  Total Decr"
 S RCNT=RCNT+1
 S @GLB@(RCNT)="                                     Amt      Amt         Amt         Amt    RH"
 S RCNT=RCNT+1
 S Z0="" F J=1:1:79 S Z0=Z0_"-"
 S @GLB@(RCNT)=Z0
 S RCNT=RCNT+1
 ;
 S LCNT=0
 F  S LCNT=$O(^TMP("RCDPE_ADP3",$J,LCNT)) Q:'LCNT  D  ; 
 . S @GLB@(RCNT)=$E(^TMP("RCDPE_ADP3",$J,LCNT),2,80)
 . S RCNT=RCNT+1
 ;
 ;Transmit mail message
 S XMDUZ=DUZ,XMTEXT=GLB
 S XMSUB=HDR("TITLE")
 S XMY("I:G.FIRST PARTY COPAY DECREASE")=""
 S XMINSTR("FROM")="POSTMASTER"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 ;
 K @GLB
 K ^TMP("RCDPEFADP3",$J),^TMP("RCDPE_ADP3",$J) ; Clear ^TMP global
 Q
