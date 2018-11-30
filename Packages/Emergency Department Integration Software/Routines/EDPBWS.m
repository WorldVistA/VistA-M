EDPBWS ;SLC/KCM - Worksheet Configuration Calls ;7/27/12 4:22pm
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
LOADALL(EDPSITE,AREA,EDPROLE) ; load all worksheet configurations for an area
 N ROLES,SECTIONS,WORKSHTS,COMPNTS,RESULTS
 ;D LSTROLES(AREA,.ROLES) M RESULTS("roles",1)=ROLES
 ;D LSTROLES(.ROLES) M RESULTS("roles",1)=ROLES
 ;D LSTCMPTS(AREA,.COMPNTS) M RESULTS("components")=COMPNTS
 ;D LSTSECTS(AREA,.SECTIONS) M RESULTS("sections",1)=SECTIONS
 D LSTWKS(EDPSITE,AREA,.WORKSHTS) M RESULTS("worksheets")=WORKSHTS
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
GETROLES(EDPSITE,AREA) ; get list of roles
 N ROLES
 D XML^EDPX("<roles>")
 D LSTROLES(AREA,.ROLES)
 D XML^EDPX("</roles>")
 Q
GETSECTS(AREA,EDPXML,ROLE) ; get list of sections
 N RESULTS,SECTIONS
 D LSTSECTS(AREA,.SECTIONS,ROLE) M RESULTS("sections",1)=SECTIONS
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
GETCMPTS(AREA,EDPXML,IEN,ROLE) ; get list of components
 N RESULTS,COMPNTS
 S IEN=$G(IEN,"")
 D LSTCMPTS(AREA,.COMPNTS,IEN,ROLE) M RESULTS("components",1)=COMPNTS
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
GETWORKS(EDPSITE,IEN,REQ,EDPXML) ; get worksheet given IEN
 N WKSSPEC,RESULTS
 D GETWKS(EDPSITE,IEN,.REQ,.WKSSPEC) M RESULTS("worksheet",IEN)=WKSSPEC
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
LDWSLIST(EDPSITE,AREA,ROLE) ; load brief worksheet list
 ; ROLE (optional) - If no role is passed, all worksheets for an AREA/SITE will be returned.
 N WSIEN,X0,X,R0,RDAT,WSNAME,RIEN,RPTR,TYPE,DISABLE
 D XML^EDPX("<worksheets>")
 S RIEN=0 F  S RIEN=$O(^EDPB(232.6,"D",RIEN)) Q:'RIEN  D
 .; quit if this is not the role we are looking for
 .I $G(ROLE) Q:RIEN'=ROLE
 . D XML^EDPX("<role id="_""""_RIEN_""""_" >")
 .S WSIEN=0 F  S WSIEN=$O(^EDPB(232.6,"D",RIEN,WSIEN)) Q:'WSIEN  D
 ..S X0=$G(^EDPB(232.6,WSIEN,0))
 ..S WSNAME=$P(X0,U),TYPE=$P(X0,U,4)
 ..S X("id")=WSIEN,X("worksheetName")=WSNAME,X("type")=TYPE
 ..S X("name")=$P(X0,U),X("id")=WSIEN
 ..S X("institution")=$P(X0,U,2)
 ..S X("area")=$P(X0,U,3)
 ..S X("disabled")=$S($P(X0,U,6):"true",1:"false")
 ..S X("editable")=$S($P(X0,U,7):"true",1:"false")
 ..I $$GET1^DIQ(232.5,RIEN,.06,"I")=WSIEN S X("default")="true"
 ..D XML^EDPX($$XMLA^EDPX("worksheet",.X)) K X
 .D XML^EDPX("</role>")
 D XML^EDPX("</worksheets>")
 Q
LSTROLES(AREA,ARRAY) ; list roles for an area
 N RIEN,X0,ROLEIEN,ROLENM,WKS,CNT,EDAC,RABBR
 S CNT=0
 S RABBR="" F  S RABBR=$O(^EDPB(232.5,"C",RABBR)) Q:RABBR=""  D
 .S RIEN="" F  S RIEN=$O(^EDPB(232.5,"C",RABBR,RIEN)) Q:'RIEN  D
 ..S CNT=CNT+1
 ..S X0=$G(^EDPB(232.5,RIEN,0)),ROLENM=$P(X0,U),WKS=$P(X0,U,4),EDAC=$P(X0,U,6)
 ..S X("id")=RIEN
 ..S X("abbr")=RABBR
 ..S X("displayName")=ROLENM
 ..S X("defaultWorksheet")=WKS
 ..S X("editAcuity")=$S(+EDAC:"true",1:"false")
 ..D XML^EDPX($$XMLA^EDPX("role",.X))
 Q
LSTCMPTS(AREA,ARRAY,IEN,ROLE) ; list components for an area
 N CNT
 I $G(IEN) D BLDCMPTS(IEN,1,1,.ARRAY) Q
 S IEN=0 F  S IEN=$O(^EDPB(232.72,IEN)) Q:'IEN  D
 .I $G(ROLE) Q:'$D(^EDPB(232.72,IEN,8,"B",ROLE))
 .S CNT=$G(CNT)+1
 .D BLDCMPTS(IEN,CNT,,.ARRAY)
 Q
BLDCMPTS(IEN,CNT,MOREDAT,ARRAY) ;
 ; IEN     - component IEN
 ; CNT     - simple counter
 ; MOREDAT - If MOREDAT is passed, return more information
 ;           This is used to differentiate between a 'list'
 ;           style of call, versus a full 'get' on a specific entry
 ;
 N NAME,X0,X1,X2,X3,X6,PIEN,P0,RCNT,RIEN,ROLE,V0,X10,DEP,DEPCNT
 S X0=$G(^EDPB(232.72,IEN,0)),NAME=$P(X0,U)
 S MOREDAT=$G(MOREDAT,0)
 S ARRAY("component",CNT,"id")=IEN
 S ARRAY("component",CNT,"name")=NAME
 S ARRAY("component",CNT,"label")=$P(X0,U,2)
 S X1=$G(^EDPB(232.72,IEN,1)),X2=$G(^EDPB(232.72,IEN,2)),X3=$G(^EDPB(232.72,IEN,3))
 S X6=$G(^EDPB(232.72,IEN,6)),X10=$G(^EDPB(232.72,IEN,10))
 S ARRAY("component",CNT,"dataProvider")=$P(X0,U,3)
 S ARRAY("component",CNT,"moniker")=$P(X0,U,5)
 S ARRAY("component",CNT,"type")=$$GET1^DIQ(232.73,$P(X0,U,6),.01,"E")
 S ARRAY("component",CNT,"defaultValue")=$P(X6,U)
 S ARRAY("component",CNT,"value")=$P(X10,U)
 S ARRAY("component",CNT,"summaryLabel")=$P(X10,U,2)
 S ARRAY("component",CNT,"summaryOrder")=$P(X10,U,3)
 S ARRAY("component",CNT,"available")=$P(X10,U,3)
 S ARRAY("component",CNT,"loadEvent",1,"name")=$P(X1,U,3)
 ; for now there can be only 1 dependency
 S (DEP,DEPCNT)=0 F  S DEP=$O(^EDPB(232.72,IEN,7,DEP)) Q:'DEP!(DEPCNT>1)  D
 .S DEPCNT=DEPCNT+1 Q:DEPCNT>1
 .S ARRAY("component",CNT,"dependentOn")=$$GET1^DIQ(232.727,DEP_","_IEN_",",.01,"E")
 ; get the list of parameters
 S PIEN=0 F  S PIEN=$O(^EDPB(232.72,IEN,5,PIEN)) Q:'PIEN  D
 .S P0=$G(^EDPB(232.72,IEN,5,PIEN,0))
 .S ARRAY("component",CNT,"param",PIEN,"name")=$P(P0,U)
 .S ARRAY("component",CNT,"param",PIEN,"type")=$P(P0,U,2)
 .S ARRAY("component",CNT,"param",PIEN,"function")=$P(P0,U,3)
 Q
LSTSECTS(AREA,ARRAY,ROLE) ; list sections for an area
 N IEN,IEN1,X0,X1,CNT,CMPCNT,CMPNT,RIEN
 S IEN=0,CNT=0
 F  S IEN=$O(^EDPB(232.71,IEN)) Q:'IEN  D
 .; if role is passed in, and this 'section' doesn't contain the role, quit
 .I $G(ROLE) Q:'$D(^EDPB(232.71,IEN,2,"B",ROLE))
 .S X0=^EDPB(232.71,IEN,0),CNT=CNT+1
 .S ARRAY("section",CNT,"id")=IEN
 .S ARRAY("section",CNT,"name")=$P(X0,U)
 .S ARRAY("section",CNT,"displayName")=$P(X0,U,4)
 .S IEN1=0,CMPCNT=0
 .F  S IEN1=$O(^EDPB(232.71,IEN,1,IEN1)) Q:'IEN1  D
 ..S CMPNT=$P(^EDPB(232.71,IEN,1,IEN1,0),U)
 ..S X1=^EDPB(232.72,CMPNT,0)
 ..S CMPCNT=CMPCNT+1
 ..S ARRAY("section",CNT,"component",CMPCNT,"name")=$P(X1,U)
 ..S ARRAY("section",CNT,"component",CMPCNT,"id")=CMPNT
 .; now build the roles into the array
 ;.S RIEN=0 F  S RIEN=$O(^EDPB(232.71,IEN,2,RIEN)) Q:'RIEN  D
 ;..S ARRAY("section",CNT,"role",RIEN,"id")=$P(^EDPB(232.71,IEN,2,RIEN,0),U)
 ;
 ; consider moving these calls to prevent jumping 2 subroutines during the calls
 ; this will require results to be newed in this function and ARRAY to be used
 ; instead of SECTIONS on the merge. EDPXML will then have to be configured differently.
 ; It is currently being cofigured in the calling routine.
 Q
LSTWKS(EDPSITE,AREA,ARRAY) ; list worksheet configurations for an area
 N IEN,CNT,WKSSPEC
 S IEN=0,CNT=0
 S IEN=0 F  S IEN=$O(^EDPB(232.6,"C",EDPSITE,AREA,IEN)) Q:'IEN  D
 . S CNT=CNT+1
 . D GETWKS(EDPSITE,IEN,,.WKSSPEC)
 . M ARRAY(CNT)=WKSSPEC
 . K WKSSPEC
 Q
GETWKS(EDPSITE,WKS,REQ,ARRAY) ;
 ; if REQ("data") is passed, build component data along with definition
 ;
 N X0,XS,XM,SEQ,SEC,MIEN,I,ROLE,RCNT,CSEQ,COMP,C0,CIEN,CVAL,PNAME,PARVAL,VIEN,V0,PIEN
 S X0=$G(^EDPB(232.6,WKS,0)),DATA=$G(DATA,0)
 S ARRAY("name")=$P(X0,U),ARRAY("id")=WKS
 S ARRAY("institution")=$P(X0,U,2)
 S ARRAY("area")=$P(X0,U,3)
 S ARRAY("disabled")=$S($P(X0,U,6):"true",1:"false")
 S ARRAY("editable")=$S($P(X0,U,7):"true",1:"false")
 ; build roles associated with this worksheet
 S (ROLE,RCNT)=0 F  S ROLE=$O(^EDPB(232.6,WKS,3,"B",ROLE)) Q:'ROLE  D
 .S RCNT=RCNT+1,ARRAY("role",RCNT,"id")=ROLE
 ; build section information
 S SEQ=0 F  S SEQ=$O(^EDPB(232.6,WKS,2,"B",SEQ)) Q:'SEQ  D
 .S SEC=0 F  S SEC=$O(^EDPB(232.6,WKS,2,"B",SEQ,SEC)) Q:'SEC  D
 ..S X0=^EDPB(232.6,WKS,2,SEC,0),XS=^EDPB(232.71,$P(X0,U,2),0)
 ..S ARRAY("section",SEQ,"id")=$P(X0,U,2)
 ..S ARRAY("section",SEQ,"name")=$P(XS,U)
 ..S ARRAY("section",SEQ,"displayName")=$P(XS,U,4)
 ..S ARRAY("section",SEQ,"initialOpen")=$S($P(X0,U,3):"true",1:"false")
 ..S ARRAY("section",SEQ,"sequence")=$P(X0,U)
 ..; build component information
 ..S CSEQ=0 F  S CSEQ=$O(^EDPB(232.6,WKS,2,SEC,2,"B",CSEQ)) Q:'CSEQ  D
 ...S COMP=0 F  S COMP=$O(^EDPB(232.6,WKS,2,SEC,2,"B",CSEQ,COMP)) Q:'COMP  D
 ....S C0=$G(^EDPB(232.6,WKS,2,SEC,2,COMP,0)),CIEN=$P(C0,U,2)
 ....S ARRAY("section",SEQ,"component",CSEQ,"id")=CIEN
 ....S ARRAY("section",SEQ,"component",CSEQ,"name")=$$GET1^DIQ(232.72,CIEN,.01,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"label")=$$GET1^DIQ(232.72,CIEN,.02,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"sequence")=CSEQ
 ....S ARRAY("section",SEQ,"component",CSEQ,"editable")=$S($P(C0,U,3):"true",1:"false")
 ....S ARRAY("section",SEQ,"component",CSEQ,"visibilityTrigger")=$$GET1^DIQ(232.72,CIEN,.12,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"includeInSummary")=$S($P(C0,U,5):"true",1:"false")
 ....S ARRAY("section",SEQ,"component",CSEQ,"dataProvider")=$$GET1^DIQ(232.72,CIEN,.03,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"summaryLabel")=$$GET1^DIQ(232.72,CIEN,.09,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"summaryOrder")=$$GET1^DIQ(232.72,CIEN,.1,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"value")=$$GET1^DIQ(232.72,CIEN,.08,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"type")=$$GET1^DIQ(232.72,CIEN,.06,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"available")=$$GET1^DIQ(232.72,CIEN,.11,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"loadAPI")=$$GET1^DIQ(232.72,CIEN,2.1,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"saveAPI")=$$GET1^DIQ(232.72,CIEN,2.2,"E")
 ....S ARRAY("section",SEQ,"component",CSEQ,"loadEvent",1,"name")=$$GET1^DIQ(232.72,CIEN,1.3,"E")
 ....S PIEN=0 F  S PIEN=$O(^EDPB(232.72,CIEN,5,PIEN)) Q:'PIEN  D
 .....; below will be needed for future enhancements
 .....;S ARRAY("section",SEQ,"component",CSEQ,"loadEvent",1,"name")=$$GET1^DIQ(232.72,CIEN,1.3,"E")
 .....;S ARRAY("section",SEQ,"component",CSEQ,"loadEvent",PIEN,"paramName")=$$GET1^DIQ(232.725,PIEN,.01,"E")
 .....;S ARRAY("section",SEQ,"component",CSEQ,"loadEvent",PIEN,"dataType")=$$GET1^DIQ(232.725,PIEN,1,"E")
 .....;S ARRAY("section",SEQ,"component",CSEQ,"loadEvent",PIEN,"saveloadType")=$$GET1^DIQ(232.725,PIEN,2,"E")
 ....S VIEN=0 F  S VIEN=$O(^EDPB(232.72,CIEN,9,VIEN)) Q:'VIEN  D
 .....S V0=$G(^EDPB(232.72,CIEN,9,VIEN,0))
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"type")=$$GET1^DIQ(232.74,$P(V0,U),.01,"E")
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"property")=$P(V0,U,2)
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"maxLength")=$P(V0,U,3)
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"required")=$S($P(V0,U,4)=1:"true",1:"false")
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"minValue")=$P(V0,U,5)
 .....S ARRAY("section",SEQ,"component",CSEQ,"validator",VIEN,"lowerThanMinError")=$G(^EDPB(232.72,CIEN,9,VIEN,1))
 ....; if 'data' is passed in, get the data for the component. Parameters for component must be passed in as well
 ....; for data to be retrieved.
 ....I '$$VAL(.REQ,"data") Q
 ....; below will be needed for future enhancement
 ....;S COMDATA=$$BLDCDATA(CIEN,.REQ,.ARRAY)
 ....;S CVAL=$P(COMDATA,U),PNAME=$P(COMDATA,U,2),PARVAL=$P(COMDATA,U,3)
 ....;S ARRAY("section",SEQ,"component",CSEQ,"dataValue")=CVAL
 ....;
 ....;S ARRAY("section",SEQ,"component",CSEQ,"parameterName")=PNAME
 ....;S ARRAY("section",SEQ,"component",CSEQ,"parameterValue")=PARVAL
 ....;D BLDCDATA(CIEN,SEQ,CSEQ,.REQ,.ARRAY)
 Q
