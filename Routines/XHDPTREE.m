XHDPTREE        ; SLC/JER - Configurator Server Calls ; 08 Oct 2003 11:00
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
GETTREE(XHDCY,XHDMOD)        ; Control Branching
 N XHDCI,XHDCDA,X S X="ONERROR^XHDPTREE",@^%ZOSF("TRAP")
 S XHDCI=0,XHDCDA=+$O(^XHD(8935.91,"AMROOT",XHDMOD,0))
 S XHDCY=$NA(^TMP("XHDPTREE",$J)) K @XHDCY
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<?xml version=""1.0"" encoding=""UTF-8""?>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<getConfigurationCallResult"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="xsi:noNamespaceSchemaLocation=""C:\reeng\main\modules\config\src\gov\va\med\hds\cd\config\xml\getConfigurationCallResult.xsd"">"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<configTree>"
 D GETCAT(XHDCY,XHDCDA,.XHDCI)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</configTree>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</getConfigurationCallResult>"
 S XHDCY=$NA(^TMP("XHDPTREE",$J,"XMLDOC"))
 Q
FLDS() ; Get field string
 Q ".01:1"
GETCAT(XHDCY,XHDCDA,XHDCI)       ; Loads Top-level Fields
 N XHDCF,XHDKI,PCATAG S XHDCF=0
 S PCATAG=$S($$ISROOT(XHDCDA):"pluginParameterCategory",1:"parameterCategory")
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<"_PCATAG_">"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<id>"_XHDCDA_"</id>"
 D GETS^DIQ(8935.91,XHDCDA_",",$$FLDS,"IE",XHDCY)
 F  S XHDCF=$O(@XHDCY@(8935.91,XHDCDA_",",XHDCF)) Q:XHDCF'>0  D
 . N TAG,VAL
 . S TAG=$TR($$FLDNAME(XHDCF,8935.91)," /","")
 . S VAL=$G(@XHDCY@(8935.91,XHDCDA_",",XHDCF,$S(XHDCF=.04:"I",1:"E")))
 . I XHDCF=.04 S VAL=+VAL
 . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<"_TAG_">"_VAL_"</"_TAG_">"
 K @XHDCY@(8935.91)
 ;** get parameters **
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameters>"
 D GETPARAM(XHDCY,XHDCDA,.XHDCI)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameters>"
 S XHDKI=0
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<children>"
 F  S XHDKI=$O(^XHD(8935.91,XHDCDA,3,XHDKI)) Q:+XHDKI'>0  D
 . N XHDKID S XHDKID=$P($G(^XHD(8935.91,XHDCDA,3,XHDKI,0)),U,2)
 . D GETCAT(XHDCY,XHDKID,.XHDCI)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</children>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</"_PCATAG_">"
 Q
ISROOT(XHDCDA)  ; Boolean - is record plugin root?
 Q +$P($G(^XHD(8935.91,XHDCDA,0)),U,5)
FLDNAME(XHDCFN,FILENUM)  ; Resolve field names
 Q $$MIXED($P($G(^DD(FILENUM,XHDCFN,0)),U))
MIXED(X) ; Return Mixed Case X
 N XHDI,WORD,TMP
 S TMP="" F XHDI=1:1:$L(X," ") S WORD=$$LOW^XLFSTR($P(X," ",XHDI)),$E(WORD)=$S(XHDI=1:$E(WORD),1:$$UP^XLFSTR($E(WORD))),TMP=$S(TMP="":WORD,1:TMP_WORD)
 Q TMP
