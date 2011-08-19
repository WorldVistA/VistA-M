ORY195A ;SLC/DAN Post-install for patch 195 ;10/7/04  11:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;DBIA SECTION
 ;10063 - %ZTLOAD
 ;10141 - XPDUTL
 ;10070 - XMD
 ;10035 - ^DPT("CN" references
 ;10061 - VADPT
 ;
Q ;Entry point to queue process during install
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="DQ^ORY195A",ZTDESC="OR*3*195 LAB CHILD ORDER CHECK ROUTINE",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN DQ^ORY195A AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("Lab Child Order Check queued as task # "_$G(ZTSK))
 Q
 ;
DQ ;
 D SRCH,MAIL
 Q
 ;
SRCH ;Search for lab orders without locations
 N LAB,LOC,IEN,CHD,ORD,SUB,ORLIST
 K ^TMP($J,"TEXT"),^TMP($J,"ERR")
 S LAB=$O(^ORD(100.98,"B","LAB",0)) Q:'+LAB  ;quit if no lab display group
 S LOC="" F  S LOC=$O(^DPT("CN",LOC)) Q:LOC=""  S IEN=0 F  S IEN=$O(^DPT("CN",LOC,IEN)) Q:'+IEN  D
 .K ^TMP("ORR",$J)
 .D EN^ORQ1(IEN_";DPT(",LAB,2) ;Get active lab orders
 .S SUB=0 F  S SUB=$O(^TMP("ORR",$J,ORLIST,SUB)) Q:'+SUB  S ORD=+^(SUB) I $D(^OR(100,ORD,2)) D
 ..I '$P(^OR(100,ORD,0),U,17) Q  ;Quit if not delayed order
 ..S CHD=0 F  S CHD=$O(^OR(100,ORD,2,CHD)) Q:'+CHD  I $P(^OR(100,CHD,0),U,10)="" S ^TMP($J,"ERR",LOC,CHD)=+$P(^OR(100,CHD,0),U,2)
 K ^TMP("ORR",$J),^TMP($J,"TEXT")
 Q
 ;
MAIL ;Send message with findings
 N CNT,XMSUB,XMTEXT,XMDUZ,XMY,XMZ,LOC,ORD,DFN,VADM
 S CNT=1
 S ^TMP($J,"TEXT",CNT)="The search for active lab orders without a location has finished.",CNT=CNT+1
 S ^TMP($J,"TEXT",CNT)="",CNT=CNT+1
 I '$D(^TMP($J,"ERR")) S ^TMP($J,"TEXT",CNT)="No problems were found so no additional work is required.",CNT=CNT+1
 I $D(^TMP($J,"ERR")) D
 .S ^TMP($J,"TEXT",CNT)="Complex lab orders (e.g. CBC Q12Hx3) that were delayed were not being",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="assigned a location upon release.  As a result, the lab orders were not",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="appearing on the lab collection lists.",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="The following patients have active lab orders without a location.",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="It is very likely that these tests have not been done.  Please review",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="each order to ensure that the test has been done.  You may need to DC the",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="existing order and enter a new order so the test appears on the",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="collection list.",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="",CNT=CNT+1
 .S ^TMP($J,"TEXT",CNT)="Please note that existing delayed complex lab orders will release correctly.",CNT=CNT+1
 .S LOC="" F  S LOC=$O(^TMP($J,"ERR",LOC)) Q:LOC=""  S ^TMP($J,"TEXT",CNT)="",CNT=CNT+1,^TMP($J,"TEXT",CNT)="Location: "_LOC,CNT=CNT+1,^(CNT)="",CNT=CNT+1 S ORD=0 F  S ORD=$O(^TMP($J,"ERR",LOC,ORD)) Q:'+ORD  D
 ..K VADM
 ..S DFN=^TMP($J,"ERR",LOC,ORD)
 ..D DEM^VADPT
 ..S ^TMP($J,"TEXT",CNT)=VADM(1)_"  ("_$E(+VADM(2),6,9)_")  ORDER #: "_ORD,CNT=CNT+1,^TMP($J,"TEXT",CNT)="  ORDER TEXT: "_$G(^OR(100,ORD,8,1,.1,1,0)),CNT=CNT+1
 S XMDUZ="PATCH OR*3*195 LAB CHILD ORDERS CHECK",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMTEXT="^TMP($J,""TEXT"",",XMSUB="PATCH OR*3*195 Lab Order Check COMPLETED"
 D ^XMD
 Q
