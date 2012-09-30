ORY39 ;SLC/JFR - POST-INSTALL OR*3*39 11/24/98 13:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**39**;Dec 17, 1997
POST ; task AWID linetag in post-install
 S ZTDTH=$H,ZTRTN="AWID^ORY39",ZTDESC="Post-install for OR*3*39"
 S ZTIO="" D ^%ZTLOAD
 D BMES^XPDUTL($S($G(ZTSK):"Post-install tasked, Task # "_ZTSK,1:"Unable to queue post-install"))
 K ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSK
 Q
AWID ; loop whole order file
 ; set "AW" x-ref on NKA allergy orders
 ; add ID's to existing orders
 ;Q:$$PATCH^XPDUTL("OR*3.0*39")
 N NKADLG,ORIFN,ORDLG,ORFTXT,ORFTOI
 S ORDLG=$$PTR^ORCD("GMRAOR ALLERGY ENTER/EDIT")_";ORD(101.41," Q:'ORDLG
 S NKADLG=$$PTR^ORCD("OR GTX NKA")
 S ORFTXT=$$PTR^ORCD("OR GTX FREE TEXT 1")
 S ORFTOI=$$PTR^ORCD("OR GTX FREE TEXT OI")
 S ORIFN=0 F  S ORIFN=$O(^OR(100,ORIFN)) Q:'ORIFN  D
 . Q:$P($G(^OR(100,ORIFN,0)),"^",5)'=ORDLG  I $$NKA(ORIFN) D  Q
 .. N DA
 .. S DA=ORIFN D WS^ORDD100 ; set logic for "AW" x-ref
 . D COMMENT(ORIFN)
 . Q
 Q
NKA(ORDER)      ; see if order is an NKA
 N RESP,NKA
 S NKA=0
 S RESP=0 F  S RESP=$O(^OR(100,ORDER,4.5,RESP)) Q:'RESP!NKA  D
 . I $P(^OR(100,ORDER,4.5,RESP,0),"^",2)=NKADLG D
 .. ; set "ID" x-ref for NKA on field 4.5 and NKA flag 
 .. S NKA=1
 .. S $P(^OR(100,ORDER,4.5,RESP,0),"^",4)="NKA"
 .. S ^OR(100,ORDER,4.5,"ID","NKA",RESP)=""
 . Q
 Q NKA
COMMENT(ORDER) ; replace COMMENT prompt with ITEM
 N RESP,ORX S RESP=0
 F  S RESP=$O(^OR(100,ORDER,4.5,"ID","COMMENT",RESP)) Q:RESP'>0  I $P($G(^OR(100,ORDER,4.5,RESP,0)),U,2)=ORFTXT S ORX=^(0) D
 . K ^OR(100,ORDER,4.5,"ID","COMMENT",RESP)
 . S $P(ORX,U,2)=ORFTOI,$P(ORX,U,4)="ITEM",^OR(100,ORDER,4.5,RESP,0)=ORX
 . S ^OR(100,ORDER,4.5,"ID","ITEM",RESP)=""
 Q
