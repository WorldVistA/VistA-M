ORMFH1 ;SLC/MKB - Process OP Meal ORM msgs ;5/5/05  13:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
 ;
XX ; -- Change order (diet mod or location only)
 N ODS,ORDIALOG,ORDG,ORIT,ORDA,ORX,STS,ORP,ORI,ORTRAIL,ORSIG,X
 I $G(ORCAT)="I" S ORERR="Only outpatient meals can be changed" Q
 I '$D(^VA(200,+ORDUZ,0)) S ORERR="Missing or invalid entering person" Q
 ;I '$G(ORL) S ORERR="Missing or invalid patient location" Q
 S ODS=$O(@ORMSG@(+ORC)) I 'ODS S ORERR="Incomplete message" Q
 S ODS=ODS_U_@ORMSG@(ODS),ORIFN=+ORIFN S:'$L(ORNATR) ORNATR="S"
 S X=$P(ODS,"|",4) D  ;get OI
 . I X?1"^^^FH-5".E S X=+$O(^ORD(101.43,"S.DIET","NPO",0)) Q
 . I X?1"^^^FH-X".E S X=+$O(^ORD(101.43,"S.DIET","NO MEAL",0)) Q
 . S X=$$ORDITEM^ORM(X)
 I 'X S ORERR="Missing or invalid diet modification" Q
 S ORSTRT=+ORSTRT I ORSTRT<1 S ORERR="Missing or invalid meal date" Q
 ; - Setup dialog and current responses:
 S ORDIALOG=+$O(^ORD(101.41,"AB","FHW OP MEAL",0)),ORTRAIL="Meal"
 D GETDLG1^ORCD(ORDIALOG),GETORDER^ORCD(ORIFN)
 S ORP=$$PTR("MEAL DATE"),ORI=$$PTR("ADDL DIETS")
 S ORIT=$G(ORDIALOG($$PTR("ORDERABLE ITEM"),1)) ;orig diet
 I '$G(ORDIALOG(ORI,ORSTRT)) Q:X=ORIT  ;no diet change
 E  Q:X=$G(ORDIALOG(ORI,ORSTRT))  I X=ORIT K ORDIALOG(ORI,ORSTRT),ORDIALOG(ORP,ORSTRT) G XX1 ;back to orig diet
 S ORDIALOG(ORI,ORSTRT)=X,ORDIALOG(ORP,ORSTRT)=ORSTRT
XX1 ; - Create action to track change
 S ORDA=$$ACTION^ORCSAVE("XX",ORIFN,ORNP,OREASON,ORLOG,ORDUZ)
 I ORDA'>0 S ORERR="Cannot create new order action" Q
 ; - Update sts of order to active, last action to dc/edit:
 K ORX S ORX=+$P($G(^OR(100,ORIFN,3)),U,7)
 S:$P($G(^OR(100,ORIFN,8,ORX,0)),U,15)="" $P(^(0),U,15)=12
 S $P(^OR(100,ORIFN,3),U,7)=ORDA,STS=$P(^(3),U,3)
 D STATUS^ORCSAVE2(ORIFN,6):STS'=6,SETALL^ORDD100(ORIFN):STS=6
 D RELEASE^ORCSAVE2(ORIFN,ORDA,ORLOG,ORDUZ,ORNATR)
 ; - If unsigned edit, leave XX unsigned & mark ORX as Sig Not Req'd:
 S ORSIG=$S($P($G(^OR(100,ORIFN,8,ORX,0)),U,4)'=2:1,1:0)
 D SIGSTS^ORCSAVE2(ORIFN,ORDA):ORSIG,SIGN^ORCSAVE2(ORIFN,,,5,ORX):'ORSIG
 ; - Update responses, get/save new order text:
 K ^OR(100,ORIFN,4.5) D RESPONSE^ORCSAVE,ORDTEXT^ORCSAVE1(ORIFN_";"_ORDA)
 S $P(^OR(100,ORIFN,8,ORDA,0),U,14)=ORDA
XXQ I $G(ORL) K ORP S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 Q
 ;
OPM ; -- parse Outpatient Meal dialog
 N X,TYPE,NPO
 S TYPE=$P(ODS,"|",2),X=$S(TYPE="S":"SPECIAL",1:"OP")
 S ORDIALOG=+$O(^ORD(101.41,"AB","FHW "_X_" MEAL",0)),ORTRAIL="Meal"
 D GETDLG1^ORCD(ORDIALOG) S X=$P(ODS,"|",4)
 I X?1"^^^FH-5".E S X=+$O(^ORD(101.43,"S.DIET","NPO",0)),NPO=1
 E  S X=$$ORDITEM^ORM(X)
 I 'X S ORERR="Missing or invalid diet modification" Q
 S ORDIALOG($$PTR("ORDERABLE ITEM"),1)=X I TYPE="D" D
 . N DAYS,SCH,I S DAYS="",SCH=$P(ORQT,U,2)
 . I $L(SCH),SCH'="ONCE" F I=1:1:$L(SCH,"~") S X=+$P($P(SCH,"~",I),"J",2),DAYS=DAYS_$E("MTWRFSX",X)
 . S:$L(DAYS) ORDIALOG($$PTR("SCHEDULE"),1)=DAYS
 S X=$P(ODS,"|",3) S:X ORDIALOG($$PTR("MEAL"),1)=$TR(X,"135","BNE")
 S ORDIALOG($$PTR("START DATE"),1)=ORSTRT
 S:ORSTOP ORDIALOG($$PTR("STOP DATE"),1)=ORSTOP
 S X=$P(ODS,"|",5) I $G(NPO) S:$L(X) ORDIALOG($$PTR("FREE TEXT 1"),1)=X
 E  S ORDIALOG($$PTR("DELIVERY"),1)=$E(X)
 Q
 ;
PTR(NAME) ; -- Returns ien of prompt NAME in Order Dialog file #101.41
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_NAME,1,63),0))
