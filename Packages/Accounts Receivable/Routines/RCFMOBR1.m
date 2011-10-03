RCFMOBR1 ;WASH-ISC@ALTOONA,PA/RWT-BILL RECONCILIATIONS LIST ;7/10/97  11:17 AM
 ;;4.5;Accounts Receivable;**53,73,90,203,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;      OBR Data Structure used by this routine
 ; ^TMP("OBR",$J,SITE,"NOT IN AR")=NextRec^TotalItems^TotalFMSAmt
 ; ^TMP("OBR",$J,SITE,"NOT IN FMS")=NextRec^TotalItems^TotalARAmt
 ; ^TMP("OBR",$J,SITE,"DISCREPANCY")=NextRec^TotalItems^TotalFMSAmt^TotalARAmt
 ; ^TMP("OBR",$J,"BN",BILLNUMBER)=[423.6 rec] <-- x-ref of FMS Bills
 ; ^TMP("OBR",$J,"REPORT","1")="LINE 1"
 ; ^TMP("OBR",$J","REPORT,"2")="LINE 2"
 ; Modules:
 ;    PROCFMS  -  loop through FMS bills (^PRCF(423.6)) updating
 ;                global ^TMP("OBR",$J,"BN") while also checking
 ;                for invalid AR bills
 ;    PROCAR   -  loop through all Active AR Bills comparing amounts
 ;                and looking for Detail bills not found in FMS
 ;    SAVE     -  Saves the errors to tmp global ^TMP("OBR",site)
 ;
 ;
PROCFMS(A0) N NODE,FUND,RSC,SRSC,ND,BN,SN,A1
 S A1=0 F  S A1=$O(^PRCF(423.6,A0,1,A1)) Q:+A1=0  S ND=^(A1,0) D
   .I $P(ND,U)="OBR" D  Q
      ..; LIN Segment with OBR identifies FMS data
      ..S ND=^PRCF(423.6,A0,1,A1,0)
      ..S SN=$P(ND,U,2),FUND=$S($P(ND,U,7)'="~":$P(ND,U,7),1:""),RSC=$S($P(ND,U,8)'="~":$P(ND,U,8),1:""),SRSC=$S($P(ND,U,9)'="~":$P(ND,U,9),1:"")
      ..S BN=$P(ND,U,4) I $D(^TMP("OBR",$J,"BN",BN)) Q
      ..S ^TMP("OBR",$J,"BN",BN)=A1,EM=""
      ..S BN=$E($P(ND,U,4),1,3)_"-"_$E($P(ND,U,4),4,10)
      ..S A2=$O(^PRCA(430,"B",BN,0))
      ..I A2=""!('$D(^PRCA(430,+A2,0))) D  Q:A2=""
          ...S AM1=+$P(ND,U,6)
          ...S AM2=0,DB="UNKNOWN"
          ...D SAVE(SN,BN,DB,AM1,AM2,"NOT IN AR")
      ..S NODE=$G(^PRCA(430,+A2,11)) Q:NODE=""
      ..I FUND'=$P(NODE,U,17) D SAVE(SN,BN,$P(NODE,U,17),FUND,0,"FUND MISMATCH")
      ..I RSC'=$P(NODE,U,6) D SAVE(SN,BN,$P(NODE,U,6),RSC,0,"RSC MISMATCH")
      ..I SRSC'=$P(NODE,U,7) D SAVE(SN,BN,$P(NODE,U,7),SRSC,0,"SUB RSC MISMATCH")
 Q
PROCAR(A0) ;
 ; - Process all Active AR Bills
 N A2,BN,AM1,AM2,AM3,DB,EM,ND,SN,FMSBN
 S A2=0 F  S A2=$O(^PRCA(430,"AC",16,A2)) Q:+A2=0  D
   .I $D(^PRCA(430,A2,0)),$P(^(0),U,18)'="01610A1",'$$ACCK^PRCAACC(A2) D
     ..Q:$P(^PRCA(430,A2,0),"^",2)=29
     ..I $P(^PRCA(430,A2,0),"^",2)=6,$E($P(^(0),"^",18),1,4)=5287,$$PTACCT^PRCAACC($P(^(0),U,18)) Q
     ..I $P(^PRCA(430,A2,0),"^",2)=6,$P(^(0),"^",18)=5014 Q
     ..S BN=$P(^PRCA(430,A2,0),U),SN=$P(BN,"-") D
       ...S FMSBN=$P(BN,"-")_$P(BN,"-",2)
       ...S AM2=$S($D(^PRCA(430,A2,7)):+^(7),1:0)
       ...S DB=$E($$NAM^RCFN01(+$P(^PRCA(430,A2,0),U,9)),1,26)
       ...I '$D(^TMP("OBR",$J,"BN",FMSBN)) D  Q
         ....S AM1=0
         ....D SAVE(SN,BN,DB,AM1,AM2,"NOT IN FMS")
       ...I $D(^TMP("OBR",$J,"BN",FMSBN)) D
         ....S ND=^PRCF(423.6,A0,1,^TMP("OBR",$J,"BN",FMSBN),0)
         ....S AM1=+$P(ND,U,6)
         ....I AM1'=AM2 D SAVE(SN,BN,DB,AM1,AM2,"DISCREPANCY")
 Q
SAVE(SN,BILL,DEBTOR,FMSAMT,ARAMT,ERR) N S0,S1,S2,S3,N,DIFF
 S S0="",$P(S0," ",(19-$L(BILL)))=""
 S S1="",$P(S1," ",(15-$L(BILL)))=""
 S S2="",$P(S2," ",(30-$L(DEBTOR)))=""
 I ERR="NOT IN AR" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S0_$J(FMSAMT,10,2)
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,3)=$P(N,U,3)+FMSAMT
 I ERR="NOT IN FMS" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S1_DEBTOR_S2_$J(ARAMT,10,2)
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,3)=$P(N,U,3)+ARAMT
 I ERR="DISCREPANCY" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0^0^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S DIFF=$S(FMSAMT>ARAMT:$J(FMSAMT-ARAMT,0,2),1:"+"_$J(ARAMT-FMSAMT,0,2))
   .S S3="",$P(S3," ",11-$L(DIFF))="",DIFF=S3_DIFF
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S1_DEBTOR_S2_$J(FMSAMT,10,2)_"  "_$J(ARAMT,10,2)_"   "_DIFF
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,3)=$P(N,U,3)+FMSAMT
   .S $P(^TMP("OBR",$J,SN,ERR),U,4)=$P(N,U,4)+ARAMT
 I ERR="FUND MISMATCH" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S2_DEBTOR_S2_FMSAMT
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
 I ERR="RSC MISMATCH" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S2_DEBTOR_S2_FMSAMT
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
 I ERR="SUB RSC MISMATCH" D  Q
   .I '$D(^TMP("OBR",$J,SN,ERR)) S ^(ERR)="1^0"
   .S N=^TMP("OBR",$J,SN,ERR)
   .S ^TMP("OBR",$J,SN,ERR,+N)=BILL_S2_DEBTOR_S2_FMSAMT
   .S $P(^TMP("OBR",$J,SN,ERR),U)=+N+1
   .S $P(^TMP("OBR",$J,SN,ERR),U,2)=$P(N,U,2)+1
 Q
