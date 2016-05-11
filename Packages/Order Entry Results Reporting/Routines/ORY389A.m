ORY389A ;SLC/JLC-Search through Outpatient Pharmacy Quick Orders ;04/27/2015  13:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**389**;Dec 17, 1997;Build 17
 ;
 ;Reference to PXRMD(801.41 supported by ICR #4097
 ;Reference to DIC(9.4 supported by ICR #2058
 ;
 Q
EN ; -- main entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 N CREAT,EXPR,ORPSO,ORURG,ORDUO,ORDONE,S1,A,B,%,X
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0) K ^XTMP("ORY389A"),^TMP($J)
 N DIEN,AFIND,TEXT,TYPE
 F TYPE="G","E" D
 . S DIEN="" F  S DIEN=$O(^PXRMD(801.41,"TYPE",TYPE,DIEN)) Q:DIEN'>0  D
 .. S TEXT=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 .. I TEXT[101.41 S ^TMP($J,$P(TEXT,";"))=""
 .. S AFIND="" F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ... I AFIND'[101.41 Q
 ... S ^TMP($J,$P(AFIND,";"))=""
 S ORPSO=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",""))
 S ORURG=$O(^ORD(101.41,"B","OR GTX URGENCY",""))
 S ORDONE=$O(^ORD(101.42,"S.PSO","DONE",""))
 I ORDONE="" S ^XTMP("ORY389A",1)="No Priority of DONE on system." D SEND K ZTQUEUED,ZTREQ Q
 S ORD=0
 F  S ORD=$O(^ORD(101.41,ORD)) Q:'ORD  S A=$G(^(ORD,0)) I $P(A,"^",4)="Q",$P(A,"^",7)=ORPSO D
 . S ORDUO=""
 . S S1=0 F  S S1=$O(^ORD(101.41,ORD,6,S1)) Q:'S1  S B=$G(^(S1,0)) I $P(B,"^",2)=ORURG D
 .. I $G(^ORD(101.41,ORD,6,S1,1))'=ORDONE Q
 .. S ^XTMP("ORY389A",ORD)=$P(A,"^")_"^"_$P(A,"^",3)
 I $D(^XTMP("ORY389A")) S ^XTMP("ORY389A",0)=EXPR_"^"_CREAT
 D SEND
 K ZTQUEUED,ZTREQ Q
SEND ;Send message
 N OCNT,ORD,A,S1,H1,H2,H3,ORSTAT,ORMSGT
 S ORMSGT(1,0)="  The check of Outpatient Pharmacy Quick Orders is complete."
 S ORMSGT(2,0)=" ",ORMSGT(3,0)="  Here is the list of all quick orders that should be reviewed and/or updated: ",ORMSGT(4,0)=" "
 S ORD=0,ORMSGT(5,0)="Quick Order Name                       Disable Text     Ancestors/Menus or Reminders"
 S ORMSGT(6,0)="  ",OCNT=6
 F  S ORD=$O(^XTMP("ORY389A",ORD)) Q:ORD=""  S A=^(ORD) D
 . S OCNT=OCNT+1,ORMSGT(OCNT,0)=$E($P(A,"^")_$J(" ",38),1,37)_"  "_$E($P(A,"^",2)_$J(" ",38),1,15)_"  ",(H1,H2,H3)=""
 . I $D(^TMP($J,ORD)) S H2="Used in Clinical Reminders Dialog"
 . I $D(^ORD(101.41,"AD",ORD)) S H3="On a menu or in an order set"
 . I H2]"" S ORMSGT(OCNT,0)=ORMSGT(OCNT,0)_H2
 . I H3]"" S:$L(ORMSGT(OCNT,0))>97 OCNT=OCNT+1,ORMSGT(OCNT,0)=$J(" ",97) S ORMSGT(OCNT,0)=ORMSGT(OCNT,0)_H3
 . S OCNT=OCNT+1,ORMSGT(OCNT,0)=" "
 S ORSTAT=$$MAIL^ORUTL("ORMSGT(","OUTPATIENT PHARMACY QUICK ORDERS",,"ORY389OQORECIPS")
 Q