BLDCDATA(IEN,REQ,ARRAY) ;
 ; IEN    - IEN of the component, from file 232.72
 ; REQ    - Parameter list from call in EDPCTRL
 ; ARRAY  - XML ARRAY to continue building XML
 N PNAME,PIEN,P0,PDTYPE,LSTYPE,LOADERR,PARVAL,CVAL,PARRAY,RET,C0,C1,CFILE,CFIELD,LALT,LAPI
 S RET=""
 S C0=$G(^EDPB(232.72,IEN,0))
 S C1=$G(^EDPB(232.72,IEN,1))
 ; get associated file/field
 S CFILE=$P(C1,U),CFIELD=$P(C1,U,2)
 ; build parameter list from component
 S LOADERR=0
 S PIEN=0 F  S PIEN=$O(^EDPB(232.72,IEN,5,PIEN)) Q:'PIEN!(LOADERR)  D
 .S P0=$G(^EDPB(232.72,IEN,5,PIEN,0))
 .; gather name, data type, and load/save type
 .S PNAME=$P(P0,U),PDTYPE=$P(P0,U,2),LSTYPE=$P(P0,U,3)
 .I PDTYPE="L",'$D(REQ(PNAME)) D LOADERR(.REQ,SEQ,CSEQ,.ARRAY) S LOADERR=1 Q
 .S PARVAL=$$VAL(.REQ,PNAME)
 .I PARVAL="" D LOADERR(.REQ,SEQ,CSEQ,.ARRAY) S LOADERR=1 Q
 .S PARRAY(PNAME)=PARVAL
 I $G(LOADERR) S RET="LOAD ERROR" Q RET
 S CVAL="" ; initialize to prevent undefined
 ; if file/field exists, get the 'TYPE' from FIELD^DID and utilize that for the call???
 I CFILE,CFIELD D
 .S CVAL=$$GET1^DIQ(CFILE,PARVAL,CFIELD,"E")
 ; if loadapi exists??
 ;S LAPI=$$GET1^DIQ(CFILE,PARVAL,2.1,"E") I $L(LAPI) D
 ;.D @LAPI
 ; if alternate load logic exists??
 ;S LALT=$$GET1^DIQ(CFILE,PARVAL,2.2,"E") I $L(LALT) D
 ;.D @LALT
 S RET=CVAL_U_PNAME_U_PARVAL
 ;S ARRAY("section",SEQ,"component",CSEQ,"value")=CVAL
 ;S ARRAY("section",SEQ,"component",CSEQ,"parameterName")=PNAME
 ;S ARRAY("section",SEQ,"component",CSEQ,"parameterValue")=PARVAL
 Q RET
