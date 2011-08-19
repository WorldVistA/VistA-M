PRCSSTAT ;WISC/KMB-COLLECT FMS QUARTERLY DATA FOR RECONCILLIATION ;1/14/93 12:00
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;we have PRC("CP"),PRC("QTR"),PRC("FY")
 N COUNTER,CHECK,FIELD,FIELDS,QTR,OUT,TOTAL,ZAP
 S (CHECK,OUT,TOTAL)=0,COUNTER=PRC("FY")_PRC("QTR")_PRC("CP")
 S (FIELD,FIELDS)="FMS REFERENCE-DATE-AMOUNT",QTR=PRC("QTR")
 I '$D(^PRCS(417,"C",COUNTER)) S OUT=1 D EVAL Q
 D HEADER
 F  S CHECK=$O(^PRCS(417,"C",COUNTER,CHECK)) Q:CHECK=""  D
 .I $D(^PRCS(417,CHECK,0)) F I=1:1:5 S $P(FIELDS,"-",I)=$P(^PRCS(417,CHECK,0),"^",I)
 .W !,$P(FIELDS,"-"),?15,$P(FIELDS,"-",2),?30,$P(FIELDS,"-",3),?45,$P(FIELDS,"-",4),?60,$P(FIELDS,"-",5)
 .S HOLD=$P(FIELDS,"-"),TOTAL=TOTAL+HOLD
 .I $Y>25 D HEADER
 W !,"Total amount of FMS transactions: $",$J(TOTAL,20,2),!,?35,"-------------------"
 Q
 ;
EVAL I OUT'=0 W $P($T(MESSAGE+OUT),";;",2) Q
HEADER W:$Y>0 @IOF W ?10,"FMS TRANSACTIONS FOR CONTROL POINT ",PRC("CP")," FOR "
 W $S(QTR=1:"1ST",QTR=2:"2ND",QTR=3:"3RD",QTR=4:"4TH",1:"")," QUARTER"
 ;
 W !,$P(FIELD,"-"),?15,$P(FIELD,"-",2),?30,$P(FIELD,"-",3),?45,$P(FIELD,"-",4),?60,$P(FIELD,"-",5),!
 S ZAP="-*-*-*-*-*-*-*" F I=1:1:4 W ZAP
 Q
MESSAGE ;;
 ;;There are no FMS transactions for the selected year and quarter
