RCDPEAD2 ;AITC/CJE - AUTO-DECREASE REPORT ;Nov 23, 2014@12:48:50
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EXCEL(DATA,A1,A2,A3) ; Format EXCEL line
 ; Input:   DATA - ERA line adjustment total
 ;          A1,A2,A3 - ^TMP("RCDPEAP") subscripts
 N CARCAMT,CCTR,DATA1
 S CCTR=0
 F  S CCTR=$O(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)) Q:'CCTR  D
 . ;Display an EXCEL line for each CARC adjustment on the line
 . S DATA1=$G(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)),CARCAMT=$P(DATA1,U,2)
 . W !,$P(DATA,U,1,5)_U_CARCAMT_U_$P(DATA,U,7)_U_DATA1
 Q
 ;
LINE(DIV) ; List selected stations
 ; Input:   DIV()       - Array of selected divisions
 ; Returns: Comma delimited list of selected divisions
 N LINE,P,SUB
 S LINE="",SUB="",P=0
 F  D  Q:'SUB
 . S SUB=$O(DIV(SUB))
 . Q:'SUB
 . S P=P+1,$P(LINE,", ",P)=$G(DIV(SUB))
 Q LINE
 ;
CLAIM(EOBIEN) ; Gets the claim number from AR
 ; Input:   EOBIEN      - Internal IEN for file 361.1
 ; Returns: External Claim Number
 N CLAIM,CLAIMIEN
 Q:'$G(EOBIEN)>0 "(no EOB IEN)"
 S CLAIMIEN=$$GET1^DIQ(361.1,EOBIEN,.01,"I")    ; IEN for file 399
 Q:'CLAIMIEN "(no Claim IEN)"
 S CLAIM=$$GET1^DIQ(430,CLAIMIEN,.01,"I")
 Q:CLAIM="" "(Claim not found)"
 Q CLAIM                                        ; Return claim (nnn-Knnnnnn)
