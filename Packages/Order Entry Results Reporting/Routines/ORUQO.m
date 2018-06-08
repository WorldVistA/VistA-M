ORUQO ;SLC/JLC - SEARCH QOS FOR  ; 5/31/17 1:34pm
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**315,395,382**;Dec 17,1997;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to PXRMD(801.41 is supported by IA #4097
 ; Reference to DIC(9.4 is supported by IA #2058
 Q
 ;
EN(PKG,OINU,OINA) ; check for quick orders
 N CREAT,EXPR,OROIP,ORDUO,S1,S2,A,B,%,ORDG,DIEN,AFIND,TEXT,TYPE,I,ORPKG
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0) K ^XTMP("ORUQO",$J),^TMP($J)
 S OROI=$P(PKG,";"),ORPKG=$P(PKG,";",2)
 K ORDG
 I ORPKG="LR" F I="LAB","MI","BB","HEMA","CH","CY","EM" S ORDG=$O(^ORD(100.98,"B",I,"")) I ORDG]"" S ORDG(ORDG)=""
 I ORPKG="PS" F I="C RX","CI RX","I RX","IV RX","NV RX","O RX","SPLY","UD RX","RX","TPN" S ORDG=$O(^ORD(100.98,"B",I,"")) I ORDG]"" S ORDG(ORDG)=""
 F TYPE="G","E" D
 . S DIEN="" F  S DIEN=$O(^PXRMD(801.41,"TYPE",TYPE,DIEN)) Q:DIEN'>0  D
 .. S TEXT=$P($G(^PXRMD(801.41,DIEN,1)),"^",5)
 .. I TEXT[101.41 S ^TMP($J,$P(TEXT,";"))=""
 .. S AFIND="" F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ... I AFIND'[101.41 Q
 ... S ^TMP($J,$P(AFIND,";"))=""
 F I="OR GTX ORDERABLE ITEM","OR GTX ADDITIVE" S OROIP(I)=$O(^ORD(101.41,"B",I,""))
 S ORD=0
 F  S ORD=$O(^ORD(101.41,ORD)) Q:'ORD  S A=$G(^(ORD,0)) I $P(A,"^",4)="Q" S B=$P(A,"^",5) I B]"" D
 . I '$D(ORDG(B)) Q
 . F I="OR GTX ORDERABLE ITEM","OR GTX ADDITIVE" S ORDUO="" D
 ..  F  S ORDUO=$O(^ORD(101.41,ORD,6,"D",OROIP(I),ORDUO)) Q:'ORDUO  D
 ...  I $G(^ORD(101.41,ORD,6,ORDUO,1))=OROI S ^XTMP("ORUQO",$J,ORD,ORDUO)=$P(A,"^")_"^"_$P(A,"^",3)
 I $D(^XTMP("ORUQO",$J)) S ^XTMP("ORUQO",$J,0)=EXPR_"^"_CREAT D SEND
 Q
SEND ;Send message
 K ORMSG,XMY N OCNT,ORD,A,S1,XMDUZ,XMSUB,XMTEXT,H1,H2,H3
 S XMDUZ="CPRS, SEARCH",XMSUB="QUICK ORDER SEARCH",XMTEXT="ORMSG(",XMY(DUZ)="",XMY("G.OR CACS")=""
 I ORPKG="LR" S ORMSG(1,0)="  The check of Lab Quick Orders that contain Lab Test",ORMSG(2,0)=" "_OINU_" ("_$G(OINA)_") is complete.",OCNT=1
 I ORPKG="PS" S ORMSG(1,0)="  The check of Pharmacy Quick Orders that contain Pharmacy",ORMSG(2,0)=" Orderable Item "_OINU_" ("_$G(OINA)_") is complete.",OCNT=1
 S OCNT=OCNT+2,ORMSG(OCNT,0)=" ",ORMSG(OCNT+1,0)="  Here is the list of all quick orders that should be reviewed by your "
 S OCNT=OCNT+2,ORMSG(OCNT,0)="Clinical Applications Coordinator or whoever manages CPRS Quick Orders"
 S OCNT=OCNT+1,ORMSG(OCNT,0)="at your site.",ORMSG(OCNT+1,0)=" "
 S ORD=0,OCNT=OCNT+2,ORMSG(OCNT,0)="Quick Order Name                       Disable Text     Text or Start Date/Time                 Ancestors/Menus or Reminders"
 S OCNT=OCNT+1,ORMSG(OCNT,0)="  "
 F  S ORD=$O(^XTMP("ORUQO",$J,ORD)) Q:ORD=""  S S1=$O(^XTMP("ORUQO",$J,ORD,0)) Q:S1=""  S A=^(S1) D
 . S OCNT=OCNT+1,ORMSG(OCNT,0)=$E($P(A,"^")_$J(" ",38),1,37)_"  "_$E($P(A,"^",2)_$J(" ",38),1,15)_"  ",(H1,H2,H3)=""
 . I $D(^TMP($J,ORD)) S H2="Used in Clinical Reminders Dialog"
 . I $D(^ORD(101.41,"AD",ORD)) S H3="On a menu or in an order set"
 . S S1=0 F  S S1=$O(^XTMP("ORUQO",$J,ORD,S1)) Q:S1=""  S A=^(S1) D
 .. S S2=0 F  S S2=$O(^XTMP("ORUQO",$J,ORD,S1,S2)) Q:S2=""  S A=^(S2) I $TR(A," ")]"" D
 ... I H1 S OCNT=OCNT+1,ORMSG(OCNT,0)=$J(" ",56)
 ... S ORMSG(OCNT,0)=ORMSG(OCNT,0)_$E($P(A,"^")_$J(" ",39),1,38)_"  ",H1=1
 ... I H2]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H2 S H2="" Q
 ... I H3]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H3 S H3=""
 . I H2]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H2
 . I H3]"" S:$L(ORMSG(OCNT,0))>97 OCNT=OCNT+1,ORMSG(OCNT,0)=$J(" ",97) S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H3
 . S OCNT=OCNT+1,ORMSG(OCNT,0)=" "
 D ^XMD
 Q
CHECKLR(OR60,OR60N) ;
 ;OR60 is the file 60 IEN that needs to be checked
 N ORPT,OROI
 S OR60=$G(OR60) Q:OR60=""
 S ORPT=OR60_";99LRT" I '$D(^ORD(101.43,"ID",ORPT)) Q  ;test is not in a CPRS orderable item
 S OROI=$O(^ORD(101.43,"ID",ORPT,"")) Q:OROI=""
 D EN(OROI_";LR",OR60,OR60N) Q
CHECKPS(OR507,OR507N) ;
 ;OR507 is the file 50.7 IEN that needs to be checked
 N ORPT,OROI,ORP
 S OR507=$G(OR507) Q:OR507=""
 S ORPT=OR507_";99PSP" I '$D(^ORD(101.43,"ID",ORPT)) Q  ;drug is not in a CPRS orderable item
 S OROI=$O(^ORD(101.43,"ID",ORPT,"")) Q:OROI=""
 D EN(OROI_";PS",OR507,OR507N)
 Q