LOADERR(PARAM,SEQ,CSEQ,ARRAY) ;
 S ARRAY("section",SEQ,"component",CSEQ,"error")="Parameter invalid or missing for this component."
 Q
 ; REQ1("param",1)=value
 ; REQ2("worksheet",counter)=sectionID^Sequence (for section)^InitiallyOpen^componentID^Sequence (for component)^Editable^IncludeInSummary
SAVEWORK(REQ1,REQ2,EDPSITE,AREA) ; save worksheet configuration
 N WSID,WSNAME,WSINST,WSAREA,WSTYPE,WSROLES,ROLESTR,I,DONE,FIL,WSIENS,NWSIEN,ROLE,SECIEN,SECID,SECIENS,WSINACT
 N ROLE,WSERR,DEL,SECIEN,SECIENS,EDITABLE
 S WSID=$$VAL(.REQ1,"id"),WSIENS=$S(WSID>0:WSID_",",1:"+1,")
 S DEL=$$VAL(.REQ1,"remove"),DEL=$S(DEL="true":1,1:0)
 ; if we are deleting the worksheet, do it, then quit
 I 'WSID,DEL D WSERR("Missing worksheet ID.") Q
 I WSID,'$$GET1^DIQ(232.6,WSID,.07,"I") D WSERR("This is a standard worksheet and is not editable.") Q
 I WSID,DEL S FDA(232.6,WSIENS,.01)="@" D FILE^DIE(,"FDA") K FDA Q
 S WSNAME=$$VAL(.REQ1,"name") I '$L(WSNAME)!$L(WSNAME)>30 D WSERR("Worksheet name missing or invalid.") Q
 I 'WSID,$D(^EDPB(232.6,"B",WSNAME)) D WSERR("Worksheet with this name already exists. Please choose another name and save again.") Q
 I 'WSID,WSNAME="" D WSERR("No worksheet ID or NAME was passed to VistA. Can not perform actions on this worksheet") Q
 S WSINST=EDPSITE,WSAREA=AREA
 S WSTYPE=$$VAL(.REQ1,"type")
 S ROLESTR=$$VAL(.REQ1,"role")
 S WSINACT=$$VAL(.REQ1,"disabled"),WSINACT=$S(WSINACT="true":1,1:0)
 ; get the list of roles appropriate for this worksheet
 S DONE=0
 F I=1:1 D  Q:DONE
 .S ROLE=$P(ROLESTR,U,I) I 'ROLE S DONE=1 Q
 .S WSROLES(ROLE)=""
 ; setup main worksheet fields
 S FIL=232.6 K FDA
 D SETFDA(FIL,WSIENS,.01,WSNAME)
 D SETFDA(FIL,WSIENS,.02,WSINST)
 D SETFDA(FIL,WSIENS,.03,WSAREA)
 D SETFDA(FIL,WSIENS,.04,WSTYPE)
 D SETFDA(FIL,WSIENS,.06,WSINACT)
 ; force all worksheets created by a facility to be editable
 D SETFDA(FIL,WSIENS,.07,1)
 ; no id means we are creating a NEW worksheet
 I '$G(WSID) D  Q
 .; add the worksheet to the database
 .D UPDATE^DIE(,"FDA","NWSIEN","WSERR") K FDA
 .I $D(WSERR) D WSERR("Filing Error") Q
 .S WSID=$O(NWSIEN(0)),WSID=$G(NWSIEN(WSID))
 .; now add roles to the entry
 .S ROLE=0 F  S ROLE=$O(WSROLES(ROLE)) Q:'ROLE  D
 ..K FDA
 ..D SETFDA(232.63,"+1,"_WSID_",",.01,ROLE)
 ..D UPDATE^DIE(,"FDA",,"WSERR") K FDA
 .; now add sections and components
 .D SECCOMP(WSID,.REQ2)
 ; updating a worksheet.
 D FILE^DIE(,"FDA") K FDA
 ; first clear out the sections and components, so we completely rebuild them
 S SECIEN=0 F  S SECID=$O(^EDPB(232.6,WSID,2,SECIEN)) Q:'SECIEN  D
 .S SECIENS=SECIEN_","_WSID_","
 .S FDA(232.62,SECIENS,.01)="@"
 ; now we can place the sections and components back in
 D SECCOMP(WSID,.REQ2)
 Q
