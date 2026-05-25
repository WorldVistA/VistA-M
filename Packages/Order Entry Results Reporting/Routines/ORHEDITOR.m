ORHEDITOR ; SLC/AGP - HTML Dialog Routine ;Apr 16, 2025@07:53:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to MAKE^TIUSRVP supported by DBIA # 3375
 ; Reference to ^TIU(8925.1,+TITLE,0) supported by DBIA # 4478
 ; Reference to ^SC(NOTEINFO("location"),0),U) supported by DBIA # 10040
 ;
 Q
 ;
BLDADDVALUES(DATA,SRCDATA,SCHEMA,DSCHEMA) ;
 N DITEM,DNAME,DTYPE,DVALUE
 K SCHEMA("vistaRequiredValues")
 K SCHEMA("vistaSourceData")
 S DTYPE="" F  S DTYPE=$O(DATA(DTYPE)) Q:DTYPE=""  D
 .S SCHEMA("vistaRequiredValues","properties",DTYPE,"type")="object"
 .S DNAME="" F  S DNAME=$O(DATA(DTYPE,DNAME)) Q:DNAME=""  D
 ..S DVALUE=$G(DATA(DTYPE,DNAME))
 ..S SCHEMA("vistaRequiredValues","properties",DTYPE,"properties",DNAME,"type")="string"
 ..S DSCHEMA("vistaRequiredValues",DTYPE,DNAME)=DVALUE
 S DNAME="" F  S DNAME=$O(SRCDATA(DNAME)) Q:DNAME=""  D
 .S DVALUE=$G(SRCDATA(DNAME)) I DVALUE="" Q
 .S SCHEMA("vistaSourceData","properties",DNAME,"type")="string"
 .S DSCHEMA("vistaSourceData",DNAME)=DVALUE
 I $D(SCHEMA("vistaRequiredValues","properties")) D
 .S SCHEMA("vistaRequiredValues","additionalProperties")="true"
 .S SCHEMA("vistaRequiredValues","title")="vistaRequiredValuesDatNum"
 .S SCHEMA("vistaRequiredValues","type")="object"
 I $D(SCHEMA("vistaSourceData","properties")) D
 .S SCHEMA("vistaSourceData","additionalProperties")="false"
 .S SCHEMA("vistaSourceData","title")="SourceDatum"
 .S SCHEMA("vistaSourceData","type")="object"
 Q
 ;
 ;
GETEDITOR(DFN,USER,IDS,PKG,EID,DARRAY,RESULTS) ;
 N CACHESUB,CNT,DATA,DSCHEMA,MPFIEN,REQDATA,RET,SCHEMA,SRCDATA,SUB,TMP,UISCHEMA,TYPE
 S SUB="ORHEDITOR DATA",CACHESUB="ORHEDITOR CACHE"
 K ^TMP(SUB,$J)
 S SRCDATA("id")=IDS,SRCDATA("patient")=DFN
 S SRCDATA("package")=PKG,SRCDATA("connectedUser")=USER
 S SRCDATA("editorId")=EID
 I EID=0 D SETERROR(.RESULTS,"Editor ID not found") Q 0
 S TMP=$$GETSCHEMAS(EID,.SCHEMA,.UISCHEMA) I '+TMP D SETERROR(.RESULTS,$P(TMP,U,2)) Q 0
 D BLDADDVALUES(.DARRAY,.SRCDATA,.SCHEMA,.DSCHEMA)
 S MPFIEN=$P($G(^ORE(101.74,EID,40)),U)
 M REQDATA("data")=DSCHEMA
 M REQDATA("schema")=SCHEMA
 M REQDATA("uiSchema")=UISCHEMA
 M REQDATA("requiredInputs")=DARRAY
 M REQDATA("sourceInputs")=SRCDATA
 S RET=$$ONCLICKEXECODE^ORIUTL(SUB,DFN,USER,"BUILD",IDS,MPFIEN,.REQDATA,CACHESUB)
 I $G(^TMP(SUB,$J,"success"))'="true" D SETERROR(.RESULTS,"Failed to load Web Content file entry") Q 0
 S CNT=0 F TYPE="Schema","UISchema","Data" D
 .I '$D(^TMP(SUB,$J,TYPE)) Q
 .S CNT=CNT+1
 .S RESULTS("contents",CNT,"contentType")=TYPE
 .S RESULTS("contents",CNT,"name")=TYPE
 .M RESULTS("contents",CNT,"data")=^TMP(SUB,$J,TYPE)
 K ^TMP(SUB,$J,"OREDITOR INDEX")
 Q 1
 ;
