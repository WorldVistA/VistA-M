ORRCOR ;SLC/MKB - OR data for CM ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;**3**;Jul 15, 2003
 ;
PTUNS(ORY,ORUSR) ; -- Return list of patients with unsigned orders by ORUSR
 ; in @ORY@(PAT) = #unsigned orders
 ;    @ORY@(PAT,"ORU:ien;act")=""
 ; [from ORRCDPT]
 N IDX,PAT,IFN,ACT,NUM,X
 S ORY=$NA(^TMP($J,"ORRCORU")),IDX="^OR(100,""AS"")" K @ORY
 F  S IDX=$Q(@IDX) Q:IDX'?1"^OR(100,""AS"",".E  D
 . S PAT=+$P($P(IDX,",",3),"""",2),IFN=+$P(IDX,",",5),ACT=+$P(IDX,",",6)
 . Q:+$P($G(^OR(100,IFN,8,ACT,0)),U,3)'=ORUSR
 . S X=+$G(ORY(PAT)),ORY(PAT)=X+1,ORY(PAT,"ORU:"_IFN_";"_ACT)=""
 Q
 ;
IDS(ORY,ORPAT,ORTYPE,ORBEG,OREND) ; -- Return order IDs for ORPAT where
 ; ORTYPE = ORN: Active Nursing Orders (2)
 ;          ORV: Orders Unverified by Nursing (9)
 ; in @ORY@(PAT) = #orders
 ;    @ORY@(PAT,ID)= ! if completed (for ORN), else null
 ; [from ORRCDPT1]
 N ORN,ORWARD,ORFLG,ORID,ORDG,ORPKG,ORLIST,ORI,ORIFN,STS,PKG,X
 S ORY=$NA(^TMP($J,"ORRCORU")) K @ORY
 S ORPAT=+$G(ORPAT)_";DPT(",ORTYPE=$G(ORTYPE,"ORD")
 S ORWARD=$G(^DPT(+ORPAT,.1)) S:$L(ORWARD) ORWARD=+$O(^DIC(42,"B",ORWARD,0))
 S ORFLG=$S(ORTYPE="ORU":11,ORTYPE="ORV":9,1:2),ORID=ORTYPE_":"
 S ORDG=$S(ORTYPE="ORN":"NURS",1:"ALL"),ORDG=+$O(^ORD(100.98,"B",ORDG,0))
 S ORPKG=+$O(^DIC(9.4,"C","OR",0))
 ;S (ORBEG,OREND)="" I ORFLG=9 S OREND=$$NOW^XLFDT,ORBEG=OREND-1
 D EN^ORQ1(ORPAT,ORDG,ORFLG,,$G(ORBEG),$G(OREND)) S (ORI,CNT)=0
 F  S ORI=+$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=^(ORI) D
 . S STS=$P($G(^OR(100,+ORIFN,3)),U,3),PKG=+$P($G(^(0)),U,14),X=""
 . ;I ORTYPE="ORV",STS=1,+$G(^(6))=10 Q  ;changed ??
 . I ORTYPE="ORN","^1^2^7^11^12^13^14^"[(U_STS_U)!(PKG'=ORPKG) S X="!" ;can't complete
 . S CNT=CNT+1,@ORY@(+ORPAT,ORID_ORIFN)=X
 S:CNT @ORY@(+ORPAT)=CNT K ^TMP("ORR",$J,ORLIST)
 ;if ORTYPE=ORN also get all other GEN TEXT ORDERS not in NURSING display group
 Q:ORTYPE'="ORN"
 S ORDG="CLINIC ORDERS",ORDG=+$O(^ORD(100.98,"B",ORDG,0))
 D EN^ORQ1(ORPAT,ORDG,ORFLG,,$G(ORBEG),$G(OREND))
 S ORI=0 F  S ORI=+$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  D
 . S ORIFN=$G(^TMP("ORR",$J,ORLIST,ORI))
 . S STS=$P($G(^OR(100,+ORIFN,3)),U,3),PKG=+$P($G(^(0)),U,14),X=""
 . I ORTYPE="ORN","^1^2^7^11^12^13^14^"[(U_STS_U)!(PKG'=ORPKG) S X="!" ;can't complete
 . Q:(PKG'=ORPKG)
 . S CNT=CNT+1,@ORY@(+ORPAT,ORID_ORIFN)=X
 S:CNT @ORY@(+ORPAT)=CNT K ^TMP("ORR",$J,ORLIST)
 Q
 ;
LISTUNS(ORY,ORUSR,ORPAT,ORDET) ; -- Return unsigned orders by ORUSR for ORPAT
 ; in @ORY@(#) = Item=ID^Text^OrderDate in HL7 format
 ;             = Order=line of order text, and also if ORDET
 ;             = Text=line of report text
 ; [from LIST^ORRCSIG]
 N ORN,ORDT,ORIFN,ORACT,ORID,ORRCTX,I
 S ORY=$NA(^TMP($J,"ORRCORD")) K @ORY
 S ORUSR=+$G(ORUSR),ORPAT=+$G(ORPAT)_";DPT(",ORN=0
 S ORDT=0 F  S ORDT=+$O(^OR(100,"AS",ORPAT,ORDT)) Q:ORDT<1  D
 . S ORIFN=0 F  S ORIFN=+$O(^OR(100,"AS",ORPAT,ORDT,ORIFN)) Q:ORIFN<1  D
 .. S ORACT=0 F  S ORACT=+$O(^OR(100,"AS",ORPAT,ORDT,ORIFN,ORACT)) Q:ORACT<1  D
 ... Q:+$P($G(^OR(100,ORIFN,8,ORACT,0)),U,3)'=ORUSR  S ORID=ORIFN_";"_ORACT
 ... D TEXT^ORQ12(.ORRCTX,ORID,200)
 ... S ORN=ORN+1,@ORY@(ORN)="Item=ORU:"_ORID_U_$$TXT1_U_$$FMTHL7^XLFDT(ORDT)_U_$$STS(ORIFN)
 ... S I=0 F  S I=$O(ORRCTX(I)) Q:I<1  S ORN=ORN+1,@ORY@(ORN)="Order="_ORRCTX(I)
 ... I $G(ORDET) D ORD ;add Detailed Display to @ORY@(#)
 ;S ORY(0)=CNT
 Q
 ;
LIST(ORY,ORPAT,ORTYPE,ORUSR,ORDET,ORBEG,OREND) ; -- Return orders for ORPAT where
 ; ORTYPE = ORN: Active Nursing Orders (2)
 ;          ORV: Orders Unverified by Nursing (9)
 ;          ORU: Unsigned Orders by ORUSR (11)
 ; in @ORY@(#) = Item=ID^Text^OrderDate in HL7 format^Status
 ;             = Order=line of order text, & if ORDET
 ;             = Text=line of report text
 ;    where ID = ORTYPE_":"_order#;action#
 ; RPC = ORRC ORDERS BY PATIENT
 N ORN,ORWARD,ORIGVIEW,ORFLG,ORID,ORDG,ORLIST,ORI,ORIFN,ORACT,OR0,ORA0,ORDT,ORRCTX,I
 S ORY=$NA(^TMP($J,"ORRCORD")) K @ORY
 S ORUSR=+$G(ORUSR),ORPAT=+$G(ORPAT)_";DPT(",ORTYPE=$G(ORTYPE,"ORD")
 S ORWARD=$G(^DPT(+ORPAT,.1)),ORIGVIEW=1
 S:$L(ORWARD) ORWARD=+$O(^DIC(42,"B",ORWARD,0))
 S ORFLG=$S(ORTYPE="ORU":11,ORTYPE="ORV":9,1:2),ORID=ORTYPE_":"
 S ORDG=$S(ORTYPE="ORN":"NURS",1:"ALL"),ORDG=+$O(^ORD(100.98,"B",ORDG,0))
 S:$G(ORBEG) ORBEG=$$HL7TFM^XLFDT(ORBEG) S:$G(OREND) OREND=$$HL7TFM^XLFDT(OREND)
 D EN^ORQ1(ORPAT,ORDG,ORFLG,,$G(ORBEG),$G(OREND)) S (ORI,ORN)=0
 F  S ORI=+$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=^(ORI) D
 . S ORACT=+$P(ORIFN,";",2) S:ORACT<1 ORACT=+$P($G(^OR(100,+ORIFN,3)),U,7)
 . S OR0=$G(^OR(100,+ORIFN,0)),ORA0=$G(^(8,ORACT,0))
 . I ORFLG=11,+$P(ORA0,U,3)'=ORUSR Q
 . S ORDT=$S('$P(OR0,U,8):$P(ORA0,U),"^DC^HD^"[(U_$P(ORA0,U,2)_U):$P(ORA0,U),1:$P(OR0,U,8))
 . D TEXT^ORQ12(.ORRCTX,ORIFN,200)
 . S ORN=ORN+1,@ORY@(ORN)="Item="_ORID_ORIFN_U_$$TXT1_U_$$FMTHL7^XLFDT(ORDT)_U_$$STS(ORIFN)
 . S I=0 F  S I=$O(ORRCTX(I)) Q:I<1  S ORN=ORN+1,@ORY@(ORN)="Order="_ORRCTX(I)
 . I $G(ORDET) D ORD ;add Detailed Display to @ORY@(#)
 Q
 ;
DETAIL(ORY,ORDER) ; -- Return details of ORDERs
 ; where ORDER(#) = ID
 ; in @ORY@(#) = Item=ID^Text^OrderDate in HL7 format^Status
 ;             = Order=line of order text
 ;             = Text=line of report text
 ; RPC = ORRC ORDERS BY ID [and from DETAIL^ORRCSIG]
 N ORN,ORI,ORID,ORIFN,ORACT,ORDT,ORRCTX,I
 S ORN=0,ORY=$NA(^TMP($J,"ORRCORD")) K @ORY
 S ORI="" F  S ORI=$O(ORDER(ORI)) Q:ORI=""  S ORID=ORDER(ORI) D
 . S ORIFN=$P(ORID,":",2),ORACT=+$P(ORIFN,";",2)
 . S:ORACT<1 ORACT=+$P($G(^OR(100,+ORIFN,3)),U,7) S:ORACT<1 ORACT=1
 . S ORDT=+$G(^OR(100,+ORIFN,8,ORACT,0))
 . D TEXT^ORQ12(.ORRCTX,ORIFN,200)
 . S ORN=ORN+1,@ORY@(ORN)="Item="_ORID_U_$$TXT1_U_$P($$FMTHL7^XLFDT(ORDT),"-")_U_$$STS(ORIFN)
 . S I=0 F  S I=$O(ORRCTX(I)) Q:I<1  S ORN=ORN+1,@ORY@(ORN)="Order="_ORRCTX(I)
 . D ORD
 Q
 ;
TXT(IFN) ; -- Return [first line of] order IFN's text
 N ORRCTX,Y D TEXT^ORQ12(.ORRCTX,$G(IFN),200)
 S Y=$G(ORRCTX(1))_$S($O(ORRCTX(1)):"...",1:"")
 Q Y
 ;
TXT1() ; -- Return [first line of] order text from ORRCTX()
 N Y
 S Y=$G(ORRCTX(1))_$S($O(ORRCTX(1)):"...",1:"")
 Q Y
 ;
STS(IFN) ; --Return name of order IFN's status
 N STS,X,Y
 S STS=+$P($G(^OR(100,+$G(IFN),3)),U,3)
 S X=$P($G(^ORD(100.01,STS,0)),U),Y=$$LOW^XLFSTR(X)
 Q Y
 ;
ORD ; -- Add details of ORIFN to @ORY@(ORN)
 Q:'+$G(ORIFN)  N ORRCZ,ORI,ORVP
 S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2)
 S ORRCZ="^TMP($J,""ORRCTXT"")" D DETAIL^ORQ2(.ORRCZ,ORIFN)
 S ORI=0 F  S ORI=$O(@ORRCZ@(ORI)) Q:ORI<1  S ORN=ORN+1,@ORY@(ORN)="Text="_@ORRCZ@(ORI)
 K @ORRCZ
 Q
 ;
VERIFY(ORY,ORUSR,ORDER) ; -- Mark ORDERs as verified by ORUSR
 ;where ORDER(#) = ID = ORV:order#;action#
 ;returns ORY(#) = ID^1 if successful, else ID^0^error
 ;RPC = ORRC ORDERS VERIFY
 Q:'$G(ORUSR)  N ORVER,ORI,ORID,ORIFN,ORACT,ORA0,ORLK,ORES,ORERR,ORVP,ORWARD
 K ORY S ORVER="N"
 S ORI=""  F  S ORI=$O(ORDER(ORI)) Q:ORI=""  D
 . S ORID=ORDER(ORI),ORIFN=$P(ORID,":",2),ORACT=+$P(ORIFN,";",2)
 . I ORACT<1 S ORACT=+$P($G(^OR(100,+ORIFN,3)),U,7),ORIFN=+ORIFN_";"_ORACT
 . S ORA0=$G(^OR(100,+ORIFN,8,ORACT,0)) I $P(ORA0,U,9) D  Q  ;verified
 .. N WHO,WHEN,X S WHO=$P(ORA0,U,8),WHEN=$P(ORA0,U,9),X=""
 .. S:WHO X=X_" by "_$$UP^XLFSTR($$NAME^XUSER(WHO,"F"))
 .. S:WHEN X=X_" on "_$$FMTE^XLFDT(WHEN,"2P")
 .. S ORY(ORI)=ORID_"^0^This order has been verified"_X_"!" Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK S ORY(ORI)=ORID_U_ORLK Q
 . S ORES(ORIFN)=ORID,ORES("B",ORIFN)=ORI
 . D REPLCD^ORCACT1 ;incl unverified replaced orders
 Q:'$O(ORES(0))  S ORIFN=0 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN<1  D
 . S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2),ORVP(ORVP)=""
 . D EN^ORCSEND(ORIFN,"VR","","",,,.ORERR),UNLK1^ORX2(+ORIFN)
 . S ORID=$G(ORES(ORIFN)),ORI=+$G(ORES("B",ORIFN))
 . I ORI S ORY(ORI)=ORID_U_$S($G(ORERR):"0^"_$P(ORERR,U,2),1:1)
 S ORVP="" F  S ORVP=$O(ORVP(ORVP)) Q:ORVP=""  D
 . S ORWARD=$S($G(^DPT(+ORVP,.105)):1,1:0) ;inpt
 . D CKALERT^ORCACT1 ;delete unver orders alerts
 Q
 ;
COMP(ORY,ORUSR,ORDER) ; -- Mark ORDERs as completed by ORUSR
 ;where ORDER(#) = ID = ORN:order#;action#
 ;returns ORY(#) = ID^1 if successful, else ID^0^error
 ;RPC = ORRC ORDERS COMPLETE
 Q:'$G(ORUSR)  N ORNOW,ORI,ORID,ORIFN,ORLK
 K ORY S ORNOW=+$E($$NOW^XLFDT,1,12)
 S ORI=""  F  S ORI=$O(ORDER(ORI)) Q:ORI=""  D
 . S ORID=ORDER(ORI),ORIFN=+$P(ORID,":",2)
 . S ORLK=$$LOCK1^ORX2(ORIFN) I 'ORLK S ORY(ORI)=ORID_U_ORLK Q
 . D COMP^ORCSAVE2(ORIFN,ORUSR,ORNOW),UNLK1^ORX2(ORIFN)
 . S ORY(ORI)=ORID_U_$S($P($G(^OR(100,ORIFN,6)),U,6):1,1:0)
 Q
