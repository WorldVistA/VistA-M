OREDITOR3 ; SLC/AGP - Dynamic Editor Plugin code ;Apr 03, 2025@07:20:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ;
 Q
 ;
EDITOR(INPUTS) ;
 I INPUTS("callFrom")="editorSave" Q $$SAVE(.INPUTS)
 I INPUTS("callFrom")="editorBuilder" Q $$BLD(.INPUTS)
 Q "0^Call from entry point not found."
 ;
BLD(INPUTS) ;
 N CNT,CACHESUB,DSCHEMA,DFN,HARRAY,IDX,IEN,ITEM,NAME,ONEOF,PIDX,SCHEMA,SUB,TSCHEMA,UISCHEMA,USER
 D PASSINVALUES^OREDITOR1(.INPUTS,.DSCHEMA,.DFN,.PIDX,.SCHEMA,.SUB,.UISCHEMA,.USER,.CACHESUB)
 ;set One Of Selection data by field
 S NAME="",CNT=0 F  S NAME=$O(^ORI(101.73,"TYPENAME","P",NAME)) Q:NAME=""  D
 .S IEN=+$O(^ORI(101.73,"TYPENAME","P",NAME,"")) Q:IEN=0
 .S CNT=CNT+1,ONEOF("editorType",CNT,"const")=IEN,ONEOF("editorType",CNT,"title")=NAME
 D GETPLUGINS^ORDD71(.ONEOF,"plugin")
 D GETLONGLIST^ORDD71(.ONEOF,"longList")
 D GETSCHEMAS^ORDD71(.ONEOF,"schema","JSON FORM SCHEMA")
 D GETSCHEMAS^ORDD71(.ONEOF,"uiSchema","JSON FORM UI SCHEMA")
 ; build editor objects
 S NAME="",CNT=0 F  S NAME=$O(^ORE(101.74,"B",NAME)) Q:NAME=""  D
 .S IDX=0 F  S IDX=$O(^ORE(101.74,"B",NAME,IDX)) Q:IDX'>0  D
 ..K ITEM D GETITEM(.ITEM,IDX,.HARRAY)
 ..M TSCHEMA("editors",$I(CNT))=ITEM
 ;merge values into final array
 M SCHEMA("properties","editors","items","properties","plugin","oneOf")=ONEOF("plugin")
 M SCHEMA("properties","editors","items","properties","delphi","properties","layout","items","properties","editorType","oneOf")=ONEOF("editorType")
 M SCHEMA("properties","editors","items","properties","delphi","properties","layout","items","properties","listControl","properties","longList","oneOf")=ONEOF("longList")
 M SCHEMA("properties","editors","items","properties","html","properties","schema","oneOf")=ONEOF("schema")
 M SCHEMA("properties","editors","items","properties","html","properties","uiSchema","oneOf")=ONEOF("uiSchema")
 D SETHASHTOTAL^OREDITOR1(.DSCHEMA,.HARRAY,.TSCHEMA)
 M DSCHEMA=TSCHEMA
 D SETFINALTMP^OREDITOR1(SUB,.SCHEMA,.UISCHEMA,.DSCHEMA)
 Q 1
 ;
DELETE(IARRAY) ;
 N DA,DIK,Y
 S DIK="^ORE(101.74,"
 S DA=0 F  S DA=$O(^ORE(101.74,DA)) Q:DA'>0  D
 .I '$D(IARRAY(DA_",")) D ^DIK
 Q
 ;
DIFFCONTROL(OBJ,FDA,HARRAY,IARRAY,IDX) ;
 N DA,IENS
 S DA(1)=IDX,DA=OBJ("id"),IENS=$$IENS^DILF(.DA),IARRAY(IENS)=""
 I HARRAY(IENS)=$$GENAREF^XLFSHAN(160,"OBJ",1) Q
 D FDACONTROL(.OBJ,.FDA,IENS)
 Q
 ;
DIFFEDITOR(OBJ,FDA,HARRAY,IARRAY,TMPSUB) ;
 N DA,IENS,TOBJ
 S DA=OBJ("id"),IENS=$$IENS^DILF(.DA),IARRAY(IENS)=""
 M TOBJ=OBJ K TOBJ("delphi","layout")
 I HARRAY(IENS)=$$GENAREF^XLFSHAN(160,"TOBJ",1) Q
 D FDAEDITOR(.OBJ,.FDA,IENS,.TMPSUB)
 Q
 ;
