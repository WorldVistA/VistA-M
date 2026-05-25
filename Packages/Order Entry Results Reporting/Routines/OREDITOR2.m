OREDITOR2 ; SLC/AGP - Info Panel Editor Code ;Dec 18, 2025@09:24:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
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
BLDIENS(TIENS) ;
 N DA,RESULT
 D BLDDA(.TIENS,.DA)
 S RESULT=$$IENS^DILF(.DA)
 Q RESULT
 ;
GETIENS(RESULT,IENS) ;
 N X
 S RESULT="" F X=1:1:$L(IENS)-1 S RESULT(X)=$P(IENS,",",X)
 Q
 ;
DELETE(IARRAY) ;
 N ERROR,FDA,IENS,TIENS
 S TIENS(1)=1,TIENS(2)=0
 F  S TIENS(2)=$O(^ORI(101.71,TIENS(1),"PKG",TIENS(2))) Q:TIENS(2)'>0  D
 . K TIENS(3),TIENS(4),TIENS(5) S IENS=$$BLDIENS(.TIENS) I '$D(IARRAY(IENS)) S FDA(101.711,IENS,.01)="@" Q
 . S TIENS(3)=0
 . F  S TIENS(3)=$O(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3))) Q:TIENS(3)'>0  D
 ..K TIENS(4),TIENS(5) S IENS=$$BLDIENS(.TIENS) I '$D(IARRAY(IENS)) S FDA(101.7112,IENS,.01)="@" Q
 ..S TIENS(4)=0
 ..F  S TIENS(4)=$O(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4))) Q:TIENS(4)'>0  D
 ...K TIENS(5) S IENS=$$BLDIENS(.TIENS) I '$D(IARRAY(IENS)) S FDA(101.71123,IENS,.01)="@" Q
 ...S TIENS(5)=0
 ...F  S TIENS(5)=$O(^ORI(101.71,TIENS(1),"PKG",TIENS(2),"LOC",TIENS(3),"ITM",TIENS(4),"REQD",TIENS(5))) Q:TIENS(5)'>0  D
 ....S IENS=$$BLDIENS(.TIENS) I '$D(IARRAY(IENS)) S FDA(101.714,IENS,.01)="@" Q
 I '$D(FDA) Q ""
 D UPDATE^DIE("","FDA","","ERROR")
 Q $S($D(ERROR):"Error",1:"")
 ;
DIFF(HARRAY,IENS,OBJ) ;
 I HARRAY(IENS)'=$$GENAREF^XLFSHAN(160,"OBJ",1) Q 1
 Q 0
 ;
DIFFLOC(OBJ,FDA,TIENS,HARRAY,IARRAY,TEMPSUB) ;
 N IDX,IENS,TOBJ
 K TIENS(3),TIENS(4),TIENS(5)
 I $G(OBJ("locationId"))="" D SETNEWLOC(.OBJ,.FDA,.TIENS,.IARRAY,.TEMPSUB) Q
 ;S TIENS(3)=OBJ("id"),IENS=$$BLDIENS(.TIENS)
 S IENS=OBJ("locationId"),IARRAY(IENS)="",TIENS(3)=$P(IENS,",")
 M TOBJ=OBJ K TOBJ("Panels") I $$DIFF(.HARRAY,IENS,.TOBJ) D FDALOC(.OBJ,.FDA,IENS)
 S IDX=0 F  S IDX=$O(OBJ("Panels",IDX)) Q:IDX'>0  D
 .K TOBJ M TOBJ=OBJ("Panels",IDX,"panelObject")
 .D DIFFITEM(.TOBJ,.FDA,.TIENS,.HARRAY,.IARRAY,.TEMPSUB)
 Q
 ;
