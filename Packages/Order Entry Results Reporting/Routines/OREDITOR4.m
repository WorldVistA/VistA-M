OREDITOR4 ; SLC/AGP - Info Panel Builder Code ;Jan 08, 2026@12:49:39
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to ^PXRMD(811.5 supported by ICR #7466
 ; Reference to ^DIC(9.4 is supported by ICR #2058
 ; Reference to ^PXD(811.9 supported by ICR #1256
 ; Reference to INFOLIST^PXRMAPI supported by ICR # 7466
 ;
 Q
 ;
BLDDA(TIENS,DA) ;
 N CNT,IDX
 S IDX=$O(TIENS("A"),-1) S DA=TIENS(IDX)
 S CNT=0 F  S IDX=$O(TIENS(IDX),-1) Q:IDX<1  D
 .S DA($I(CNT))=TIENS(IDX)
 Q
 ;
BLD(INPUTS) ;
 N ARRAY,CNT,DATES,DEFSCHEMA,DSCHEMA,DFN,HARRAY,IENS,LIDX,NIDX,NODE,ONEOF,PIDX
 N SCHEMA,SUB,TIENS,TOBJ,TSCHEMA,UISCHEMA,USER,XCTARRAY
 S NIDX=$$GETNATIONAL^ORIUTL I NIDX=0 Q "-1^Cannot find national information panels"
 D PASSINVALUES^OREDITOR1(.INPUTS,.DSCHEMA,.DFN,.PIDX,.SCHEMA,.SUB,.UISCHEMA,.USER)
 D SETONEOF(.ONEOF)
 S NODE=$G(^ORI(101.71,NIDX,0))
 S TSCHEMA("name")=$P(NODE,U),TSCHEMA("active")=$S($P(NODE,U,2)=1:"true",1:"false")
 D SETDATES($P(NODE,U,3),.DATES) I $D(DATES) M TSCHEMA("updateDateTime")=DATES
 S TSCHEMA("updateSource")=$P(NODE,U,4)
 D MERGEONEOF(.ONEOF,.SCHEMA)
 S PIDX=0,CNT=0 F  S PIDX=$O(^ORI(101.71,NIDX,"PKG",PIDX)) Q:PIDX'>0  D
 . S NODE=$G(^ORI(101.71,NIDX,"PKG",PIDX,0)) I +$P(NODE,U)'>0 Q
 . K XCTARRAY D SETLOOKUPDEF(9.4,$P(NODE,U),.XCTARRAY)
 . S TIENS(1)=NIDX,TIENS(2)=PIDX,IENS=$$BLDIENS^OREDITOR2(.TIENS)
 . M TSCHEMA("ResponsiblePackages",PIDX,"package")=XCTARRAY
 . S TSCHEMA("ResponsiblePackages",PIDX,"packageId")=IENS
 . S LIDX=0 F  S LIDX=$O(^ORI(101.71,NIDX,"PKG",PIDX,"LOC",LIDX)) Q:LIDX'>0  D
 .. K TIENS(3),TIENS(4),TIENS(5)
 .. S TIENS(3)=LIDX
 .. K TOBJ D BLDLOC(.TOBJ,.TIENS,.HARRAY,.DEFSCHEMA) I '$D(TOBJ) Q
 .. M TSCHEMA("ResponsiblePackages",PIDX,"locationId",$I(CNT))=TOBJ
 S DSCHEMA("hashValues","totalHash")=$$GENAREF^XLFSHAN(512,"TSCHEMA",1)
 M DSCHEMA("hashValues","hashes")=HARRAY
 M DSCHEMA("definitions")=DEFSCHEMA("definitions")
 M DSCHEMA=TSCHEMA
 M ^TMP(SUB,$J,"Schema")=SCHEMA
 M ^TMP(SUB,$J,"UISchema")=UISCHEMA
 M ^TMP(SUB,$J,"Data")=DSCHEMA
 S ^TMP(SUB,$J,"success")="true"
 Q 1
 ;
BLDITEM(DSCHEMA,TIENS,HARRAY) ;
 N CNT,HCNT,IDX,IENS,LIDX,NIDX,NODE,PIDX,RIDX,TEXT,TMP,TOBJ,TSCHEMA,XCTARRAY
 S NIDX=TIENS(1),PIDX=TIENS(2),LIDX=TIENS(3)
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),0))
 I $P(NODE,U,1)=0!($P(NODE,U,2)="")!($P(NODE,U,4)="")!($P(NODE,U,5)="") Q
 S IENS=$$BLDIENS^OREDITOR2(.TIENS)
 S (DSCHEMA("panelId"),DSCHEMA("panelObject","panelId"))=IENS
 S DSCHEMA("panelObject","panelSequence")=$P(NODE,U),DSCHEMA("panelObject","panelName")=$P(NODE,U,2)
 S DSCHEMA("panelObject","status")=$P(NODE,U,3)
 S DSCHEMA("panelObject","panelAbbreviation")=$P(NODE,U,4),DSCHEMA("panelObject","defaultText")=$P(NODE,U,5)
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,6),.XCTARRAY) M DSCHEMA("panelObject","backgroundColor")=XCTARRAY
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,8),.XCTARRAY) M DSCHEMA("panelObject","imageIcon")=XCTARRAY
 ;
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),10))
 S DSCHEMA("panelObject","evaluationObject","evaluationType")=$P(NODE,U)
 I $P(NODE,U)="RT"!($P(NODE,U)="RD")!($P(NODE,U)="C") D
 .I $P(NODE,U)'="C" D  Q
 ..I $P(NODE,U,3)'="" S DSCHEMA("panelObject","evaluationObject","reminderStatus")=$P(NODE,U,3)
 ..I $P(NODE,U,2)'="" S DSCHEMA("panelObject","evaluationObject","reminderComponent")=$P(NODE,U,2)
 .I $P(NODE,U,4)>0 S DSCHEMA("panelObject","evaluationObject","evaluationCode")=$P(NODE,U,4)
 ;
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),20))
 S DSCHEMA("panelObject","applicableObject","displayIfApplicable")=$S($P(NODE,U)=1:"true",1:"false")
 I $P(NODE,U,2)'="" S DSCHEMA("panelObject","applicableObject","notApplicableabbreviation")=$P(NODE,U,2)
 I $P(NODE,U,3)'="" S DSCHEMA("panelObject","applicableObject","notApplicableText")=$P(NODE,U,3)
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,4),.XCTARRAY) M DSCHEMA("panelObject","applicableObject","backgroundColor")=XCTARRAY
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,5),.XCTARRAY) M DSCHEMA("panelObject","applicableObject","imageIcon")=XCTARRAY
 ;
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),30))
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U),.XCTARRAY) M DSCHEMA("panelObject","actionObject","panelAction")=XCTARRAY
 I $P(NODE,U,2)'="" S DSCHEMA("panelObject","actionObject","formType")=$P(NODE,U,2)
 I $P(NODE,U,3)'="" S DSCHEMA("panelObject","actionObject","detailCode")=$P(NODE,U,3)
 ;
 S DSCHEMA("panelObject","actionObject","callRPC")=$S($P(NODE,U,4)'="":$P(NODE,U,4),1:"false")
 K XCTARRAY D SETLOOKUPDEF(101.74,$P(NODE,U,5),.XCTARRAY)
 I $G(XCTARRAY("const"))'="" M DSCHEMA("panelObject","actionObject","editor")=XCTARRAY
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"URL"))
 I $P(NODE,U)'="" S DSCHEMA("panelObject","actionObject","url")=$P(NODE,U)
 K TMP,TEXT
 M TEXT=^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"DTXT")
 S TMP=$$SETTEXT^OREDITOR1(.TEXT) I TMP'="" S DSCHEMA("panelObject","actionObject","detailText")=TMP
 K TMP,TEXT
 M TEXT=^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"DESC")
 S TMP=$$SETTEXT^OREDITOR1(.TEXT) I TMP'="" S DSCHEMA("panelObject","panelDescription")=TMP
 D SETHASH(.HARRAY,.TIENS,.TSCHEMA)
 S RIDX=0,CNT=0 F  S RIDX=$O(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"REQD",RIDX)) Q:RIDX'>0  D
 .K TOBJ S TIENS(5)=RIDX D BLDREQ(.TOBJ,.TIENS,.HARRAY) I '$D(TOBJ) Q
 .M DSCHEMA("panelObject","actionObject","requiredData",$I(CNT))=TOBJ
 ;D SETHASH(.HARRAY,.TIENS,.DSCHEMA)
 Q
 ;