FDAEDITOR(OBJ,FDA,IENS,TMPSUB) ;
 N TEXT,TMP,TSUB
 S FDA(101.74,IENS,.01)=OBJ("name"),FDA(101.74,IENS,1)=OBJ("displayName")
 I $G(OBJ("inactive"))'="" S FDA(101.74,IENS,2)=$S(OBJ("inactive")="true":1,1:0)
 I $G(OBJ("refreshPanels"))'="" S FDA(101.74,IENS,43)=$S(OBJ("refreshPanels")="true":1,1:0)
 I $G(OBJ("description"))'="" D
 .K TEXT,TMP M TMP=OBJ("description") D PARSETEXT^OREDITOR1(.TEXT,TMP) S TSUB="OREDITOR1 DESCRIPTION "_IENS
 .M ^TMP(TSUB,$J)=TEXT S TMPSUB(TSUB)=""
 .S FDA(101.74,IENS,20)=$NA(^TMP(TSUB,$J))
 I +$G(OBJ("plugin"))>0 S FDA(101.74,IENS,40)=OBJ("plugin")
 I +$G(OBJ("document"))>0 S FDA(101.74,IENS,42)=OBJ("document")
 I $G(OBJ("siteSetNote"))'="" S FDA(101.74,IENS,43)=$S(OBJ("siteSetNote")="true":1,1:0)
 ;
 I OBJ("recordType")="H" D
 .;I +$G(OBJ("html","schema"))=0 S RESULT=-1_U_OBJ("schema")_" schema entry missing." Q
 .;I +$G(OBJ("html","uiSchema"))=0 S RESULT=-1_U_OBJ("uiSchema")_" schema entry missing." Q
 .S FDA(101.74,IENS,50)=OBJ("html","schema"),FDA(101.74,IENS,51)=OBJ("html","uiSchema")
 ;
 I OBJ("recordType")="D" D
 .;I +$G(OBJ("delphi","numCol"))=0 S RESULT=-1_U_OBJ("name")_" number of columns not defined" Q
 .;I +$G(OBJ("delphi","numRow"))=0 S RESULT=-1_U_OBJ("name")_" number of rows not defined" Q
 .S FDA(101.74,IENS,3)=OBJ("delphi","numCol"),FDA(101.74,IENS,4)=OBJ("delphi","numRow")
 .I $G(OBJ("delphi","hideButton"))'="" S FDA(101.74,IENS,5)=$S(OBJ("delphi","hideButton")="true":1,1:0)
 .I $G(OBJ("delphi","cancelText"))'="" S FDA(101.74,IENS,7)=OBJ("delphi","cancelText")
 .I $G(OBJ("delphi","cancelText"))'="" S FDA(101.74,IENS,7)=OBJ("delphi","saveText")
 Q
 ;
FDACONTROL(OBJ,FDA,IENS) ;
 S FDA(101.743,IENS,.01)=OBJ("name"),FDA(101.743,IENS,1)=OBJ("editorType")
 S FDA(101.743,IENS,11)=OBJ("column"),FDA(101.743,IENS,13)=OBJ("columnSpan")
 S FDA(101.743,IENS,12)=OBJ("row"),FDA(101.743,IENS,14)=OBJ("rowSpan")
 I $G(OBJ("label"))'="" S FDA(101.743,IENS,10)=OBJ("label")
 I $G(OBJ("disabled"))'="" S FDA(101.743,IENS,2)=OBJ("disabled")
 I $G(OBJ("required"))'="" S FDA(101.743,IENS,15)=OBJ("required")
 I $G(OBJ("setDefaultValue"))'="" S FDA(101.743,IENS,16)=OBJ("setDefaultValue")
 I $G(OBJ("listControl","setDefaultValue"))'="" S FDA(101.743,IENS,30)=OBJ("listControl","setDefaultValue")
 I $G(OBJ("listControl","possibleValues"))'="" S FDA(101.743,IENS,31)=OBJ("listControl","possibleValues")
 I +$G(OBJ("listControl","longList"))>0 S FDA(101.743,IENS,32)=OBJ("listControl","longList")
 I $G(OBJ("listControl","longListParameter"))'="" S FDA(101.743,IENS,33)=OBJ("listControl","longListParameter")
 Q
 ;
