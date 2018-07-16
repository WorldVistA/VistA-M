RCDPRU2 ;AITC/CJE - CARC REPORT ON PAYER OR CARC CODE ;
 ;;4.5;Accounts Receivable;**321**;;Build 48
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; PRCA*4.5*321 - CARC and Payer report utilities
 ;
 ; Moved from RCDPARC to RCDPRU then to RCDPRU2 - PRCA*4.5*321
SUM(ARRAY,IEN,BILL,CARC,PAYER,BAMT,PAMT,DESC,AAMT,SORT) ; EP
 ; Count Claims and summarize for the report
 ; IEN: IEN from 361.1 file; BILL: The K-Bill number; ITEM: Top level sort item PAYER or CARC to summarize;
 ; BAMT: Billed Amount; PAMT: Paid Amount ; AAMT: Adjustment Amount;
 ; LVL: second level sort (CARC/Payer) ; SORT: "C" is CARC or "P" is Payer first level sort,
 N ITEM,LVL
 I SORT="C" S ITEM=CARC,LVL=PAYER
 E  S ITEM=PAYER,LVL=CARC
 ;
 D:$G(@ARRAY@("~~SUM",ITEM,IEN))'=1  ; If we already counted this claim for CARC or Payer skip
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,3)+PAMT ; Summarize amount paid
 ; Always add in the adjustment (this is a different adjustment each time procedure is called)
 S $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,4)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM")),U,4)+AAMT ; Summarize amount adjusted
 S:SORT="C" $P(@ARRAY@("REPORT",ITEM,"~~SUM"),U,5)=$G(DESC) ; CARC Description
 I (SORT="C")&($G(LVL)'="") D:$G(@ARRAY@("~~SUM",ITEM,IEN))'=1
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,3)+PAMT ; Summarize amount paid
 ;I $G(LVL)'="" D:$G(@ARRAY@("~~SUM",LVL,IEN))'=1
 I (SORT="P")&($G(LVL)'="") D:$G(@ARRAY@("~~SUM",ITEM,IEN,LVL))'=1
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,1)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,1)+1 ; Count claims
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,2)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,2)+BAMT ; Summarize amount billed
 . S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,3)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,3)+PAMT ; Summarize amount paid
 ; Always add in the adjustment (this is a different adjustment each time procedure is called)
 S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,4)=$P($G(@ARRAY@("REPORT",ITEM,"~~SUM",LVL)),U,4)+AAMT ; Summarize amount adjusted
 I SORT="P",$G(LVL)'="" S $P(@ARRAY@("REPORT",ITEM,"~~SUM",LVL),U,5)=DESC ; CARC Description
 ; Get grand totals for report
 D:$G(@ARRAY@("~~SUM",BILL))'=1
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,1)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,1)+1
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,2)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,2)+BAMT
 . S $P(@ARRAY@("~~SUM","CLAIMS"),U,3)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,3)+PAMT
 ; May have more than one adjustment on a bill
 I $G(@ARRAY@("~~SUM",BILL,ITEM))'=1 S $P(@ARRAY@("~~SUM","CLAIMS"),U,4)=$P($G(@ARRAY@("~~SUM","CLAIMS")),U,4)+AAMT ;W "BILL: ",BILL," ITEM: ",ITEM," Adj: ",AAMT,!
 ; Set markers so we don't double count a claim
 S @ARRAY@("~~SUM",ITEM,BILL)=1,@ARRAY@("~~SUM",ITEM,IEN)=1,@ARRAY@("~~SUM",ITEM,IEN,LVL)=1,@ARRAY@("~~SUM",BILL)=1,@ARRAY@("~~SUM",LVL,BILL)=1,@ARRAY@("~~SUM",LVL,IEN)=1
 Q
 ;