DIFFITEM(OBJ,FDA,TIENS,HARRAY,IARRAY,TEMPSUB) ;
 N HRDATA,IDX,IENS,RDATA,TOBJ
 K TIENS(4),TIENS(5)
 I $G(OBJ("panelId"))="" D SETNEWITEM(.OBJ,.FDA,.TIENS,.IARRAY,.TEMPSUB) Q
 S IENS=OBJ("panelId"),IARRAY(IENS)="",TIENS(4)=$P(IENS,",")
 M RDATA=OBJ("actionObject","requiredData")
 S HRDATA=$$HREQDATA(.RDATA)
 M TOBJ=OBJ K TOBJ("actionObject","requiredData")
 I $$DIFF(.HARRAY,IENS,.TOBJ) D FDAITEM(.OBJ,.FDA,IENS,.TEMPSUB,HRDATA)
 S IDX=0 F  S IDX=$O(OBJ("actionObject","requiredData",IDX)) Q:IDX'>0  D
 .K TOBJ M TOBJ=OBJ("actionObject","requiredData",IDX)
 .D DIFFREQ(.TOBJ,.FDA,.TIENS,.HARRAY,.IARRAY)
 Q
 ;
DIFFREQ(OBJ,FDA,TIENS,HARRAY,IARRAY) ;
 N IENS
 K TIENS(5)
 I $G(OBJ("dataId"))="" D SETNEWDATA(.OBJ,.FDA,.TIENS,.IARRAY) Q
 ;S TIENS(5)=OBJ("id"),IENS=$$BLDIENS(.TIENS),IARRAY(IENS)=""
 S IENS=OBJ("dataId"),IARRAY(IENS)=""
 I $$DIFF(.HARRAY,IENS,.OBJ) D FDAREQ(.OBJ,.FDA,IENS)
 Q
 ;
HREQDATA(ARRAY) ;
 N IDX,RESULT
 S IDX=0,RESULT=0
 F  S IDX=$O(ARRAY(IDX)) Q:IDX'>0!(RESULT=1)  D
 .I $G(ARRAY("requiredForAction"))="true" S RESULT=1
 Q RESULT
 ;
