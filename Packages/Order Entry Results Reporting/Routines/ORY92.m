ORY92 ;SLC/MKB - Postinit for patch OR*3*92 ;1/22/01  08:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**92**;Dec 17, 1997
 ;
POST ; -- postinit
 N ORMSG
 S ORMSG(1)=""
 S ORMSG(2)="This patch imports the ORDER TEXT and LAB TEST entries"
 S ORMSG(3)="from the OE/RR PRINT FIELDS file.  As a result, the entries"
 S ORMSG(4)="in the OE/RR PRINT FORMAT file need to be recompiled."
 S ORMSG(5)=""
 S ORMSG(6)="**NOTE: If you have made local modifications to the compiled"
 S ORMSG(7)="code in the OE/RR PRINT FORMAT file they will be OVERWRITTEN."
 S ORMSG(8)=""
 S ORMSG(9)="Recompiling..."
 D MES^XPDUTL(.ORMSG) H 3
 D RECMPL^ORPR00 K ORMSG
 Q:'$$EXISTS(100,.11)  ;postinit has run before
 N OREJ,ORI,ORX
 ; -update Natures of Order
 S OREJ=$O(^ORD(100.02,"C","X",0)) S:OREJ $P(^ORD(100.02,OREJ,1),U,2)=1
 S ORI=0 F  S ORI=$O(^ORD(100.02,ORI)) Q:ORI'>0  S ORX=$S("EIXPVW"[$P($G(^(ORI,0)),U,2):1,1:0),$P(^(1),U,6)=ORX
 ; -queue conversion to run
 D TASK
 ; -delete DD for old Order Text field #.11
 N DIK,DA,DIU S DIK="^DD(100,",DA(1)=100,DA=.11 D ^DIK
 S DIU=100.011,DIU(0)="S" D EN^DIU2
 ; -update expert system
 D ^OCXRULE
 Q
 ;
EXISTS(FILE,FLD) ; -- Returns 1 or 0, if FLD exists in FILE
 I '$G(FILE)!('$G(FLD)) Q 0
 N ORY,ORZ D FIELD^DID(FILE,FLD,,"LABEL","ORY")
 S ORZ=$L($G(ORY("LABEL")))
 Q ORZ
 ;
TASK ; -- queue up conversion
 N ZTDESC,ZTRTN,ZTIO,ZTSAVE,ZTDTH,ZTSK,ORMSG
 S ORMSG(1)="Please queue the background job to move the Order Text field to its new",ORMSG(2)="location within the Orders file #100." D MES^XPDUTL(.ORMSG) K ORMSG
 S ZTDESC="Move order text within Orders file #100",ZTRTN="EN^ORY92"
 S ZTIO="",ZTSAVE("DUZ")="" D ^%ZTLOAD
 S ORMSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 D MES^XPDUTL(ORMSG)
 I '$G(ZTSK) D BMES^XPDUTL("Use TASK^ORY92 to queue this job to move the Order Text as soon as possible!")
 Q
 ;
EN ; -- main conversion loop
 N ORIFN,ORCNT S ORIFN=+$$GET^XPAR("SYS","OR ORDER TEXT CONVERSION")
 F  S ORIFN=$O(^OR(100,ORIFN)) Q:ORIFN'>0  D:$D(^(ORIFN,1))  Q:$G(ZTSTOP)
 . I $G(ORCNT)>1000,$D(ZTQUEUED) S:$$S^%ZTLOAD ZTSTOP=1 Q:$G(ZTSTOP)  S ORCNT=0
 . D CNV(ORIFN) S ORCNT=+$G(ORCNT)+1
 . D EN^XPAR("SYS","OR ORDER TEXT CONVERSION",1,ORIFN) ;save last order#
 D MAIL ;send message
 Q
 ;
CNV(ORDER) ; -- move text of ORDER
 N ORDT,HDR,ORI S ORDER=+$G(ORDER)
 Q:ORDER'>0  Q:'$O(^OR(100,ORDER,1,0))  ;no order or text to convert
 F ORI=1:1:10 L +^OR(100,ORDER):1 Q:$T  H 2
 Q:'$T  M ^TMP("ORTX",$J,ORDER)=^OR(100,ORDER) ;work in ^TMP then re-save
 M ^TMP("ORTX",$J,ORDER,8,1,.1)=^TMP("ORTX",$J,ORDER,1) ;move text
 K ^TMP("ORTX",$J,ORDER,1) ;clear old text location
 ; -Fix format of header node if needed
 S ORDT=$P($P($G(^TMP("ORTX",$J,+ORDER,0)),U,7),"."),HDR=$G(^(8,1,.1,0))
 S $P(HDR,U,2)="",$P(HDR,U,5,6)=ORDT_U,^TMP("ORTX",$J,ORDER,8,1,.1,0)=HDR
 ; -set all actions to use text in 1, merge & unlock order
 S ORI=0 F  S ORI=$O(^TMP("ORTX",$J,ORDER,8,ORI)) Q:ORI'>0  S $P(^(ORI,0),U,14)=1
 K ^OR(100,ORDER) M ^OR(100,ORDER)=^TMP("ORTX",$J,ORDER)
 L -^OR(100,ORDER) K ^TMP("ORTX",$J,ORDER)
 Q
 ;
MAIL ; -- Send completion message to user who initiated conversion
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT
 S XMDUZ="PATCH OR*3*92 CONVERSION",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S ORTXT(1)="The order text conversion of patch OR*3*92"_$S($G(ZTSK):" (Task #"_ZTSK_")",1:"")
 S ORTXT(2)="completed at "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S XMTEXT="ORTXT(",XMSUB="PATCH OR*3*92 CONVERSION COMPLETED"
 D ^XMD
 Q