GETPARAM(XHDCY,XHDCDA,XHDCI)    ; Loads Parameters
 N XHDI S XHDI=0
 F  S XHDI=$O(^XHD(8935.91,XHDCDA,2,XHDI)) Q:+XHDI'>0  D
 . N PNODE,FULLNAME,MULTIVAL,WORDPROC,PAR,PARDEF0,PARDEF1,DNAME,VDTYPE,READONLY
 . S PNODE=$G(^XHD(8935.91,XHDCDA,2,XHDI,0))
 . Q:PNODE']""
 . S PAR=$P(PNODE,U,2),PARDEF0=$G(^XTV(8989.51,PAR,0)),PARDEF1=$G(^(1))
 . S FULLNAME=$P(PARDEF0,U),DNAME=$P(PARDEF0,U,2),VDTYPE=$P(PARDEF1,U)
 . S READONLY=$S(+$P(PARDEF0,U,6):"true",1:"false")
 . S MULTIVAL=$S(+$P(PARDEF0,U,3):"true",1:"false")
 . S WORDPROC=$S(VDTYPE="W":"true",1:"false")
 . N PLIST,ERR
 . D GETLST^XPAR(.PLIST,"ALL^"_DUZ_";VA(200,^"_$$GETSRV_";DIC(49,",PAR,$S(VDTYPE="D":"Q",1:"E"),.ERR)
 . I ERR Q
 . I PLIST=0 D  Q
 . . N KEY,ENT,INST,NAME,VAL,EXTENT
 . . S NAME=$$ESCAPE^XHDLXM(DNAME)
 . . S INST=$S(FULLNAME="ORWOR TIMEOUT CHART":1,1:"")
 . . S VAL=$S(FULLNAME="ORWOR TIMEOUT CHART":DTIME,1:"")
 . . S:(MULTIVAL="true") NAME=NAME_" "_INST
 . . S ENT=DUZ_";VA(200,",EXTENT=$$ENTNAME^XPARLIST(ENT)
 . . S KEY=NAME_U_ENT_U_PAR_U_INST
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameter>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<id>"_PAR_"</id>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<name>"_NAME_"</name>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<fullName>"_$$ESCAPE^XHDLXM(FULLNAME)_"</fullName>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<key>"_KEY_"</key>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<readOnly>"_READONLY_"</readOnly>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<extEntity>"_EXTENT_"</extEntity>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<multiValued>"_MULTIVAL_"</multiValued>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<wordProcessing>"_WORDPROC_"</wordProcessing>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)=$S(VAL="":"<value/>",1:"<value>"_VAL_"</value>")
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<defaultValue/>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameter>"
 . N XHDJ S XHDJ=0
 . F  S XHDJ=$O(PLIST(XHDJ)) Q:+XHDJ'>0  D
 . . N KEY,ENT,INST,VAL,NAME,EXTENT
 . . S NAME=$$ESCAPE^XHDLXM(DNAME)
 . . S INST=$P(PLIST(XHDJ),U),VAL=$P(PLIST(XHDJ),U,2)
 . . S:(MULTIVAL="true") NAME=NAME_" "_INST
 . . S ENT=$$GETENT(PAR,INST,VAL),EXTENT=$$ENTNAME^XPARLIST(ENT)
 . . S KEY=NAME_U_ENT_U_PAR_U_INST
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameter>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<id>"_PAR_"</id>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<name>"_NAME_"</name>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<fullName>"_$$ESCAPE^XHDLXM(FULLNAME)_"</fullName>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<key>"_KEY_"</key>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<readOnly>"_READONLY_"</readOnly>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<extEntity>"_EXTENT_"</extEntity>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<multiValued>"_MULTIVAL_"</multiValued>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<wordProcessing>"_WORDPROC_"</wordProcessing>"
 . . ; If wp, call for wp result
 . . I (WORDPROC="true") D
 . . . N VALIST,ERR
 . . . D GETWP^XPAR(.VALIST,"ALL^"_$P(KEY,U,2),PAR,INST,.ERR)
 . . . I 'ERR D
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<value>"
 . . . . N XHDK S XHDK=0
 . . . . F  S XHDK=$O(VALIST(XHDK)) Q:+XHDK'>0  D
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)=$$ESCAPE^XHDLXM($G(VALIST(XHDK,0)))
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</value>"
 . . . N DFLIST,ERR
 . . . D GETWP^XPAR(.DFLIST,"PKG",PAR,INST,.ERR)
 . . . I 'ERR D
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<defaultValue>"
 . . . . N XHDK S XHDK=0
 . . . . F  S XHDK=$O(VALIST(XHDK)) Q:+XHDK'>0  D
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)=$$ESCAPE^XHDLXM($G(VALIST(XHDK,0)))
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</defaultValue>"
 . . E  D
 . . . N DVAL S DVAL=$$GET^XPAR("PKG",PAR,INST,$S(VDTYPE="D":"Q",1:"E"))
 . . . S VAL=$$XFORM(VAL,VDTYPE)
 . . . S DVAL=$$XFORM(DVAL,VDTYPE)
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<value>"_$$ESCAPE^XHDLXM(VAL)_"</value>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<defaultValue>"_$$ESCAPE^XHDLXM(DVAL)_"</defaultValue>"
 . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameter>"
 Q
GETSRV()        ; Get user's Service/Section
 Q $P($G(^VA(200,DUZ,5)),U)
XFORM(VAL,VDTYPE)       ; Transform values for select data types
 N XHDY S XHDY=VAL
 I VDTYPE="D" S XHDY=$$FMTHL7^XLFDT(VAL) G XFORMX
 I VDTYPE="Y" S XHDY=$S(VAL="YES":"true",VAL="NO":"false",1:VAL)
XFORMX Q XHDY
GETENT(PAR,INST,VAL)    ; Find entity, given parameter, instance, and value
 N VLIST,ERR,ENTITY S ENTITY=0
 D ENVAL^XPAR(.VLIST,PAR,INST,.ERR)
 I 'ERR D
 . N XHDENT S XHDENT=0
 . F  S XHDENT=$O(VLIST(XHDENT)) Q:+XHDENT'>0!+ENTITY  D
 . . I $P(XHDENT,";",2)="VA(200,",(+XHDENT'=DUZ) Q
 . . I ($G(VLIST(XHDENT,INST))=VAL) S ENTITY=XHDENT
 S:'+ENTITY ENTITY=DUZ_";VA(200,"
 Q ENTITY
ONERROR ; Trap errors
 N XHDCI S XHDCI=4
 ; remove remnant of DIQ1 call result
 K @XHDCY@(8935.91)
 ; remove partial configTree node
 F  S XHDCI=$O(@XHDCY@("XMLDOC",XHDCI)) Q:+XHDCI'>0  K @XHDCY@("XMLDOC",XHDCI)
 ; append error node to call result
 S XHDCI=4
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<error>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<![CDATA["_$$EC^%ZOSV_"]]>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</error>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</getConfigurationCallResult>"
 S XHDCY=$NA(^TMP("XHDPTREE",$J,"XMLDOC"))
 D ^%ZTER
 Q