GETSCHEMA(SID,RESULT) ;
 N ARRAY,ERROR,INPUT,NAME,TMP
 S INPUT("id")=SID
 S NAME=$P($G(^ORW(101.76,SID,0)),U) I NAME="" Q "-1^Could not find schema id# "_SID_"."
 D GETWEBCONTENTID^ORWEB(.ARRAY,.INPUT)
 I $G(ARRAY("success"))'="true" Q "-1^Schema "_NAME_" could not be loaded from file."
 M TMP=ARRAY("contents",1,"data","\") I '$D(TMP) Q "-1^Schema "_NAME_" could not be merge into tmp file."
 D DECODE^XLFJSON("TMP","RESULT","ERROR")
 I $D(ERROR) Q "-1^Schema "_NAME_" fail decoding from temp file."
 Q 1
 ;
GETSCHEMAS(EID,SCHEMA,UISCHEMA) ;
 N NODE,SID,TMP
 S NODE=$G(^ORE(101.74,EID,50))
 S SID=+$P(NODE,U) I SID=0 Q "-1^Schema id not found."
 S TMP=$$GETSCHEMA(SID,.SCHEMA) I '+TMP Q TMP
 S SID=+$P(NODE,U,2) I SID=0 Q "-1^UI Schema id not found."
 K TMP S TMP=$$GETSCHEMA(SID,.UISCHEMA) I '+TMP Q TMP
 Q 1
 ;
SAVE(RESULTS,IJSON) ;
 N ADDVALUES,DATA,DFN,EID,IDS,INFOARRAY,INPUTS,SRCDATA,SUB,SUBSCRIPT,TARRAY,USER
 S SUBSCRIPT="ORHEDITOR SAVE DATA"
 K ^TMP(SUBSCRIPT,$J)
 S RESULTS=$NA(^TMP(SUBSCRIPT,$J))
 D DECODE^XLFJSON("IJSON","INPUTS","ERROR")
 S SUB="" F  S SUB=$O(INPUTS(SUB)) Q:SUB=""  D
 .I SUB="vistaRequiredValues" M ADDVALUES=INPUTS(SUB) Q
 .I SUB="vistaSourceData" M SRCDATA=INPUTS(SUB) Q
 .M DATA(SUB)=INPUTS(SUB)
 ;
 S DFN=+$G(SRCDATA("patient")),IDS=$G(SRCDATA("id")),EID=+$G(SRCDATA("editorId")),USER=+$G(SRCDATA("connectedUser"))
 I 'DFN D SETERROR(.TARRAY,"Patient DFN not found") G SAVEX
 I 'EID D SETERROR(.TARRAY,"Editor ID not found") G SAVEX
 I 'IDS D SETERROR(.TARRAY,"Panel ID not found") G SAVEX
 I 'USER D SETERROR(.TARRAY,"User Id not found") G SAVEX
 I '$$GETINFOARRAY^ORIRPCCL(.INFOARRAY,IDS,.TARRAY) G SAVEX
 ;
 ;AGP TODO DETERMINE IF WE CAN BRING BACK REQUIRED CHECK
 ;I '$$REQDATA^ORIRPCCL(.INFOARRAY,.INPUTS,.TARRAY,.REQDATA) G SAVEX
 I '$$SAVEDATA(DFN,USER,EID,IDS,SUBSCRIPT,.DATA,.ADDVALUES,.SRCDATA,.TARRAY) G SAVEX
 S TARRAY("success")="true"
SAVEX ;
 K ^TMP(SUBSCRIPT,$J)
 D ENCODE^XLFJSON("TARRAY",$NA(^TMP(SUBSCRIPT,$J)),"ERROR")
 Q
 ;
SAVEDATA(DFN,USER,EID,PIDX,SUB,DATA,REQDATA,SRCDATA,TARRAY) ;
 N MPFIEN,NODE,NOTEINFO,REFRESH,RET,ROUTINE,RTN,SAVEDATA,TAG,TEMP,TITLE
 S NODE=$G(^ORE(101.74,EID,40))
 S MPFIEN=$P(NODE,U,1)
 S TITLE=+$P(NODE,U,3) I TITLE>0,'$$NOTEINFO(.NOTEINFO,.REQDATA,.TARRAY,TITLE) Q 0
 S REFRESH=$S($P($G(^ORE(101.74,EID,0)),U,9)=1:"true",1:"false")
 I TITLE>0 S SAVEDATA("noteTitleId")=TITLE
 M SAVEDATA("data")=DATA
 M SAVEDATA("requiredInputs")=REQDATA
 M SAVEDATA("sourceInputs")=SRCDATA
 S SAVEDATA("createNote")=$S(TITLE>0:1,1:0)
 M SAVEDATA("noteCreationData")=NOTEINFO
 S RET=$$ONCLICKEXECODE^ORIUTL(SUB,DFN,USER,"SAVE",PIDX,MPFIEN,.SAVEDATA)
 I +RET<1 D SETERROR(.TARRAY,$P(RET,U,2)) Q 0
 M TARRAY("resultData")=^TMP(SUB,$J,"resultData")
 S TARRAY("refreshAllInfoPanels")=REFRESH
 I $D(^TMP(SUB,$J,"noteInformation")) M TARRAY("noteInformation")=^TMP(SUB,$J,"noteInformation") Q 1
 I TITLE>0,SAVEDATA("createNote")=1,'$$MAKENOTE(SUB,DFN,.NOTEINFO,.TARRAY) Q 0
 Q 1
 ;
SETERROR(ARRAY,ERROR) ;
 S ARRAY("success")="false"
 S ARRAY("error")=ERROR
 Q
 ;
MAKENOTE(SUB,DFN,NOTEINFO,TARRAY) ;
 N CHANGE,CNT,DATETIME,LCNT,ORNOTE,TIUX,VSIT,SUPPRESS,NOASF
 S DATETIME=$$NOW^XLFDT
 S NOASF=1
 S TIUX(1201)=NOTEINFO("visitDateTime") ; entry date and time
 S TIUX(1202)=NOTEINFO("user") ; author
 S TIUX(1204)=NOTEINFO("user") ; expected signer
 ;I +COSIGNER>0 S TIUX(1208)=COSIGNER
 S TIUX(1301)=$$NOW^XLFDT ; reference date/time (this can be something other than NOW)
 S CNT=0,LCNT=0 F  S CNT=$O(^TMP(SUB,$J,"noteText",CNT)) Q:CNT'>0  D
 .S LCNT=LCNT+1,TIUX("TEXT",LCNT,0)=$G(^TMP(SUB,$J,"noteText",CNT))
 D MAKE^TIUSRVP(.ORNOTE,DFN,NOTEINFO("title"),NOTEINFO("visitDateTime"),NOTEINFO("location"),NOTEINFO("visitId"),.TIUX,NOTEINFO("visitString"),"",NOASF)
 I 'ORNOTE D SETERROR(.TARRAY,$S($P(ORNOTE,U,2)="":ERROR,1:$P(ORNOTE,U,2))) Q 0
 S TARRAY("noteInformation","title")=NOTEINFO("titleName")
 S TARRAY("noteInformation","id")=$P(ORNOTE,U)
 S TARRAY("noteInformation","details")=$P($$FMTE^XLFDT(NOTEINFO("visitDateTime"),2),"@")_" "_NOTEINFO("titleName")_", "_$P(^SC(NOTEINFO("location"),0),U)_" "_$$TITLE^XLFSTR($P(^VA(200,NOTEINFO("user"),0),U))
 S TARRAY("noteInformation","dateTime")=DATETIME
 Q 1
 ;
NOTEINFO(NOTEINFO,REQDATA,TARRAY,TITLE) ;
 N ERROR,INCOMPLETE,NODE
 S NODE=^TIU(8925.1,+TITLE,0)
 I $P(NODE,U)="" D SETERROR(.TARRAY,"Could not find note title name.") Q 0
 S NOTEINFO("title")=TITLE
 S NOTEINFO("titleName")=$P(NODE,U)
 S ERROR="Error with note creation information. "
 I $P(NODE,U,4)'="DOC" D SETERROR(.TARRAY,ERROR_"Is the wrong type.") Q 0
 I +$$GET1^DIQ(8925.1,TITLE,.07,"I")'=11 D SETERROR(.TARRAY,ERROR_"Is the wrong status.") Q 0
 S NOTEINFO("user")=+$G(REQDATA("dataUserInformation","id")) I NOTEINFO("user")=0 D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"User Information missing.") Q 0
 S NOTEINFO("location")=+$G(REQDATA("dataVisitInformation","locId")) I NOTEINFO("location")=0 D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"Location information missing.") Q 0
 S NOTEINFO("visitServiceCategory")=$G(REQDATA("dataVisitInformation","visitType")) I NOTEINFO("visitServiceCategory")="" D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"Visit Type information missing.") Q 0
 S NOTEINFO("visitDateTime")=+$G(REQDATA("dataVisitInformation","visitDateTime")) I NOTEINFO("visitDateTime")=0 D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"Visit date time information missing.") Q 0
 S NOTEINFO("visitString")=$G(REQDATA("dataVisitInformation","visitString")),NOTEINFO("visitId")=+$G(REQDATA("dataVisitInformation","id"))
 I NOTEINFO("visitId")>0 Q 1
 I NOTEINFO("visitString")="" D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"Visit identifier is missing.") Q 0
 S INCOMPLETE=$S(NOTEINFO("visitString")="":1,NOTEINFO("location")=0:1,1:0)
 I INCOMPLETE D SETERROR(.TARRAY,ERROR_$C(13)_$C(10)_"Visit identifier is missing.") Q 0
 Q 1
 ;
