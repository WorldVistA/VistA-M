RCDPARC1 ;AITC/CJE - CARC REPORT ON PAYER OR CARC CODE ;9/15/14 3:00pm
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
SORT(ARRAY,SORT) ; Sort and summarize data based on SORT variable
 N CARC,IEN,D1,D2,PIEN,PAYER,Z,TIN,DESC,R1,BILL S IEN=""
 ; IEN= IEN from file 361.1; PIEN= 835 Payer IEN from file 344.6
 F  S IEN=$O(@ARRAY@("BILLS",IEN)) Q:IEN=""  D
 . S D1=@ARRAY@("BILLS",IEN,0),TIN=$P(D1,U,5),BILL=$P(D1,U,2)
 . S PAYER=$$GPAYR^RCDPRU2(TIN) Q:$G(PAYER)=""  ; couldn't find a payer to match TIN, quit
 . S CARC="",Z="",R1=""
 . F  S Z=$O(@ARRAY@("BILLS",IEN,"C",Z)) Q:Z=""  S D2=@ARRAY@("BILLS",IEN,"C",Z),CARC=$P(D2,U,1),DESC=$P(D2,U,4) D
 .. ; If RARC exists append to CARC Information
 .. S:$G(@ARRAY@("BILLS",IEN,"R",Z))'="" R1=@ARRAY@("BILLS",IEN,"R",Z)
 .. ;W "RARC: |",$G(@ARRAY@("BILLS",IEN,"R",Z)),"|",!
 .. D:SORT="C"  ; Sort by CARC, group by Payer
 ... S @ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,0)=D1
 ... ; First time through set the "BILLS" D2 into report, otherwise add adjustment amt to the existing for this CARC
 ... I $G(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1))="" S @ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1)=D2_U_R1
 ... E  S $P(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1),U,2)=$P(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1),U,2)+$P(D2,U,2) ;W "CARC: ",CARC," Bill: ",BILL," D2: ",D2,!
 .. D:SORT="P"  ; Sort by Payer, group by CARC
 ... S @ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,0)=D1
 ... ; First time through set the "BILLS" D2 into report, otherwise add adjustment amt to the existing for this CARC
 ... I $G(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1))="" S @ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1)=D2_U_R1
 ... E  S $P(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1),U,2)=$P(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1),U,2)+$P(D2,U,2)
 .. ;I CARC=1 W ARRAY," BILL:",BILL," CARC:",CARC,"  ",PAYER_"/"_TIN,"  ",$P(D1,U,6),"  ",$P(D1,U,7),"  ",DESC,"  ",$P(D2,U,2),"  ",SORT,!
 .. D SUM^RCDPRU2(ARRAY,IEN,BILL,CARC,PAYER_"/"_TIN,$P(D1,U,6),$P(D1,U,7),DESC,$P(D2,U,2),SORT)
 Q