BLDLOC(DSCHEMA,TIENS,HARRAY,DEFSCHEMA) ;
 N CNT,IDX,IENS,LIDX,NIDX,NODE,PIDX,TOBJ,XCTARRAY
 S NIDX=TIENS(1),PIDX=TIENS(2),LIDX=TIENS(3)
 S NODE=$G(^ORI(101.71,NIDX,"PKG",PIDX,"LOC",LIDX,0))
 I +$P(NODE,U)'>0!(+$P(NODE,U,2)'>0)!($P(NODE,U,3)="")!($P(NODE,U,4)="") Q
 S IENS=$$BLDIENS^OREDITOR2(.TIENS)
 S DSCHEMA("locationId")=IENS,DSCHEMA("locationSequence")=$P(NODE,U)
 D SETLOOKUPDEF(101.73,$P(NODE,U,2),.XCTARRAY) M DSCHEMA("location")=XCTARRAY
 S DSCHEMA("displayText")=$P(NODE,U,3),DSCHEMA("abbreviation")=$P(NODE,U,4)
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,5),.XCTARRAY) M DSCHEMA("backgroundColor")=XCTARRAY
 S DSCHEMA("disabled")=$S($P(NODE,U,6)'="":$P(NODE,U,6),1:"false")
 S DSCHEMA("collapsible")=$S($P(NODE,U,7)'="":$P(NODE,U,7),1:"false")
 K XCTARRAY D SETLOOKUPDEF(101.73,$P(NODE,U,8),.XCTARRAY) M DSCHEMA("imageIcon")=XCTARRAY
 D SETHASH(.HARRAY,.TIENS,.DSCHEMA)
 S IDX=0,CNT=0 F  S IDX=$O(^ORI(101.71,NIDX,"PKG",PIDX,"LOC",LIDX,"ITM",IDX)) Q:IDX'>0  D
 .K TOBJ,TIENS
 .S TIENS(1)=NIDX,TIENS(2)=PIDX,TIENS(3)=LIDX,TIENS(4)=IDX
 .D BLDITEM(.TOBJ,.TIENS,.HARRAY) I '$D(TOBJ) Q
 .M DSCHEMA("Panels",$I(CNT))=TOBJ
 Q
 ;
BLDREQ(DSCHEMA,TIENS,HARRAY) ;
 N IENS,NODE,XCTARRAY
 S NODE=$G(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"REQD",TIENS(5),0))
 S IENS=$$BLDIENS^OREDITOR2(.TIENS),DSCHEMA("dataId")=IENS
 D SETLOOKUPDEF(101.73,$P(NODE,U),.XCTARRAY) M DSCHEMA("dataType")=XCTARRAY
 I $P(NODE,U)>0 S DSCHEMA("requiredForAction")=$S($P(NODE,U,2)=1:"true",1:"false")
 D SETHASH(.HARRAY,.TIENS,.DSCHEMA)
 Q
 ;
SETHASH(HARRAY,TIENS,OBJ) ;
 N HCNT,IENS
 S IENS=$$BLDIENS^OREDITOR2(.TIENS)
 D SETHASH^OREDITOR1(.HARRAY,IENS,.OBJ)
 Q
 ;
SETONEOF(ONEOF) ;
 N CNT,CODES,IEN,NAME,NODE,ORREMARRAY,SUB
 ;evaluation codes
 D CODE^ORIUTL(.CODES,101.71123,10) M ONEOF("evaluation")=CODES
 ;status
 K CODES D CODE^ORIUTL(.CODES,101.71123,.03) M ONEOF("status")=CODES
 ;form types
 K CODES D CODE^ORIUTL(.CODES,101.71123,31) M ONEOF("form")=CODES
 ;required data
 K CODES D CODE^ORIUTL(.CODES,101.714,.02) M ONEOF("required")=CODES
 ;reminder status
 K CODES D CODE^ORIUTL(.CODES,101.71123,12) M ONEOF("reminderStatus")=CODES
 D INFOLIST^PXRMAPI(.ORREMARRAY)
 S CNT=0,NAME="" F  S NAME=$O(ORREMARRAY(NAME)) Q:NAME=""  D
 .S CNT=CNT+1,ONEOF("reminder",CNT,"const")=ORREMARRAY(NAME),ONEOF("reminder",CNT,"title")=NAME
 D GETPLUGINS^ORDD71(.ONEOF,"plugin")
 Q
 ;
MERGEONEOF(ONEOF,SCHEMA) ;
 N SUB,TYPE
 S SUB="" F  S SUB=$O(ONEOF(SUB)) Q:SUB=""  D
 .S TYPE=$$GETTYPE(SUB) I TYPE="" Q
 .M SCHEMA("definitions",TYPE,"oneOf")=ONEOF(SUB) Q
 Q
 ;
GETTYPE(SUB) ;
 I SUB="action" Q "actionTypeData"
 I SUB="color" Q "colorData"
 I SUB="data" Q "dataTypeData"
 I SUB="editor" Q "editorData"
 I SUB="evaluation" Q "evaluationTypeData"
 I SUB="form" Q "formTypeData"
 I SUB="image" Q "imageData"
 I SUB="location" Q "locationData"
 I SUB="package" Q "packageData"
 I SUB="plugin" Q "codeData"
 I SUB="reminder" Q "reminderComponentData"
 I SUB="reminderStatus" Q "reminderStatusData"
 I SUB="status" Q "statusData"
 Q ""
SETDATES(DATE,DATES) ;
 S DATES("internal")=DATE
 S DATES("external")=$$FMTE^XLFDT(DATE)
 Q
 ;
SETLOOKUPDEF(FN,IEN,ARRAY) ;
 I IEN="" Q
 S ARRAY("const")=IEN
 I FN=9.4 S (ARRAY("display"),ARRAY("title"))=$P($G(^DIC(9.4,IEN,0)),U) Q
 I FN=101.73 S (ARRAY("display"),ARRAY("title"))=$P($G(^ORI(101.73,IEN,0)),U)
 I FN=101.74 S (ARRAY("display"),ARRAY("title"))=$P($G(^ORE(101.74,IEN,0)),U)
 I FN=101.75 S ARRAY("title")=$P($G(^OR(101.75,IEN,0)),U)
 I FN=811.5 S ARRAY("title")=$P($G(^PXRMD(811.5,+IEN,0)),U)
 I FN=811.9 S ARRAY("title")=$P($G(^PXD(811.9,+IEN,0)),U)
 Q
