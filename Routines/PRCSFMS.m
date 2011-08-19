PRCSFMS ;WISC/KMB-FMS TRANSACTIONS FOR CP RUNNING BALANCE ;10/16/97  1315
V ;;5.1;IFCAP;**90**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BEGIN ;   this routine is called from PRCSP1A
 ;   find FMS transactions, for selected quarter, for CP
 N FTST,ZIP,P18,P19,RPR,RPR1,CUTOFF,FMSTOT,LINE,STRING,RDATE1,FIRST,FINAL,AMT,TYPE,MINUS,OBL,REF,RECNO,P1,RECN1
 S Z1=0,P1=0,U="^"
 D NOW^%DTC S Y=% D DD^%DT S RDATE1=Y
 S FMSTOT=0 S:'$D(PRCS("O")) PRCS("O")=0 S FINAL=PRCS("O"),STRING=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_+PRC("CP")
 S MINUS="" S:'$D(PRCS("C")) PRCS("C")=0
 S FIRST=PRCS("C")
 S RECNO="" F  S RECNO=$O(^PRCS(417,"C",STRING,RECNO)) Q:RECNO=""  D  Q:Z1=U
 .I '$D(C1),P1=0 D HDR1
 .I '$D(C1),IOSL-$Y<8 D HOLD1 Q:Z1=U
 .S ZIP="",RPR1="",RECN1=$P(^PRCS(417,RECNO,0),"^",23)
 .Q:RECN1="D"
 .Q:RECN1="N"
 .S AMT=$P(^PRCS(417,RECNO,0),"^",20),REF=$P(^(0),"^",22),OBL=$P(^(0),"^",18),TYPE=$P(^(0),"^",17)
 .S P18=$P(^PRCS(417,RECNO,0),"^",18),P19=$P(^PRCS(417,RECNO,0),"^",19)
 .S RPR="C"_P18_P19
 .I TYPE="CC",$D(^PRCH(440.6,"B",RPR)) S RPR1=$O(^PRCH(440.6,"B",RPR,0))
 .I $G(RPR1)'="" S FTST=$P($G(^PRCH(440.6,RPR1,0)),"^",16) S:FTST="N" ZIP="@"
 .S CUTOFF=$P($G(^PRCS(417,RECNO,1)),"^") I CUTOFF'=1 S FIRST=FIRST-AMT
 .I CUTOFF=1,TYPE'="CC",$E(OBL,4,7)'?4A S FIRST=FIRST-AMT
 .S FINAL=FINAL-AMT
 .I '$D(C1) S Y=$P(REF,".") D DD^%DT W !,Y
 .I '$D(C1) W ?13,OBL,?32,TYPE,?40,$J(AMT,11,2),ZIP,?54,$J(FIRST,11,2)
 .I '$D(C1) W ?68,$J(FINAL,11,2)
 .S FMSTOT=FMSTOT+AMT
 I FMSTOT<0 S MINUS="-",FMSTOT=-FMSTOT
 I Z1'=U W !!,"FMS transaction total for this quarter: ",MINUS,"$"_$J(FMSTOT,0,2)
 S L="",$P(L,"=",IOM)="=" W !,L S L=""
 S PRCS("C")=FIRST,PRCS("O")=FINAL Q
HOLD1 ;
 Q:$D(C1)
 G HDR1:$D(ZTQUEUED),HDR1:IO'=IO(0)
 D:$E(IOST,1,2)="C-" CRT D:Z1'=U HDR1
 Q
HDR1 ;
 S P1=1
 S P=P+1 W @IOF W "Control Point Balance - ",Z(0)_" "_$E($P(PRC("CP")," ",2),1,10),?50,RDATE1,?73,"PAGE ",P
 W !,?40,"FMS Transactions",!
 W !,"TRANSMISSION",?32,"TRANS",?40,"TRANSACTION",?68,"UNOBLIG",!,"DATE",?13,"REFERENCE #",?32,"CODE",?40,"$ AMOUNT",?54,"CP BALANCE",?68,"BALANCE"
 S L="",$P(L,"=",IOM)="=" W !,L S L="" Q
NONE ; find PO with no 2237 for running balance
 QUIT
HOLD2 ;
 G HDR2:$D(ZTQUEUED),HDR2:IO'=IO(0)
 D:$E(IOST,1,2)="C-" CRT D:Z1'=U HDR2
 Q
HDR2 ;
 S P1=1
 S P=P+1 W @IOF W "Control Point Balance - ",Z(0)_" "_$E($P(PRC("CP")," ",2),1,10),?50,RDATE1,?73,"PAGE ",P
 W !,?5,"__________PO TRANSACTIONS WITHOUT 2237______________",!
 W !,"PO/",?20,"PO ",?33,"COMMITTED",?58,"OBL/CEIL",?68,"UNOBLIG",!,"OBL#",?20,"DATE",?33,"(EST) COST",?44,"CP BALANCE",?58,"$ AMOUNT",?68,"BALANCE"
 S L="",$P(L,"=",IOM)="=" W !,L S L="" Q
CRT W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U Q:Z1=""  Q:Z1=U  W "??" G CRT
