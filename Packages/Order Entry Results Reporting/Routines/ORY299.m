ORY299 ;SLC/JLC-Search for truncated Patient Instructions ;02/26/08  09:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**299**;Dec 17, 1997;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ; 
 I $G(DUZ)="" W "Your DUZ is not defined.",! Q
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE
TASK S ZTRTN="EN^ORY299",ZTIO=""
 S ZTDESC="Check for Truncated Patient Instructions"
 D ^%ZTLOAD
 W !!,"The check for truncated Patient Instructions is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
 ;
EN ; -- tasked entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 N CREAT,EXPR,OI,STOP,S1,X1,X2,X,OIEN,PSOP,A,S2,S3,B,DFN,PKGR,DIV,%,RXD,LASTS3,SET,UPD,IDFN,ORN,START
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0) K ^XTMP("ORY281A")
 S X1=%,X2=-366 D C^%DTC S S1=X
 ; .9.4 reference - DBIA # 2058
 ; PXRMINDX reference - DBIA # 4290
 ; PSRX reference - DBIA #5205
 S PSOP=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",""))
 S OI=0 F  S OI=$O(^PXRMINDX(52,"IP",OI)) Q:'OI  D
 . S IDFN=0 F  S IDFN=$O(^PXRMINDX(52,"IP",OI,IDFN)) Q:'IDFN  D
 .. S START=0 F  S START=$O(^PXRMINDX(52,"IP",OI,IDFN,START)) Q:'START  D
 ... S STOP=S1 F  S STOP=$O(^PXRMINDX(52,"IP",OI,IDFN,START,STOP)) Q:'STOP  D
 .... S ORN=0 F  S ORN=$O(^PXRMINDX(52,"IP",OI,IDFN,START,STOP,ORN)) Q:'ORN  S OIEN=$P(^PSRX(+ORN,"OR1"),"^",2),UPD=0 I OIEN]"" D
 ..... S A=$G(^OR(100,OIEN,0)) Q:$P(A,"^",14)'=PSOP
 ..... S S2=$O(^OR(100,OIEN,4.5,"ID","PI","")) Q:S2=""
 ..... S DFN=$P($P(A,"^",2),";"),PKGR=$G(^OR(100,OIEN,4)) Q:PKGR=""  D EN^PSOORDER(DFN,PKGR) Q:'$D(^TMP("PSOR",$J))
 ..... S DIV=$P(^TMP("PSOR",$J,PKGR,1),"^",7),S3=0 F B=1:1 Q:'$D(^TMP("PSOR",$J,PKGR,"PI",B,0))  S RXD=^(0),S3=$O(^OR(100,OIEN,4.5,S2,2,S3)) D  Q:UPD
 ...... I S3]"" S LASTS3=S3
 ...... I S3="" D UPDATE S UPD=1 Q
 ...... I $G(^OR(100,OIEN,4.5,S2,2,S3,0))'=$G(^TMP("PSOR",$J,PKGR,"PI",B,0)) D UPDATE S UPD=1
 I $D(^XTMP("ORY281A")) S ^XTMP("ORY281A",0)=EXPR_"^"_CREAT
 D SEND
 K ZTQUEUED,ZTREQ Q
UPDATE ;Update OR file and record problem order number
 S ^XTMP("ORY281A",DIV,OIEN)=$P(^TMP("PSOR",$J,PKGR,0),"^",5)_"^"_$P($P(^TMP("PSOR",$J,PKGR,"DRUG",0),"^"),";",2)
 S A=$G(^OR(100,OIEN,4.5,S2,2,0)) K ^OR(100,OIEN,4.5,S2,2)
 M ^OR(100,OIEN,4.5,S2,2)=^TMP("PSOR",$J,PKGR,"PI")
 S SET=$O(^OR(100,OIEN,4.5,S2,2,""),-1),$P(A,"^",3)=SET,$P(A,"^",4)=SET,^OR(100,OIEN,4.5,S2,2,0)=A
 Q
SEND ;Send message
 K ORMSG,XMY N OCNT,OIEN,A,XMDUZ,XMSUB,XMTEXT,OIP,DIV,SP,DVNM,STATUS,STOP,OI,RX,DD
 S XMDUZ="CPRS, SEARCH",XMSUB="TRUNCATED PATIENT INSTRUCTIONS",XMTEXT="ORMSG(",XMY(DUZ)=""
 S ORMSG(1,0)="  The check for truncated Patient Instructions is complete."
 S ORMSG(2,0)=" ",ORMSG(3,0)="  Here is the list of the affected orders: ",ORMSG(4,0)=" "
 S (DIV,OIEN)=0,ORMSG(5,0)="Patient/Division      SSN   Item/Dispense         Status/RX#     Stop/OIEN",OCNT=5,SP=$J(" ",50)
 I '$D(^XTMP("ORY281A")) S OCNT=OCNT+1,ORMSG(OCNT,0)="No orders found."
 F  S DIV=$O(^XTMP("ORY281A",DIV)) Q:DIV=""  D PSS^PSO59(DIV,,"ORY281A") S DVNM=^TMP($J,"ORY281A",DIV,.01) D
 . F  S OIEN=$O(^XTMP("ORY281A",DIV,OIEN)) Q:OIEN=""  S A=^(OIEN),RX=$P(A,"^"),DD=$P(A,"^",2) D
 .. S A=$G(^OR(100,OIEN,0)),DFN=$P($P(A,"^",2),";"),STOP=$P(A,"^",9),STOP=$E(STOP,4,5)_"/"_$E(STOP,6,7)_"/"_($E(STOP,1,3)+1700)_"  "_$E(STOP,9,10)
 .. S A=^DPT(DFN,0),STATUS=$P($G(^OR(100,OIEN,3)),"^",3),STATUS=$P($G(^ORD(100.01,STATUS,0)),"^")
 .. S OIP=$O(^OR(100,OIEN,4.5,"ID","ORDERABLE","")),OI=$G(^OR(100,OIEN,4.5,OIP,1)),OI=$P($G(^ORD(101.43,OI,0)),"^")
 .. S OCNT=OCNT+1,ORMSG(OCNT,0)=$E($P(A,"^")_SP,1,20)_"  "_$E($P(A,"^",9),6,9)_"  "_$E(OI_SP,1,20)_"  "_$E(STATUS_SP,1,13)_"  "_STOP
 .. S OCNT=OCNT+1,ORMSG(OCNT,0)=$E(DVNM_SP,1,26)_"  "_$E(DD_SP,1,20)_"  "_$E(RX_SP,1,13)_"  "_OIEN
 .. S OCNT=OCNT+1,ORMSG(OCNT,0)=" "
 D ^XMD
 Q
