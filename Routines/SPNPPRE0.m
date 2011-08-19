SPNPPRE0 ;HISC/WAA-PRE PRINT ROUTINE ;8/07/96  14:23
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 ; This routine will get all the pre sort question from
 ; the file 154.92 and ask the user the questions. It will then
 ; Store the answers inti the file:
 ; ^TMP($J,"SPNPRT","PRE",SORT)
 ;
EN1 ;Loop through and collect the questions
 N SPNORD,SPNEXIT
 S SPNEXIT=0
 K ^TMP($J,"SPNPRT","PRE") ; Delete the OLD answers
 S SPNORD=0
 F  S SPNORD=$O(^SPNL(154.92,"AUP",SPNORD)) Q:SPNORD<1  D  Q:SPNEXIT
 .N SPNIEN,SPNSORT
 .S SPNIEN=$O(^SPNL(154.92,"AUP",SPNORD,0)) Q:SPNIEN<1
 .S SPNSORT=$G(^SPNL(154.92,SPNIEN,2))
 .S SEQUENCE=SPNORD,ACTION="PRE"
 .X SPNSORT
 .Q
 Q