PAYTIN(PY,L) ; EP
 ; Truncate Payer/TIN string to L characters for reports
 ; Input:  PY = Payer/TIN string
 ;         L  = Maximum length allowed
 ; Return: Payer/TIN string truncated to length L
 N RETURN,XX,YY,ZZ
 S RETURN=PY
 I $L(PY)>L D
 . S ZZ=$L(PY,"/"),XX=$P(PY,"/",1,ZZ-1),YY=$P(PY,"/",ZZ)
 . S XX=$E(XX,1,L-($L(YY)+1)),RETURN=XX_"/"_YY
 Q RETURN
 ;
PAYTINS(PY,RETURN) ; Get all PAYER/TIN strings for the TIN in PY
 ; Input: PY String with Payer Name/TIN in it
 ; Output: RETURN passed by reference, array of Payer Name/TINS with same TIN as input PY
 N COUNT,NAME,TIN,ZZ
 K RETURN
 S COUNT=0
 S TIN=$P(PY,"/",$L(PY,"/"))
 S ZZ="" F  S ZZ=$O(^RCY(344.6,"C",TIN_" ",ZZ)) Q:ZZ=""  D
 . S NAME=$$GET1^DIQ(344.6,ZZ_",",.01,"E")
 . I NAME'="" D  ;
 . . S COUNT=COUNT+1
 . . S RETURN(COUNT)=NAME_"/"_TIN
 Q
 ;
PAYLIST(ARRAY,TYPE,RETURN) ; Expand list of payers to include ones with the same TIN
 ; Input: ARRAY - array of payer names or IENS
 ;        TYPE  - E=External (Payer Name array) or I=Internal (IEN array)
 ; Output: RETURN array passed by reference
 N KEY,ZZ
 S KEY=""
 F  S KEY=$O(ARRAY(KEY)) Q:KEY=""  D  ;
 . I TYPE="I" D  ;
 . . D TINLIST(KEY,.RETURN,TYPE)
 . I TYPE="E" D  ;
 . S ZZ=""
 . F  S ZZ=$O(^RCY(344.6,"B",KEY,ZZ)) Q:ZZ=""  D  ;
 . . D TINLIST(ZZ,.RETURN,TYPE)
 Q
TINLIST(PIEN,RETURN,TYPE) ; Given a payer IEN from #344.6, get list of payers with the same TIN
 ; Input: PIEN - Payer IEN (#344.6)
 ;        ARRAY - array of payer names or IENS
 ;        TYPE  - E=External (Payer Name array) or I=Internal (IEN array)
 ; Output: ARRAY passed by reference with modified entries
 N TIN,PNAME,ZZ
 S TIN=$$GET1^DIQ(344.6,PIEN_",",.02,"E")
 I TIN="" Q
 S ZZ=""
 F  S ZZ=$O(^RCY(344.6,"C",TIN_" ",ZZ)) Q:ZZ=""  D
 . I TYPE="E" D  ;
 . . S PNAME=$$GET1^DIQ(344.6,ZZ_",",.01,"E")
 . . I PNAME'="" S RETURN(PNAME)=1
 . E  D
 . . S RETURN(ZZ)=1
 Q
 ;
CHK(TYPE,ITEM,ARRAY) ; Check to see if this ITEM is included for processing
 ; If all are included no need to check further
 Q:$G(ARRAY(TYPE))="ALL" 1
 Q:$G(ITEM)="" 0
 Q:$G(ARRAY(TYPE,ITEM))=1 1
 Q 0
 ;
 ;
GPAYR(TIN) ; First payer name derived from TIN - PRCA*4.5*321
 ; Input: TIN - Payer ID
 ; Return: The first payer name related to TIN
 ;         *Note more than one entry in 344.6 may have this TIN but for sort by name
 ;          purposes we have to select one of them.
 N RETURN,ZZ
 S ZZ=$O(^RCY(344.6,"C",TIN_" ",""))
 I ZZ Q $$GET1^DIQ(344.6,ZZ_",",.01,"E")
 Q ""
