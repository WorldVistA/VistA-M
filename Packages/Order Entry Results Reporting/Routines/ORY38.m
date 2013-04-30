ORY38 ;SLC/MKB-Postinit for patch OR*3*38 ;11/20/98  09:24
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**38**;Dec 17, 1997
 ;
EN ; -- Clear default value for SC prompt in Outpt Med quick orders
 ;
 N ORDLG,OR0,ORSC,DA,DIK
 S ORSC=+$O(^ORD(101.41,"AB","OR GTX SERVICE CONNECTED",0)) Q:ORSC'>0
 S ORDG=+$O(^ORD(100.98,"B","O RX",0)) Q:ORDG'>0  S ORDLG=0
 W !!,"Clearing SC default from Outpatient Medication quick orders ..."
 F  S ORDLG=$O(^ORD(101.41,ORDLG)) Q:ORDLG'>0  S OR0=$G(^(ORDLG,0)) I $P(OR0,U,4)="Q",$P(OR0,U,5)=ORDG D
 . S DA=$O(^ORD(101.41,ORDLG,6,"D",ORSC,0)),DA(1)=ORDLG
 . I DA>0 S DIK="^ORD(101.41,"_ORDLG_",6," D ^DIK
 W " done."
 Q