SECCOMP(WSID,DATA) ; adds/updates sections and components in a given worksheet
 ; REQ2("worksheet",counter)=sectionID^Sequence (for section)^InitiallyOpen^componentID^Sequence (for component)^Editable^IncludeInSummary^VisibilityTrigger
 N CNT,ARY,SECDATA,SID,CID,COMP,SECT,I,SFIL,CFIL,SUPDERR,SADDERR,PFLD,CID,INITOPEN
 N SSEQ,CSEC,SECIEN,SIENS,CIENS,SECTION,SOK,COK,COMPIEN,COMDATA,EDITABLE
 N VISIBLE,CVIS,SUMMARY,CSUM
 S ARY=$NA(DATA("worksheet"))
 S CNT=0 F  S CNT=$O(@ARY@(CNT)) Q:'CNT  D
 .S SECDATA=$G(@ARY@(CNT)) Q:'$L(SECDATA)
 .S SID=$P(SECDATA,U),SSEQ=$P(SECDATA,U,2),INITOPEN=$P(SECDATA,U,3),INITOPEN=$S(INITOPEN="true":1,INITOPEN="false":0,1:"")
 .S CID=$P(SECDATA,U,4),CSEQ=$P(SECDATA,U,5),EDITABLE=$P(SECDATA,U,6),SUMMARY=$P(SECDATA,U,7),VISIBLE=$P(SECDATA,U,8)
 .S EDITABLE=$S(EDITABLE="true":1,EDITABLE="false":0,1:"")
 .S SUMMARY=$S(SUMMARY="true":1,SUMMARY="false":0,1:"")
 .I CSEQ S COMP(SSEQ,CSEQ)=CID_U_EDITABLE_U_SUMMARY_U_VISIBLE
 .I SSEQ,'CSEQ S SECT(SSEQ)=SID_U_INITOPEN
 ;
 ; first file the sections
 K SECDATA
 S SFIL=232.62
 S SSEQ=0 F  S SSEQ=$O(SECT(SSEQ)) Q:'SSEQ  D
 .; first check to see if the section already exists in this worksheet
 .S SOK=0
 .S SECDATA=$G(SECT(SSEQ)),SID=$P(SECDATA,U),INITOPEN=$P(SECDATA,U,2)
 .I $D(^EDPB(232.6,WSID,2,"B",SSEQ)) D  Q
 ..S SECIEN=$O(^EDPB(232.6,WSID,2,"B",SSEQ,0)) Q:'SECIEN
 ..S SIENS=SECIEN_","_WSID_","
 ..S SOK=$$FILEDAT(SFIL,SIENS,SSEQ,SID,INITOPEN,0)
 ..I SOK Q
 ..; process error (OK was returned as -1 (indicating error))
 .; build FDA to add a new section
 .S SIENS="+1,"_WSID_","
 .S SOK=$$FILEDAT(SFIL,SIENS,SSEQ,SID,INITOPEN,1)
 ;
 ; now file the components
 S CFIL=232.622
 S SSEQ=0 F  S SSEQ=$O(COMP(SSEQ)) Q:'SSEQ  D
 .; for some reason this section does not exist (possible filing error)
 .I '$D(^EDPB(232.6,WSID,2,"B",SSEQ)) Q
 .S SECIEN=$O(^EDPB(232.6,WSID,2,"B",SSEQ,0)) Q:'SECIEN
 .S CSEQ=0 F  S CSEQ=$O(COMP(SSEQ,CSEQ)) Q:'CSEQ  D
 ..S COK=0
 ..S COMDATA=$G(COMP(SSEQ,CSEQ)),CID=$P(COMDATA,U),EDITABLE=$P(COMDATA,U,2),CSUM=$P(COMDATA,U,3),CVIS=$P(COMDATA,U,4)
 ..I $D(^EDPB(232.6,WSID,2,SECIEN,2,"B",CSEQ)) D  Q
 ...S COMPIEN=$O(^EDPB(232.6,WSID,2,SECIEN,2,"B",CSEQ,0)) Q:'COMPIEN
 ...S CIENS=COMPIEN_","_SECIEN_","_WSID_","
 ...S COK=$$FILEDAT(CFIL,CIENS,CSEQ,CID,EDITABLE,0,CSUM,CVIS)
 ..;
 ..; build FDA for adding a 'new' component to a section
 ..S CIENS="+1,"_SECIEN_","_WSID_","
 ..S COK=$$FILEDAT(CFIL,CIENS,CSEQ,CID,EDITABLE,1,CSUM,CVIS)
 Q
