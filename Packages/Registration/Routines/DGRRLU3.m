DGRRLU3 ;alb/aas - DG Replacement and Rehosting RPC for VADPT ;8/8/05  15:38
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
 QUIT
 ; -- Get list of wards or clinics for patient lookup by ward
 ;
 ; -- Does not currently limit display by division, institution, etc.  May need to.
 ;
GETLIST(RESULT,PARAM) ;
 ; Input: PARAM("TYPE")="ward" returns a list of wards
 ;        PARAM("TYPE")="clinic" returns a list of clinics
 ;        PARAM("TYPE")="provider" returns a list of providers 
 ;        PARAM("TYPE")="specialty" returns a list of specialties
 ;        PARAM("VALUE")= Beginning lookup value or null to start
 ;                         at the beginning or end of the file.
 ;        PARAM("MAXNUM")= Number of records to be returned.  If a
 ;                          negative number, traverse backwards.
 ;
 NEW X,CNT,DGRRLINE,DGRRESLT,OKAY
 SET (CNT,OKAY)=0
 IF '$D(DT) D DT^DICRW
 ;
 SET DGRRLINE=0
 K ^TMP($J,"PLU-FILTER")
 SET DGRRESLT="^TMP($J,""PLU-FILTER"")"
 SET RESULT=$NA(@DGRRESLT)
 ;
 DO ADD^DGRRUTL($$XMLHDR^DGRRUTL)
 ;
 IF $$UP^XLFSTR($G(PARAM("TYPE")))="WARD" S OKAY=1 D
 . D ADD^DGRRUTL("<filterlist type='ward'>")
 . D WLIST("ward",$G(PARAM("VALUE")),$G(PARAM("MAXNUM")))
 . D ADD^DGRRUTL("</filterlist>")
 ;
 IF $$UP^XLFSTR($G(PARAM("TYPE")))="CLINIC" S OKAY=2 D
 . D ADD^DGRRUTL("<filterlist type='clinic'>")
 . D CLIST("clinic","C",$G(PARAM("VALUE")),$G(PARAM("MAXNUM")))
 . D ADD^DGRRUTL("</filterlist>")
 ;
 IF $$UP^XLFSTR($G(PARAM("TYPE")))="PROVIDER" S OKAY=3 D
 . D ADD^DGRRUTL("<filterlist type='provider'>")
 . D PLIST("provider",$G(PARAM("VALUE")),$G(PARAM("MAXNUM")))
 . D ADD^DGRRUTL("</filterlist>")
 ;
 IF $$UP^XLFSTR($G(PARAM("TYPE")))="SPECIALTY" S OKAY=4 D
 . D ADD^DGRRUTL("<filterlist type='specialty'>")
 . D SLIST("specialty",$G(PARAM("VALUE")),$G(PARAM("MAXNUM")))
 . D ADD^DGRRUTL("</filterlist>")
 ;
 IF OKAY<1 D
 . D ADD^DGRRUTL("<unspecified>")
 . D ADD^DGRRUTL("<error message='List type not supported or not specified!'>")
 . D ADD^DGRRUTL("</unspecified>")
 ;
 QUIT
 ;
 ; -- get list of clinics for patient lookup by clinic
CLIST(ITEM,CHKVAL,VALUE,MAXNUM) ;
 NEW NAME,IEN,IDATE,RDATE,DIR,CNT2,DGRRB,FLAG
 S VALUE=$$UP^XLFSTR($G(VALUE))
 S NAME=$G(VALUE)
 S MAXNUM=$G(MAXNUM)
 S DGRRB=0
 K ^TMP("DGRRLU3-CLIST",$J)
 I $E(MAXNUM)="-" D
 . S DGRRB=1  ; ****
 .I MAXNUM="-" S MAXNUM="" Q  ; ****
 .S MAXNUM=$$ABS^XLFMTH(MAXNUM)
 S (FLAG,CNT)=0
 I $L(NAME)>0,DGRRB=0,$D(^SC("B",NAME)) S NAME=$O(^SC("B",NAME),-1) ; ****
 I $L(NAME)>0,DGRRB=1,$D(^SC("B",NAME)) S NAME=$O(^SC("B",NAME)) ; ****
 I 'DGRRB D
 . S DIR=1
 .FOR  S NAME=$O(^SC("B",NAME)) Q:NAME=""  DO  Q:FLAG=1
 .. S IEN=0
 .. FOR  S IEN=$O(^SC("B",NAME,IEN)) Q:IEN<1  DO  Q:FLAG=1
 ...N STATUS
 ...S STATUS=$$STATUS(IEN,CHKVAL)
 ...I STATUS=1 D
 ....S CNT=CNT+1  I MAXNUM,CNT>MAXNUM S FLAG=1 Q   ; ****
 .... ;DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 .... S ^TMP("DGRRLU3-CLIST",$J,CNT)=IEN_U_NAME
 I DGRRB D
 . S DIR=-1
 .FOR  S NAME=$O(^SC("B",NAME),-1) Q:NAME=""  DO  Q:FLAG=1
 .. S IEN=0
 .. FOR  S IEN=$O(^SC("B",NAME,IEN)) Q:IEN<1  DO  Q:FLAG=1
 ...N STATUS
 ...S STATUS=$$STATUS(IEN,CHKVAL)
 ...I STATUS=1 D
 ....S CNT=CNT+1  I MAXNUM,CNT>MAXNUM S FLAG=1 Q   ; ****
 .... ; DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 .... S ^TMP("DGRRLU3-CLIST",$J,CNT)=IEN_U_NAME
 S CNT2="",CNT=0
 F  S CNT2=$O(^TMP("DGRRLU3-CLIST",$J,CNT2),DIR) Q:CNT2=""  D
 . S IEN=+^TMP("DGRRLU3-CLIST",$J,CNT2)
 . S NAME=$P(^TMP("DGRRLU3-CLIST",$J,CNT2),U,2)
 . S CNT=CNT+1
 . DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 QUIT
