XHDPEDIT        ; SLC/JER - Configuration Editor Server Calls ; 25 Jul 2003  9:42 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
GETTREE(XHDCY,XHDMOD)        ; Control Branching
 N XHDCI,XHDCDA
 S XHDCI=0,XHDCDA=+$O(^XHD(8935.91,"AMROOT",XHDMOD,0))
 S XHDCY=$NA(^TMP("XHDPTREE",$J)) K @XHDCY
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<?xml version=""1.0"" encoding=""UTF-8""?>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<getConfigurationCallResult"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="xsi:noNamespaceSchemaLocation=""C:\reeng\main\modules\config\src\gov\va\med\hds\cd\config\xml\configTree.xsd"">"
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
 ;S XHDKI=0
 ;F  S XHDKI=$O(^XHD(8935.91,XHDCDA,2,XHDKI)) Q:+XHDKI'>0  D
 ;. N XHDPARAM S XHDPARAM=$P($G(^XHD(8935.91,XHDCDA,2,XHDKI,0)),U,2)
 ;. D GETLEAF(XHDCY,XHDPARAM,XHDCDA,.XHDCI)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</children>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</"_PCATAG_">"
 Q
GETLEAF(XHDCY,PAR,PID,XHDCI)    ; Build Leafnode categories
 N FULLNAME,PLUGINID,NAME,PARAM0,PCAT0
 S PARAM0=$G(^XTV(8989.51,PAR,0)),PCAT0=$G(^XHD(8935.91,PID,0))
 S FULLNAME=$$ESCAPE^XHDLXM($P(PARAM0,U)),NAME=$$ESCAPE^XHDLXM($P(PARAM0,U,2))
 S PLUGINID=$P(PCAT0,U,2)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameterCategory>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<id/>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<fullName>"_FULLNAME_"</fullName>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<pluginId>"_PLUGINID_"</pluginId>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<name/>"_NAME_"</name>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parentId/>"_PID_"</parentId>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<packageRoot/>false</packageRoot>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<preferencePage/>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<leaf>true</leaf>"
 ;** get parameters **
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameters>"
 D GETPARAM(XHDCY,XHDCDA,.XHDCI)
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameters>"
 S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameterCategory>"
 Q
ISROOT(XHDCDA)  ; Boolean - is record plugin root?
 Q +$P($G(^XHD(8935.91,XHDCDA,0)),U,5)
FLDNAME(XHDCFN,FILENUM)  ; Resolve field names
 Q $$MIXED($P($G(^DD(FILENUM,XHDCFN,0)),U))
MIXED(X) ; Return Mixed Case X
 N ORI,WORD,TMP
 S TMP="" F ORI=1:1:$L(X," ") S WORD=$$LOW^XLFSTR($P(X," ",ORI)),$E(WORD)=$S(ORI=1:$E(WORD),1:$$UP^XLFSTR($E(WORD))),TMP=$S(TMP="":WORD,1:TMP_WORD)
 Q TMP
GETPARAM(XHDCY,XHDCDA,XHDCI)    ; Loads Parameters
 N ORI S ORI=0
 F  S ORI=$O(^XHD(8935.91,XHDCDA,2,ORI)) Q:+ORI'>0  D
 . N PNODE,FULLNAME,MULTIVAL,WORDPROC,PAR,PARDEF0,PARDEF1,DNAME,VDTYPE,READONLY
 . S PNODE=$G(^XHD(8935.91,XHDCDA,2,ORI,0))
 . Q:PNODE']""
 . S PAR=$P(PNODE,U,2),PARDEF0=$G(^XTV(8989.51,PAR,0)),PARDEF1=$G(^(1))
 . S FULLNAME=$P(PARDEF0,U),DNAME=$P(PARDEF0,U,2),VDTYPE=$P(PARDEF1,U)
 . S READONLY=$S(+$P(PARDEF0,U,6):"true",1:"false")
 . S MULTIVAL=$S(+$P(PARDEF0,U,3):"true",1:"false")
 . S WORDPROC=$S(VDTYPE="W":"true",1:"false")
 . N PLIST,ERR
 . D GETLST^XHDPAR(.PLIST,PAR,.ERR)
 . I 'ERR D
 . . N ORJ S ORJ=0
 . . F  S ORJ=$O(PLIST(ORJ)) Q:+ORJ'>0  D
 . . . N KEY,ENT,INST,VAL,NAME,EXTENT
 . . . S NAME=$$ESCAPE^XHDLXM(DNAME)
 . . . S ENT=$P(PLIST(ORJ),U),EXTENT=$P(PLIST(ORJ),U,2)
 . . . S INST=$P(PLIST(ORJ),U,3),VAL=$P(PLIST(ORJ),U,4)
 . . . S:(MULTIVAL="true") NAME=NAME_" "_INST
 . . . S KEY=NAME_U_ENT_U_PAR_U_INST
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<parameter>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<id>"_PAR_"</id>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<name>"_NAME_"</name>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<fullName>"_$$ESCAPE^XHDLXM(FULLNAME)_"</fullName>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<key>"_KEY_"</key>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<readOnly>"_READONLY_"</readOnly>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<extEntity>"_EXTENT_"</extEntity>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<multiValued>"_MULTIVAL_"</multiValued>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<wordProcessing>"_WORDPROC_"</wordProcessing>"
 . . . ; If wp, call for wp result
 . . . I (WORDPROC="true") D
 . . . . N VALIST,ERR
 . . . . D GETWP^XPAR(.VALIST,"ALL^"_$P(KEY,U,2),PAR,INST,.ERR)
 . . . . I 'ERR D
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<value>"
 . . . . . N ORK S ORK=0
 . . . . . F  S ORK=$O(VALIST(ORK)) Q:+ORK'>0  D
 . . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)=$$ESCAPE^XHDLXM($G(VALIST(ORK,0)))
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</value>"
 . . . . N DFLIST,ERR
 . . . . D GETWP^XPAR(.DFLIST,"PKG",PAR,INST,.ERR)
 . . . . I 'ERR D
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<defaultValue>"
 . . . . . N ORK S ORK=0
 . . . . . F  S ORK=$O(VALIST(ORK)) Q:+ORK'>0  D
 . . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)=$$ESCAPE^XHDLXM($G(VALIST(ORK,0)))
 . . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</defaultValue>"
 . . . E  D
 . . . . N DVAL S DVAL=$$GET^XPAR("PKG",PAR,INST,$S(VDTYPE="D":"Q",1:"E"))
 . . . . S VAL=$$XFORM^XHDPTREE(VAL,VDTYPE)
 . . . . S DVAL=$$XFORM^XHDPTREE(DVAL,VDTYPE)
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<value>"_$$ESCAPE^XHDLXM(VAL)_"</value>"
 . . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="<defaultValue>"_$$ESCAPE^XHDLXM(DVAL)_"</defaultValue>"
 . . . S XHDCI=XHDCI+1,@XHDCY@("XMLDOC",XHDCI)="</parameter>"
 Q