FILEDAT(FIL,IENS,SEQ,ID,P03,NEW,CSUM,CVIS) ; filer for section and component data
 ; this can be used for both section and component due to the similarities in the file structures
 N ERR,RET
 S RET=1
 ; if deleting a section or component
 I ID="@" D  Q RET
 .D SETFDA(FIL,IENS,.01,"@")
 .; lock record
 .L +^EDPB(232.6,WSID):3 Q:'$T
 .D FILE^DIE(,"FDA") S RET=1
 .L -^EDPB(232.6,WSID)
 .; unlock record
 D SETFDA(FIL,IENS,.01,SEQ)
 D SETFDA(FIL,IENS,.02,ID)
 D SETFDA(FIL,IENS,.03,P03)
 ; two additional fields need to be handled for components
 I FIL=232.622 D
 .D SETFDA(FIL,IENS,.04,CVIS)
 .D SETFDA(FIL,IENS,.05,CSUM)
 ; if this is a new entry, file it, then quit
 I $G(NEW) K ERR D UPDATE^DIE(,"FDA",,"ERR") K FDA S RET=$S($D(ERR):-1,1:1) Q RET
 ; if this is meant to update an entry, lock, update, unlock
 ; lock
 L +^EDPB(232.6,WSID):3 Q:'$T 0
 D FILE^DIE(,"FDA","ERR")
 L -^EDPB(232.6,WSID)
 ; unlock
 I $D(ERR) S RET=-1
 Q RET
SETFDA(F,IENS,FD,VAL) ;
 S FDA(F,IENS,FD)=VAL
 Q
WSERR(ERRTXT) ;
 D XML^EDPX("<error>")
 D XML^EDPX($G(ERRTXT))
 D XML^EDPX("</error>")
 Q
VAL(ARRY,ITEM) ;return value from array, given ARRY (array name), and ITEM (subscript)
 I $D(ARRY(ITEM)),$G(ARRY(ITEM))'="" Q $G(ARRY(ITEM))
 Q $G(ARRY(ITEM,1))