GETITEM(ITEM,IDX,HARRAY) ;
 N DITEM,ISCOMBO,NODE,TIDX,TIENS,X0
 S ITEM("id")=IDX
 S X0=$G(^ORE(101.74,IDX,0))
 S ITEM("name")=$P(X0,U),ITEM("displayName")=$P(X0,U,2)
 S ITEM("inactive")=$S($P(X0,U,3)=1:"true",1:"false"),ITEM("refreshPanels")=$S($P(X0,U,9)=1:"true",1:"false")
 S NODE=$G(^ORE(101.74,IDX,40))
 S ITEM("siteSetNote")=$S($P(NODE,U,4)>0:"true",1:"false") S:+$P(NODE,U)>0 ITEM("plugin")=$P(NODE,U)  S:+$P(NODE,U,3)>0 ITEM("document")=$P(NODE,U,3)
 ;description
 S NODE="",TIDX=0 F  S TIDX=$O(^ORE(101.74,IDX,20,TIDX)) Q:TIDX'>0  D
 .S NODE=NODE_$G(^ORE(101.74,IDX,20,TIDX,0))_$C(13)_$C(10)
 I NODE'="" S ITEM("description")=NODE
 ;HTML dialog
 S NODE=$G(^ORE(101.74,IDX,50))
 I +$P(NODE,U)>0,+$P(NODE,U,2)>0 D  Q
 .S ITEM("recordType")="H",ITEM("html","schema")=$P(NODE,U),ITEM("html","uiSchema")=$P(NODE,U,2)
 .D SETHASH^OREDITOR1(.HARRAY,IDX_",",.ITEM)
 ;delphi dialog
 S ITEM("recordType")="D"
 S:$P(X0,U,4)>0 ITEM("delphi","numCol")=$P(X0,U,4)  S:$P(X0,U,5)>0 ITEM("delphi","numRow")=$P(X0,U,5)
 S ITEM("delphi","hideButton")=$S($P(X0,U,6)=1:"true",1:"false")
 S:$P(X0,U,7)>0 ITEM("delphi","saveText")=$P(X0,U,7)  S:$P(X0,U,8)>0 ITEM("delphi","cancelText")=$P(X0,U,8)
 D SETHASH^OREDITOR1(.HARRAY,IDX_",",.ITEM)
 ;
 S TIDX=0 F  S TIDX=$O(^ORE(101.74,IDX,30,TIDX)) Q:TIDX'>0  D
 .S NODE=$G(^ORE(101.74,IDX,30,TIDX,0)),ISCOMBO=0
 .S DITEM("id")=TIDX
 .I $P(NODE,U)'="" S DITEM("name")=$P(NODE,U)
 .I $P(NODE,U,2)'="" S DITEM("editorType")=$P(NODE,U,2) S ISCOMBO=$$ISLISTCOMP^ORDD71($P(NODE,U,2))
 .S DITEM("disabled")=$S($P(NODE,U,3)'="":$P(NODE,U,3),1:"false")
 .S NODE=$G(^ORE(101.74,IDX,30,TIDX,10))
 .I $P(NODE,U)'="" S DITEM("label")=$P(NODE,U)
 .I $P(NODE,U,2)>0 S DITEM("column")=$P(NODE,U,2)
 .I $P(NODE,U,3)>0 S DITEM("row")=$P(NODE,U,3)
 .I $P(NODE,U,4)>0 S DITEM("columnSpan")=$P(NODE,U,4)
 .I $P(NODE,U,5)>0 S DITEM("rowSpan")=$P(NODE,U,5)
 .S DITEM("required")=$S($P(NODE,U,6)'="":$P(NODE,U,6),1:"false")
 .S DITEM("setDefaultValue")=$S($P(NODE,U,7)'="":$P(NODE,U,7),1:"false")
 .I 'ISCOMBO D SETHASH^OREDITOR1(.HARRAY,TIDX_","_IDX_",",.DITEM) M ITEM("delphi","layout",TIDX)=DITEM Q
 .S NODE=$G(^ORE(101.74,IDX,30,TIDX,30))
 .S DITEM("listControl","needSort")=$S($P(NODE,U)'="":$P(NODE,U),1:"false")
 .S DITEM("listControl","possibleValues")=$S($P(NODE,U,2)'="":$P(NODE,U,2),1:"false")
 .I $P(NODE,U,3)>0 S DITEM("listControl","longList")=$P(NODE,U,3)
 .S NODE=$G(^ORE(101.74,IDX,30,TIDX,40))
 .I $P(NODE,U)'="" S DITEM("listControl","longListParameter")=$P(NODE,U)
 .D SETHASH^OREDITOR1(.HARRAY,TIDX_","_IDX_",",.DITEM)
 .M ITEM("delphi","layout",TIDX)=DITEM
 Q
 ;
SAVE(INPUTS) ;
 N DATA,ERROR,FDA,HARRAY,IARRAY,IDX,LIDX,LOBJ,OBJ,RESULT,SHARRAY,TMPSUB
 M DATA=INPUTS("data")
 M HARRAY=DATA("hashValues") K DATA("hashValues")
 I HARRAY("totalHash")=$$GENAREF^XLFSHAN(512,"DATA",1) Q 1
 D SETHASHARRAY^OREDITOR1(.HARRAY,.SHARRAY)
 S RESULT=1
 S IDX=0
 F  S IDX=$O(DATA("editors",IDX)) Q:IDX'>0  D
 .K OBJ M OBJ=DATA("editors",IDX)
 .I $G(OBJ("name"))="" S RESULT=-1_U_"Name not found" Q
 .I $G(OBJ("displayName"))="" S RESULT=-1_U_"Display Name not found" Q
 .I +$G(OBJ("id"))>0 D DIFFEDITOR(.OBJ,.FDA,.SHARRAY,.IARRAY,.TMPSUB)
 .I +$G(OBJ("id"))=0 D SETNEWEDITOR(.OBJ,.FDA,.IARRAY,.TMPSUB)
 .I '$D(OBJ("delphi","layout")) Q
 .S LIDX=0 F  S LIDX=$O(OBJ("delphi","layout",LIDX)) Q:LIDX'>0  D
 ..K LOBJ M LOBJ=OBJ("delphi","layout",LIDX)
 ..I +$G(LOBJ("id"))<1 D SETNEWCONTROL(.LOBJ,.FDA,.IARRAY,OBJ("id")) Q
 ..D DIFFCONTROL(.LOBJ,.FDA,.SHARRAY,.IARRAY,OBJ("id"))
 I $D(FDA) D FILE^DIE("","FDA","ERROR")
 I $D(ERROR) S RESULT=-1_U_"Error saving editor record "_OBJ("name")
 D DELETE(.IARRAY)
 Q RESULT
 ;
SETNEWCONTROL(OBJ,FDA,IARRAY,IDX) ;
 N DA,DIC,IENS,ORIMGR,X,Y
 S DA(1)=IDX
 S DIC(0)="F"
 S X=$G(OBJ("name"))
 S ORIMGR=1
 S DIC="^ORE(101.74,"_DA(1)_",30,"
 D FILE^DICN
 I +Y=0 Q
 S OBJ("id")=+Y
 S DA(1)=IDX,DA=OBJ("id"),IENS=$$IENS^DILF(.DA)
 D FDACONTROL(.OBJ,.FDA,IENS)
 S IARRAY(IENS)=""
 Q
 ;
SETNEWEDITOR(OBJ,FDA,IARRAY,TMPSUB) ;
 N DA,DIC,IENS,ORIMGR,Y,X
 S X=$O(OBJ("name"))
 S DIC(0)="F"
 S ORIMGR=1
 S DIC="^ORE(101.74,"
 D FILE^DICN
 I +Y=0 Q
 S OBJ("id")=+Y,DA=OBJ("id"),IENS=$$IENS^DILF(.DA)
 D FDAEDITOR(.OBJ,.FDA,IENS,.TMPSUB)
 S IARRAY(IENS)=""
 Q
 ;