FDAITEM(OBJ,FDA,IENS,TEMPSUB,RDATA) ;
 N CALLRPC,IDX,TMP,TOBJ,TEXT,TSUB
 S TMP=""
 I +$G(OBJ("panelSequence"))=0 S FDA(101.71123,IENS,.01)="@" Q
 S CALLRPC=$S($G(OBJ("actionObject","callRPC"))'="":OBJ("actionObject","callRPC"),1:"false")
 S FDA(101.71123,IENS,.01)=OBJ("panelSequence")
 I $G(OBJ("panelName"))'="" S FDA(101.71123,IENS,.02)=$S($G(OBJ("panelName"))'="":OBJ("panelName"),1:"@")
 S FDA(101.71123,IENS,.03)=$S($G(OBJ("status"))'="":OBJ("status"),1:"@")
 S FDA(101.71123,IENS,.04)=$S($G(OBJ("panelAbbreviation"))'="":OBJ("panelAbbreviation"),1:"@")
 S FDA(101.71123,IENS,.05)=$S($G(OBJ("defaultText"))'="":OBJ("defaultText"),1:"@")
 S FDA(101.71123,IENS,.06)=$S(+$G(OBJ("backgroundColor","const"))>0:OBJ("backgroundColor","const"),1:"@")
 S FDA(101.71123,IENS,.08)=$S(+$G(OBJ("imageIcon","const"))>0:OBJ("imageIcon","const"),1:"@")
 S FDA(101.71123,IENS,10)=$S($G(OBJ("evaluationObject","evaluationType"))'="":OBJ("evaluationObject","evaluationType"),1:"@")
 S FDA(101.71123,IENS,11)=$S($G(OBJ("evaluationObject","reminderComponent"))'="":OBJ("evaluationObject","reminderComponent"),1:"@")
 S FDA(101.71123,IENS,12)=$S($G(OBJ("evaluationObject","reminderStatus"))'="":OBJ("evaluationObject","reminderStatus"),1:"@")
 S FDA(101.71123,IENS,13)=$S(+$G(OBJ("evaluationObject","evaluationCode"))>0:OBJ("evaluationObject","evaluationCode"),1:"@")
 S FDA(101.71123,IENS,20)=$S($G(OBJ("applicableObject","displayIfApplicable"))="true":1,1:0)
 S FDA(101.71123,IENS,21)=$S($G(OBJ("applicableObject","notApplicableabbreviation"))'="":OBJ("applicableObject","notApplicableabbreviation"),1:"@")
 S FDA(101.71123,IENS,22)=$S($G(OBJ("applicableObject","notApplicableText"))'="":OBJ("applicableObject","notApplicableText"),1:"@")
 S FDA(101.71123,IENS,23)=$S(+$G(OBJ("applicableObject","backgroundColor","const"))>0:OBJ("applicableObject","backgroundColor","const"),1:"@")
 S FDA(101.71123,IENS,24)=$S(+$G(OBJ("applicableObject","imageIcon","const"))>0:OBJ("applicableObject","imageIcon","const"),1:"@")
 S FDA(101.71123,IENS,30)=$S(+$G(OBJ("actionObject","panelAction","const"))>0:OBJ("actionObject","panelAction","const"),1:"@")
 S FDA(101.71123,IENS,31)=$S($G(OBJ("actionObject","formType"))'="":OBJ("actionObject","formType"),1:"@")
 S FDA(101.71123,IENS,32)=$S(+$G(OBJ("actionObject","detailCode"))>0:OBJ("actionObject","detailCode"),1:"@")
 S FDA(101.71123,IENS,34)=$S(+$G(OBJ("actionObject","editor","const"))>0:OBJ("actionObject","editor","const"),1:"@")
 I +$G(FDA(101.71123,IENS,34))>0 S CALLRPC="true"
 S FDA(101.71123,IENS,70)=$S($G(OBJ("actionObject","url"))'="":OBJ("actionObject","url"),1:"@")
 I $G(OBJ("actionObject","detailText"))="" S FDA(101.71123,IENS,50)="@"
 I $G(OBJ("description"))="" S FDA(101.71123,IENS,40)="@"
 I $G(OBJ("actionObject","detailText"))'="" D
 .K TEXT,TMP M TMP=OBJ("actionObject","detailText")
 .D PARSETEXT^OREDITOR1(.TEXT,.TMP)
 .S TSUB="IPANEL DETAIL "_IENS
 .M ^TMP(TSUB,$J)=TEXT
 .S FDA(101.71123,IENS,50)=$NA(^TMP(TSUB,$J)),TEMPSUB(TSUB)=""
 I $G(OBJ("description"))'="" D
 .K TEXT,TMP M TMP=OBJ("description")
 .D PARSETEXT^OREDITOR1(.TEXT,.TMP)
 .S TSUB="IPANEL DESCRIPTION "_IENS
 .M ^TMP(TSUB,$J)=TEXT S FDA(101.71123,IENS,40)=$NA(^TMP(TSUB,$J)),TEMPSUB(TSUB)=""
 I +$G(OBJ("actionObject","editor"))>0 S CALLRPC="true"
 I +$G(OBJ("actionObject","detailCode"))>0 S CALLRPC="true"
 I RDATA=1 S CALLRPC="true"
 S FDA(101.71123,IENS,33)=CALLRPC
 Q
 ;
FDALOC(OBJ,FDA,IENS) ;
 N TMP
 I +$G(OBJ("locationSequence"))=0 S FDA(101.7112,IENS,.01)="@" Q
 S FDA(101.7112,IENS,.01)=OBJ("locationSequence")
 S FDA(101.7112,IENS,.02)=$S(+$G(OBJ("location","const"))>0:OBJ("location","const"),1:"@")
 S FDA(101.7112,IENS,.03)=$S($G(OBJ("displayText"))'="":OBJ("displayText"),1:"@")
 S FDA(101.7112,IENS,.04)=$S($G(OBJ("abbreviation"))'="":OBJ("abbreviation"),1:"@")
 S FDA(101.7112,IENS,.05)=$S(+$G(OBJ("backgroundColor","const"))>0:OBJ("backgroundColor","const"),1:"@")
 S FDA(101.7112,IENS,.06)=$S($G(OBJ("disabled"))'="":OBJ("disabled"),1:"@")
 S FDA(101.7112,IENS,.07)=$S($G(OBJ("collapsible"))'="":OBJ("collapsible"),1:"@")
 S FDA(101.7112,IENS,.08)=$S(+$G(OBJ("imageIcon","const"))>0:OBJ("imageIcon","const"),1:"@")
 Q
 ;
FDAPKG(OBJ,FDA,IENS) ;
 I $G(OBJ("package","title"))="" S FDA(101.711,IENS,.01)="@" Q
 S FDA(101.711,IENS,.01)=OBJ("package","const")
 Q
 ;
FDAREQ(OBJ,FDA,IENS) ;
 I +$G(OBJ("dataType","const"))=0 S FDA(101.714,IENS,.01)="@" Q
 S FDA(101.714,IENS,.01)=OBJ("dataType","const")
 I $G(OBJ("requiredForAction"))'="" S FDA(101.714,IENS,.02)=$S(OBJ("requiredForAction")="true":1,1:0)
 Q
 ;
IPANEL(INPUTS) ;
 I INPUTS("callFrom")="editorSave" Q $$SAVE(.INPUTS)
 I INPUTS("callFrom")="editorBuilder" Q $$BLD^OREDITOR4(.INPUTS)
 Q "0^Call from entry point not found."
 ;
SAVE(INPUTS) ;
 N DATA,FDA,ERROR,HARRAY,IARRAY,ID,IDX,LIDX,NIDX
 N OBJ,ORIMGR,PIDX,RIDX,SHARRAY,SUB,TIENS,TEMPSUB,TMPSUB,TSUB
 M DATA=INPUTS("data")
 S SUB=INPUTS("subscript")
 S NIDX=$$GETNATIONAL^ORIUTL I NIDX=0 Q -1_U_"Could not find the National IDX"
 M HARRAY=DATA("hashValues") K DATA("hashValues")
 I HARRAY("totalHash")=$$GENAREF^XLFSHAN(512,"DATA",1) Q 1
 S FDA(101.71,NIDX_",",.01)="NATIONAL"
 S FDA(101.71,NIDX_",",.02)=$S(DATA("active")="true":1,1:0)
 S FDA(101.71,NIDX_",",.03)=$$NOW^XLFDT()
 ;S FDA(101.71,NIDX_",",.04)="CPRS Info Panel Update"
 D SETHASHARRAY^OREDITOR1(.HARRAY,.SHARRAY)
 S PIDX=0
 F  S PIDX=$O(DATA("ResponsiblePackages",PIDX)) Q:PIDX'>0  D
 . K TIENS S TIENS(1)=NIDX,IDX=0
 . S ID=$G(DATA("ResponsiblePackages",PIDX,"packageId")) I ID'="" S IDX=$P(ID,",")
 . I ID=""!(IDX=0) M OBJ=DATA("ResponsiblePackages",PIDX) D SETNEWPKG(.OBJ,.FDA,.TIENS,.IARRAY,.TEMPSUB) Q
 . S TIENS(2)=IDX,LIDX=0,IARRAY(ID)=""
 . F  S LIDX=$O(DATA("ResponsiblePackages",PIDX,"locationId",LIDX)) Q:LIDX'>0  D
 .. K OBJ M OBJ=DATA("ResponsiblePackages",PIDX,"locationId",LIDX)
 .. D DIFFLOC(.OBJ,.FDA,.TIENS,.SHARRAY,.IARRAY,.TEMPSUB)
 S ORIMGR=1
 I $D(FDA) D FILE^DIE("","FDA","ERROR")
 I +$G(ERROR)>0 Q -1_U_"Error performing final update"
 I $$DELETE(.IARRAY)'="" Q -1_U_"Error removing records"
 S TSUB="" F  S TSUB=$O(TEMPSUB(TSUB)) Q:TSUB=""  K ^TMP($J,TSUB)
 K OBJ,TMPSUB M TMPSUB=^ORI(101.71,NIDX)
 D CHECKPANEL^ORICHECK(.OBJ,.TMPSUB) I $G(OBJ("success"))'="true" Q -1_U_"Failed final check after update. "_$C(13)_$C(10)_$G(OBJ("error"))
 Q 1
 ;
SETNEW(TYPE,TIENS,OBJ) ;
 N CNT,DA,DIC,IDX,ORIMGR,TMP,X,Y
 S DIC(0)="F"
 S CNT=0,IDX="A" F  S IDX=$O(TIENS(IDX),-1) Q:IDX<1  D
 .S DA($I(CNT))=TIENS(IDX)
 I TYPE="PKG" D
 . S DIC="^ORI(101.71,"_DA(1)_",""PKG"","
 . S X=$G(OBJ("package","const"))
 I TYPE="LOC" D
 . S DIC="^ORI(101.71,"_DA(2)_",""PKG"","_DA(1)_",""LOC"","
 . S TMP=OBJ("location","title")
 . S X=$G(OBJ("locationSequence")),DIC("DR")=".02///^S X=TMP"
 I TYPE="ITM" D
 . S DIC="^ORI(101.71,"_DA(3)_",""PKG"","_DA(2)_",""LOC"","_DA(1)_",""ITM"","
 . S X=$G(OBJ("panelSequence"))
 I TYPE="REQD" D
 . S DIC="^ORI(101.71,"_DA(4)_",""PKG"","_DA(3)_",""LOC"","_DA(2)_",""ITM"","_DA(1)_",""REQD"","
 . S TMP=$S(OBJ("requiredForAction")="true":1,1:0)
 . S X=$G(OBJ("dataType","const")),DIC("DR")=".02///^S X=TMP"
 I +$G(X)=0 Q 0
 S ORIMGR=1
 D FILE^DICN
 Q +$G(Y)
 ;
SETNEWITEM(OBJ,FDA,TIENS,IARRAY,TEMPSUB) ;
 N DA,DIC,HRDATA,IDX,IEN,IENS,RDATA,RIDX,TOBJ,Y
 K TIENS(4),TIENS(5)
 S IEN=$$SETNEW("ITM",.TIENS,.OBJ) I IEN'>0 Q
 S TIENS(4)=IEN,IENS=$$BLDIENS(.TIENS),IARRAY(IENS)=""
 M RDATA=OBJ("actionObject","requiredData")
 S HRDATA=$$HREQDATA(.RDATA)
 K TIENS(5) D FDAITEM(.OBJ,.FDA,.IENS,.TEMPSUB,HRDATA)
 S IDX=0 F  S IDX=$O(OBJ("actionObject","requiredData",IDX)) Q:IDX'>0  D
 .K TOBJ M TOBJ=OBJ("actionObject","requiredData",IDX)
 .D SETNEWDATA(.TOBJ,.FDA,.TIENS,.IARRAY)
 Q
 ;
SETNEWLOC(OBJ,FDA,TIENS,IARRAY,TEMPSUB) ;
 N DA,DIC,IDX,IEN,IENS,TOBJ,Y
 K TIENS(3),TIENS(4),TIENS(5)
 S IEN=$$SETNEW("LOC",.TIENS,.OBJ) I IEN'>0 Q
 S TIENS(3)=IEN,IENS=$$BLDIENS(.TIENS),IARRAY(IENS)=""
 D FDALOC(.OBJ,.FDA,IENS)
 S IDX=0 F  S IDX=$O(OBJ("Panels",IDX)) Q:IDX'>0  D
 .K TOBJ M TOBJ=OBJ("Panels",IDX,"panelObject")
 .D SETNEWITEM(.TOBJ,.FDA,.TIENS,.IARRAY,.TEMPSUB)
 Q
 ;
SETNEWPKG(OBJ,FDA,TIENS,IARRAY,TEMPSUB) ;
 N DA,DIC,IDX,IEN,IENS,TOBJ,Y
 K TIENS(2),TIENS(3),TIENS(4),TIENS(5)
 S IEN=$$SETNEW("PKG",.TIENS,.OBJ) I IEN'>0 Q
 S TIENS(2)=IEN,IENS=$$BLDIENS(.TIENS),IARRAY(IENS)=""
 D FDAPKG(.OBJ,.FDA,IENS)
 S IDX=0 F  S IDX=$O(OBJ("locationId",IDX)) Q:IDX'>0  D
 .K TOBJ M TOBJ=OBJ("locationId",IDX)
 .D SETNEWLOC(.TOBJ,.FDA,.TIENS,.IARRAY,.TEMPSUB)
 Q
 ;
SETNEWDATA(OBJ,FDA,TIENS,IARRAY) ;
 N DA,DIC,IEN,IENS,Y
 K TIENS(5)
 S IEN=$$SETNEW("REQD",.TIENS,.OBJ) I IEN'>0 Q
 S TIENS(5)=IEN,IENS=$$BLDIENS(.TIENS),IARRAY(IENS)=""
 Q
 ;
SETDATES(DATE,DATES) ;
 S DATES("internal")=DATE
 S DATES("external")=$$FMTE^XLFDT(DATE)
 Q
 ;