STATUS(IEN,CHKVAL) ;
 N IDATE,RDATE,STATUS
 S STATUS=0
 IF $P($G(^SC(IEN,0)),"^",3)=CHKVAL DO  ;is a clinic
 .S IDATE=$P($G(^SC(IEN,"I")),"^",1) ;inactivate date
 .S RDATE=$P($G(^SC(IEN,"I")),"^",2) ;reactivate date
 .IF (IDATE="")!(IDATE'<DT)!((IDATE<DT)&(RDATE>IDATE)) S STATUS=1
 Q STATUS
 ;
WLIST(ITEM,VALUE,MAXNUM) ;
 ;  Input:  VALUE - Beginning value or null to start at the beginning
 ;                  or end of the file.
 ;         MAXNUM - Number of entries to be returned.  Defaults to
 ;                  traversing forward but if MAXNUM is a negative
 ;                  number, traverses through the file backwards.
 N FLAG,ERROR,CNT,DGRRB,BACKMTCH,CNT2
 S CNT=0
 ;I VALUE is null and MAXNUM is set to "-" or null, all wards returned
 S VALUE=$$UP^XLFSTR($G(VALUE))
 S MAXNUM=$G(MAXNUM)
 S FLAG=""
 I $E(MAXNUM)="-" D
 .;Set direction for traversing file to backwards and remove - from
 .;maximum number of records returned.
 .S FLAG="B"
 .I MAXNUM="-" S MAXNUM="" Q
 .S MAXNUM=$$ABS^XLFMTH(MAXNUM)
 ;Look for exact match
 K ^TMP("DILIST",$J)
 I ($G(VALUE)'="") D EXMTCH
 ;Call File Manager for remaining matches
 ; K ^TMP("DILIST",$J)
 I MAXNUM'=0 D LIST^DIC(42,,.01,$G(FLAG),MAXNUM,VALUE,,"B",,,,"ERROR")
 Q:$D(ERROR)
 N DGRRI
 S DGRRI=""
 I $G(BACKMTCH) D
 . S ^TMP("DILIST",$J,2,"ZZ")=+BACKMTCH
 . S ^TMP("DILIST",$J,1,"ZZ")=$P(BACKMTCH,U,2)
 S DGRRB=1 ; I FLAG="B" S DGRRB=-1
 F  S DGRRI=$O(^TMP("DILIST",$J,1,DGRRI),DGRRB) Q:DGRRI=""  D
 .N IEN,NAME
 .S CNT=CNT+1
 .S NAME=$G(^TMP("DILIST",$J,1,DGRRI))
 .S IEN=$G(^TMP("DILIST",$J,2,DGRRI))
 .DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 ; I FLAG="B",($G(VALUE)'="") D EXMTCH
 Q
EXMTCH ;Look for exact match
 I $D(^DIC(42,"B",VALUE)) D
 .N IEN
 .S IEN=0
 .F  S IEN=$O(^DIC(42,"B",VALUE,IEN)) Q:IEN=""  D
 ..N NAME
 ..S NAME=$P($G(^DIC(42,+IEN,0)),U)
 .. ; S CNT=CNT+1
 .. I MAXNUM'="" S MAXNUM=MAXNUM-1
 .. I FLAG'="B" S CNT=CNT+1 DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 .. I FLAG="B" S BACKMTCH=IEN_U_NAME
 Q
 ; -- get list of providers for patient lookup by provider
 ;    from ORQPTQ2
PLIST(ITEM,VALUE,MAXNUM) ;
 NEW NAME,IEN,DGRRB,FLAG,CNT2,DGRRSCR,DGRRFMT
 S VALUE=$$UP^XLFSTR($G(VALUE))
 S NAME=$G(VALUE)
 S MAXNUM=$G(MAXNUM)
 S DGRRB=1
 ;K ^TMP("DGRRLU3-PLIST",$J)
 K ^TMP("DILIST",$J)
 I $E(MAXNUM)="-" D
 . S DGRRB=-1  ; *****
 . I MAXNUM="-" S MAXNUM="" Q  ; *****
 .S MAXNUM=$$ABS^XLFMTH(MAXNUM)
 S (FLAG,CNT)=0
 ;I $L(NAME)>0,DGRRB=1,$D(^VA(200,"B",NAME)) S NAME=$O(^VA(200,"B",NAME),-1)
 ;I $L(NAME)>0,DGRRB=-1,$D(^VA(200,"B",NAME)) S NAME=$O(^VA(200,"B",NAME))
 ;FOR  S NAME=$O(^VA(200,"B",NAME),DGRRB) Q:NAME=""  DO  Q:FLAG=1
 ;. S IEN=0
 ;. FOR  S IEN=$O(^VA(200,"B",NAME,IEN)) Q:IEN<1  DO  Q:FLAG=1
 ;.. I $D(^XUSEC("PROVIDER",IEN)),$$ACTIVE^XUSER(IEN) DO
 ;... SET CNT=CNT+1
 ;... S ^TMP("DGRRLU3-PLIST",$J,CNT)=IEN_U_NAME
 ;... I MAXNUM,CNT>(MAXNUM-1) S FLAG=1
 ;S CNT2="",CNT=0
 ;F  S CNT2=$O(^TMP("DGRRLU3-PLIST",$J,CNT2),DGRRB) Q:CNT2=""  D
 ;. S IEN=+^TMP("DGRRLU3-PLIST",$J,CNT2)
 ;. S NAME=$P(^TMP("DGRRLU3-PLIST",$J,CNT2),U,2)
 ;. S CNT=CNT+1
 ;. DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 I $L(NAME)>0,DGRRB=1,$D(^VA(200,"AK.PROVIDER",NAME)) S NAME=$O(^VA(200,"AK.PROVIDER",NAME),-1)
 I $L(NAME)>0,DGRRB=-1,$D(^VA(200,"AK.PROVIDER",NAME)) S NAME=$O(^VA(200,"AK.PROVIDER",NAME))
 S DGRRSCR="I $$ACTIVE^XUSER(+Y)"
 S DGRRFMT="P"_$S(DGRRB=-1:"B",1:"")
 D LIST^DIC(200,,"@;.01",DGRRFMT,MAXNUM,NAME,,"AK.PROVIDER",DGRRSCR)
 S (CNT2,CNT)=0
 F  S CNT2=$O(^TMP("DILIST",$J,CNT2)) Q:CNT2=""  D
 . S IEN=+$G(^TMP("DILIST",$J,CNT2,0))
 . S NAME=$P($G(^TMP("DILIST",$J,CNT2,0)),U,2)
 . S CNT=CNT+1
 . DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 K ^TMP("DILIST",$J)
 D CLEAN^DILF
 QUIT
 ;
SLIST(ITEM,VALUE,MAXNUM) ;Returns active specialties in Facility TreatingSpecialty (#45.7) file
 ;
 N NAME,IEN,CNT,FLAG,DGRRB,DGRRD,CNT2
 S NAME=$$UP^XLFSTR($G(VALUE))
 ; S NAME=$G(VALUE)
 S (FLAG,IEN,CNT)=0
 S MAXNUM=$G(MAXNUM)
 S DGRRB=1
 K ^TMP("DGRRLU3-SLIST",$J)
 I $E(MAXNUM)="-" D
 .S DGRRB=-1
 .S MAXNUM=$$ABS^XLFMTH(MAXNUM)
 ;Capture exact matches
 I $L(NAME),$D(^DIC(45.7,"B",NAME)) D
 .N DGRRD
 .S DGRRD=$S(DGRRB=1:-1,1:1)
 .S NAME=$O(^DIC(45.7,"B",NAME),DGRRD)
 F  S NAME=$O(^DIC(45.7,"B",NAME),DGRRB) Q:NAME=""  D  Q:FLAG=1
 .F  S IEN=$O(^DIC(45.7,"B",NAME,IEN)) Q:IEN'>0  D  Q:FLAG=1
 ..I $$ACTIVE^DGACT(45.7,IEN) D
 ...S CNT=CNT+1
 ...I MAXNUM,(CNT>MAXNUM) S FLAG=1 Q
 ...; DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 ...S ^TMP("DGRRLU3-SLIST",$J,CNT)=IEN_U_NAME
 S CNT=1,CNT2=""
 S DGRRD=$S(DGRRB=1:1,1:-1)
 F  S CNT2=$O(^TMP("DGRRLU3-SLIST",$J,CNT2),DGRRD) Q:CNT2=""  D
 . S IEN=+^TMP("DGRRLU3-SLIST",$J,CNT2)
 . S NAME=$P(^TMP("DGRRLU3-SLIST",$J,CNT2),U,2)
 . DO ADD^DGRRUTL("<lineitem number='"_CNT_"' id='"_IEN_"' name='"_$$CHARCHK^DGRRUTL(NAME)_"'></lineitem>")
 . S CNT=CNT+1
 Q
 ;
DISPLAY(RESULT) ;
 NEW I
 S I=-1 FOR  SET I=$O(@RESULT@(I)) Q:I<1  W !!,@RESULT@(I)
 QUIT
