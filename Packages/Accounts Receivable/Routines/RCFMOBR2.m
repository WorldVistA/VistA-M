RCFMOBR2 ;WASH-ISC@ALTOONA,PA/RWT-BILL RECONCILIATIONS LIST ;12/9/96  2:05 PM
V ;;4.5;Accounts Receivable;**53,73,107**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;      OBR Data Structure used by this routine
 ; ^TMP("OBR",$J,SITE,"NOT IN AR")=NextRec^TotalItems^TotalFMSAmt
 ; ^TMP("OBR",$J,SITE,"NOT IN FMS")=NextRec^TotalItems^TotalARAmt
 ; ^TMP("OBR",$J,SITE,"DISCREPANCY")=NextRec^TotalItems^TotalFMSAmt^TotalARAmt
 ; ^TMP("OBR",$J,"BN",BILLNUMBER)=[423.6 rec] <-- x-ref of FMS Bills
 ; ^TMP("OBR",$J,"REPORT","1")="LINE 1"
 ; ^TMP("OBR",$J","REPORT,"2")="LINE 2"
 ;
 ; Descriptions of modules:
 ;    BUILDRPT -  Prepares report in global ^TMP("OBR",$J,"REPORT")
 ;
BUILDRPT(PARENT) N Y,SN,N,ARTOTAL,FMSTOTAL,DIFF,N1,N2,N3,TB,MULTSN,DATE,TMP
 S N=1,SN=$O(^TMP("OBR",$J,0)),MULTSN=$O(^TMP("OBR",$J,SN))'=0
 ;
 D NOW^%DTC,YX^%DTC S DATE=$P(Y,"@")
 S ^TMP("OBR",$J,"REPORT",N)="Date of Report: "_DATE,N=N+1
 S ^TMP("OBR",$J,"REPORT",N)="NOTE: This report compares your current A/R records with data received from",N=N+1
 S ^TMP("OBR",$J,"REPORT",N)="      FMS on the last day of the previous accounting period.",N=N+1
 D BLANKLN(1)
 ;
 I '+$G(SN) S ^TMP("OBR",$J,"REPORT",N)="FMS and AR are in balance." Q
 S SN="" F  S SN=$O(^TMP("OBR",$J,SN)) Q:+SN=0  D
   .I MULTSN D
      ..S ^TMP("OBR",$J,"REPORT",N)=$P(^DIC(4,$P(^RC(342,1,0),U),0),U)
      ..S N=N+1
   .;
   .; - FMS Bills not in AR
   .D BLANKLN(1)
   .S TB="",$P(TB," ",21)=""
   .S ^TMP("OBR",$J,"REPORT",N)="    FMS BILLS NOT IN AR",N=N+1
   .S ^TMP("OBR",$J,"REPORT",N)=TB_"  AMOUNT",N=N+1
   .I '$D(^TMP("OBR",$J,SN,"NOT IN AR")) S N1="1^0^0"
   .I $D(^TMP("OBR",$J,SN,"NOT IN AR")) D
      ..S N1=^TMP("OBR",$J,SN,"NOT IN AR")
      ..F I=1:1:$P(N1,U,2) D
        ...S ^TMP("OBR",$J,"REPORT",N)=^TMP("OBR",$J,SN,"NOT IN AR",I)
        ...S N=N+1
   .D BLANKLN(1)
   .; - Summarize FMS Bills not in AR
   .S TMP=$P(N1,U,2)_$S($P(N1,U,2)=1:" Bill",1:" Bills")
   .S TB="",$P(TB," ",15-$L(TMP))=""
   .S ^TMP("OBR",$J,"REPORT",N)="    "_TMP_TB_$J($P(N1,U,3),10,2),N=N+1
   .;
   .; - AR Bills not in FMS
   .D BLANKLN(2)
   .S TB="",$P(TB," ",46)=""
   .S ^TMP("OBR",$J,"REPORT",N)="    AR BILLS NOT IN FMS",N=N+1
   .S ^TMP("OBR",$J,"REPORT",N)=TB_"  AMOUNT",N=N+1
   .I '$D(^TMP("OBR",$J,SN,"NOT IN FMS")) S N2="1^0^0"
   .I $D(^TMP("OBR",$J,SN,"NOT IN FMS")) D
      ..S N2=^TMP("OBR",$J,SN,"NOT IN FMS")
      ..F I=1:1:$P(N2,U,2) D
       ...S ^TMP("OBR",$J,"REPORT",N)=^TMP("OBR",$J,SN,"NOT IN FMS",I)
       ...S N=N+1
   .D BLANKLN(1)
   .; - Summarize Bills not if FMS
   .S TMP=$P(N2,U,2)_$S($P(N2,U,2)=1:" Bill",1:" Bills")
   .S TB="",$P(TB," ",40-$L(TMP))=""
   .S ^TMP("OBR",$J,"REPORT",N)="    "_TMP_TB_$J($P(N2,U,3),10,2),N=N+1
   .;
   .; - Discrepancies
   .D BLANKLN(2)
   .S ^TMP("OBR",$J,"REPORT",N)="    DISCREPANCIES",N=N+1
   .S TB="",$P(TB," ",44)=""
   .S ^TMP("OBR",$J,"REPORT",N)=TB_"FMS AMOUNT   AR AMOUNT   DIFFERENCE",N=N+1
   .I '$D(^TMP("OBR",$J,SN,"DISCREPANCY")) S N3="1^0^0^0"
   .I $D(^TMP("OBR",$J,SN,"DISCREPANCY")) D
      ..S N3=^TMP("OBR",$J,SN,"DISCREPANCY")
      ..F I=1:1:$P(N3,U,2) D
        ...S ^TMP("OBR",$J,"REPORT",N)=^TMP("OBR",$J,SN,"DISCREPANCY",I)
        ...S N=N+1
      ..D BLANKLN(1)
   .; - Summarize Discrepancy Totals
   .S DIFF=$P(N3,U,4)-$P(N3,U,3)
   .S TMP=$P(N3,U,2)_$S($P(N3,U,2)=1:" Bill",1:" Bills")
   .S TB="",$P(TB," ",40-$L(TMP))=""
   .S ^TMP("OBR",$J,"REPORT",N)="    "_TMP_TB_$J($P(N3,U,3),10,2)_"  "_$J($P(N3,U,4),10,2)_" "_$J($S(DIFF>0:"+",1:"")_$J(DIFF,0,2),12),N=N+1
   .D BLANKLN(2)
   .;
   .; - Summary of Totals
   .S ARTOTAL=$P(N2,U,3)+$P(N3,U,4)
   .S FMSTOTAL=$P(N1,U,3)+$P(N3,U,3)
   .S DIFF=ARTOTAL-FMSTOTAL
   .S ^TMP("OBR",$J,"REPORT",N)="Total FMS Amount  :  $"_$J(FMSTOTAL,10,2),N=N+1
   .S ^TMP("OBR",$J,"REPORT",N)="Total AR Amount   :  $"_$J(ARTOTAL,10,2),N=N+1
   .S ^TMP("OBR",$J,"REPORT",N)="Total Discrepancy :  "_"$"_$J(DIFF,10,2),N=N+1
   .I +$O(^TMP("OBR",$J,SN))'=0 D BLANKLN(3)
   .D ^RCFMOBR3
 Q
BLANKLN(LINES) ;
 N I
 F I=1:1:LINES S ^TMP("OBR",$J,"REPORT",N)="",N=N+1
 Q
