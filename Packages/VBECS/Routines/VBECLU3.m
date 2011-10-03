VBECLU3 ;HIOFO/BNT - VBECS Patient Lookup Utility ;04/13/2005 09:00
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;
 QUIT
 ; -- Get list of wards or clinics for patient lookup by ward
 ; 
 ; -- Does not currently limit display by division, institution, etc.  May need to.
 ; 
GETLIST(RESULT,PARAM) ;
 NEW X,CNT,VBECLINE,VBECESLT,OKAY
 SET (CNT,OKAY)=0
 IF '$D(DT) D DT^DICRW
 ;
 SET VBECLINE=0
 K ^TMP($J,"PLU-FILTER")
 SET VBECRSLT="^TMP($J,""PLU-FILTER"")"
 SET RESULT=$NA(@VBECRSLT)
 ;
 DO ADD^VBECLU($$XMLHDR^XOBVLIB)
 ;
 IF $$UP^XLFSTR(PARAM("TYPE"))="WARD" S OKAY=1 D
 . D ADD^VBECLU("<filterlist type='ward'>")
 . D WLIST("ward")
 . D ADD^VBECLU("</filterlist>")
 ;
 IF $$UP^XLFSTR(PARAM("TYPE"))="CLINIC" S OKAY=2 D
 . D ADD^VBECLU("<filterlist type='clinic'>")
 . D CLIST("clinic","C")
 . D ADD^VBECLU("</filterlist>")
 ;
 IF $$UP^XLFSTR(PARAM("TYPE"))="PROVIDER" S OKAY=3 D
 . D ADD^VBECLU("<filterlist type='provider'>")
 . D PLIST("provider")
 . D ADD^VBECLU("</filterlist>")
 ;
 IF OKAY<1 D
 . D ADD^VBECLU("<unspecified>")
 . D ADD^VBECLU("<error message='List type not supported or not specified!'>")
 . D ADD^VBECLU("</unspecified>")
 ;
 QUIT
 ;
 ; -- get list of clinics for patient lookup by clinic
CLIST(ITEM,CHKVAL) ;
 NEW NAME,IEN,IDATE,RDATE
 SET IEN=0
 SET CNT=0
 FOR  S IEN=$O(^SC("AC","C",IEN)) Q:IEN<1  DO  ;loop through clinic xref
 . S IDATE=$P($G(^SC(IEN,"I")),"^",1) ;inactivate date
 . S RDATE=$P($G(^SC(IEN,"I")),"^",2) ;reactivate date
 . IF (IDATE="")!(IDATE'<DT)!((IDATE<DT)&(RDATE>IDATE)) DO
 . SET CNT=CNT+1
 . SET NAME=$P(^SC(IEN,0),"^",1)
 . DO ADD^VBECLU("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^XOBVLIB(NAME)_"'></lineitem>")
 ;FOR  S NAME=$O(^SC("B",NAME)) Q:NAME=""  DO
 ;. S IEN=0
 ;. FOR  S IEN=$O(^SC("B",NAME,IEN)) Q:IEN<1  DO
 ;.. IF $P($G(^SC(IEN,0)),"^",3)=CHKVAL DO  ;is a clinic
 ;...  S IDATE=$P($G(^SC(IEN,"I")),"^",1) ;inactivate date
 ;...  S RDATE=$P($G(^SC(IEN,"I")),"^",2) ;reactivate date
 ;...  IF (IDATE="")!(IDATE'<DT)!((IDATE<DT)&(RDATE>IDATE)) DO
 ;.... SET CNT=CNT+1
 ;.... DO ADD^VBECLU("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^XOBVLIB(NAME)_"'></lineitem>")
 QUIT
 ;
WLIST(ITEM) ;
 NEW NAME,IEN
 SET NAME=""
 SET CNT=0
 FOR  S NAME=$O(^DIC(42,"B",NAME)) Q:NAME=""  DO
 . S IEN=0
 . FOR  S IEN=$O(^DIC(42,"B",NAME,IEN)) Q:IEN<1  DO
 .. SET CNT=CNT+1
 .. DO ADD^VBECLU("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^XOBVLIB(NAME)_"'></lineitem>")
 QUIT
 ; -- get list of providers for patient lookup by provider
 ;    from ORQPTQ2
PLIST(ITEM) ;
 NEW NAME,IEN
 SET (NAME,IEN)=""
 SET CNT=0
 K ^TMP($J,"PLU-F")
 FOR  S IEN=$O(^XUSEC("PROVIDER",IEN)) Q:IEN<1  I $$ACTIVE^XUSER(IEN) DO
 . SET ^TMP($J,"PLU-F",$P(^VA(200,IEN,0),"^",1),IEN)=""
 SET NAME=""
 F  S NAME=$O(^TMP($J,"PLU-F",NAME)) Q:NAME=""  DO
 . SET IEN=0 F  S IEN=$O(^TMP($J,"PLU-F",NAME,IEN)) Q:IEN<1  DO  W IEN
 .. SET CNT=CNT+1
 .. DO ADD^VBECLU("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^XOBVLIB(NAME)_"'></lineitem>")
 ;
 ;FOR  S NAME=$O(^VA(200,"B",NAME)) Q:NAME=""  DO
 ;. S IEN=0
 ;. FOR  S IEN=$O(^VA(200,"B",NAME,IEN)) Q:IEN<1  DO
 ;.. I $D(^XUSEC("PROVIDER",IEN)),$$ACTIVE^XUSER(IEN) DO
 ;... SET CNT=CNT+1
 ;... DO ADD^VBECLU("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^XOBVLIB(NAME)_"'></lineitem>")
 QUIT
 ;
TEST ;
 NEW X,START,FINISH
 DO TESTC
 DO TESTP
 DO TESTW
 QUIT
 ;
TESTW ;
 S START=$H
 W !,"WARD LIST"
 S X("TYPE")="wARd"
 D GETLIST(.RESULT,.X)
 S FINISH=$H
 D DISPLAY(.RESULT)
 W !,"Elapse Time: ",$P(FINISH,",",2)-$P(START,",",2)
 K RESULT
 QUIT
 ;
TESTC ;
 S START=$H W !,"CLINIC LIST"
 S X("TYPE")="ClinIC"
 D GETLIST(.RESULT,.X)
 S FINISH=$H
 D DISPLAY(.RESULT)
 W !,"Elapse Time: ",$P(FINISH,",",2)-$P(START,",",2)
 K RESULT
 QUIT
 ;
TESTP ;
 S START=$H W !,"PROVIDER LIST"
 S X("TYPE")="pROvIdER"
 D GETLIST(.RESULT,.X)
 S FINISH=$H
 D DISPLAY(.RESULT)
 W !,"Elapse Time: ",$P(FINISH,",",2)-$P(START,",",2)
 Q
DISPLAY(RESULT) ;
 NEW I
 S I=-1 FOR  SET I=$O(@RESULT@(I)) Q:I<1  W !!,@RESULT@(I)
 QUIT
